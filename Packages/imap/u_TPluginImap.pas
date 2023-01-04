unit u_TPluginImap;

interface

uses
  i_plugin, u_TPluginImpl;


type
  TPluginImap = class(TPluginImpl)
    private
    protected
      function getPluginName : string; override;
    public
      procedure Execute; override;

  end;

function getPIF : IPlugin; export;
procedure release; export;

var
  PluginImap : IPlugin = NIL;

exports
  getPIF,
  release;

implementation

uses
  Vcl.Forms, f_mail;

{ TPluginImap }
function getPIF : IPlugin;
begin
  try
    PluginImap := TPluginImap.create;
    Result := PluginImap;
  except
    Result := NIL;
  end;
end;

procedure release;
begin
  if Assigned(PluginImap) then begin
    PluginImap.restoreOldApplication;
  end;
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

function TPluginImap.getPluginName: string;
begin
  Result := 'Mail(IMAP)';
end;

end.

