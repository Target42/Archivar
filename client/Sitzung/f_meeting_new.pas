unit f_meeting_new;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base;

type
  TMeetingForm = class(TForm)
    BaseFrame1: TBaseFrame;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  MeetingForm: TMeetingForm;

implementation

{$R *.dfm}

end.
