unit f_InputBox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, fr_base;

type
  TInputBoxForm = class(TForm)
    BaseFrame1: TBaseFrame;
    Edit1: TEdit;
  private
    function GetText: string;
    procedure SetText(const Value: string);
    { Private-Deklarationen }
  public
    property Text: string read GetText write SetText;
  end;

var
  InputBoxForm: TInputBoxForm;

implementation

{$R *.dfm}

{ TInputBoxForm }

function TInputBoxForm.GetText: string;
begin
  Result := Trim(Edit1.Text);
end;

procedure TInputBoxForm.SetText(const Value: string);
begin
  Edit1.Text := value;
end;

end.
