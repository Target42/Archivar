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

var
  PluginDairy : TPluginDairy;

implementation

uses
  i_plugin, Vcl.Forms, f_dairy;

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
  m_oldApp := Application;
  Application := m_data.App;
  if not Assigned(DairyForm)then begin
    DairyForm := TDairyForm.create(m_data.App);
//    DairyForm.Parent := m_data.App.MainForm;
//    DairyForm.ParentApplication := m_data.App
  end else begin
    DairyForm.BringToFront;
  end;
  DairyForm.Show;
  Application := m_oldApp;
end;

exports
  getPIF;

initialization
  PluginDairy := TPluginDairy.create;
finalization
  PluginDairy.Free;
end.

