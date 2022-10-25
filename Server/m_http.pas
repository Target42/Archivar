unit m_http;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdCustomHTTPServer, IdHTTPServer, Web.HTTPApp, IdContext,
  Web.HTTPProd, IdServerIOHandler, IdServerIOHandlerSocket,
  IdServerIOHandlerStack, IdScheduler, IdSchedulerOfThread,
  IdSchedulerOfThreadDefault, IdSSL, IdSSLOpenSSL;

type
  THttpMod = class(TDataModule)
    IdHTTPServer1: TIdHTTPServer;
    IdSchedulerOfThreadDefault1: TIdSchedulerOfThreadDefault;
    PageProducer1: TPageProducer;
    IdServerIOHandlerStack1: TIdServerIOHandlerStack;
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private-Deklarationen }
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
  system.IOUtils;

{$R *.dfm}

{ THttpMod }

procedure THttpMod.DataModuleCreate(Sender: TObject);
begin
  PageProducer1.HTMLFile := TPath.Combine(ExtractFilePath(ParamStr(0)), 'Launcher\index.html');
end;

procedure THttpMod.ende;
begin
  IdHTTPServer1.Active := False;
end;

procedure THttpMod.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  st : TFileStream;
  fname : string;
begin

  if SameText(ARequestInfo.Document, '/launcher.zip') then begin
    fname := TPath.combine(ExtractFilePath(ParamStr(0)), 'Launcher\Launcher.zip');
    st := TFileStream.Create(fname, fmOpenRead + fmShareDenyNone);
    AResponseInfo.ContentStream := st;
    AResponseInfo.FreeContentStream := true;
  end else begin
    AResponseInfo.ContentText := PageProducer1.Content;
  end;
end;

function THttpMod.isActive: boolean;
begin
  Result := IdHTTPServer1.Active;
end;

procedure THttpMod.start(port: integer);
begin
  IdHTTPServer1.Active := false;
  IdHTTPServer1.DefaultPort := port;
  IdHTTPServer1.Active := true;
end;

end.
