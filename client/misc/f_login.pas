unit f_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TLoginForm = class(TForm)
    LabeledEdit2: TLabeledEdit;
    BaseFrame1: TBaseFrame;
    LabeledEdit1: TComboBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function GetUserName: string;
    procedure SetUserName(const Value: string);
    function GetPassword: string;
    procedure SetPassword(const Value: string);
    { Private-Deklarationen }
  public
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
  end;

var
  LoginForm: TLoginForm;

implementation

uses
  m_glob_client;

{$R *.dfm}

{ TLoginForm }

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  LabeledEdit1.Text := GM.UserName;
  LabeledEdit2.Text := '';
end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
  LabeledEdit2.SetFocus;
end;

function TLoginForm.GetPassword: string;
begin
  Result := LabeledEdit2.Text;
end;

function TLoginForm.GetUserName: string;
begin
  Result := Trim(LabeledEdit1.Text);
end;

procedure TLoginForm.SetPassword(const Value: string);
begin
  LabeledEdit2.Text := value;
end;

procedure TLoginForm.SetUserName(const Value: string);
begin
  LabeledEdit1.Text := Trim(value);
end;

initialization
  LoginForm := NIL;
end.
