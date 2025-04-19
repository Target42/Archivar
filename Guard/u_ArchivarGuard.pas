unit u_ArchivarGuard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TArchivarGuard = class(TService)
    IdHTTP1: TIdHTTP;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceCreate(Sender: TObject);
  private
    FHost: string;
    FPort: integer;
    { Private-Deklarationen }
  public
    property Host: string read FHost write FHost;
    property Port: integer read FPort write FPort;
    function GetServiceController: TServiceController; override;
    { Public-Deklarationen }
  end;

var
  ArchivarGuard: TArchivarGuard;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ArchivarGuard.Controller(CtrlCode);
end;

function TArchivarGuard.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TArchivarGuard.ServiceCreate(Sender: TObject);
begin
  FHost := 'localhost';
  FPort := 8090;
end;

procedure TArchivarGuard.ServiceStart(Sender: TService; var Started: Boolean);
begin
  Started := true;
end;

procedure TArchivarGuard.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Stopped := false;
end;

end.
