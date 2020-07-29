program Setup;

uses
  Vcl.Forms,
  f_main in 'f_main.pas' {MainSetupForm},
  xsd_TaskType in '..\misc\xsd_TaskType.pas',
  xsd_StoreLimits in '..\misc\xsd_StoreLimits.pas',
  xsd_Betriebsrat in '..\misc\xsd_Betriebsrat.pas',
  xsd_DataField in '..\misc\xsd_DataField.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainSetupForm, MainSetupForm);
  Application.Run;
end.
