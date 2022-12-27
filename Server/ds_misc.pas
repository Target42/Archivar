unit ds_misc;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB, System.JSON,
  Datasnap.DSSession, u_json, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf;

type
  [TRoleAuth('user,admin', 'download')]
  TdsMisc = class(TDSServerModule)
    OpenTaskQry: TDataSetProvider;
    MeetingQry: TDataSetProvider;
    GetTaskinfo: TFDQuery;
    GetProtoInfo: TFDQuery;
    LockTrans: TFDTransaction;
    IBTransaction1: TFDTransaction;
    openTasks: TFDQuery;
    AutoIncQry: TFDQuery;
    Meetings: TFDQuery;
    IncTrans: TFDTransaction;
    PEQry: TFDQuery;
    PEQryPE_ID: TIntegerField;
    PEQryPE_NAME: TStringField;
    PEQryPE_VORNAME: TStringField;
    PEQryPE_DEPARTMENT: TStringField;
    GetKeyQry: TFDQuery;
    FDTransaction1: TFDTransaction;
    ListStoragesQry: TFDQuery;
    PEQryDR_ID: TIntegerField;
    GRTab: TFDTable;
    PETab: TFDTable;
    DRTab: TFDTable;
    procedure DSServerModuleCreate(Sender: TObject);
  private
  private
    m_Session : TDSSession;

  public
    function LockDocument(   req : TJSONObject ) : TJSONObject;
    function UnLockDocument( req : TJSONObject ) : TJSONObject;
    function isLocked(       req : TJSONObject ) : TJSONObject;

    function validTask(      id, dt  : integer ) : boolean;

    function AutoInc( gen : string ) : integer;

    function getUserList : TJSONobject;
    function changeOnlineStatus(req: TJSONObject) : TJSONObject;

    function getPublicKey( net : string; stamp : TDateTime ) : TStream;

    function getStorageList : TJSONObject;

    function ping( value : integer ) : integer;

    function checkFolder( data : TJSONObject ) : TJSONObject;

    function getConfigData( req : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  Grijjy.CloudLogging, m_lockMod,
  u_berTypes, i_user, m_db, System.Variants, m_mail;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdsMisc }

function TdsMisc.AutoInc(gen: string): integer;
begin
  if IncTrans.Active then
    IncTrans.Commit;
  IncTrans.StartTransaction;

  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;

  IncTrans.Commit;
end;

function TdsMisc.changeOnlineStatus(req: TJSONObject) : TJSONObject;
var
  online  : Boolean;
  s       : string;
  id      : integer;
  status  : string;
begin
  Result := TJSONObject.create;

  online := JBool( req, 'online');
  status := JString( req, 'state');

  try
    if online then
    begin
      s  := m_Session.GetData('ID');
      id := StrToInt( s );
      ous.addUser( id,
        m_Session.GetData('name'),
        m_Session.GetData('vorname'),
        m_Session.Id );

      ous.changeStatus( id, JString(req, 'state'));
    end
    else
      ous.removeSessionID(m_Session.Id);
  except
    on e : exception do
    begin

    end;
  end;
end;

function TdsMisc.checkFolder(data: TJSONObject): TJSONObject;
var
  typ : string;
  id  : integer;
  drid: integer;

  function getNewDir : integer;
  begin
    Result := AutoInc('gen_dr_id');

    DRTab.Open;
    DRTab.Append;
    DRTab.FieldByName('DR_ID').AsInteger      := Result;
    DRTab.FieldByName('DR_GROUP').AsInteger  := Result;
    DRTab.Post;
    DRTab.Close;
  end;
begin
  Result := TJSONObject.Create;

  typ := JString( data, 'typ' );
  id  := JInt( data, 'id' );
  drid:= -1;

  if SameText( typ, 'Gremium' )  then begin
    GRTab.Open;
    if GRTab.Locate('GR_ID', VarArrayOf([id]), []) then begin
      drid := GRTab.FieldByName('DR_ID').AsInteger;
      if  drid = 0 then begin
        drid := getNewDir;
        GRTab.Edit;
        GRTab.FieldByName('DR_ID').AsInteger := drid;
        GRTab.Post;
      end;
    end;
    GRTab.Close;

    JResult(Result, true, '');
  end else if SameText( typ, 'person') then begin
    PETab.Open;
    if PETab.Locate('PE_ID', VarArrayOf([id]), []) then begin
      drid := PETab.FieldByName('DR_ID').AsInteger;
      if  drid = 0 then begin
        drid := getNewDir;
        PETab.Edit;
        PETab.FieldByName('DR_ID').AsInteger := drid;
        PETab.Post;
      end;
    end;
    PETab.Close;

    JResult(Result, true, '');
  end else begin
    JResult( Result, false, 'Unbekannter Typ:'+typ);
  end;
  JReplace(Result, 'drid', drid);

  if FDTransaction1.Active then
    FDTransaction1.Commit;

end;

procedure TdsMisc.DSServerModuleCreate(Sender: TObject);
begin
  m_Session := TDSSessionManager.GetThreadSession;
end;

function TdsMisc.getConfigData(req: TJSONObject): TJSONObject;
begin
  Result := TMailMod.getMailConfig;
end;

function TdsMisc.getPublicKey(net : string; stamp: TDateTime): TStream;
var
  st : TStream;
begin
  Result := TMemoryStream.Create;

  if net = '' then
    net := m_Session.GetData('user');

  GetKeyQry.ParamByName('name').AsString  := net;
  GetKeyQry.ParamByName('da').AsDateTime  := stamp;

  GetKeyQry.Open;
  if not GetKeyQry.IsEmpty then begin
    st := GetKeyQry.CreateBlobStream(GetKeyQry.FieldByName('PK_DATA'), bmRead);
    Result.CopyFrom(st, -1);
    st.Free;
    Result.Position := 0;
  end;
  GetKeyQry.Close;

  if GetKeyQry.Transaction.Active then
    GetKeyQry.Transaction.Commit;
end;

function TdsMisc.getStorageList: TJSONObject;
var
  arr : TJSONArray;
  row : TJSONObject;
begin
  Result  := TJSONObject.Create;
  arr     := TJSONArray.Create;

  if FDTransaction1.Active then
    FDTransaction1.Rollback;
  FDTransaction1.StartTransaction;
  with ListStoragesQry do begin
    open;
    while not eof do begin
      row := TJSONObject.Create;
      JReplace(row, 'id',     FieldByName('ST_ID').AsInteger);
      JReplace(row, 'name',   FieldByName('ST_NAME').AsString );
      JReplace(row, 'drid',   FieldByName('DR_ID').AsInteger);
      arr.AddElement(row);
      next;
    end;
    close;
  end;
  FDTransaction1.Commit;
  JReplace(Result, 'items', arr);
end;

function TdsMisc.getUserList: TJSONobject;
var
  arr : TJSONArray;
  row : TJSONObject;
begin
  arr := TJSONArray.Create;

  PEQry.Open;
  while not PEQry.Eof do
  begin
    row := TJSONObject.Create;

    JReplace( row, 'id',      PEQryPE_ID.Value);
    JReplace( row, 'name',    PEQryPE_NAME.AsString);
    JReplace( row, 'vorname', PEQryPE_VORNAME.AsString);
    JReplace( row, 'dept',    PEQryPE_DEPARTMENT.AsString);
    JReplace( row, 'drid',    PEQryDR_ID.Value );

    arr.AddElement(row);
    PEQry.Next;
  end;
  PEQry.Close;

  if PEQry.Transaction.Active then
    PEQry.Transaction.Commit;

  Result := TJSONObject.Create;
  JReplace( Result, 'user', arr);
end;

function TdsMisc.isLocked( req : TJSONObject ): TJSONObject;
begin
  Result := LockMod.isLocked( req );
end;

function TdsMisc.LockDocument(req : TJSONObject): TJSONObject;
begin
  Result := LockMod.LockDocument( req );
end;

function TdsMisc.ping(value: integer): integer;
begin
  Result := value;
end;

function TdsMisc.UnLockDocument(req : TJSONObject): TJSONObject;
begin
  Result := LockMod.UnLockDocument( req  );
end;

function TdsMisc.validTask(id, dt: integer): boolean;
var
  t : TDocType;
begin
  GrijjyLog.EnterMethod(self, 'validTask');
  t := tDocType(dt);
  GrijjyLog.Send(format('valid task: %d %d', [id, dt]));

  if LockTrans.Active then
    LockTrans.Rollback;

  LockTrans.StartTransaction;

  case t of
    dtTask:
    begin
      GetTaskinfo.ParamByName('TA_ID').AsInteger := id;
      GetTaskinfo.Open;
      Result := not GetTaskinfo.IsEmpty;
      GetTaskinfo.Close;
    end;
    dtProtokoll:
    begin
      GetProtoInfo.ParamByName('PR_ID').AsInteger := id;
      GetProtoInfo.Open;
      Result := not GetProtoInfo.IsEmpty;
      GetProtoInfo.Close;
    end
  else
    Result := false;
  end;
  GrijjyLog.Send('valid', Result);

  LockTrans.Commit;
  GrijjyLog.ExitMethod(self, 'validTask');
end;

end.

