unit m_fileServer;

interface

uses
  System.SysUtils, System.Classes, IdTCPServer, IdCmdTCPServer,
  IdExplicitTLSClientServerBase, IdFTPServer, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdCustomHTTPServer, IdHTTPServer, IdUDPBase, IdUDPServer,
  IdTrivialFTPServer, IdContext, Web.HTTPApp, Web.HTTPProd, JvComponentBase,
  JvComputerInfoEx;

type
  TFileServer = class(TDataModule)
    IdHTTPServer1: TIdHTTPServer;
    JvComputerInfoEx1: TJvComputerInfoEx;
    PageProducer1: TPageProducer;
    procedure DataModuleCreate(Sender: TObject);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
  private
    m_base : string;
  public
    procedure start;
    procedure stop;

    procedure createUpdaterZIP;
  end;

var
  FileServer: TFileServer;

implementation

uses
  u_ini, Grijjy.CloudLogging, System.IOUtils, System.Types, System.Zip;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TFileServer.createUpdaterZIP;
var
  path  : string;
  arr   : TStringDynArray;
  i     : integer;
  dest  : string;
  zip   : TZipFile;
begin
  GrijjyLog.EnterMethod( self, 'createUpdaterZIP');
  dest := TPath.Combine( ExtractFilePath(paramStr(0)), IniOptions.DNLwwwroot);
  dest := TPath.Combine( dest, 'updater\launcher.zip');

  try
    if FileExists(dest) then
      System.SysUtils.DeleteFile(dest);

    path := TPath.Combine( ExtractFilePath(paramStr(0)), 'Launcher');

    arr := TDirectory.GetFiles(path);

    zip := TZipFile.Create;
    zip.Open(dest, zmWrite);

    for i := low(arr) to high(arr) do begin
      zip.Add(arr[i], ExtractFileName(arr[i]));
    end;
    zip.Close;

  except
    on e : exception do
      GrijjyLog.Send(e.ToString, TgoLogLevel.Error);
  end;

  GrijjyLog.ExitMethod( self, 'createUpdaterZIP');
end;

procedure TFileServer.DataModuleCreate(Sender: TObject);
var
  fname : string;
begin
  GrijjyLog.EnterMethod( self, 'DataModuleCreate');
  IdHTTPServer1.DefaultPort       := IniOptions.DNLport;

  m_base := ExpandFileName(TPath.Combine(ExtractFilePath(ParamStr(0)), IniOptions.DNLwwwroot));
  GrijjyLog.Send('dnl root', m_base);

  fname := TPath.Combine(m_base, 'index.html');
  if FileExists( fname ) then
    PageProducer1.HTMLFile := fname;

  GrijjyLog.ExitMethod(self, 'DataModuleCreate');
end;

procedure TFileServer.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  fname : string;
begin
  GrijjyLog.EnterMethod( self, 'IdHTTPServer1CommandGet');
  GrijjyLog.Send('request', ARequestInfo.Document );

  fname := StringReplace( ARequestInfo.Document, '/', '\', [rfReplaceAll]);
  if fname = '\' then
    fname := '\index.html';

  fname := StringReplace( fname, '\', m_base, []);
  fname := ExpandFileName( fname );

  AResponseInfo.ResponseNo := 404;
  AResponseInfo.ResponseText := 'Page not found!';
  if pos( m_base, fname) = 1 then begin
    if FileExists(fname) then begin
      AResponseInfo.ContentText   := PageProducer1.Content;
      AResponseInfo.ResponseNo    := 200;
    end;
  end;
  GrijjyLog.Send('ReponseNo',   AResponseInfo.ResponseNo);
  GrijjyLog.Send('ReponseText', AResponseInfo.ResponseText);

  GrijjyLog.ExitMethod( self, 'IdHTTPServer1CommandGet');
end;

procedure TFileServer.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString, 'host') then
    ReplaceText := JvComputerInfoEx1.Identification.LocalComputerName
  else if SameText(TagString, 'port') then
    ReplaceText := IntToStr(IniOptions.DSport);

end;

procedure TFileServer.start;
begin
  GrijjyLog.EnterMethod( self, 'start');

  if SameText(IniOptions.DNLactive, 'true') then
    try
      IdHTTPServer1.Active := true;
      GrijjyLog.Send('HTTP active', IdHTTPServer1.Active );
      GrijjyLog.Send('HTTP port', IdHTTPServer1.DefaultPort );
    except
      on e : exception do
        GrijjyLog.Send(e.ToString, TgoLogLevel.Error);
    end;

  GrijjyLog.ExitMethod( self, 'start');
end;

procedure TFileServer.stop;
begin
  GrijjyLog.EnterMethod(self, 'stop');

  IdHTTPServer1.Active        := false;

  GrijjyLog.ExitMethod(self, 'stop');
end;

end.
