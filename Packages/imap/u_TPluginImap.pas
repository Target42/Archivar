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
  i_plugin, Vcl.Forms, f_mail;

{ TPluginImap }
function getPIF : IPlugin;
begin
  Result := PluginImap;
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

