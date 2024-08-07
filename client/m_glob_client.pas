unit m_glob_client;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, Data.DB, Data.SqlExpr, Winapi.Messages, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Generics.Collections, u_gremium, u_stub, System.JSON,
  Datasnap.DSCommon,
  Data.DBXJSON, pngimage, Vcl.ImgList, Vcl.Controls,
  u_berTypes, Datasnap.DSConnect, i_personen, Vcl.Dialogs,
  JvSHFileOperation, System.Notification,
  DbxCompressionFilter, u_ShowMessageTimeOut, Data.DbxHTTPLayer, Vcl.ExtCtrls,
  JvBaseDlg,
  JvComponentBase, u_pluginManager, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, REST.OpenSSL;

const
  WMUSER            = WM_USER + 25;
  msgConnected      = WMUSER ;
  msgDisconnected   = WMUSER + 1;
  msgStatus         = WMUSER + 2;
  msgUpdateGr       = WMUSER + 3;
  msgFilterTasks    = WMUSER + 4;
  msgNewTask        = WMUSER + 5;
  msgNewBookMark    = WMUSER + 6;
  msgRemoveBookmark = WMUSER + 7;
  msgLoadLogo       = WMUSER + 8;
  msgUpdateGremium  = WMUSER + 9;
  msgUpdateMeetings = WMUSER + 10;
  msgEditMeeting    = WMUSER + 11;
  msgLogin          = WMUSER + 12;
  msgNewMeeting     = WMUSER + 13;
  msgDoMeeting      = WMUSER + 14;
  msgMeetingEnd     = WMUSER + 15;
  msgRetryLogin     = WMUSER + 16;
  msgShowFileCache  = WMUSER + 17;
  msgNeedKeys       = WMUSER + 18;
  msgUpdateTaskList = WMUSER + 19;
  msgDeleteMeeting  = WMUSER + 20;
type
  TGM = class(TDataModule)
    SQLConnection1: TSQLConnection;
    DeleteTimesTab: TFDMemTable;
    DeleteTimesTabFD_ID: TIntegerField;
    DeleteTimesTabFD_NAME: TStringField;
    DeleteTimesTabFD_MONATE: TIntegerField;
    DSClientCallbackChannelManager1: TDSClientCallbackChannelManager;
    ImageList1: TImageList;
    ImageList2: TImageList;
    DSProviderConnection1: TDSProviderConnection;
    GremiumMA: TClientDataSet;
    JvSHFileOperation1: TJvSHFileOperation;
    NotificationCenter1: TNotificationCenter;
    PingTimer: TTimer;
    procedure SQLConnection1AfterConnect(Sender: TObject);
    procedure SQLConnection1AfterDisconnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure SQLConnection1BeforeDisconnect(Sender: TObject);
    procedure PingTimerTimer(Sender: TObject);
  private
    FIsAdmin  : boolean;
    FUserID   : integer;
    FUserName : string;
    FVorname  : string;
    FName     : string;

    m_public  : string;
    m_home    : string;
    m_export  : string;
    m_images  : string;
    m_httpHome: string;
    m_epubHome: string;
    m_cache   : string;

    m_misc    : TdsMiscClient;
    m_gremien : TList<TGremium>;

    m_imageNames : TDictionary<string,integer>;

    m_hostList  : TStringList;
    m_userList  : TStringList;

    m_LoginFailCount  : integer;
    FUserFolder: integer;

    m_plugins : TPluginManager;

    procedure setIsAdmin( value : boolean );

    procedure FillTimes( arr :TJSONArray );
    procedure clearGrmien;

    procedure checkimages;
    procedure checkImage( obj : TJSONObject; client : TdsImageClient );

    procedure requestUser;

    function downloadimage( name : string;client : TdsImageClient) :  boolean;
    procedure CreateDirs;

    function handle_admin         ( const Arg: TJSONObject ) : boolean;
    function handle_taskmove      ( const Arg: TJSONObject ) : boolean;
    function handle_taskdelete    ( const Arg: TJSONObject ) : boolean;
    function handle_newmeeting    ( const Arg: TJSONObject ) : boolean;
    function handle_deletemeeting ( const Arg: TJSONObject ) : boolean;
    function handle_updatemeeting ( const Arg: TJSONObject ) : boolean;
    function handle_task_assign   ( const arg: TJSONObject ) : boolean;

    procedure checkOrDownloadKeys;

    procedure setProxy;

  public
    function Connect : boolean;
    procedure Disconnect;


    property IsAdmin    : boolean         read FIsAdmin     write setIsAdmin;
    property UserName   : string          read FUserName    write FUserName;
    property Vorname    : string          read FVorname     write FVorname;
    property Name       : string          read FName        write FName;
    property UserID     : integer         read FUserID      write FUserID;
    property UserFolder : integer         read FUserFolder  write FUserFolder;

    property PublicPath : string          read m_public;
    property Home       : string          read m_home;
    property ExportDir  : string          read m_export;
    property Images     : string          read m_images;
    property Gremien    : TList<TGremium> read m_gremien;
    property wwwHome    : string          read m_httpHome;
    property ePubHome   : string          read m_epubHome;
    property Cache      : string          read m_cache;

    property Hostlist   : TStringList     read m_hostList;
    property UserList   : TStringList     read m_userList;

    property Plugins    : TPluginManager  read m_plugins;

    property MiscIF    : TdsMiscClient    read m_misc;

    procedure FillGremien( arr :TJSONArray );

    function  LockDocument(   id, typ : integer; subid : integer = 0 ) : TJSONObject;
    function  UnLockDocument( id, typ : integer; subid : integer = 0 ) : TJSONObject;
    function  isLocked(       id, typ : integer; subid : integer = 0 ) : TJSONObject;
    function  LockedFlag(     id, typ : integer ) : boolean;
    procedure ShowLockInfo(   data    : TJSONObject);

    function  GremiumName( id : integer ) : string;

    function isValidTask( id : integer; dt : tDocType ) : Boolean;

    function md5( fname : string  ) : string; overload;
    function md5( st    : TStream ) : string; overload;

    function download( fname : string ; st : TStream ) : boolean;
    function getImageID( name : string ) : Integer;
    function GetShortImage( name : string ) : integer;

    function autoInc( name : string ) : integer;

    function getGremiumMA( id : integer ) : IPersonenListe;
    function getGremium( id : integer ) : TGremium;
    function getUserList: TJSONobject;

    procedure changeStatus( text : string );

    procedure loadHostList;
    procedure saveHostList;

    procedure loadUserlist;
    procedure saveUserList;

    function getHostName : string;

    procedure checkWWWRoot;

    function calcSize( size : int64 ) : string;

    function getStorageList : TJSONObject;

    function CheckStorage( typ : string; id : integer ) : integer;

    procedure doAfterConnect;
  end;

  TMyCallback = class(TDBXCallback)
  public
    function Execute(const Arg: TJSONValue): TJSONValue; override;
  end;

var
  GM: TGM;

var
  arrRolls : TArray<String> =
    ['',
    'Vorsitz',
    'Stellvertretung',
    'Schriftführung',
    'Optional',
    'Ersatz',
    'Berater',
    'Praktikant',
    'Auszubildender'
    ];

function ShowResult( res : TJSONObject; positiv : Boolean = false ) : boolean;

implementation

uses
  Vcl.Forms, Winapi.Windows, u_json,
  System.UITypes, system.IOUtils, FireDAC.Stan.Storagebin,
  System.Win.ComObj, m_WindowHandler, m_BookMarkHandler, IdHashMessageDigest,
  Vcl.Graphics, u_PersonenListeImpl, m_cache, f_login, u_kategorie,
  u_onlineUser, m_http, f_doMeeting, u_eventHandler, u_Konst, IdStack, m_fileCache,
  m_crypt, CodeSiteLogging, f_main, u_ini;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function ShowResult( res : TJSONObject; positiv : Boolean ) : boolean;
begin
  Result := false;
  if not Assigned(res) then exit;

  Result := JBool( res, 'result', false);
  if not Result then
    ShowMessage( JString( res, 'text'))
  else if positiv then
    ShowMessage( JString( res, 'text'))
end;
{ TGM }

function TGM.autoInc(name: string): integer;
begin
  Result := m_misc.AutoInc(name);
end;

function TGM.calcSize(size: int64): string;
begin
  if      size = 0 then           Result := '0 KB'
  else if size < 1 shl 10 then    Result := Format('%d B',  [size])
  else if size < 1 shl 20 then    Result := Format('%d KB', [size div (1 shl 10)])
  else if size < 1 shl 30 then    Result := Format('%d MB', [size div (1 shl 20)])
  else                            Result := Format('%d MB', [size div (1 shl 30)]);
end;

procedure TGM.changeStatus(text: string);
var
  req : TJSONObject;
begin
  try

    req := TJSONObject.Create;
    JReplace( req, 'online', true);
    JReplace( req, 'state',  text );

    m_misc.changeOnlineStatus(req);
  except

  end;
end;

procedure TGM.checkWWWRoot;
begin
  Application.CreateForm(TCacheMod, CacheMod);
  CacheMod.checkHttpFiles;
  CacheMod.Free;
end;

procedure TGM.checkImage(obj: TJSONObject; client : TdsImageClient);
var
  name    : string;
  fname   : string;
  png     : TPNGImage;
  bmp     : TBitmap;

begin
  if not Assigned(obj) then
    exit;

  name := JString( obj, 'name');
  fname := TPath.Combine( m_images, name );

  if JString(obj, 'md5', 'xxx') <> md5(fname) then  begin
    CodeSite.SendFmtMsg('download : %s', [fname]);
    downloadimage( name, client );
  end;

  png := TPNGImage.Create;
  bmp := TBitmap.Create;

  png.LoadFromFile(fname);
  bmp.AlphaFormat := afDefined;
  bmp.Assign(png);
  m_imageNames.Add(LowerCase(name), ImageList1.Add(bmp, NIL));

  bmp.Free;
  png.Free;
end;

procedure TGM.checkimages;
var
  client : TdsImageClient;
  data   : TJSONObject;
  arr    : TJSONArray;
  i      : integer;
begin
  CodeSite.EnterMethod(Self, 'checkimages');
  client := TdsImageClient.Create(SQLConnection1.DBXConnection);
  try
    m_imageNames.Clear;
    ImageList1.Clear;

    data := client.getimageList;
    arr := JArray(data, 'items');
    if Assigned(arr) then
    begin
      for i := 0 to pred(arr.Count) do
      begin
        checkImage( getRow(arr, i), client);
      end;
    end;
  except
  end;
  client.Free;
  CodeSite.ExitMethod(Self, 'checkimages');
end;

procedure TGM.checkOrDownloadKeys;
  procedure saveToFile( st : TStream; fname : string );
  var
    fi : TFileStream;
  begin
    if st.Size > 0 then begin
      fi := TFileStream.Create(fname, fmCreate + fmShareDenyNone);
      fi.CopyFrom(st, -1);
      fi.Free;
    end;
  end;
var
  client  : TdsPKIClient;
  priv    : TStream;
  pub     : TStream;
begin

  CryptMod.PrivateKeyFile := TPath.Combine(Home, 'key.pri');
  CryptMod.PublicKeyFile  := TPath.Combine(Home, 'key.pub');

  if not FileExists(CryptMod.PrivateKeyFile) or not FileExists(CryptMod.PublicKeyFile) then begin
    client := TdsPKIClient.Create(SQLConnection1.DBXConnection);

    priv := client.getPrivateKey;
    if priv.size > 0 then begin
      saveToFile(priv, CryptMod.PrivateKeyFile);

      pub := client.getPublicKey('', now);
      saveToFile(pub, CryptMod.PublicKeyFile);
    end;
    client.Free;
  end;
  // Keine Key's, also neue anlegen
  if not CryptMod.hasKeyFiles then
    PostMessage( Application.MainFormHandle, msgNeedKeys, 0, 0 );
end;

function TGM.CheckStorage(typ: string; id: integer): integer;
var
  req, res : TJSONObject;
begin
  req := TJSONObject.Create;
  JReplace(req, 'typ', 'gremium');
  JReplace(req, 'id', id);

  res := m_misc.checkFolder(req);
  Result := JInt(res, 'drid', -1);
end;

procedure TGM.clearGrmien;
var
  i : integer;
begin
  for i := 0 to pred(m_gremien.Count) do
    m_gremien[i].Free;
  m_gremien.Clear;
end;

function TGM.Connect: boolean;
var
  inx : integer;
  err : integer;
  host : string;
  procedure setHost( s : string );
  var
    host  : string;
    port  : string;

    procedure findPort;
    var
      inx : integer;
    begin
      inx := LastDelimiter(':', host);
      if inx <> 0 then begin
        port := host.Substring(   inx);
        host := host.Substring(0, inx-1);
      end;

    end;
  begin
    s := trim(s);
    // default ohne protokll und port
    host := s;
    port := '211';
    SQLConnection1.Params.Values['CommunicationProtocol'] := 'tcp/ip';

    if SameText('ds://', s.Substring(0, 5)) then begin
      SQLConnection1.Params.Values['CommunicationProtocol'] := 'tcp/ip';
      Host := s.Substring(5);
    end
    else if SameText('http://', s.SubString(0, 7)) then begin
      SQLConnection1.Params.Values['CommunicationProtocol'] := 'http';
      Host := s.Substring(7);
    end
    else if SameText('https://', s.SubString(0, 8)) then begin
      SQLConnection1.Params.Values['CommunicationProtocol'] := 'https';
      Host := s.Substring(8);
    end;

    DSClientCallbackChannelManager1.CommunicationProtocol := SQLConnection1.Params.Values['CommunicationProtocol'];

    findPort;

    CodeSite.SendFmtMsg('%s://%s:%s', [SQLConnection1.Params.Values['CommunicationProtocol'], host, port]);

    SQLConnection1.Params.Values['HostName']  := host;
    SQLConnection1.Params.Values['Port']      := port;
  end;

  procedure setupProxy;
  begin
    SQLConnection1.Params.Values['DSProxyHost']     := '';
    SQLConnection1.Params.Values['DSProxyPassword'] := '';
    SQLConnection1.Params.Values['DSProxyPort']     := '';
    SQLConnection1.Params.Values['DSProxyUsername'] := '';
    SQLConnection1.Params.Values['User_Name']       := '';
    SQLConnection1.Params.Values['Password']        := '';

    DSClientCallbackChannelManager1.ProxyHost       := '';
    DSClientCallbackChannelManager1.ProxyPassword   := '';
    DSClientCallbackChannelManager1.ProxyPort       := 0;
    DSClientCallbackChannelManager1.ProxyUsername   := '';

    if IniObject.ProxyActive then begin
      SQLConnection1.Params.Values['DSProxyHost']     := IniObject.ProxyHost;
      DSClientCallbackChannelManager1.ProxyHost       := IniObject.ProxyHost;

      SQLConnection1.Params.Values['DSProxyPassword'] := IniObject.ProxyPwd;
      SQLConnection1.Params.Values['Password']        := IniObject.ProxyPwd;
      DSClientCallbackChannelManager1.ProxyPassword   := IniObject.ProxyPwd;

      SQLConnection1.Params.Values['DSProxyPort']     := IntToStr(IniObject.ProxyPort);
      DSClientCallbackChannelManager1.ProxyPort       := IniObject.ProxyPort;

      SQLConnection1.Params.Values['DSProxyUsername'] := IniObject.ProxyUser;
      SQLConnection1.Params.Values['User_Name']       := IniObject.ProxyUser;
      DSClientCallbackChannelManager1.ProxyUsername   := IniObject.ProxyUser;
    end;
end;

begin
  CodeSite.EnterMethod(Self, 'connect');
  Result := false;
  if not Assigned(LoginForm) then
  begin
    Application.CreateForm(TLoginForm, LoginForm);
    if FindCmdLineSwitch('host', host) then begin
      inx := m_hostList.IndexOf(host);
      if inx <> -1 then
        m_hostList.Delete(inx);
      m_hostList.Insert(0, host);
    end;
  end;

  LoginForm.setUserlist(m_userList );
  LoginForm.setHostList(m_hostList);

  if LoginForm.ShowModal <> mrOk then
    exit;

  SQLConnection1.Params.Values['DSAuthenticationUser']      := LoginForm.UserName;
  SQLConnection1.Params.Values['DSAuthenticationPassword']  := LoginForm.Password;

  setHost(LoginForm.HostName);
  setupProxy;

  DSClientCallbackChannelManager1.UserName  := '*'+LoginForm.UserName;
  DSClientCallbackChannelManager1.Password  := LoginForm.Password;

  try
    SQLConnection1.Open;
    Result := SQLConnection1.Connected;

    if Result then begin
      m_LoginFailCount := 0;

      inx := m_hostList.IndexOf(LoginForm.HostName);
      if inx <> -1 then
        m_hostList.Delete(inx);

      m_hostList.Insert(0, LoginForm.HostName);
      saveHostList;

      inx := m_userList.IndexOf(LoginForm.UserName);
      if inx <> -1 then
        m_userList.Delete(inx);

      m_userList.Insert(0, LoginForm.UserName);
      saveUserList;
    end;

  except
    on e : Exception do begin
      if e is TDBXError then begin
        err := (e as TDBXError).ErrorCode;
        case err of
          0 : begin
                ShowMessageTimeout('Login', 'Benutzername oder Passwort ist falsch.');
                inc(m_LoginFailCount);
                if m_LoginFailCount < 3 then
                  PostMessage(Application.MainFormHandle, msgRetryLogin, 0, 0 )
                else
                  m_LoginFailCount := 0;
              end;
        else begin
          CodeSite.SendError(e.ToString);
          ShowMessage(e.ToString);
          end;
        end;
      end else if (e is EIdSocketError) then  begin
        err := (e as EIdSocketError).LastError;
        case err of
          10061 : ShowMessage('Der Server konnte nicht erreicht werden. (10061)');
        else
          ShowMessage(e.ToString);
        end;
      end else
        ShowMessage( e.ClassName );
    end;
  end;
  CodeSite.ExitMethod(Self, 'connect');
end;

procedure TGM.CreateDirs;
begin
  m_export    := TPath.Combine(TPath.GetDocumentsPath, 'Archivar\export');
  m_public    := TPath.Combine(TPath.GetHomePath, 'Archivar' );
  m_home      := TPath.Combine(m_public,  'user\'+FUserName );
  m_images    := TPath.Combine(m_public,  'Images' );
  m_httpHome  := TPath.Combine(m_public,  'wwwroot');
  m_epubHome  := TPath.Combine(m_home,    'epubs');
  m_cache     := TPath.Combine(m_public,  'cache');

  ForceDirectories(m_public);
  ForceDirectories(m_home);
  ForceDirectories(m_images);
  ForceDirectories(m_httpHome);
  ForceDirectories(m_export);
  ForceDirectories(m_epubHome);
  ForceDirectories(m_cache);
end;

function GetUsername: String;
var
  Buffer: array[0..256] of Char; // UNLEN (= 256) +1 (definiert in Lmcons.h)
  Size: DWord;
begin
  Size := length(Buffer); // length stat SizeOf, da Anzahl in TChar und nicht BufferSize in Byte
   if not Winapi.Windows.GetUserName(Buffer, Size) then
    RaiseLastOSError;
  SetString(Result, Buffer, Size - 1);
end;

procedure TGM.DataModuleCreate(Sender: TObject);
begin
  DSClientCallbackChannelManager1.ChannelName := BRD_CHANNEL;
  DSClientCallbackChannelManager1.ManagerId   := createClassID;

  m_imageNames  := TDictionary<string,integer>.create;
  m_misc        := NIL;
  m_gremien     := TList<TGremium>.create;
  m_hostList    := TStringList.Create;
  m_userList    := TStringList.Create;
  FUserName     := GetUsername;
  FUserFolder   := -1;
  m_plugins     := TPluginManager.create;

{$ifndef RELEASE}
  if ParamStr(1) <> '' then
    FUserName := ParamStr(1);
{$endif}

  EventHandler.Register( self, handle_admin,        BRD_ADMIN);
  EventHandler.Register( self, handle_taskmove,     BRD_TASK_MOVE);
  EventHandler.Register( self, handle_taskdelete,   BRD_TASK_DELETE);
  EventHandler.Register( self, handle_newmeeting,   BRD_MEETING_NEW );
  EventHandler.Register( self, handle_deletemeeting,BRD_MEETING_DEL );
  EventHandler.Register( self, handle_updatemeeting,BRD_MEETING_UPDATE );
  EventHandler.Register( self, handle_task_assign,  BRD_TASK_ASSIGN);

  loadHostList;
  loadUserlist;

  m_LoginFailCount := 0;

  setProxy;
end;

procedure TGM.DataModuleDestroy(Sender: TObject);
begin
  JvSHFileOperation1.SourceFiles.add( TPath.Combine(m_httpHome, '{*}'));
  JvSHFileOperation1.Execute;

  clearGrmien;
  m_gremien.free;

  if Assigned(m_misc) then
    m_misc.Free;
  m_misc := NIL;
  m_imageNames.Free;

  if Assigned(EventHandler) then
    EventHandler.Unregister(Self);

  m_hostList.Free;
  m_userList.Free;

  m_plugins.unloadAll;
  m_plugins.Free;
end;

procedure TGM.Disconnect;
begin
  CodeSite.EnterMethod(Self, 'diconnect');
  try
    if SQLConnection1.Connected then begin
      CodeSite.EnterMethod(self, 'CloseClientChannel');
      DSClientCallbackChannelManager1.CloseClientChannel;
      CodeSite.exitMethod(self, 'CloseClientChannel');

    if Assigned(m_misc) then
      FreeAndNil(m_misc);

      SQLConnection1.Close;
    end;
  except
  end;
  CodeSite.ExitMethod(self, 'diconnect');
end;

procedure TGM.doAfterConnect;
var
  Client : TAdminModClient;
  data   : TJSONObject;
  req    : TJSONObject;

  fname : string;
begin
  req := TJSONObject.Create;

  JReplace( req, 'host',      GetEnvironmentVariable('COMPUTERNAME'));
  JReplace( req, 'hostuser',  GetEnvironmentVariable('USERNAME'));
  client := NIL;


  DSClientCallbackChannelManager1.DSHostname  := SQLConnection1.ConnectionData.Properties.Values['HostName'];
  DSClientCallbackChannelManager1.DSPort      := SQLConnection1.ConnectionData.Properties.Values['Port'];
  DSClientCallbackChannelManager1.RegisterCallback(BRD_CHANNEL, TMyCallback.Create);

  try
    Client := TAdminModClient.Create(SQLConnection1.DBXConnection);
    data := Client.getUserInfo(req);
    if Assigned(data) then
    begin
      self.UserName   := JString( data, 'user' );
      self.IsAdmin    := JBool(   data, 'admin');
      Self.Name       := JString( data, 'name');
      Self.Vorname    := JString( data, 'vorname');
      Self.UserID     := JInt(    data, 'id' );
      Self.UserFolder := JInt(    data, 'drid');
    end;

    CreateDirs;

    data := client.getDeleteTimes;
    FillTimes( JArray( data, 'items'));
  finally
    Client.Free;
  end;

  try
    m_misc := TdsMiscClient.Create(SQLConnection1.DBXConnection);
  finally

  end;
  HttpMod.Home := self.wwwHome;

  BookMarkHandler.load;

  checkimages;
  checkWWWRoot;

  FileCacheMod.SyncCache;

  requestUser;

  fname :=  FileCacheMod.getFile('data', 'Kategorie.json');
  Kategorien.load(fname);

  PostMessage( Application.MainFormHandle, msgLoadLogo,       0, 0 );
  PostMessage( Application.MainFormHandle, msgUpdateMeetings, 0, 0 );

  checkOrDownloadKeys;

  if SQLConnection1.Params.Values['CommunicationProtocol'] <> 'tcp/ip' then
    PingTimer.Enabled := true;

  m_plugins.loadAll;
end;

function TGM.download(fname: string; st: TStream): boolean;
const
  BSize = 1024 * 1024;
var bytes : integer;
   buffer : array  of byte;
   fout : TFileStream;
begin
  Result := false;
  if not Assigned(st) then
    exit;

  try
    SetLength(Buffer, BSize);
    fout := TFileStream.Create( fname, fmCreate);
    repeat
      bytes := st.Read( buffer[0], BSize);
      fout.Write(buffer[0], bytes)
    until bytes <> BSize;
    FreeAndNil(fout);
    Result := true;
  except
    Result := false;
  end;
  SetLength(Buffer, 0);
end;


function TGM.downloadimage(name: string; client : TdsImageClient): boolean;
var
  req    : TJSONObject;
  st     : TStream;
  fname  : String;
begin
  fname := TPath.Combine( m_images, name );
  req    :=  TJSONObject.Create;
  JReplace( req, 'name', name);
  try
    st := client.getImage( req);
    Result := download( fname, st );
  except
    Result := false;
  end;
end;

procedure TGM.FillGremien(arr :TJSONArray );
var
  i : integer;
  row :  TJSONObject;
  gr  : TGremium;
begin
  clearGrmien;
  for i := 0 to pred(arr.Count) do
  begin
    row := getRow( arr, i);
    gr  := TGremium.create;
    gr.setJSON( row );
    m_gremien.Add(gr);
  end;
end;

procedure TGM.FillTimes(arr: TJSONArray);
var
  i     : Integer;
  row   : TJSONObject;
  fname : string;
begin
  if not Assigned(arr) then
    exit;

  DeleteTimesTab.Open;
  DeleteTimesTab.EmptyDataSet;
  for i := 0 to pred( arr.Count) do
  begin
    row := getRow( arr, i);
    DeleteTimesTab.Append;
    DeleteTimesTab.FieldByName('FD_ID').AsInteger     := JInt( row, 'id');
    DeleteTimesTab.FieldByName('FD_NAME').AsString    := JString( row, 'name');
    DeleteTimesTab.FieldByName('FD_MONATE').AsInteger := JInt( row, 'monate');
    DeleteTimesTab.Post;
  end;
  fname := TPath.Combine(m_public, 'deltimes.adb');
  DeleteTimesTab.SaveToFile( fname, sfBinary );
  DeleteTimesTab.Close;
end;

function TGM.getGremium(id: integer): TGremium;
var
  gr : TGremium;
begin
  Result := NIL;
  for gr in m_gremien do
  begin
    if gr.ID = id then begin
      Result := gr;
      break;
    end;
  end;
end;

function TGM.getGremiumMA(id: integer): IPersonenListe;
var
  p : IPerson;
begin
  Result := TPersonenListeImpl.Create;
  GremiumMA.ParamByName('GR_ID').AsInteger := id;
  GremiumMA.Open;
  while not GremiumMA.eof do begin
    p := Result.newPerson;
    p.ID        := GremiumMA.FieldByName('PE_ID').AsInteger;
    p.Name      := GremiumMA.FieldByName('PE_NAME').AsString;
    p.Vorname   := GremiumMA.FieldByName('PE_VORNAME').AsString;
    p.Abteilung := GremiumMA.FieldByName('PE_DEPARTMENT').AsString;
    p.Rolle     := GremiumMA.FieldByName('GP_ROLLE').AsString;
    GremiumMA.Next;
  end;
  GremiumMA.Close;
end;

function TGM.getHostName: string;
begin
  Result := SQLConnection1.Params.Values['HostName'];
end;

function TGM.getImageID(name: string): Integer;
begin
  Result := -1;
  name := LowerCase(name);
  if m_imageNames.ContainsKey( name ) then
  begin
    Result := m_imageNames[name];
  end;
end;

function TGM.GetShortImage(name: string): integer;
var
  i : integer;
  arr : TArray<String>;
begin
  Result := -1;

  name := LowerCase(name);

  arr := m_imageNames.Keys.ToArray;
  for i := 0 to pred(m_imageNames.Keys.Count) do
  begin
    if pos( name, arr[i]) = 1 then
    begin
      Result := m_imageNames[arr[i]];
      break;
    end;
  end;
end;

function TGM.getStorageList: TJSONObject;
begin
  try
    Result := m_misc.getStorageList.Clone as TJSONObject;
  except
    Result := TJSONObject.Create;
  end;
end;

function TGM.getUserList: TJSONobject;
var
  obj : TJSONObject;
begin
  Result := NIL;
  if Assigned(m_misc) then begin
    obj := m_misc.getUserList;

    if Assigned(obj) then
      Result := obj.Clone as TJSONObject;
  end;
end;

function TGM.GremiumName(id: integer): string;
var
  i : integer;
begin
  if id < 1 then begin
  for i := 0 to pred(m_gremien.Count) do
    begin
      if Gremien.Items[i].ParentShort = '' then begin
        Result := Gremien.Items[i].ShortName;
        break;
      end;
    end
  end else begin
    for i := 0 to pred(m_gremien.Count) do
    begin
      if Gremien.Items[i].ID = id then
      begin
        Result := Gremien.Items[i].ShortName;
        break;
      end;
    end;
  end;
end;

function TGM.handle_admin(const Arg: TJSONObject): boolean;
var
  cmd  : string;

  procedure SendMsg;
  var
    list : TStringList;
  begin
    list := TStringList.Create;
    getText(arg, 'text', list );

    if list.Count > 0 then begin
      MainForm.AdminMsg(DateTimeToStr(now)+':'+list[0]);
      list.Insert(0, DateTimeToStr(now));
      if JBool(arg, 'urgend') then
        ShowMessage( list.Text )
      else
        ShowMessageTimeout('Admin', list.Text );
    end;
    list.Free;
  end;
  procedure CloseEdit;
  begin
    WindowHandler.closeAll;
  end;
  procedure ShowShutdown;
  begin
    ShowMessage( JString( arg, 'text' ) );
  end;
  procedure doTerminate;
  begin
    Application.Terminate;
  end;

  begin
  cmd := JString( Arg, 'cmd');
       if SameText(cmd, BRD_ADMIN_MSG)        then SendMsg
  else if SameText(cmd, BRD_ADMIN_CLOSE_EDIT) then CloseEdit
  else if SameText(cmd, BRD_ADMIN_TERMINATE)  then doTerminate
  else if SameText(cmd, BRD_ADMIN_REBOOT)     then ShowShutdown;


  Result := true;
end;

function TGM.handle_deletemeeting(const Arg: TJSONObject): boolean;
begin
  PostMessage(Application.MainFormHandle, msgDeleteMeeting, 0, JInt(Arg, 'id'));
  Result := true;
end;

function TGM.handle_newmeeting(const Arg: TJSONObject): boolean;
begin
  PostMessage(Application.MainFormHandle, msgNewMeeting, 0, JInt(Arg, 'id'));

  Result := true;
end;

function TGM.handle_taskdelete(const Arg: TJSONObject): boolean;
begin
  WindowHandler.closeTaksWindowMsg( JInt(Arg, 'taid'), 'Die Aufgabe wurde gelöscht!');
  BookMarkHandler.Bookmarks.remove( JString( ARg, 'clid'));

  PostMessage( Application.MainFormHandle, msgFilterTasks, 1, 0 );

  Result := true;
end;

function TGM.handle_taskmove(const Arg: TJSONObject): boolean;
begin
  WindowHandler.closeTaksWindowMsg( JInt(Arg, 'taid'), 'Die Aufgabe wurde verschoben!');
  PostMessage( Application.MainFormHandle, msgFilterTasks, 1, 0 );

  Result := true;
end;

function TGM.handle_task_assign(const arg: TJSONObject): boolean;
begin
  PostMessage(Application.MainFormHandle, msgUpdateTaskList, 0, JInt(Arg, 'taid') );

  Result := false
end;

function TGM.handle_updatemeeting(const Arg: TJSONObject): boolean;
begin
  PostMessage(Application.MainFormHandle, msgUpdateMeetings, 0, 0 );

  Result := true;
end;

function TGM.isLocked(id, typ: integer; subid : integer): TJSONObject;
var
  req : TJSONObject;
begin
  req := TJSONObject.Create;
  JReplace( req, 'id',  id);
  JReplace( req, 'typ', typ);
  JReplace( req, 'sub', subid );

  Result := m_misc.isLocked(req);
end;

function TGM.isValidTask(id: integer; dt : tDocType): Boolean;
begin
  Result := m_misc.validTask(id, integer(dt));
end;

procedure TGM.loadHostList;
var
  fname : string;
begin
  fname := ExtractFilePath(paramStr(0))+'hosts.dat';
  if FileExists(fname) then
    m_hostList.LoadFromFile(fname)
  else
    m_hostList.Text := 'localhost';
end;

procedure TGM.loadUserlist;
var
  fname : string;
begin
  fname := ExtractFilePath(ParamStr(0))+'user.dat';
  if FileExists(fname) then
    m_userList.LoadFromFile(fname)
  else
    m_userList.Text := 'admin';
end;

function TGM.LockDocument(id, typ: integer; subid : integer): TJSONObject;
var
  req : TJSONObject;
begin
  req := TJSONObject.Create;

  JReplace( req, 'id',  id);
  JReplace( req, 'typ', typ);
  JReplace( req, 'sub', subid );

  Result := m_misc.LockDocument(req);
end;

function TGM.LockedFlag(id, typ: integer): boolean;
var
  res : TJSONObject;
begin
  res := isLocked(id, typ);

  Result := JBool( res, 'result');
end;

function TGM.md5(st: TStream): string;
var
  IdMD5: TIdHashMessageDigest5;
begin
  IdMD5 := TIdHashMessageDigest5.Create;
  try
    Result := LowerCase( IdMD5.HashStreamAsHex(st));
  finally
    IdMD5.Free;
  end;

end;

procedure TGM.requestUser;
var
  res : TJSONObject;
begin
  try
    res := m_misc.getUserList;
    OnlineUser.fillUserList(res);

    changeStatus('online');
  except

  end;
end;

function TGM.md5(fname: string): string;
var
  fs   : TFileStream;
begin
  Result := '';

  fs := NIL;
  if not FileExists(fname) then
    exit;

  try
    fs    := TFileStream.Create(fname, fmOpenRead + fmShareDenyWrite);
    Result := md5(fs);
  finally
    fs.Free;
  end;
end;

procedure TGM.PingTimerTimer(Sender: TObject);
var
  val : cardinal;
begin
  CodeSite.EnterMethod(Self, 'PingTimerTimer');
  if Assigned(m_misc) then begin
    val := m_misc.ping( GetTickCount );
    CodeSite.SendFmtMsg('ping:%d', [GetTickCount - val]);
  end;
  CodeSite.ExitMethod(Self, 'PingTimerTimer');
end;

procedure TGM.saveHostList;
var
  fname : string;
begin
  fname := ExtractFilePath(paramStr(0))+'hosts.dat';
  m_hostList.SaveToFile(fname);
end;

procedure TGM.saveUserList;
var
  fname : string;
begin
  fname := ExtractFilePath(ParamStr(0))+'user.dat';
  m_userList.SaveToFile(fname);
end;

procedure TGM.setIsAdmin(value: boolean);
begin
  FIsAdmin :=value;
  if FIsAdmin then
    PostMessage( Application.MainFormHandle, msgStatus, 1, 0 )
  else
    PostMessage( Application.MainFormHandle, msgStatus, 0, 0 )
end;

procedure TGM.setProxy;
var
  val   : string;
begin
  fname := TPath.Combine(ExtractFilePath(ParamStr(0)), 'proxy.dat');
  if FindCmdLineSwitch('proxyhost', val) then begin

    if FindCmdLineSwitch('proxyhost', val) then IniObject.ProxyHost := val;
    if FindCmdLineSwitch('proxypwd', val)  then IniObject.ProxyPwd  := val;
    if FindCmdLineSwitch('proxyport', val) then IniObject.ProxyPort := StrToIntDef(val, 8080);
    if FindCmdLineSwitch('proxyuser', val) then IniObject.ProxyUser := val;

    IniObject.ProxyActive := IniObject.ProxyHost <> '';
    IniObject.save;
  end;
end;

procedure TGM.ShowLockInfo(data: TJSONObject);
var
  s : string;
begin
  s := 'Das Dokument ist gesperrt von '+JString( data, 'user');
  ShowMessage(s);
end;

procedure TGM.SQLConnection1AfterConnect(Sender: TObject);
begin
  PostMessage( Application.MainFormHandle, msgConnected, 0, 0 );
end;

procedure TGM.SQLConnection1AfterDisconnect(Sender: TObject);
begin
  CodeSite.EnterMethod(self, 'AfterDisconnect(');
  PingTimer.Enabled := false;

  m_plugins.unloadAll;

  if Assigned(LoginForm) then
    LoginForm.Password := '';

  (Application.MainForm as TMainForm).ApplicationSetMenu(false );
  CodeSite.ExitMethod(self, 'AfterDisconnect(');
//  PostMessage( Application.MainFormHandle, msgDisconnected, 0, 0 );
end;

procedure TGM.SQLConnection1BeforeDisconnect(Sender: TObject);
begin
  CodeSite.EnterMethod(self, 'BeforeDisconnect(');
  DSClientCallbackChannelManager1.UnregisterCallback(BRD_CHANNEL);

  if Assigned(m_misc) then
    m_misc.Free;
  m_misc := NIL;

  WindowHandler.closeAll;
  CodeSite.ExitMethod(self, 'BeforeDisconnect(');

end;

function TGM.UnLockDocument(id, typ: integer; subid : integer): TJSONObject;
var
  req : TJSONObject;
begin
  Result := NIL;

  req := TJSONObject.Create;
  JReplace( req, 'id', id);
  JReplace( req, 'typ',typ);
  JReplace( req, 'sub', subid );

  try
    if Assigned(m_misc) then
      Result := m_misc.UnLockDocument(req);
  except
  end;
end;

{ TMyCallback }

function TMyCallback.Execute(const Arg: TJSONValue): TJSONValue;
var
  msg : TJSONObject;
begin
  CodeSite.EnterMethod(self, 'Execute');
  msg := arg.Clone as TJSONObject;
  CodeSite.SendMsg(msg.ToString);

  TThread.Queue(nil,
    procedure
    begin
        EventHandler.execute(msg);
        msg.Free;
    end
  );
  Result := TJSONBool.Create(true);
  CodeSite.ExitMethod(self, 'Execute');
end;

end.

