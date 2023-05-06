unit ServerContainerUnit1;

interface

uses
  Grijjy.CloudLogging, System.SysUtils, System.Classes,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  IPPeerServer, Datasnap.DSAuth, DbxSocketChannelNative,
  DbxCompressionFilter, Vcl.SvcMgr, m_glob_server, Data.DB,
  m_lockMod, Datasnap.DSSession, i_user,
  System.JSON,
  System.SyncObjs, System.Generics.Collections, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, MidasLib, u_serverTimer,
  Datasnap.DSHTTP, Data.DBXCommon, Data.DBCommonTypes, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, u_MailHandler;

type
  TArchivService = class(TService)
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
    DSHTTPService1: TDSHTTPService;
    DSHTTPService2: TDSHTTPService;
    DSCertFiles1: TDSCertFiles;
    dsPlugin: TDSServerClass;
    dsImport: TDSServerClass;
    dsMail: TDSServerClass;
    MailKonto: TFDTable;
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
    procedure DSCertFiles1GetPEMFilePasskey(ASender: TObject;
      var APasskey: AnsiString);
    function DSServer1Trace(TraceInfo: TDBXTraceInfo): CBRType;
    procedure dsPluginGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsImportGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsMailGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    const
      MaxUserNameLength = 25;
  private
    m_timer : TServerTimer;
    m_secret : string;
    m_Lock : TCriticalSection;
    m_sessions : TThreadList<String>;
    m_log : string;

    m_mailHandler : TMailHandler;

    procedure removeUser( Session: TDSSession );
    procedure createTimer;
    procedure execShutdown( sender : TObject );
    procedure execTimeToDie( sender : TObject );

    procedure fillMailHandler;
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

    procedure Shutdown( value : integer );
  end;

var
  ArchivService: TArchivService;

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
  ds_updater, ds_stamm, ds_pki, ds_dairy, ds_storage, WinApi.WinSvc,
  u_Konst, Winapi.Messages, m_http, m_del_files, system.DateUtils, m_mail,
  ds_plugin, ds_import, ds_mail;

procedure TArchivService.dsAdminGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_admin.TAdminMod;
end;

procedure TArchivService.DSServer1Connect(
  DSConnectEventObject: TDSConnectEventObject);
var
  Session : TDSSession;
  f : TextFile;
begin

  GrijjyLog.EnterMethod(self, 'DSServer1Connect');
  Session := TDSSessionManager.GetThreadSession;

  GrijjyLog.Send('DSConnectEventObject.ChannelInfo.Id', DSConnectEventObject.ChannelInfo.Id);
  GrijjyLog.Send('session id',                          session.id);
  GrijjyLog.Send('session name',                        session.UserName);
  GrijjyLog.Send('remote host',                         DSConnectEventObject.ChannelInfo.ClientInfo.IpAddress);

  AssignFile(f, m_log);
  Append(f);
  try
    WriteLN(f, Format('connect: IP:%s Port:%s Protocol:%s App:%s',
      [
       DSConnectEventObject.ChannelInfo.ClientInfo.IpAddress,
       DSConnectEventObject.ChannelInfo.ClientInfo.ClientPort,
       DSConnectEventObject.ChannelInfo.ClientInfo.Protocol,
       DSConnectEventObject.ChannelInfo.ClientInfo.AppName
      ]));
  finally
    CloseFile(f);
  end;

  GrijjyLog.ExitMethod(self, 'DSServer1Connect');
end;

procedure TArchivService.DSServer1Disconnect(
  DSConnectEventObject: TDSConnectEventObject);
var
  session : TDSSession;
begin
  GrijjyLog.EnterMethod(self, 'DSServer1Disconnect' );

  Session := TDSSessionManager.GetThreadSession;

//  session.Close;
  GrijjyLog.Send('DSConnectEventObject.ChannelInfo.Id', DSConnectEventObject.ChannelInfo.Id);
  GrijjyLog.Send('session id',                          session.id);
  GrijjyLog.Send('session name',                        session.UserName);

  GrijjyLog.ExitMethod(self, 'DSServer1Disconnect');
end;

procedure TArchivService.DSServer1Error(
  DSErrorEventObject: TDSErrorEventObject);
var
  session : TDSSession;
begin
  GrijjyLog.EnterMethod(self, 'DSServer1Error');

  Session := TDSSessionManager.GetThreadSession;
  GrijjyLog.Send('session id',                          session.id);
  GrijjyLog.Send('session name',                        session.UserName);
  GrijjyLog.Send('Error',                               DSErrorEventObject.Error.ToString, TgoLogLevel.Error);

  if IBTransaction1.Active then
     IBTransaction1.Rollback;

  GrijjyLog.ExitMethod(self, 'DSServer1Error');

end;

function TArchivService.DSServer1Trace(TraceInfo: TDBXTraceInfo): CBRType;
begin
  Result := cbrCONTINUE;
end;

procedure TArchivService.dsTextBlockGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_textblock.TdsTextBlock;
end;

procedure TArchivService.dsUpdaterGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_updater.TdsUpdater;
end;

procedure TArchivService.dsSitzungGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_sitzung.TdsSitzung;
end;

procedure TArchivService.dsStammDataGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_stamm.TStammMod;
end;

procedure TArchivService.dsStorageGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_storage.TdsStorage;
end;

procedure TArchivService.dsTaskEditGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_taskEdit.TdsTaskEdit;
end;

procedure TArchivService.dsTaskGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_taks.TdsTask;
end;

procedure TArchivService.dsTaskViewGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_taskView.TdsTaskView;
end;

procedure TArchivService.DSTCPServerTransport1Connect(
  Event: TDSTCPConnectEventObject);
begin
  GrijjyLog.EnterMethod(self, 'DSTCPServerTransport1Connect');

  Event.Channel.EnableKeepAlive(1000);
  GrijjyLog.Send('session', Event.Channel.SessionId);
  GrijjyLog.Send('connection', Event.Connection );

  GrijjyLog.ExitMethod(self, 'DSTCPServerTransport1Connect');
end;

procedure TArchivService.DSTCPServerTransport1Disconnect(
  Event: TDSTCPDisconnectEventObject);
begin
  GrijjyLog.EnterMethod(self, 'DSTCPServerTransport1Disconnect');
  GrijjyLog.Send('connection', Event.Connection );
  GrijjyLog.ExitMethod(self, 'DSTCPServerTransport1Disconnect');
end;

procedure TArchivService.dsTemplateGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_template.TdsTemplate;
end;

procedure TArchivService.dumpOnlineUser;
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

procedure TArchivService.dumpSessions;
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
  ArchivService.Controller(CtrlCode);
end;

procedure SimKeyEvent(VirtualKey : Integer; Flags : LongWord);
var
  KeybdInput : TagKeybdInput;
  Input : TagInput;
begin
  KeybdInput.wVk := VirtualKey;
  KeybdInput.dwFlags := Flags;
  KeybdInput.dwExtraInfo := 0;
  KeybdInput.wScan := 0;
  KeybdInput.time := 0;

  Input.Itype := INPUT_KEYBOARD;
  Input.ki := KeybdInput;

  SendInput(1, Input, SizeOf(Input));
end;

procedure TArchivService.execShutdown(sender: TObject);
var
  obj  : TJSONObject;
{$ifdef DEBUG}
  hnd : HWND;
{$endif}
begin
  // Send close Edits
  obj  := TJSONObject.Create;
  JReplace( obj, 'action', BRD_ADMIN);
  JReplace( obj, 'cmd',    BRD_ADMIN_CLOSE_EDIT);
  BroadcastMessage(BRD_CHANNEL, obj);

  // Send terminate !!
  obj  := TJSONObject.Create;
  JReplace( obj, 'action',  BRD_ADMIN);
  JReplace( obj, 'cmd',     BRD_ADMIN_TERMINATE);
  BroadcastMessage(BRD_CHANNEL, obj);


{$ifdef DEBUG}
  hnd := FindWindow('ConsoleWindowClass', PWideChar(ParamStr(0))) ;
  PostMessage( hnd, WM_CLOSE, 0, 0 );
{$else}
  ServiceController(SERVICE_CONTROL_STOP);
{$endif}
end;

procedure TArchivService.execTimeToDie(sender: TObject);
var
  DeleteFilesMod : TDeleteFilesMod;
begin
  GrijjyLog.EnterMethod(self, 'execTimeToDie');
  DeleteFilesMod := TDeleteFilesMod.create(self);
  try
    DeleteFilesMod.TimeToDie;
  finally

  end;
  DeleteFilesMod.Free;
  GrijjyLog.ExitMethod(self, 'execTimeToDie');
end;

procedure TArchivService.fillMailHandler;
var
  data : TJSONObject;
  bst  : TStream;
begin
  MailKonto.Open;
  while not MailKonto.Eof do begin
    if MailKonto.FieldByName('MAC_ACTIVE').AsString = 'T' then begin
      bst := MailKonto.CreateBlobStream(MailKonto.FieldByName('MAC_DATA'), bmRead);
      try
        data := loadJSON(bst);
        JReplace(data, 'kontoname', MailKonto.FieldByName('MAC_TITLE').AsString);
        JReplace(data, 'kontoid', MailKonto.FieldByName('MAC_ID').AsInteger);
        m_mailHandler.addMail( data);
      except
      end;
    end;
    MailKonto.Next;
  end;
  MailKonto.Close;

  if MailKonto.Transaction.Active then
    MailKonto.Transaction.Commit;

end;

function TArchivService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TArchivService.removeUser(Session: TDSSession);
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

procedure TArchivService.BroadcastMessage(id: string; data: TJSONObject);
begin
  GrijjyLog.EnterMethod(self, 'BroadcastMessage');
  GrijjyLog.Send('Broadcast', id);
  GrijjyLog.Send('data', formatJSON(data) );

  DSServer1.BroadcastMessage(id, data);
  GrijjyLog.ExitMethod(self, 'BroadcastMessage');
end;

procedure TArchivService.createTimer;
begin
  if not Assigned(m_timer) then begin
    m_timer := TServerTimer.Create;
  end;
end;

function TArchivService.DoContinue: Boolean;
begin
  Result := inherited;
  DSServer1.Start;
end;

procedure TArchivService.DoInterrogate;
begin
  inherited;
end;

function TArchivService.DoPause: Boolean;
begin
  DSServer1.Stop;
  Result := inherited;
end;

function TArchivService.DoStop: Boolean;
begin
  try
    DSServer1.Stop;
    DBMod.stopDB;
  except

  end;
  Result := inherited;
end;

procedure TArchivService.DSAuthenticationManager1UserAuthenticate(
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
    GrijjyLog.Send(Format('username:%s', [username]));
    if Password = '' then
      GrijjyLog.Send('leeres Password');


    QueryUser.ParamByName('net').AsString := userName;
    QueryUser.Open;
    if QueryUser.RecordCount = 1 then
    begin
      Result := (Password = '' ) and
        ( QueryUser.FieldByName('pe_pwd').IsNull or
          (QueryUser.FieldByName('pe_pwd').AsString = '')
        );

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
  try
    GrijjyLog.EnterMethod(self, 'DSAuthenticationManager1UserAuthenticate');
    m_Lock.Acquire;
    valid   := false;
    userName:= LowerCase(User);

    if Length(userName) > MaxUserNameLength then begin
      GrijjyLog.Send('Exceed MaxUserNameLength', Length(userName));
      GrijjyLog.ExitMethod(self, 'DSAuthenticationManager1UserAuthenticate');
      m_Lock.Release;
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
            GrijjyLog.send('Check ob in Gremium:', valid );

            Session.PutData('admin', 'false');
          end;

          if valid then begin
            Session.PutData('user',     userName);
            Session.PutData('ID',       QueryUser.FieldByName('PE_ID').AsString );
            if not  QueryUser.FieldByName('DR_ID').IsNull then
              Session.PutData('DRID',     QueryUser.FieldByName('DR_ID').AsString )
            else
              Session.PutData('DRID',     '0' );

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
        if QueryUser.Active then
          QueryUser.Close;
      end;
    end;

    if IBTransaction1.Active then begin
      IBTransaction1.Rollback;
      GrijjyLog.Send('Emergency rollback', Error);
    end;
    GrijjyLog.Send('user authenticate', valid);
    GrijjyLog.Send('user rols', UserRoles);
  finally
    m_Lock.Release;
  end;
  GrijjyLog.ExitMethod(self, 'DSAuthenticationManager1UserAuthenticate');
end;

procedure TArchivService.DSAuthenticationManager1UserAuthorize(
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

procedure TArchivService.DSCertFiles1GetPEMFilePasskey(ASender: TObject;
  var APasskey: AnsiString);
begin
  APasskey := AnsiString(IniOptions.sslpassword);
end;

procedure TArchivService.dsChapterGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_chapter.TdsChapter;
end;

procedure TArchivService.dsDairyGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_dairy.TdsDairy;
end;

procedure TArchivService.dsEpubGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_epub.TdsEpub;
end;

procedure TArchivService.dsFileCacheGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_fileCache.TdsFileCache;
end;

procedure TArchivService.dsFileGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_file.TdsFile;
end;

procedure TArchivService.dsGremiumGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_gremium.TDSGremium;
end;

procedure TArchivService.dsImageGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_image.TdsImage;
end;

procedure TArchivService.dsImportGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_import.TDSImport;
end;

procedure TArchivService.dsMailGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_mail.TDSMail;
end;

procedure TArchivService.dsMeeingGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_meeting.TdsMeeing;
end;

procedure TArchivService.dsMiscGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_misc.TdsMisc;
end;

procedure TArchivService.dsPersonGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_person.TdsPerson;
end;

procedure TArchivService.dsPKIGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_pki.TdsPKI;
end;

procedure TArchivService.dsPluginGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_plugin.TTdsPlugin;
end;

procedure TArchivService.dsProtocolGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_protocol.TdsProtocol;
end;

procedure TArchivService.ServiceCreate(Sender: TObject);
var
  f : TExtFile;
begin
  GrijjyLog.Service := 'Archivar';
  GrijjyLog.SetLogLevel(TgoLogLevel.Info);

  m_mailHandler := TMailHandler.create;

  SetCurrentDirectory(PWchar(ExtractFilePath(paramStr(0))));
  LockMod     := TLockMod.create(self);
  GM          := TGM.Create(self);
  HttpMod     := THttpMod.Create(self);
  DBMod       := TDBMod.Create(self);
  HellMod     := THellMod.create(self );
  m_lock      := TCriticalSection.Create;
  m_sessions  := TThreadList<String>.create;
  MailMod     := TMailMod.Create(self);

  MailMod.loadSmtp;

  m_secret    := IniOptions.SecretName;
  m_timer     := NIL;

  m_log       := ExpandFileName(IniOptions.pathlog);
  ForceDirectories(m_log);

  m_log       := TPath.Combine(m_log, 'ds.log');
  AssignFile(f, m_log);
  if not FileExists(m_log) then
    Rewrite(f)
  else
    Append(f);
  try
    WriteLN(f, Format('started at : %s', [DateTimeToStr(now)]));
  finally
    CloseFile(f);
  end;

  DSTCPServerTransport1.Port  := IniOptions.DStcpport;
  DSHTTPService1.HttpPort     := IniOptions.DShttpport;
  DSHTTPService2.HttpPort     := IniOptions.DShttpsport;

  DSCertFiles1.CertFile       := ExpandFileName(IniOptions.sslcrt);
  DSCertFiles1.KeyFile        := ExpandFileName(IniOptions.sslkey);
  DSCertFiles1.RootCertFile   := ExpandFileName(IniOptions.sslrootcrt);

  grijjyLog.Send('CertFile:', DSCertFiles1.CertFile);
  grijjyLog.Send('KeyFile:', DSCertFiles1.KeyFile);
  grijjyLog.Send('RootCrtFile:', DSCertFiles1.RootCertFile);


  TDSSessionManager.Instance.AddSessionEvent(
    procedure(Sender: TObject;
              const EventType: TDSSessionEventType;
              const Session: TDSSession)
    var
      list  : TList<String>;
      inx   : integer;
    begin
      grijjyLog.EnterMethod(self, 'AddSessionEvent');
      grijjyLog.Send('Session', Session);
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
      grijjyLog.ExitMethod(self, 'AddSessionEvent');
    end);

end;

procedure TArchivService.ServiceDestroy(Sender: TObject);
begin
  try
  if Assigned(m_timer) then
    m_timer.Terminate;
  m_sessions.Free;

  m_mailHandler.free;
  except
    on e : exception do
      GrijjyLog.Send(e.ToString);
  end;
end;

procedure TArchivService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  GrijjyLog.EnterMethod(self, 'ServiceStart');
  createTimer;

  m_timer.newTimer(3, 1, true, execTimeToDie);

  try
    DBMod.startDB;

    if DSHTTPService1.HttpPort > 0 then begin
      try
        DSHTTPService1.Server := DSServer1;
      except
        on e : exception do begin
          GrijjyLog.Send('Http-Service:'+e.ToString, TgoLogLevel.Error );
        end;
      end;
    end;
    if DSHTTPService2.HttpPort > 0 then begin
      try
        DSHTTPService2.Server := DSServer1;
      except
        on e : exception do begin
          GrijjyLog.Send('Https-Service:'+e.ToString, TgoLogLevel.Error );
        end;
      end;
    end;

    try
      DSServer1.Start;
    except
      on e : exception do begin
        GrijjyLog.Send('DSServer:'+e.ToString, TgoLogLevel.Error );
      end;
    end;
    GrijjyLog.Send('Http-Service:', DSHTTPService1.Active );
    GrijjyLog.Send('Https-Service:', DSHTTPService2.Active );

    if SameText(IniOptions.DNLactive, 'true') and (IniOptions.DNLport >0 ) then
      HttpMod.start(IniOptions.DNLport);

    Started := DSServer1.Started and DBMod.Started;

  except
    on e : exception do begin
      GrijjyLog.Send('exception:', e.ToString, TgoLogLevel.Error);
      Started := false;
    end;
  end;

  fillMailHandler;

  m_mailHandler.start;
  GrijjyLog.Send('started:', Started);
  GrijjyLog.ExitMethod(self, 'ServiceStart');
end;

procedure TArchivService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  GrijjyLog.EnterMethod(self, 'ServiceStop');
  try
    m_mailHandler.stop;

    try
    DSServer1.Stop;
    except

    end;

    DBMod.stopDB;
    HttpMod.ende;

    m_timer.Terminate;
    m_timer := NIL;

  except
    on e : exception do
      GrijjyLog.Send(e.ToString, TgoLogLevel.Error );
  end;
  Stopped := true;
  GrijjyLog.ExitMethod( self, 'ServiceStop');
end;

procedure TArchivService.Shutdown(value: integer);
begin
  m_timer.newTimer( value * 1000, false, execShutdown);
end;

procedure TArchivService.startLogging;
begin
  GrijjyLog.Connect(GrijjyLog.DEFAULT_BROKER, GrijjyLog.Service );
end;

end.
