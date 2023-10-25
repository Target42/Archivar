unit u_TPluginImap;

interface

uses
  Vcl.Forms, i_plugin, u_TPluginImpl;


type
  TPluginImap = class(TPluginImpl)
    public
      procedure Execute; override;
  end;

var
  PluginImap : IPlugin;

implementation


uses
  f_mail, System.SysUtils, System.Classes;

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
  RegisterClass(TMailForm);
  PluginImap := NIL;

finalization
  UnRegisterClass(TMailForm);

end.

