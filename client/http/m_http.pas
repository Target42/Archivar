unit m_http;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdCustomHTTPServer, IdHTTPServer, IdContext;

type
  THttpMod = class(TDataModule)
    IdHTTPServer1: TIdHTTPServer;
    procedure DataModuleCreate(Sender: TObject);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure IdHTTPServer1CommandOther(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  private
    m_home : string;
  public
    { Public-Deklarationen }
  end;

var
  HttpMod: THttpMod;

implementation

uses
  m_glob_client, System.StrUtils, Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure THttpMod.DataModuleCreate(Sender: TObject);
begin
  IdHTTPServer1.Active := true;
  m_home := ReplaceText(GM.wwwHome, '\', '/');

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
    AResponseInfo.ResponseNo := 200;
    AResponseInfo.ContentStream := TFileStream.Create(fname, fmOpenRead + fmShareDenyNone);
    AResponseInfo.FreeContentStream := true;
  end;

end;

procedure THttpMod.IdHTTPServer1CommandOther(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  ShowMessage( ARequestInfo.Document);
end;

end.