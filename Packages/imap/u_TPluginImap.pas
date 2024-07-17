unit u_TPluginImap;

interface

uses
  Vcl.Forms, i_plugin, u_TPluginImpl;


type
  TPluginImap = class(TPluginImpl)
    public
      procedure Execute; override;
      procedure closeAllForms;  override;
  end;

var
  PluginImap : IPlugin;

implementation


uses
  f_mail, System.SysUtils, System.Classes, Winapi.Messages, Winapi.Windows;

{ TPluginImap }
function getPluginName : PChar; stdcall;
begin
  Result := 'Mail(IMAP)';
end;

function getPIF : IPlugin; stdcall;
begin
  try
    PluginImap := TPluginImap.create;
    Result := PluginImap;
  except
    Result := NIL;
  end;
end;

procedure release; stdcall;
begin
  PluginImap := NIL;
end;


procedure TPluginImap.closeAllForms;
begin
  inherited;
  if assigned(Mailform) then begin
    MailForm.ForceClose(true);
  end;
end;

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

exports
  getPluginName,
  getPif,
  release;

initialization
  System.Classes.RegisterClass(TMailForm);
  PluginImap := NIL;

finalization
  System.Classes.UnRegisterClass(TMailForm);

end.

