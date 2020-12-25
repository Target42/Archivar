unit f_abwesenheit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, fr_base;

type
  TAbwesenForm = class(TForm)
    BaseFrame1: TBaseFrame;
    ComboBox1: TComboBox;
    Label1: TLabel;
  private
    function GetGrund: String;
    procedure SetGrund(const Value: String);
    { Private-Deklarationen }
  public
    property Grund: String read GetGrund write SetGrund;
  end;

var
  AbwesenForm: TAbwesenForm;

implementation

{$R *.dfm}

{ TAbwesenForm }

function TAbwesenForm.GetGrund: String;
begin
  Result := Trim(ComboBox1.Text);
  if (Result = '') and ( ComboBox1.ItemIndex <> -1 ) then
    Result := ComboBox1.Items.Strings[ComboBox1.ItemIndex];
end;

procedure TAbwesenForm.SetGrund(const Value: String);
var
  inx : integer;
begin
  inx := ComboBox1.Items.IndexOf(value);
  if inx <> -1 then
    ComboBox1.ItemIndex := inx
  else
    ComboBox1.Text := value;

end;

end.
