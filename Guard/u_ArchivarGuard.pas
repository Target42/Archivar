unit u_ArchivarGuard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs;

type
  TArchivarGuard = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private-Deklarationen }
  public
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

procedure TArchivarGuard.ServiceStart(Sender: TService; var Started: Boolean);
begin
  Started := true;
end;

procedure TArchivarGuard.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Stopped := false;
end;

end.
