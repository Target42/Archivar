unit f_titel_edit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TTitelEditform = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
  private
    function GetTitelText: string;
    procedure SetTitelText(const Value: string);
    { Private-Deklarationen }
  public
    property TitelText: string read GetTitelText write SetTitelText;
  end;

var
  TitelEditform: TTitelEditform;

implementation

{$R *.dfm}

procedure TTitelEditform.FormCreate(Sender: TObject);
begin
  Edit1.Text := '';
end;

function TTitelEditform.GetTitelText: string;
begin
  Result := trim(Edit1.Text);
end;

procedure TTitelEditform.SetTitelText(const Value: string);
begin
  Edit1.Text := value;
end;

end.
