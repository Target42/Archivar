program Setup;

uses
  Vcl.Forms,
  f_main in 'f_main.pas' {MainSetupForm},
  xsd_StoreLimits in '..\misc\xsd_StoreLimits.pas',
  xsd_DataField in '..\misc\xsd_DataField.pas',
  u_ePub in '..\misc\ePub\u_ePub.pas',
  u_navpoint in '..\misc\ePub\u_navpoint.pas',
  u_xml in '..\misc\ePub\u_xml.pas',
  xsd_TextBlock in '..\misc\xsd_TextBlock.pas',
  u_json in '..\misc\u_json.pas',
  xsd_TaskType in '..\misc\xsd_TaskType.pas',
  Vcl.Themes,
  Vcl.Styles,
  m_mail in '..\misc\m_mail.pas' {MailMod: TDataModule},
  u_texte in 'u_texte.pas',
  xsd_Betriebsrat in '..\misc\xsd_Betriebsrat.pas',
  u_service in 'u_service.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sapphire Kamri');
  Application.CreateForm(TMainSetupForm, MainSetupForm);
  Application.CreateForm(TMailMod, MailMod);
  Application.Run;
end.
