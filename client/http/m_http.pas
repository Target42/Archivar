unit m_http;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent,
  IdCustomTCPServer, IdCustomHTTPServer, IdHTTPServer, IdContext, IdTCPServer,
  IdComponent;

type
  THttpMod = class(TDataModule)
    IdHTTPServer1: TIdHTTPServer;
    procedure DataModuleCreate(Sender: TObject);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure IdHTTPServer1CommandOther(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure IdHTTPServer1ParseAuthentication(AContext: TIdContext;
      const AAuthType, AAuthData: string; var VUsername, VPassword: string;
      var VHandled: Boolean);
    procedure IdTCPServer1Execute(AContext: TIdContext);
  private
    m_home  : string;
    function getport: integer;
    function IsTCPPortAvailable(const APort: Word): Boolean;
  public
    property Home : string  read m_home write m_home;
    property Port : integer read getport;
  end;

var
  HttpMod: THttpMod;

implementation

uses
  m_glob_client, System.StrUtils, Vcl.Dialogs, IdException;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure THttpMod.DataModuleCreate(Sender: TObject);
var
  i : integer;
begin
  for i := IdHTTPServer1.DefaultPort to IdHTTPServer1.DefaultPort + 10 do
  begin
    if IsTCPPortAvailable(i) then
    begin
      IdHTTPServer1.DefaultPort := i;
      IdHTTPServer1.Active := true;
      break;
    end;
  end;
  m_home := ReplaceText(GM.wwwHome, '\', '/');
end;

function THttpMod.getport: integer;
begin
  result := IdHTTPServer1.Defaultport;
end;

procedure THttpMod.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  fname : string;
begin
  fname := m_home + ARequestInfo.Document;
  if not FileExists( fname ) then
  begin
    AResponseInfo.ResponseNo := 404;
    AResponseInfo.ResponseText := 'Page not Found!!<br>'+ARequestInfo.Document;
    exit
  end
  else
  begin
    if SameText(ExtractFileExt(fname), '.css') then
      AResponseInfo.ContentType := 'text/css';

    AResponseInfo.ResponseNo := 200;
    AResponseInfo.ContentStream := TFileStream.Create(fname, fmOpenRead + fmShareDenyNone);
    AResponseInfo.FreeContentStream := true;
  end;

end;

procedure THttpMod.IdHTTPServer1CommandOther(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  IdHTTPServer1CommandGet(AContext, ARequestInfo, AResponseInfo);
end;

procedure THttpMod.IdHTTPServer1ParseAuthentication(AContext: TIdContext;
  const AAuthType, AAuthData: string; var VUsername, VPassword: string;
  var VHandled: Boolean);
begin
  VHandled := true;
end;

procedure THttpMod.IdTCPServer1Execute(AContext: TIdContext);
begin
  //
end;

function THttpMod.IsTCPPortAvailable(const APort: Word): Boolean;
var
  LTCPServer: TIdTCPServer;
begin
  Result := True;
  LTCPServer := TIdTCPServer.Create;
  try
    try
      with LTCPServer do
      begin
        DefaultPort   := APort;
        OnExecute     := IdTCPServer1Execute;
        Active        := True;
      end;
    finally
      LTCPServer.Free;
    end;
  except on EIdCouldNotBindSocket do
    Result := False;
  end;
end;

end.
