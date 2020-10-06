unit f_set;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base;

type
  TMySettingsForm = class(TForm)
    BaseFrame1: TBaseFrame;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  MySettingsForm: TMySettingsForm;

implementation

{$R *.dfm}

end.
