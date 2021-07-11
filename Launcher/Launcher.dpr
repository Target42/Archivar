program Launcher;

uses
  Vcl.Forms,
  f_main in 'f_main.pas' {MainForm},
  u_stub in '..\client\u_stub.pas',
  u_ini in 'u_ini.pas',
  u_json in '..\misc\u_json.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
