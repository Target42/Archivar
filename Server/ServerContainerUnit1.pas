unit ServerContainerUnit1;

interface

uses
  Grijjy.CloudLogging, System.SysUtils, System.Classes,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  IPPeerServer, IPPeerAPI, Datasnap.DSAuth, DbxSocketChannelNative,
  DbxCompressionFilter, Vcl.SvcMgr, m_glob_server, Data.DB,
  m_lockMod, Datasnap.DSSession, i_user,
  System.JSON, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer,
  System.SyncObjs, System.Generics.Collections, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TServerContainer1 = class(TService)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    dsAdmin: TDSServerClass;
    dsGremium: TDSServerClass;
    DSAuthenticationManager1: TDSAuthenticationManager;
    dsPerson: TDSServerClass;
    dsTask: TDSServerClass;
    dsFile: TDSServerClass;
    dsMisc: TDSServerClass;
    dsProtocol: TDSServerClass;
    dsImage: TDSServerClass;
    dsChapter: TDSServerClass;
    dsTaskEdit: TDSServerClass;
    dsTemplate: TDSServerClass;
    dsTaskView: TDSServerClass;
    dsTextBlock: TDSServerClass;
    dsFileCache: TDSServerClass;
    dsEpub: TDSServerClass;
    dsMeeing: TDSServerClass;
    dsSitzung: TDSServerClass;
    dsUpdater: TDSServerClass;
    IBTransaction1: TFDTransaction;
    QueryUser: TFDQuery;
    GRPEQry: TFDQuery;
    dsStammData: TDSServerClass;
    dsPKI: TDSServerClass;
    dsDairy: TDSServerClass;
    dsStorage: TDSServerClass;
    procedure dsAdminGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure dsGremiumGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject;
      AuthorizeEventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure ServiceCreate(Sender: TObject);
    procedure dsPersonGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSServer1Connect(DSConnectEventObject: TDSConnectEventObject);
    procedure DSServer1Disconnect(DSConnectEventObject: TDSConnectEventObject);
    procedure dsTaskGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsFileGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsMiscGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsProtocolGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsImageGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsChapterGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsTaskEditGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsTemplateGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure dsTaskViewGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsTextBlockGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSServer1Error(DSErrorEventObject: TDSErrorEventObject);
    procedure dsFileCacheGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsEpubGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsMeeingGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSTCPServerTransport1Connect(Event: TDSTCPConnectEventObject);
    procedure DSTCPServerTransport1Disconnect(
      Event: TDSTCPDisconnectEventObject);
    procedure dsSitzungGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure ServiceDestroy(Sender: TObject);
    procedure dsUpdaterGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsStammDataGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsPKIGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsDairyGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsStorageGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    const
      MaxUserNameLength = 25;
  private
    m_secret : string;
    m_Lock : TCriticalSection;
    m_sessions : TThreadList<String>;

    procedure removeUser( Session: TDSSession );
  protected
    function DoStop: Boolean; override;
    function DoPause: Boolean; override;
    function DoContinue: Boolean; override;
    procedure DoInterrogate; override;
  public
    function GetServiceController: TServiceController; override;

    procedure BroadcastMessage( id : string ; data : TJSONObject );

    procedure dumpOnlineUser;
    procedure dumpSessions;

    procedure startLogging;
  end;

var
  ServerContainer1: TServerContainer1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}
{

  http://docwiki.embarcadero.com/RADStudio/Seattle/en/Server_Side_Session_Management
}
uses
  Winapi.Windows, m_db, ds_gremium, ds_admin, ds_person, IOUtils,
  ds_taks, ds_file, ds_misc, ds_protocol, ds_image, ds_chapter,
  ds_taskEdit, ds_template, ds_taskView, ds_textblock, ds_fileCache, ds_epub,
  ds_meeting, System.Hash, u_json, ds_sitzung, m_hell, Grijjy.sysUtils, u_ini,
  m_fileServer, ds_updater, ds_stamm, ds_pki, ds_dairy, ds_storage;

procedure TServerContainer1.dsAdminGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_admin.TAdminMod;
end;

procedure TServerContainer1.DSServer1Connect(
  DSConnectEventObject: TDSConnectEventObject);
var
  Session : TDSSession;
begin
  GrijjyLog.EnterMethod(self, 'DSServer1Connect');
  Session := TDSSessionManager.GetThreadSession;

  GrijjyLog.Send('DSConnectEventObject.ChannelInfo.Id', DSConnectEventObject.ChannelInfo.Id);
  GrijjyLog.Send('session id',                          session.id);
  GrijjyLog.Send('session name',                        session.UserName);
  GrijjyLog.Send('remote host',                         DSConnectEventObject.ChannelInfo.ClientInfo.IpAddress);

  GrijjyLog.ExitMethod(self, 'DSServer1Connect');
end;

procedure TServerContainer1.DSServer1Disconnect(
  DSConnectEventObject: TDSConnectEventObject);
var
  session : TDSSession;
begin
  GrijjyLog.EnterMethod(self, 'DSServer1Disconnect' );

  Session := TDSSessionManager.GetThreadSession;

  session.Close;
  GrijjyLog.Send('DSConnectEventObject.ChannelInfo.Id', DSConnectEventObject.ChannelInfo.Id);
  GrijjyLog.Send('session id',                          session.id);
  GrijjyLog.Send('session name',                        session.UserName);

  GrijjyLog.ExitMethod(self, 'DSServer1Disconnect');
end;

procedure TServerContainer1.DSServer1Error(
  DSErrorEventObject: TDSErrorEventObject);
var
  session : TDSSession;
begin
  GrijjyLog.EnterMethod(self, 'DSServer1Error');

  Session := TDSSessionManager.GetThreadSession;
  GrijjyLog.Send('session id',                          session.id);
  GrijjyLog.Send('session name',                        session.UserName);
  GrijjyLog.Send('Error',                               DSErrorEventObject.Error.ToString, TgoLogLevel.Error);

  GrijjyLog.ExitMethod(self, 'DSServer1Error');
end;

procedure TServerContainer1.dsTextBlockGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_textblock.TdsTextBlock;
end;

procedure TServerContainer1.dsUpdaterGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_updater.TdsUpdater;
end;

procedure TServerContainer1.dsSitzungGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_sitzung.TdsSitzung;
end;

procedure TServerContainer1.dsStammDataGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_stamm.TStammMod;
end;

procedure TServerContainer1.dsStorageGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_storage.TdsStorage;
end;

procedure TServerContainer1.dsTaskEditGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_taskEdit.TdsTaskEdit;
end;

procedure TServerContainer1.dsTaskGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_taks.TdsTask;
end;

procedure TServerContainer1.dsTaskViewGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_taskView.TdsTaskView;
end;

procedure TServerContainer1.DSTCPServerTransport1Connect(
  Event: TDSTCPConnectEventObject);
begin
  GrijjyLog.EnterMethod(self, 'DSTCPServerTransport1Connect');
  Event.Channel.EnableKeepAlive(1000);

  GrijjyLog.Send('session', Event.Channel.SessionId);
  GrijjyLog.ExitMethod(self, 'DSTCPServerTransport1Connect');
end;

procedure TServerContainer1.DSTCPServerTransport1Disconnect(
  Event: TDSTCPDisconnectEventObject);
begin
  GrijjyLog.EnterMethod(self, 'DSTCPServerTransport1Disconnect');
  GrijjyLog.ExitMethod(self, 'DSTCPServerTransport1Disconnect');
end;

procedure TServerContainer1.dsTemplateGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_template.TdsTemplate;
end;

procedure TServerContainer1.dumpOnlineUser;
var
  i : integer;
  us : IServerUser;
begin
  GrijjyLog.EnterMethod(self, 'dumpOnlineUser');
  for i := 0 to pred(ous.Count) do begin
    us  := ous.Items[i];
    GrijjyLog.Send('user info', us.toText);
  end;
  GrijjyLog.ExitMethod(self, 'dumpOnlineUser');
end;

procedure TServerContainer1.dumpSessions;
var
  list    : TList<String>;
  s       : string;
  mngr    : TDSSessionManager;
  session : TDSSession;
  text    : TStringList;
begin
  list := m_sessions.LockList;
  text := TStringList.Create;
  try
    mngr := TDSSessionManager.Instance;
    for s in list do begin
      session := mngr.Session[ s ];
      if Assigned(session) then begin
        text.Add('user name :' +session.UserName);
        text.Add('id :'+intToStr(session.Id));
        text.Add('session name :'+session.SessionName);
        text.AddStrings(session.UserRoles);
        text.Add('#########################');
      end;
    end;
    GrijjyLog.Send('dump sessions', text);
  finally
    text.Free;
    m_sessions.UnlockList;
  end;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ServerContainer1.Controller(CtrlCode);
end;

function TServerContainer1.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TServerContainer1.removeUser(Session: TDSSession);
begin
  GrijjyLog.EnterMethod(self, 'removeUser');

  if Session.HasObject('ID') then begin
    if StrToIntDef(Session.GetData('ID'), -1) < 0 then
    begin
      GrijjyLog.send('no user id !');
      GrijjyLog.ExitMethod(self, 'removeUser');
      exit;
    end;
  end;

  if not Assigned(session) then begin
    GrijjyLog.send('no session!');
    GrijjyLog.ExitMethod(self, 'removeUser');
    exit;
  end;

  m_Lock.Enter;
  try
    GrijjyLog.send('session name', Session.UserName );
    GrijjyLog.send('session id', Session.Id );

    LockMod.removeLocks(Session.Id);
    ous.removeSessionID( Session.Id );
    HellMod.remove(Session.id);

  finally
    m_Lock.Leave;
  end;
  GrijjyLog.ExitMethod(self, 'removeUser');
end;

procedure TServerContainer1.BroadcastMessage(id: string; data: TJSONObject);
begin
  GrijjyLog.EnterMethod(self, 'BroadcastMessage');
  GrijjyLog.Send('Broadcast', id);
  GrijjyLog.Send('data', formatJSON(data) );

  DSServer1.BroadcastMessage(id, data);
  GrijjyLog.ExitMethod(self, 'BroadcastMessage');
end;

function TServerContainer1.DoContinue: Boolean;
begin
  Result := inherited;
  DSServer1.Start;
end;

procedure TServerContainer1.DoInterrogate;
begin
  inherited;
end;

function TServerContainer1.DoPause: Boolean;
begin
  DSServer1.Stop;
  Result := inherited;
end;

function TServerContainer1.DoStop: Boolean;
begin
  try
    DSServer1.Stop;
    DBMod.stopDB;
  except

  end;
  Result := inherited;
end;

procedure TServerContainer1.DSAuthenticationManager1UserAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
var
  Session   : TDSSession;
  userName  : string;
  ph        : string;

  function checkUser(userName : string ) : Boolean;
  begin
    Result := false;
    GrijjyLog.EnterMethod(self, 'DSAuthenticationManager1UserAuthenticate.CheckUser');

    QueryUser.ParamByName('net').AsString := userName;
    QueryUser.Open;
    if QueryUser.RecordCount = 1 then
    begin
      Result := (Password = '' ) and QueryUser.FieldByName('pe_pwd').AsString.IsEmpty;
      if not Result then
        Result := SameText( ph, QueryUser.FieldByName('pe_pwd').AsString)
    end;
    GrijjyLog.send('result', Result);
    GrijjyLog.ExitMethod(self, 'DSAuthenticationManager1UserAuthenticate.CheckUser');
  end;

  procedure broadcastUser(userName : string );
  begin
    userName := trim(StringReplace(userName, '*', '',[rfReplaceAll, rfIgnoreCase]));
    ph       := THashSHA2.GetHashString( LowerCase(userName)+m_secret+Password);

    valid := checkUser( userName );
    if valid then
    begin
      Session.PutData('ID',       '-1' );
      UserRoles.Add('broadcast');
    end;
  end;

  procedure downloadUser;
  begin
    Session.PutData('ID',       '-2' );
    UserRoles.Add('download');
    valid := true;
  end;

  procedure addUserRols( rols : string );
  begin
    UserRoles.DelimitedText := rols;
  end;

begin
  GrijjyLog.EnterMethod(self, 'DSAuthenticationManager1UserAuthenticate');
  valid   := false;
  userName:= LowerCase(User);

  if Length(userName) > MaxUserNameLength then begin
    GrijjyLog.Send('Exceed MaxUserNameLength', Length(userName));
    GrijjyLog.ExitMethod(self, 'DSAuthenticationManager1UserAuthenticate');
    exit;
  end;

  ph      := THashSHA2.GetHashString(Password);

  if IBTransaction1.Active then
    IBTransaction1.Rollback;
  try
    IBTransaction1.StartTransaction;

    Session := TDSSessionManager.GetThreadSession;

    GrijjyLog.send('thread id', GetCurrentThreadID );
    GrijjyLog.Send('user name', userName );

    if (userName = 'qwertzuiopmnbvcxy1234') and
       ( ph = '912f5ed6722678ad07c807a443f54982b11bdc0b43993c50411422c8a6c0bcda') then begin
      // download user ..
      downloadUser;
    end else if pos('*', userName) > 0 then begin
      // callback channel ...
      broadcastUser( userName);
    end else begin
      ph      := THashSHA2.GetHashString( LowerCase(userName)+m_secret+Password);
      // normal user
      GrijjyLog.send('session id', Session.Id );
      GrijjyLog.Send('session name', Session.UserName );

      // user exists ....
      valid := checkUser(userName);
      if valid then
      begin
        // is user admin?
        if QueryUser.FieldByName('PE_ID').AsInteger = 1 then
        begin
          Session.PutData('admin', 'true');
          Session.PutData('ID', '1' );
          addUserRols(QueryUser.FieldByName('PE_ROLS').AsString);
          Session.PutData('fullname', 'admin');
        end
        else begin
          //is user in, at least, one concile?
          GRPEQry.ParamByName('PE_ID').AsInteger := QueryUser.FieldByName('PE_ID').AsInteger;
          GRPEQry.Open();
          valid := GRPEQry.FieldByName('count').AsInteger > 0;
          GRPEQry.Close;

          Session.PutData('admin', 'false');
        end;

        if valid then begin
          Session.PutData('user',     userName);
          Session.PutData('ID',       QueryUser.FieldByName('PE_ID').AsString );
          Session.PutData('DRID',     QueryUser.FieldByName('DR_ID').AsString );
          Session.PutData('name',     QueryUser.FieldByName('pe_name').AsString);
          Session.PutData('vorname',  QueryUser.FieldByName('pe_vorname').AsString);
          Session.PutData('dept',     QueryUser.FieldByName('PE_DEPARTMENT').AsString);

          Session.PutData('fullname', Format('%s %s (%s)',
          [QueryUser.FieldByName('pe_vorname').AsString,
           QueryUser.FieldByName('pe_name').AsString,
           QueryUser.FieldByName('PE_DEPARTMENT').AsString]));

          addUserRols(QueryUser.FieldByName('PE_ROLS').AsString);
          if UserRoles.IndexOf('admin') >-1 then
            Session.PutData('admin', 'true');
        end;
      end;
    end;

    QueryUser.Close;
    IBTransaction1.Commit;
  except
    on e : exception do begin
      GrijjyLog.Send( e.ToString, Error);
      QueryUser.Close;
    end;
  end;
  if IBTransaction1.Active then begin
    IBTransaction1.Rollback;
    GrijjyLog.Send('Emergency rollback', Error);
  end;
  GrijjyLog.Send('user authenticate', valid);
  GrijjyLog.Send('user rols', UserRoles);

  GrijjyLog.ExitMethod(self, 'DSAuthenticationManager1UserAuthenticate');
end;

procedure TServerContainer1.DSAuthenticationManager1UserAuthorize(
  Sender: TObject; AuthorizeEventObject: TDSAuthorizeEventObject;
  var valid: Boolean);
var
  i : integer;
begin
//  GrijjyLog.EnterMethod(self, 'UserAuthorize');
//  GrijjyLog.Send('Authorise user rols', AuthorizeEventObject.UserRoles );

  // system action
  valid := not Assigned(AuthorizeEventObject.AuthorizedRoles) or
           not Assigned(AuthorizeEventObject.DeniedRoles);

  if not valid and Assigned(AuthorizeEventObject.AuthorizedRoles)  then begin
//    GrijjyLog.Send('Authorise auth rols', AuthorizeEventObject.AuthorizedRoles );
    for i := 0 to pred( AuthorizeEventObject.UserRoles.Count) do begin
      if AuthorizeEventObject.AuthorizedRoles.IndexOf(AuthorizeEventObject.UserRoles.Strings[i]) > -1 then begin
        valid := true;
        break;
      end;
    end;
  end;

  if not valid and Assigned(AuthorizeEventObject.DeniedRoles) then begin
//    GrijjyLog.Send('Authorise deny rols', AuthorizeEventObject.DeniedRoles );
    for i := 0 to pred( AuthorizeEventObject.UserRoles.Count) do begin
      if AuthorizeEventObject.DeniedRoles.IndexOf(AuthorizeEventObject.UserRoles.Strings[i]) > -1 then begin
        valid := false;
        break;
      end;
    end;
  end;
{
  if not valid then
    GrijjyLog.Send('Authorisation method', AuthorizeEventObject.MethodAlias, TgoLogLevel.Error );

  GrijjyLog.Send('Authorisation', valid );
  GrijjyLog.ExitMethod(self, 'UserAuthorize');}
end;

procedure TServerContainer1.dsChapterGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_chapter.TdsChapter;
end;

procedure TServerContainer1.dsDairyGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_dairy.TdsDairy;
end;

procedure TServerContainer1.dsEpubGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_epub.TdsEpub;
end;

procedure TServerContainer1.dsFileCacheGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_fileCache.TdsFileCache;
end;

procedure TServerContainer1.dsFileGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_file.TdsFile;
end;

procedure TServerContainer1.dsGremiumGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_gremium.TDSGremium;
end;

procedure TServerContainer1.dsImageGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_image.TdsImage;
end;

procedure TServerContainer1.dsMeeingGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_meeting.TdsMeeing;
end;

procedure TServerContainer1.dsMiscGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_misc.TdsMisc;
end;

procedure TServerContainer1.dsPersonGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_person.TdsPerson;
end;

procedure TServerContainer1.dsPKIGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_pki.TdsPKI;
end;

procedure TServerContainer1.dsProtocolGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_protocol.TdsProtocol;
end;

procedure TServerContainer1.ServiceCreate(Sender: TObject);
begin
  GrijjyLog.Service := 'Archivar';
  GrijjyLog.SetLogLevel(TgoLogLevel.Info);

  LockMod     := TLockMod.create(self);
  GM          := TGM.Create(self);
  FileServer  := TFileServer.create(self);
  DBMod       := TDBMod.Create(self);
  HellMod     := THellMod.create(self );
  m_lock      := TCriticalSection.Create;
  m_sessions  := TThreadList<String>.create;

  m_secret    := IniOptions.SecretName;


  FileServer.createUpdaterZIP;
  DSTCPServerTransport1.Port := IniOptions.DSport;

  TDSSessionManager.Instance.AddSessionEvent(
    procedure(Sender: TObject;
              const EventType: TDSSessionEventType;
              const Session: TDSSession)
    var
      list  : TList<String>;
      inx   : integer;
    begin

      list := m_sessions.LockList;
      try
        case EventType of
          SessionCreate :
            begin
              grijjyLog.Send('new session', session.SessionName);
              if list.IndexOf(session.SessionName) = -1 then
                list.Add(session.SessionName);

            end;

          SessionClose  :
            begin
              grijjyLog.Send('delete session', session.SessionName);
              inx := list.IndexOf(session.SessionName);
              if  inx <> -1 then
                list.Delete(inx);
              removeUser(Session);
            end;
        end;
      finally
        m_sessions.UnlockList;
      end;
    end);
end;

procedure TServerContainer1.ServiceDestroy(Sender: TObject);
begin
//  m_Lock.
  m_sessions.Free;
end;

procedure TServerContainer1.ServiceStart(Sender: TService; var Started: Boolean);
begin
  GrijjyLog.EnterMethod(self, 'ServiceStart');
  try
    DBMod.startDB;
    FileServer.start;
    DSServer1.Start;
    Started := true;
  except
    on e : exception do begin
      GrijjyLog.Send('exception:', e.ToString, TgoLogLevel.Error);
      Started := false;
    end;
  end;
  GrijjyLog.Send('started:', Started);
  GrijjyLog.ExitMethod(self, 'ServiceStart');
end;

procedure TServerContainer1.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  GrijjyLog.EnterMethod(self, 'ServiceStop');
  DSServer1.Stop;
  FileServer.stop;
  DBMod.stopDB;
  Stopped := true;
  GrijjyLog.ExitMethod( self, 'ServiceStop');
end;

procedure TServerContainer1.startLogging;
begin
  GrijjyLog.Connect(GrijjyLog.DEFAULT_BROKER, GrijjyLog.Service );
end;

end.

