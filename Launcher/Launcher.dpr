program Launcher;

{$R *.dres}

uses
  Vcl.Forms,
  f_main in 'f_main.pas' {MainForm},
  u_stub in '..\client\u_stub.pas',
  u_json in '..\misc\u_json.pas',
  u_ini in 'u_ini.pas',
  fr_base in '..\misc\fr_base.pas' {BaseFrame: TFrame},
  f_proxy in '..\misc\f_proxy.pas' {ProxyForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sapphire Kamri');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TProxyForm, ProxyForm);
  Application.Run;
end.
