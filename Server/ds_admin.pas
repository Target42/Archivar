unit ds_admin;

interface

uses System.SysUtils, System.Classes,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, System.JSON, Datasnap.DSSession,
  IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  [TRoleAuth('user,admin')]
  TAdminMod = class(TDSServerModule)
    FDTransaction1: TFDTransaction;
    GremiumQry: TFDQuery;
    DeleteQry: TFDQuery;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    m_session : TDSSession;
  public
    function getUserInfo( data : TJSONObject) : TJSONObject;
    function getGremiumList : TJSONObject;
    function getDeleteTimes : TJSONObject;
    [TRoleAuth('admin')]
    function ServiceAction( data : TJSONObject ) : TJSONObject;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}


uses
  Grijjy.CloudLogging, u_json,
  ServerContainerUnit1, u_Konst, DateUtils;

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

  if DeleteQry.Transaction.Active then
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
    JReplace( row, 'id',      GremiumQry.FieldByName('gr_id').AsInteger);
    JReplace( row, 'name',    GremiumQry.FieldByName('gr_name').AsString);
    JReplace( row, 'short',   GremiumQry.FieldByName('gr_short').AsString);
    JReplace( row, 'parent',  GremiumQry.FieldByName('GR_PARENT_SHORT').AsString);
    JReplace( row, 'image',   GremiumQry.FieldByName('GR_PIC_NAME').AsString);
    JReplace( row, 'sid',     GremiumQry.FieldByName('DR_ID').AsInteger );
    JReplace( row, 'color',    GremiumQry.FieldByName('GR_COLOR').AsInteger);

    arr.AddElement(row);
    GremiumQry.Next
  end;
  GremiumQry.Close;

  if GremiumQry.Transaction.Active then
    GremiumQry.Transaction.Commit;


  JReplace(Result, 'items', arr);
end;

function TAdminMod.getUserInfo( data : TJSONObject): TJSONObject;
begin
  GrijjyLog.EnterMethod(self, 'getUserInfo');
  Result := TJSONObject.Create;
  JReplace( Result, 'user',     m_session.GetData('user'));
  JReplace( Result, 'admin',    (m_session.GetData('admin') = 'true'));
  JReplace( Result, 'name',     m_session.GetData('name'));
  JReplace( Result, 'vorname',  m_session.GetData('vorname'));
  JReplace( Result, 'id',       StrToInt(m_session.GetData('ID')));
  JReplace( Result, 'drid',     StrToInt(m_session.GetData('DRID')));


  GrijjyLog.Send('session id', m_session.Id);

  m_session.PutData('host', JString(data, 'host'));
  m_session.PutData('hostuser', JString( data, 'hostuser'));

  GrijjyLog.ExitMethod(self, 'getUserInfo');

end;


function TAdminMod.ServiceAction(data: TJSONObject): TJSONObject;
var
  cmd : string;
  obj : TJSONObject;

  procedure sendShutdown;
  var
    val : integer;
    da  : TDatetime;
  begin
    val := JInt(data, 'counter', 120);

    da := IncSecond(now, val);

    JReplace( obj, 'counter', val);
    setText(  obj, 'text', Format('Der Server wird um %s runtergefahren', [DateTimeToStr(da)]));

    ArchivService.BroadcastMessage(BRD_CHANNEL, obj);
    ArchivService.Shutdown( val );
  end;
  procedure sendMessage;
  begin
    JReplace( obj, 'urgend', JBool(data, 'urgend'));
    setText(  obj, 'text', getText( data, 'text' ));
    ArchivService.BroadcastMessage(BRD_CHANNEL, obj);
  end;
  procedure sendCloseEdits;
  begin
    ArchivService.BroadcastMessage(BRD_CHANNEL, obj);
  end;
  procedure sendTerminate;
  begin
    ArchivService.BroadcastMessage(BRD_CHANNEL, obj);
  end;

begin
  GrijjyLog.EnterMethod(self, 'ServiceAction');
  Result := TJSONObject.Create;

  obj := TJSONObject.Create;

  JAction( obj, BRD_ADMIN);
  cmd := JString(data, 'cmd');
  JReplace( obj, 'cmd', cmd );

       if SameText(cmd, BRD_ADMIN_REBOOT)     then sendShutdown
  else if SameText(cmd, BRD_ADMIN_MSG)        then sendMessage
  else if SameText(cmd, BRD_ADMIN_CLOSE_EDIT) then sendCloseEdits
  else if SameText(cmd, BRD_ADMIN_TERMINATE)  then sendTerminate;


  JResult(Result, true, '');
  GrijjyLog.ExitMethod(self, 'ServiceAction');
end;

end.

