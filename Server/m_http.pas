unit m_http;

interface

uses
  System.SysUtils, System.Classes,
  IdCustomTCPServer, IdCustomHTTPServer, IdHTTPServer, Web.HTTPApp, IdContext,
  Web.HTTPProd,
  IdServerIOHandlerStack,
  IdSchedulerOfThreadDefault, IdSSL, IdSSLOpenSSL, IdServerIOHandler,
  IdServerIOHandlerSocket, IdScheduler, IdSchedulerOfThread, IdBaseComponent,
  IdComponent;

type
  THttpMod = class(TDataModule)
    IdHTTPServer1: TIdHTTPServer;
    IdSchedulerOfThreadDefault1: TIdSchedulerOfThreadDefault;
    PageProducer1: TPageProducer;
    IdServerIOHandlerStack1: TIdServerIOHandlerStack;
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
  private
    m_dataDir : string;
    m_config  : TStringList;

    procedure buildZip( AResponseInfo: TIdHTTPResponseInfo );
  public
    procedure start( port : integer = 8080 );
    procedure ende;
    function isActive : boolean;
  end;

var
  HttpMod: THttpMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  Grijjy.CloudLogging, system.IOUtils, u_ini, System.Zip;

{$R *.dfm}

{ THttpMod }

procedure THttpMod.buildZip(AResponseInfo: TIdHTTPResponseInfo);
var
  flist : TStringList;
  fname : String;
  zip   : TZipFile;
  i     : integer;
  dest  : TMemoryStream;
begin
  AResponseInfo.ResponseNo := 400;

  fname := ExpandFileName(TPath.Combine(IniOptions.DNLlauncher, 'files.txt'));
  if FileExists(fname) then begin
    flist := TStringList.Create;
    flist.LoadFromFile(fname);

    dest  := TMemoryStream.Create;

    zip := TZipFile.Create;
    zip.Open(dest, zmWrite);
    for i := 0 to pred(flist.Count) do begin

      fname := ExpandFileName(TPath.Combine(IniOptions.DNLlauncher , flist[i]));
      if FileExists(fname) then
        zip.Add(fname, flist[i]);
    end;
    zip.Free;
    dest.Position := 0;

    AResponseInfo.ContentStream     := dest;
    AResponseInfo.FreeContentStream := true;

    flist.Free;
    AResponseInfo.ResponseNo := 200;
  end;

end;

procedure THttpMod.DataModuleCreate(Sender: TObject);
var
  fname : string;
begin
  GrijjyLog.EnterMethod(self, 'DataModuleCreate');
  m_config  := TStringList.Create;

  fname := ExpandFileName(TPath.Combine( IniOptions.DNLwwwroot, 'index.html'));
  PageProducer1.HTMLFile := fname;
  GrijjyLog.Send('page producer:', fname);

  fname := ExpandFileName(TPath.Combine( IniOptions.DNLwwwroot, 'config.txt'));
  if FileExists(fname) then
    m_config.LoadFromFile(fname);
  GrijjyLog.Send('config file:', fname);

  m_dataDir := ExpandFileName(IniOptions.DNLlauncher);
  GrijjyLog.Send('data dir:', m_dataDir);

  GrijjyLog.ExitMethod(self, 'DataModuleCreate');
end;

procedure THttpMod.DataModuleDestroy(Sender: TObject);
begin
  m_config.Free;
end;

procedure THttpMod.ende;
begin
  IdHTTPServer1.Active := False;
end;

procedure THttpMod.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  s :string;
  fname : string;
begin
  GrijjyLog.EnterMethod(self, 'IdHTTPServer1CommandGet(');
  GrijjyLog.send( 'get:', ARequestInfo.Document );
  GrijjyLog.send( 'IP :', ARequestInfo.RemoteIP );

  if SameText(ARequestInfo.Document, '/launcher.zip') then
  begin
    GrijjyLog.send( 'buildZip');
    buildZip( AResponseInfo );
  end else if SameText(ARequestInfo.Document, '/logo.png') then begin
    fname := ExpandFileName(TPath.Combine( IniOptions.DNLwwwroot, 'html\logo.png'));
    if FileExists(fname) then begin
      AResponseInfo.ContentStream := TFileStream.Create(fname, fmOpenRead + fmShareDenyNone);
      AResponseInfo.FreeContentStream := true;
      AResponseInfo.ResponseNo := 200;
    end else
      AResponseInfo.ResponseNo := 404;
  end else if SameText(ARequestInfo.Document, '/facicon.ico') then begin
    AResponseInfo.ResponseNo := 404;
  end  else if SameText(ARequestInfo.Document, '/server.zip') then begin
    fname := ExpandFileName(TPath.Combine( IniOptions.DNLwwwroot, 'server.zip'));
  if FileExists(fname) then begin
      AResponseInfo.ContentStream := TFileStream.Create(fname, fmOpenRead + fmShareDenyNone);
      AResponseInfo.FreeContentStream := true;
      AResponseInfo.ResponseNo := 200;
    end else
      AResponseInfo.ResponseNo := 404;
  end else begin
    GrijjyLog.send( 'page procducer');
    s := PageProducer1.Content;
    AResponseInfo.ContentText := s;
    GrijjyLog.Send('content:', s );
    AResponseInfo.ResponseNo := 200;
  end;
  GrijjyLog.Send('response code:', AResponseInfo.ResponseNo);
  GrijjyLog.ExitMethod(self, 'IdHTTPServer1CommandGet(');
end;

function THttpMod.isActive: boolean;
begin
  Result := IdHTTPServer1.Active;
end;

procedure THttpMod.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
       if SameText( TagString, 'xxhost')      then ReplaceText := m_config.Values['hostname']
  else if SameText( TagString, 'xxtcpport')   then ReplaceText := IntToStr(IniOptions.DStcpport)
  else if SameText( TagString, 'xxhttpport')  then ReplaceText := IntToStr(IniOptions.DShttpport)
  else if SameText( TagString, 'xxhttpsport') then ReplaceText := IntToStr(IniOptions.DShttpsport)
  else if SameText( TagString, 'xxhostip')    then ReplaceText := m_config.Values['hostip']

end;

procedure THttpMod.start(port: integer);
begin
  GrijjyLog.EnterMethod(self, 'start');
  GrijjyLog.Send('port:', port);

  try
    IdHTTPServer1.Active      := false;
    IdHTTPServer1.DefaultPort := port;
    IdHTTPServer1.Active      := true;

    GrijjyLog.Send('active:', IdHTTPServer1.Active );
  except
    on e : exception do
      GrijjyLog.Send('fail start http-server:'+e.ToString, TgoLogLevel.Error );
  end;
  GrijjyLog.ExitMethod(self, 'start');
end;

end.
