unit ServerContainerUnit1;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  IPPeerServer, IPPeerAPI, Datasnap.DSAuth, DbxSocketChannelNative,
  DbxCompressionFilter, Vcl.SvcMgr, m_glob_server, IBX.IBDatabase, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery, m_lockMod, Datasnap.DSSession, i_user,
  System.JSON, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer;

type
  TServerContainer1 = class(TService)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    dsAdmin: TDSServerClass;
    dsGremium: TDSServerClass;
    DSAuthenticationManager1: TDSAuthenticationManager;
    dsPerson: TDSServerClass;
    dsTask: TDSServerClass;
    QueryUser: TIBQuery;
    IBTransaction1: TIBTransaction;
    dsFile: TDSServerClass;
    dsMisc: TDSServerClass;
    dsProtocol: TDSServerClass;
    dsImage: TDSServerClass;
    dsChapter: TDSServerClass;
    dsTaskEdit: TDSServerClass;
    dsTemplate: TDSServerClass;
    dsTaskView: TDSServerClass;
    DSServerClass1: TDSServerClass;
    dsFileCache: TDSServerClass;
    dsEpub: TDSServerClass;
    dsMeeing: TDSServerClass;
    dsSitzung: TDSServerClass;
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
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
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
  private
    const
      MaxUserNameLength = 25;
  procedure removeUser( id : NativeInt );
  protected
    function DoStop: Boolean; override;
    function DoPause: Boolean; override;
    function DoContinue: Boolean; override;
    procedure DoInterrogate; override;
  public
    function GetServiceController: TServiceController; override;

    procedure BroadcastMessage( id : string ; data : TJSONObject );
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
  ds_meeting, System.Hash, u_json, ds_sitzung, m_hell;

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
  Session := TDSSessionManager.GetThreadSession;

  DebugMsg('Connect::connect      : ' + IntToStr(DSConnectEventObject.ChannelInfo.Id));
  DebugMsg('Connect::session id   : ' + intToStr(Session.Id));
  DebugMsg('Connect::Session name : ' + Session.UserName);
  DebugMsg('Connect::remote host  : ' + DSConnectEventObject.ChannelInfo.ClientInfo.IpAddress);
  DebugMsg('');
end;

procedure TServerContainer1.DSServer1Disconnect(
  DSConnectEventObject: TDSConnectEventObject);
var
  session : TDSSession;
begin
  Session := TDSSessionManager.GetThreadSession;
  if Assigned(session) then
  begin
    removeUser(session.Id);
  end;
  DebugMsg(  'Disconnect::disconnect : ' + IntToStr(DSConnectEventObject.ChannelInfo.Id));
  DebugMsg('');
end;

procedure TServerContainer1.DSServer1Error(
  DSErrorEventObject: TDSErrorEventObject);
begin
  DebugMsg('Error::DS Server Error: '+DSErrorEventObject.Error.ToString);
  DebugMsg('');
end;

procedure TServerContainer1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_textblock.TdsTextBlock;
end;

procedure TServerContainer1.dsSitzungGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_sitzung.TdsSitzung;
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
  Event.Channel.EnableKeepAlive(1000);
  DebugMsg('connect '+Event.Channel.SessionId);
end;

procedure TServerContainer1.DSTCPServerTransport1Disconnect(
  Event: TDSTCPDisconnectEventObject);
begin
  DebugMsg('disconnect ');
end;

procedure TServerContainer1.dsTemplateGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_template.TdsTemplate;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ServerContainer1.Controller(CtrlCode);
end;

function TServerContainer1.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TServerContainer1.removeUser(id: NativeInt);
begin
  LockMod.removeLocks(Id);
  DebugMsg('removeUser::session id : ' + intToStr( Id ));
  ous.removeSessionID( Id );
  HellMod.remove(id);

  if not ous.isSessionOnline(id) then
  begin
    TDSSessionManager.Instance.ForEachSession(
      procedure(const Session: TDSSession)
      begin
        if Session.Id = id  then begin
          Session.Close;
        end;
      end);
  end;
end;

procedure TServerContainer1.BroadcastMessage(id: string; data: TJSONObject);
begin
  DebugMsg('Broadcast : '+id);
  DebugMsg(formatJSON(data));

  DSServer1.BroadcastMessage(id, data);
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

  function checkUser : Boolean;
  begin
    Result := false;

    QueryUser.ParamByName('net').AsString := userName;
    QueryUser.Open;
    if QueryUser.RecordCount = 1 then
    begin
      Result := SameText( ph, QueryUser.FieldByName('pe_pwd').AsString);
    end;
  end;
begin
  valid   := false;
  userName:= LowerCase(User);

  if Length(userName) > MaxUserNameLength then exit;

  ph      := THashSHA2.GetHashString(Password);

  if IBTransaction1.InTransaction then IBTransaction1.Rollback;
  IBTransaction1.StartTransaction;

  Session := TDSSessionManager.GetThreadSession;

  DebugMsg('UserAuthenticate::user thread id  :'+IntToStr(GetCurrentThreadID));
  DebugMsg('UserAuthenticate::user :' +userName);
  // callback channel ...
  if pos('*', userName) > 0 then
  begin
    userName := trim(StringReplace(userName, '*', '',[rfReplaceAll, rfIgnoreCase]));

    valid := checkUser;
    if valid then
    begin
      Session.PutData('ID',       '-1' );
      UserRoles.Add('broadcast');
    end;
  end
  else
  begin
    // normal user
    DebugMsg('UserAuthenticate::session id   : '  + intToStr(Session.Id));
    DebugMsg('UserAuthenticate::Session name : '  + Session.UserName);

    valid := checkUser;
    if valid then
    begin
      Session.PutData('user',     userName);
      Session.PutData('ID',       QueryUser.FieldByName('PE_ID').AsString );
      Session.PutData('name',     QueryUser.FieldByName('pe_name').AsString);
      Session.PutData('vorname',  QueryUser.FieldByName('pe_vorname').AsString);
      Session.PutData('dept',     QueryUser.FieldByName('PE_DEPARTMENT').AsString);

      if QueryUser.FieldByName('PE_ID').AsInteger = 1 then
      begin
        Session.PutData('admin', 'true');
        UserRoles.Add('admin');
      end
      else
        Session.PutData('admin', 'false');

      UserRoles.Add('user');
    end;
  end;

  if valid then
    debugMsg( 'UserAuthenticate::Login ok');

  QueryUser.Close;
  IBTransaction1.Commit;

  DebugMsg('');
end;

procedure TServerContainer1.DSAuthenticationManager1UserAuthorize(
  Sender: TObject; AuthorizeEventObject: TDSAuthorizeEventObject;
  var valid: Boolean);
begin
  valid := true;
end;

procedure TServerContainer1.dsChapterGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_chapter.TdsChapter;
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

procedure TServerContainer1.dsProtocolGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ds_protocol.TdsProtocol;
end;

procedure TServerContainer1.ServiceCreate(Sender: TObject);
begin
  LockMod := TLockMod.create(self);
  GM      := TGM.Create(self);
  DBMod   := TDBMod.Create(self);
  HellMod := THellMod.create(self );

  DSTCPServerTransport1.Port := GM.DSPort;

  TDSSessionManager.Instance.AddSessionEvent(
    procedure(Sender: TObject;
              const EventType: TDSSessionEventType;
              const Session: TDSSession)
    begin
      case EventType of
        SessionCreate :;// DebugMsg('session create '+IntToStr(Session.Id));
        SessionClose  : removeUser(Session.Id); //  DebugMsg('session closed '+IntToStr(Session.Id));
      end;
    end);
end;

procedure TServerContainer1.ServiceStart(Sender: TService; var Started: Boolean);
begin
  try
    DBMod.startDB;
    DSServer1.Start;
    Started := true;
  except
    Started := false;
  end;
end;

procedure TServerContainer1.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  DSServer1.Start;
  DBMod.startDB;
  Stopped := true;
end;

end.

