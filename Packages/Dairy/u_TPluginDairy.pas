unit u_TPluginDairy;

interface

uses
  i_plugin, u_TPluginImpl;

type
  TPluginDairy = class(TPluginImpl)
    private
    protected
    public
    procedure Execute; override;
  end;

var
  PluginDairy : IPlugin;

implementation

uses
  Vcl.Forms, f_dairy;

var
  oldApp : TApplication;

{ TPluginDairy }

function getPluginName: pchar; stdcall;
begin
  Result := 'Tagebuch';
end;

function getPIF(App : TApplication) : IPlugin; stdcall;
begin
  oldApp := Application;
  Application := app;
  try
    PluginDairy := TPluginDairy.create;
    Result := PluginDairy;
  except
    Result := NIL;
  end;
end;

procedure release; stdcall;
begin
  if Assigned(PluginDairy) then begin
    PluginDairy.restoreOldApplication;
  end;
  PluginDairy := NIL;
  Application := oldApp;
end;

procedure TPluginDairy.Execute;
begin
  if not Assigned(DairyForm)then begin
    DairyForm := TDairyForm.create(NIL);//Application.MainForm);
  end else begin
    DairyForm.BringToFront;
  end;
  DairyForm.Show;
end;

exports
  getPluginName,
  getPIF,
  release;

initialization
  PluginDairy := NIL;

end.

