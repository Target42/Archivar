unit u_TPluginDairy;

interface

uses
  u_TPluginImpl;

type
  TPluginDairy = class(TPluginImpl)
    private
    protected
      function getPluginName : string; override;
    public
    procedure Execute; override;
  end;

implementation

uses
  i_plugin, Vcl.Forms, f_dairy;

var
  PluginDairy : TPluginDairy;
{ TPluginDairy }

function getPIF : IPlugin;
begin
  Result := PluginDairy;
end;

function TPluginDairy.getPluginName: string;
begin
  Result := 'Tagebuch';
end;

procedure TPluginDairy.Execute;
begin
  inherited;
  if not Assigned(HelloworldForm)then begin
    HelloworldForm := THelloworldForm.Create(Application);
    HelloworldForm.SQl := m_sql;
  end else begin
    HelloworldForm.BringToFront;
  end;
  HelloworldForm.Show;

end;

exports
  getPIF;

initialization
  PluginDairy := TPluginDairy.create;
finalization
  PluginDairy.Free;
end.
