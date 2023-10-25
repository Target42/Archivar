unit u_TPluginDairy;

interface

uses
  i_plugin, u_TPluginImpl;

type
  TPluginDairy = class(TPluginImpl)
    public
    procedure Execute; override;
  end;

var
  PluginDairy : IPlugin;

implementation

uses
  Vcl.Forms, f_dairy, System.Classes;

{ TPluginDairy }

function getPluginName: pchar; stdcall;
begin
  Result := 'Tagebuch';
end;

function getPIF : IPlugin; stdcall;
begin
  try
    PluginDairy := TPluginDairy.create;
    Result := PluginDairy;
  except
    Result := NIL;
  end;
end;

procedure release; stdcall;
begin
  PluginDairy := NIL;
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
  RegisterClass(TDairyForm);

finalization
  UnregisterClass(TDairyForm);

end.

