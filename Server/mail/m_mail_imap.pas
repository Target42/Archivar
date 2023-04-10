unit m_mail_imap;

interface

uses
  System.SysUtils, System.Classes, IdSMTPBase, IdSMTP, IdMessage, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdIMAP4, i_mail, System.JSON;

type
  TMailIMap = class(TDataModule, IMail)
    IdIMAP41: TIdIMAP4;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    TestMsg: TIdMessage;
    IdSMTP1: TIdSMTP;
    IdSSLIOHandlerSocketOpenSSL2: TIdSSLIOHandlerSocketOpenSSL;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_KontoName : string;
    m_folder    : TStringList;
    procedure setKontoName( value : string );
    function  getKontoName : string;
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
  u_json;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TMailIMap }

procedure TMailIMap.abort;
begin

end;

function TMailIMap.config(data: TJSONObject): boolean;
var
  obj : TJSONObject;
begin

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

procedure TMailIMap.setKontoName(value: string);
begin
  m_KontoName := value;
end;

function TMailIMap.update: integer;
var
  fld : integer;
  i   : integer;
  st  : TMemoryStream;
begin
  Result := 0;
  st := TMemoryStream.Create;
  try
    IdIMAP41.Connect();

    for fld := 0 to pred(m_folder.Count) do
    begin
      if IdIMAP41.SelectMailBox(m_folder[fld]) then begin
        for i := IdIMAP41.MailBox.TotalMsgs downto 1 do begin

          IdIMAP41.Retrieve(i, TestMsg);

        end;
      end;
    end;
  except

  end;
  IdIMAP41.Disconnect;
  st.Free;

end;

end.
