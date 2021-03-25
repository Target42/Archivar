unit ds_admin;

interface

uses System.SysUtils, System.Classes,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, System.JSON, Datasnap.DSSession,
  IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery, Datasnap.Provider;

type
  [TRoleAuth('user,admin')]
  TAdminMod = class(TDSServerModule)
    GremiumQry: TIBQuery;
    IBTransaction1: TIBTransaction;
    DeleteQry: TIBQuery;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    m_session : TDSSession;
  public
    function getUserInfo( data : TJSONObject) : TJSONObject;
    function getGremiumList : TJSONObject;
    function getDeleteTimes : TJSONObject;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}


uses System.StrUtils, u_json, m_db, m_glob_server;

{ TAdminMod }

procedure TAdminMod.DSServerModuleCreate(Sender: TObject);
begin
  m_session := TDSSessionManager.GetThreadSession;;
end;

function TAdminMod.getDeleteTimes: TJSONObject;
var
  arr : TJSONArray;
  row : TJSONObject;
begin
  Result := TJSONObject.Create;
  arr    := TJSONArray.Create;

  DeleteQry.Open;
  while not DeleteQry.Eof do
  begin
    row := TJSONObject.Create;
    JReplace( row, 'id', DeleteQry.FieldByName('FD_ID').AsInteger);
    JReplace( row, 'name', DeleteQry.FieldByName('FD_NAME').AsString);
    JReplace( row, 'monate', DeleteQry.FieldByName('FD_MONATE').AsInteger);
    arr.AddElement(row);
    DeleteQry.Next;
  end;
  DeleteQry.Close;
  JReplace( Result, 'items', arr);

  if DeleteQry.Transaction.InTransaction then
    DeleteQry.Transaction.Commit;
end;

function TAdminMod.getGremiumList: TJSONObject;
var
  arr : TJSONArray;
  row : TJSONObject;
begin
  Result := TJSONObject.Create;
  arr    := TJSONArray.Create;

  GremiumQry.Open;
  while not GremiumQry.Eof do
  begin
    row := TJSONObject.Create;
    JReplace( row, 'id',    GremiumQry.FieldByName('gr_id').AsInteger);
    JReplace( row, 'name',  GremiumQry.FieldByName('gr_name').AsString);
    JReplace( row, 'short',  GremiumQry.FieldByName('gr_short').AsString);
    JReplace( row, 'parent', GremiumQry.FieldByName('GR_PARENT_SHORT').AsString);
    JReplace( row, 'image', GremiumQry.FieldByName('GR_PIC_NAME').AsString);

    arr.AddElement(row);
    GremiumQry.Next
  end;
  GremiumQry.Close;

  if GremiumQry.Transaction.InTransaction then
    GremiumQry.Transaction.Commit;


  JReplace(Result, 'items', arr);
end;

function TAdminMod.getUserInfo( data : TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  JReplace( Result, 'user',     m_session.GetData('user'));
  JReplace( Result, 'admin',    (m_session.GetData('admin') = 'true'));
  JReplace( Result, 'name',     m_session.GetData('name'));
  JReplace( Result, 'vorname',  m_session.GetData('vorname'));
  JReplace( Result, 'id',       StrToInt(m_session.GetData('ID')));

  DebugMsg('getUserInfo::session : '+IntToStr(m_session.Id));
  DebugMsg('');

  m_session.PutData('host', JString(data, 'host'));
  m_session.PutData('hostuser', JString( data, 'hostuser'));

end;

end.

