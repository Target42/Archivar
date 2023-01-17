unit u_TPluginImap;

interface

uses
  Vcl.Forms, i_plugin, u_TPluginImpl;


type
  TPluginImap = class(TPluginImpl)
    private
    protected
    public
      procedure Execute; override;

  end;
  pApp = ^TApplication;


var
  PluginImap : IPlugin;
implementation


uses
  f_mail, System.SysUtils, System.Classes;

var
  oldApp : TApplication;

{ TPluginImap }
function getPluginName : PChar; stdcall;
begin
  Result := 'Mail(IMAP)';
end;

function getPIF(app : TApplication) : IPlugin; stdcall;
begin
  oldApp := Application;
  Application := app;
  RegisterClass(TMailForm);
  try
    PluginImap := TPluginImap.create;
    Result := PluginImap;
  except
    Result := NIL;
  end;
end;

procedure release; stdcall;
begin
  if Assigned(PluginImap) then begin
    PluginImap.restoreOldApplication;
  end;
  PluginImap := NIL;
  UnRegisterClass(TMailForm);
  Application := oldApp;
end;

exports
  getPluginName,
  getPif,
  release;


procedure TPluginImap.Execute;
begin
  inherited;

  if not Assigned(MailForm)then begin
    MailForm := TMailForm.create(m_data.App);
  end else begin
    MailForm.BringToFront;
  end;
  MailForm.Show;
end;


initialization
  PluginImap := NIL;

end.

