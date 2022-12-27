unit u_TPluginImap;

interface

uses
  u_TPluginImpl;


type
  TPluginImap = class(TPluginImpl)
    private
    protected
      function getPluginName : string; override;
    public
    procedure Execute; override;
  end;

var
  PluginImap : TPluginImap;

implementation

uses
  i_plugin, f_mail, Vcl.Forms;

{ TPluginImap }
function getPIF : IPlugin;
begin
  Result := PluginImap;
end;

procedure TPluginImap.Execute;
begin
  inherited;

  m_oldApp := Application;

  Application := m_data.App;
  if not Assigned(MailForm)then begin
    MailForm := TMailForm.create(m_data.App);
  end else begin
    MailForm.BringToFront;
  end;
  MailForm.Show;

  Application := m_oldApp;
end;

function TPluginImap.getPluginName: string;
begin
  Result := 'Mail(IMAP)';
end;

exports
  getPIF;

initialization
  PluginImap := TPluginImap.create;
finalization
  PluginImap.Free;
end.

