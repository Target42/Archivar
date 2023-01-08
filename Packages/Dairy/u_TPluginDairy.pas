unit u_TPluginDairy;

interface

uses
  i_plugin, u_TPluginImpl;

type
  TPluginDairy = class(TPluginImpl)
    private
    protected
      function getPluginName : string; override;
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


function getPIF(ptr : pointer) : IPlugin; stdcall;
begin
  oldApp := Application;
  Application := TApplication(ptr);
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

function TPluginDairy.getPluginName: string;
begin
  Result := 'Tagebuch';
end;

procedure TPluginDairy.Execute;
begin
  if not Assigned(DairyForm)then begin
    DairyForm := TDairyForm.create(m_data.App);
  end else begin
    DairyForm.BringToFront;
  end;
  DairyForm.Show;
end;

exports
  getPIF,
  release;

initialization
  PluginDairy := NIL;
end.

