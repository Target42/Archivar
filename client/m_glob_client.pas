unit m_glob_client;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, Data.DB, Data.SqlExpr, Winapi.Messages, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Generics.Collections, u_gremium, u_stub, System.JSON, JvComponentBase,
  JvComputerInfoEx, IdBaseComponent, IdComponent, IdIPWatch, Datasnap.DSCommon,
  Data.DBXJSON, pngimage, System.ImageList, Vcl.ImgList, Vcl.Controls,
  u_berTypes;

const
  msgConnected      = WM_USER ;
  msgDisconnected   = WM_USER + 1;
  msgStatus         = WM_USER + 2;
  msgUpdateGr       = WM_USER + 3;
  msgFilterTasks    = WM_USER + 4;
  msgNewTask        = WM_USER + 5;
  msgNewBookMark    = WM_USER + 6;
  msgRemoveBookmark = WM_USER + 7;
  msgLoadLogo       = WM_USER + 8;


type
  TGM = class(TDataModule)
    SQLConnection1: TSQLConnection;
    DeleteTimesTab: TFDMemTable;
    DeleteTimesTabFD_ID: TIntegerField;
    DeleteTimesTabFD_NAME: TStringField;
    DeleteTimesTabFD_MONATE: TIntegerField;
    JvComputerInfoEx1: TJvComputerInfoEx;
    DSClientCallbackChannelManager1: TDSClientCallbackChannelManager;
    ImageList1: TImageList;
    procedure SQLConnection1AfterConnect(Sender: TObject);
    procedure SQLConnection1AfterDisconnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure SQLConnection1BeforeDisconnect(Sender: TObject);
  private
    FIsAdmin: boolean;
    FUserName: string;
    FVorname: string;
    FName: string;

    m_home    : string;
    m_images  : string;
    m_misc    : TdsMiscClient;
    m_gremien : TList<TGremium>;
    m_imageNames : TDictionary<string,integer>;
    procedure setIsAdmin( value : boolean );

    procedure FillTimes( arr :TJSONArray );
    procedure clearGrmien;

    procedure checkimages;
    procedure checkImage( obj : TJSONObject; client : TdsImageClient );

    function downloadimage( name : string;client : TdsImageClient) :  boolean;
  public

    function Connect : boolean;
    procedure Disconnect;

    function login( user : string ; pwd : string ) : boolean;

    property IsAdmin: boolean read FIsAdmin write setIsAdmin;
    property UserName: string read FUserName write FUserName;
    property Vorname: string read FVorname write FVorname;
    property Name: string read FName write FName;

    property Home : string read m_home;
    property Images : string read m_images;
    property Gremien : TList<TGremium> read m_gremien;

    procedure FillGremien( arr :TJSONArray );

    function LockDocument( id, typ : integer ) : TJSONObject;
    function UnLockDocument( id, typ : integer ) : TJSONObject;
    function isLocked( id, typ : integer ) : TJSONObject;
    procedure ShowLockInfo( data : TJSONObject);

    procedure Execute(const Arg: TJSONObject);
    function GremiumName( id : integer ) : string;

    function isValidTask( id : integer; dt : tDocType ) : Boolean;
    function md5( fname : string ) : string;

    function download( fname : string ; st : TStream ) : boolean;
    function getImageID( name : string ) : Integer;
    function GetShortImage( name : string ) : integer;

    function autoInc( name : string ) : integer;
  end;

  TMyCallback = class(TDBXCallback)
  public
    function Execute(const Arg: TJSONValue): TJSONValue; override;
  end;

var
  GM: TGM;

var
  arrRolls : TArray<String> = ['', 'Vorsitz', 'Stellvertretung', 'Schriftführung', 'Ersatz', 'Berater'];

implementation

uses
  Vcl.Dialogs, Vcl.Forms, Winapi.Windows, u_json,
  System.UITypes, system.IOUtils, FireDAC.Stan.Storagebin,
  System.Win.ComObj, m_WindowHandler, m_BookMarkHandler, IdHashMessageDigest,
  Vcl.Graphics;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TGM }

function TGM.autoInc(name: string): integer;
begin
  Result := m_misc.AutoInc(name);
end;

procedure TGM.checkImage(obj: TJSONObject; client : TdsImageClient);
var
  name    : string;
  fname   : string;
  needdnl : Boolean;
  png     : TPNGImage;
  bmp     : TBitmap;

begin
  if not Assigned(obj) then
    exit;
  name := JString( obj, 'name');
  fname := TPath.Combine( m_images, name );

  needdnl := not FileExists(fname);
  if not needdnl then
  begin
    needdnl := JString(obj, 'md5') <> md5(fname);
  end;
  if needdnl then
  begin
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
begin
  Result := false;
  try
    SQLConnection1.Open;
  except
    on e : Exception do
      ShowMessage( e.ToString );
  end;
end;

procedure TGM.DataModuleCreate(Sender: TObject);
begin
  DSClientCallbackChannelManager1.ManagerId := createClassID;

  m_imageNames := TDictionary<string,integer>.create;
  m_misc := NIL;
  m_gremien := TList<TGremium>.create;
  m_home  := TPath.Combine(TPath.GetDocumentsPath, 'Archivar' );
  m_images:= TPath.Combine(m_home, 'Images' );
  ForceDirectories(m_home);
  ForceDirectories(m_images);
end;

procedure TGM.DataModuleDestroy(Sender: TObject);
begin
  clearGrmien;
  m_gremien.free;

  if Assigned(m_misc) then
    m_misc.Free;
  m_misc := NIL;
  m_imageNames.Free;
end;

procedure TGM.Disconnect;
begin
  if SQLConnection1.Connected then
    SQLConnection1.Close;
end;

function TGM.download(fname: string; st: TStream): boolean;
const
  BSize = 1024 * 1024;
var bytes : integer;
   buffer : array  of byte;
   fout : TFileStream;
begin
  Result := true;
  try
    SetLength(Buffer, BSize);
    fout := TFileStream.Create( fname, fmCreate);
    repeat
      bytes := st.Read( buffer[0], BSize);
      fout.Write(buffer[0], bytes)
    until bytes <> BSize;
    FreeAndNil(fout);
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

procedure TGM.Execute(const Arg: TJSONObject);
var
  cmd : string;

begin
  cmd := Jstring( arg, 'action');
  if cmd = 'taskmove' then
  begin
    WindowHandler.closeTaksWindowMsg( JInt(Arg, 'taid'), 'Die Aufgabe wurde verschoben!');
  end
  else if cmd = 'taskdelete' then
  begin
    WindowHandler.closeTaksWindowMsg( JInt(Arg, 'taid'), 'Die Aufgabe wurde gelöscht!');
    BookMarkHandler.Bookmarks.remove( JString( ARg, 'clid'));
  end;
  PostMessage( Application.MainFormHandle, msgFilterTasks, 1, 0 );
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
  i : Integer;
  row : TJSONObject;
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
  DeleteTimesTab.SaveToFile( TPath.Combine(m_home, 'deltimes.adb'), sfBinary );
  DeleteTimesTab.Close;
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

function TGM.GremiumName(id: integer): string;
var
  i : integer;
begin
  for i := 0 to pred(m_gremien.Count) do
  begin
    if Gremien.Items[i].ID = id then
    begin
      Result := Gremien.Items[i].ShortName;
      break;
    end;
  end;
end;

function TGM.isLocked(id, typ: integer): TJSONObject;
begin
  Result := m_misc.isLocked(id, typ);
end;

function TGM.isValidTask(id: integer; dt : tDocType): Boolean;
begin
  Result := m_misc.validTask(id, integer(dt));
end;

function TGM.LockDocument(id, typ: integer): TJSONObject;
begin
  Result := m_misc.LockDocument(id, typ);
end;

function TGM.login(user, pwd: string): boolean;
var
  dbxProps: TDBXDatasnapProperties;
begin
  Result := false;

  dbxProps := SQLConnection1.ConnectionData.Properties as TDBXDatasnapProperties;
  dbxProps.DSAuthUser     := user;
  dbxProps.DSAuthPassword := pwd;
//  dbxProps.HostName       := HostName;

  try
    Screen.Cursor := crHourglass;
    SQLConnection1.Open;

    Result := SQLConnection1.Connected;
  except on E: Exception do
    begin
      ShowMessage( e.ToString );
    end;
  end;
  Screen.Cursor := crDefault;
end;

function TGM.md5(fname: string): string;
var
  IdMD5: TIdHashMessageDigest5;
  fs   : TFileStream;
begin
  fs := NIL;
  if not FileExists(fname) then
    exit;

  IdMD5 := TIdHashMessageDigest5.Create;
  try
    fs    := TFileStream.Create(fname, fmOpenRead + fmShareDenyWrite);
    Result := LowerCase( IdMD5.HashStreamAsHex(fs));
  finally
    fs.Free;
  end;
  IdMD5.Free;
end;

procedure TGM.setIsAdmin(value: boolean);
begin
  FIsAdmin :=value;
  if FIsAdmin then
    PostMessage( Application.MainFormHandle, msgStatus, 1, 0 )
  else
    PostMessage( Application.MainFormHandle, msgStatus, 0, 0 )
end;

procedure TGM.ShowLockInfo(data: TJSONObject);
var
  s : string;
begin
  s := 'Das Dokument ist gesperrt von '+JString( data, 'user');
  ShowMessage(s);
end;

procedure TGM.SQLConnection1AfterConnect(Sender: TObject);
var
  Client : TAdminModClient;
  data   : TJSONObject;
  req    : TJSONObject;
begin
  PostMessage( Application.MainFormHandle, msgConnected, 0, 0 );

  req := TJSONObject.Create;

  JReplace( req, 'host', JvComputerInfoEx1.Identification.LocalComputerName);
  JReplace( req, 'hostuser', JvComputerInfoEx1.Identification.LocalUserName );
  client := NIL;


  DSClientCallbackChannelManager1.DSHostname  := SQLConnection1.ConnectionData.Properties.Values['HostName'];
  DSClientCallbackChannelManager1.DSPort      := SQLConnection1.ConnectionData.Properties.Values['Port'];

  DSClientCallbackChannelManager1.RegisterCallback('storage', TMyCallback.Create);

  try
    Client := TAdminModClient.Create(SQLConnection1.DBXConnection);
    data := Client.getUserInfo(req);
    if Assigned(data) then
    begin
      self.UserName:= JString( data, 'user' );
      self.IsAdmin := JBool(   data, 'admin');
      Self.Name    := JString( data, 'name');
      Self.Vorname := JString( data, 'vorname');
    end;

    data := client.getDeleteTimes;
    FillTimes( JArray( data, 'items'));
  finally
    Client.Free;
  end;

  try
    m_misc := TdsMiscClient.Create(SQLConnection1.DBXConnection);
  finally

  end;
  checkimages;
  PostMessage( Application.MainFormHandle, msgLoadLogo, 0, 0 );
end;

procedure TGM.SQLConnection1AfterDisconnect(Sender: TObject);
begin
  PostMessage( Application.MainFormHandle, msgDisconnected, 0, 0 );
end;

procedure TGM.SQLConnection1BeforeDisconnect(Sender: TObject);
begin
  DSClientCallbackChannelManager1.UnregisterCallback('storage');
  if Assigned(m_misc) then
    m_misc.Free;
  m_misc := NIL;
end;

function TGM.UnLockDocument(id, typ: integer): TJSONObject;
begin
  Result := m_misc.UnLockDocument(id, typ);
end;

{ TMyCallback }

function TMyCallback.Execute(const Arg: TJSONValue): TJSONValue;
var
  msg : TJSONObject;
begin
  msg := arg.Clone as TJSONObject;

  TThread.Queue(nil,
    procedure
    begin
        GM.Execute(msg);
        msg.Free;
    end
  );
  Result := TJSONBool.Create(true);
end;

end.

