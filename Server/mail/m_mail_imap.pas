unit m_mail_imap;

interface

uses
  System.SysUtils, System.Classes, IdSMTPBase, IdSMTP, IdMessage, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdIMAP4, i_mail, System.JSON, System.Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet;

type
  TMailIMap = class(TDataModule, IMail)
    IdIMAP41: TIdIMAP4;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Msg: TIdMessage;
    IdSMTP1: TIdSMTP;
    IdSSLIOHandlerSocketOpenSSL2: TIdSSLIOHandlerSocketOpenSSL;
    FolderQry: TFDQuery;
    FDTransaction1: TFDTransaction;
    MailTab: TFDTable;
    AutoincQry: TFDQuery;
    ListQry: TFDQuery;
    DeleteQry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_KontoName : string;
    m_konto_id  : integer;
    m_folder    : TStringList;
    procedure setKontoName( value : string );
    function  getKontoName : string;
    procedure move(arr : array of string; folder: string);
    function AutoInc( gen : string ) : integer;
  public
    function config( data : TJSONObject ): boolean;
    function connect : boolean;
    procedure disconnect;

    procedure abort;

    function MailTyp : string;
    function update : integer;

    function getFolderList : TStringList;

  end;

var
  MailIMap: TMailIMap;

implementation

uses
  u_json, IdMessageCollection, m_db, system.hash, System.Variants;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TMailIMap }

procedure TMailIMap.abort;
begin

end;

function TMailIMap.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;
end;

function TMailIMap.config(data: TJSONObject): boolean;
var
  obj : TJSONObject;
begin
  m_konto_id := JInt( data, 'kontoid' );
  m_KontoName:= JString( data, 'kontoname');

  FolderQry.ParamByName('MAC_ID').AsInteger := m_konto_id;

  if JExistsKey(data, 'imap') then begin
    obj := JObject(data, 'imap');
    if Assigned(obj) then begin
      IdIMAP41.Host     := JString( obj, 'host');
      IdIMAP41.Port     := JInt( obj, 'port');
      IdIMAP41.Username := JString( obj, 'user');
      IdIMAP41.Password := JString( obj, 'pwd');

      getText( data, 'folder', m_folder);
    end;
  end;

  if JExistsKey(data, 'smtp') then begin
    obj := JObject(data, 'smtp');
    if Assigned(obj) then begin
      IdSMTP1.Host     := JString( obj, 'host');
      IdSMTP1.Port     := JInt( obj, 'port');
      IdSMTP1.Username := JString( obj, 'user');
      IdSMTP1.Password := JString( obj, 'pwd');
    end;
  end;

  if m_folder.Count = 0 then
    m_folder.Add('INBOX');

  result := (IdSMTP1.Host <> '' ) and (IdSMTP1.Host <> '');
end;

function TMailIMap.connect: boolean;
begin
  try
    IdIMAP41.Connect;
    Result := IdIMAP41.Connected;
  except
    Result := false;
  end;

  try
    IdSMTP1.Connect;
    Result := IdSMTP1.Connected and Result;
  finally

  end;
end;

procedure TMailIMap.DataModuleCreate(Sender: TObject);
begin
  m_folder := TStringList.Create;
  m_konto_id := -1;

end;

procedure TMailIMap.DataModuleDestroy(Sender: TObject);
begin
  m_folder.Free;
end;

procedure TMailIMap.disconnect;
begin
  IdIMAP41.Disconnect;
  IdSMTP1.Disconnect;
end;

function TMailIMap.getFolderList: TStringList;
begin
  Result := TStringlist.Create;
  if not IdIMAP41.Connected then exit;

  IdIMAP41.ListMailBoxes(Result);
end;

function TMailIMap.getKontoName: string;
begin
  Result := m_KontoName;
end;

function TMailIMap.MailTyp: string;
begin
  result := 'IMAP/SMTP'
end;

procedure TMailIMap.move(arr: array of string; folder: string);
var
  i   : integer;
begin
  if length(arr) > 0 then begin
    if IdIMAP41.Connected then begin
      for i := low(arr) to high(arr) do begin
        IdIMAP41.UIDCopyMsg(arr[i], folder);
      end;
      IdIMAP41.UIDDeleteMsgs(arr);
    end;
  end;
end;

procedure TMailIMap.setKontoName(value: string);
begin
  m_KontoName := value;
end;

function TMailIMap.update: integer;
var
  backup: string;
  md5   : string;
  maf_id: integer;
  mails : TStringList;
  toDelete : TList<integer>;

  procedure createArchivarInbox;
  var
    y, m, d : word;
  begin
    DecodeDate(date, y, m, d);;
    backup := 'Archivar_Inbox'+IntToStr(y);
    if not IdIMAP41.SelectMailBox(backup) then begin
      IdIMAP41.CreateMailBox(backup);
    end;
  end;

  procedure addMail( st : TMemoryStream );
  var
    bst : TStream;
  begin
    st.Position := 0;
    MailTab.Append;
    MailTab.FieldByName('MAM_ID').AsInteger := AutoInc('GEN_MAM_ID');
    MailTab.FieldByName('MAF_ID').AsInteger := FolderQry.FieldByName('MAF_ID').AsInteger;
    MailTab.FieldByName('MAM_Sender').AsString := msg.From.Text;
    MailTab.FieldByName('MAM_DATE').AsDateTime := msg.Date;
    MailTab.FieldByName('MAM_TITLE').AsString  := msg.Subject;
    MailTab.FieldByName('MAM_MD5').AsString    := md5;
    MailTab.FieldByName('MAM_ATTACH').AsInteger:= msg.MessageParts.AttachmentCount;
    MailTab.FieldByName('MAM_MSG_ID').AsString := THashMD5.GetHashString(msg.Headers.Values['Message-ID']);

    bst := MailTab.CreateBlobStream(MailTab.FieldByName('MAM_DATA'), bmWrite);
    bst.CopyFrom(st, -1);
    bst.Free;
    MailTab.Post;
  end;
  procedure readAll;
  var
    inx : integer;
  begin
    ListQry.ParamByName('MAF_ID').AsInteger := maf_id;
    ListQry.Open;
    while not ListQry.Eof do begin
      inx := mails.IndexOf(ListQry.FieldByName('MAM_MSG_ID').AsString);
      if inx = -1 then
        toDelete.Add(ListQry.FieldByName('MAM_ID').AsInteger )
      else
        mails.Delete(inx);

      ListQry.Next;
    end;
    ListQry.Close;
  end;
  procedure deleteOld;
  var
    id : integer;
  begin
    if toDelete.Count = 0 then exit;

    DeleteQry.Prepare;
    for id in toDelete do begin
      DeleteQry.ParamByName('MAM_ID').AsInteger := id;
      DeleteQry.ExecSQL;
    end;

    DeleteQry.Unprepare;
  end;
var
  i     : integer;
  st    : TMemoryStream;
begin
  Result    := 0;
  st        := TMemoryStream.Create;
  mails     := TStringList.Create;
  toDelete  := TList<integer>.create;

  MailTab.Open;
  try
    IdIMAP41.Connect();
//    createArchivarInbox;

    FolderQry.Open;
    while not FolderQry.eof do begin
      if IdIMAP41.SelectMailBox(FolderQry.FieldByName('MAF_NAME').AsString) then begin
        maf_id := FolderQry.FieldByName('MAF_ID').AsInteger;

        mails.Clear;
         for i := IdIMAP41.MailBox.TotalMsgs downto 1 do begin

          IdIMAP41.RetrieveHeader( i, msg);

          md5 := THashMD5.GetHashString(msg.Headers.Values['Message-ID']);
          mails.Add(md5);

          if not MailTab.Locate('MAF_ID;MAM_MSG_ID', VarArrayOf([maf_id, md5]), [loCaseInsensitive]) then begin
            st.Clear;
            IdIMAP41.Retrieve(i, Msg);
            msg.SaveToStream(st);
            st.Position := 0;
            md5 := THashMD5.GetHashString(st);
            addMail(st);
          end
        end;
      end;
      // gespeicherte mails ...
      readAll;
      deleteOld;

      FolderQry.Next;
    end;
  except

  end;
  IdIMAP41.Disconnect;
  st.Free;

  if FDTransaction1.Active then
    FDTransaction1.Commit;

  FolderQry.Close;
  MailTab.Close;
end;

end.


