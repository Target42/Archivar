unit u_TPluginImap;

interface

uses
  Vcl.Forms, i_plugin, u_TPluginImpl;


type
  TPluginImap = class(TPluginImpl)
    private
    protected
      function getPluginName : string; override;
    public
      procedure Execute; override;

  end;
  pApp = ^TApplication;


var
  PluginImap : IPlugin;
implementation


uses
  f_mail;

var
  oldApp : TApplication;

{ TPluginImap }
function getPIF(ptr : pointer) : IPlugin; stdcall;
begin
  oldApp := Application;
  Application := TApplication(ptr);
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
  Application := oldApp;
end;

exports
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

function TPluginImap.getPluginName: string;
begin
  Result := 'Mail(IMAP)';
end;



initialization
  PluginImap := NIL;

end.

