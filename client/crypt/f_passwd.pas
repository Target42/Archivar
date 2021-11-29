unit f_passwd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.StdCtrls;

type
  TPassWdform = class(TForm)
    Edit1: TEdit;
    BaseFrame1: TBaseFrame;
    procedure FormCreate(Sender: TObject);
  private
    function GetPassword: string;
    procedure SetPassword(const Value: string);
    { Private-Deklarationen }
  public
    property Password: string read GetPassword write SetPassword;
  end;

var
  PassWdform: TPassWdform;

implementation

{$R *.dfm}

{ TPassWdform }

procedure TPassWdform.FormCreate(Sender: TObject);
begin
  Edit1.Text := '';
end;

function TPassWdform.GetPassword: string;
begin
  Result := Edit1.Text;
end;

procedure TPassWdform.SetPassword(const Value: string);
begin
  Edit1.Text := value;
end;

end.
