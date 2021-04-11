unit ds_misc;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery, System.JSON,
  Datasnap.DSSession, u_lockInfo, u_json;

type
  [TRoleAuth('user,admin')]
  TdsMisc = class(TDSServerModule)
    openTasks: TIBQuery;
    IBTransaction1: TIBTransaction;
    OpenTaskQry: TDataSetProvider;
    LockTrans: TIBTransaction;
    GetTaskinfo: TIBQuery;
    GetProtoInfo: TIBQuery;
    AutoIncQry: TIBQuery;
    IncTrans: TIBTransaction;
    Meetings: TIBQuery;
    MeetingQry: TDataSetProvider;
    PEQry: TIBQuery;
    PEQryPE_ID: TIntegerField;
    PEQryPE_NAME: TIBStringField;
    PEQryPE_VORNAME: TIBStringField;
    PEQryPE_DEPARTMENT: TIBStringField;
    PEQryPE_NET: TIBStringField;
    PEQryPE_MAIL: TIBStringField;
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
  end;

implementation

uses
  m_db, m_glob_server, m_lockMod, System.Generics.Collections,
  u_berTypes, i_user;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsMisc }

function TdsMisc.AutoInc(gen: string): integer;
begin
  if IncTrans.InTransaction then
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

procedure TdsMisc.DSServerModuleCreate(Sender: TObject);
begin
  m_Session := TDSSessionManager.GetThreadSession;
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
    JReplace( row, 'name',    PEQryPE_NAME.Value);
    JReplace( row, 'vorname', PEQryPE_VORNAME.Value);
    JReplace( row, 'dept',    PEQryPE_DEPARTMENT.Value);

    arr.AddElement(row);
    PEQry.Next;
  end;
  PEQry.Close;

  if PEQry.Transaction.InTransaction then
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

function TdsMisc.UnLockDocument(req : TJSONObject): TJSONObject;
begin
  Result := LockMod.UnLockDocument( req  );
end;

function TdsMisc.validTask(id, dt: integer): boolean;
var
  t : TDocType;
begin
  t := tDocType(dt);

  DebugMsg(format('valid task: %d %d', [id, dt]));

  if LockTrans.InTransaction then
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
  if Result then
    DebugMsg('is valid')
  else
    DebugMsg('is invalid');

  LockTrans.Commit;
end;

end.

