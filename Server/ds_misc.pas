unit ds_misc;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery, System.JSON,
  Datasnap.DSSession, u_lockInfo;

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
    procedure DSServerModuleCreate(Sender: TObject);
  private
  private
    m_Session : TDSSession;

  public
    function LockDocument( id, typ : integer ) : TJSONObject;
    function UnLockDocument( id, typ : integer ) : TJSONObject;
    function isLocked( id, typ : integer ) : TJSONObject;
    function validTask( id, dt : integer ) : boolean;

    function AutoInc( gen : string ) : integer;
  end;

implementation

uses
  m_db, u_json, m_glob_server, m_lockMod, System.Generics.Collections,
  u_berTypes;

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

procedure TdsMisc.DSServerModuleCreate(Sender: TObject);
begin
  m_Session := TDSSessionManager.GetThreadSession;
end;

function TdsMisc.isLocked(id, typ: integer): TJSONObject;
begin
  Result := LockMod.isLocked( id, typ );
end;

function TdsMisc.LockDocument(id, typ: integer): TJSONObject;
begin
  Result := LockMod.LockDocument( id, typ );
end;

function TdsMisc.UnLockDocument(id, typ: integer): TJSONObject;
begin
  Result := LockMod.UnLockDocument( id, typ );
end;

function TdsMisc.validTask(id, dt: integer): boolean;
var
  t : TDocType;
begin
  t := tDocType(dt);
  Result := false;

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

