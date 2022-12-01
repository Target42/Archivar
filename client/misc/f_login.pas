unit f_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TLoginForm = class(TForm)
    LabeledEdit2: TLabeledEdit;
    BaseFrame1: TBaseFrame;
    LabeledEdit1: TComboBox;
    LabeledEdit3: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function GetUserName: string;
    procedure SetUserName(const Value: string);
    function GetPassword: string;
    procedure SetPassword(const Value: string);
    function GetHostName: string;
    procedure SetHostName(const Value: string);
    { Private-Deklarationen }
  public
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
    property HostName: string read GetHostName write SetHostName;

    procedure setHostList( list : TStringList );
    procedure setUserlist( list : TStringList );
  end;

var
  LoginForm: TLoginForm;

implementation

uses
  m_glob_client, u_ini, f_proxy;

{$R *.dfm}

{ TLoginForm }

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  LabeledEdit1.Text := GM.UserName;
  LabeledEdit2.Text := '';
end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
  if IniObject.ProxyActive then
    BaseFrame1.StatusBar1.SimpleText := Format('%s:%d',
      [IniObject.ProxyHost, IniObject.ProxyPort])
    else
      BaseFrame1.StatusBar1.SimpleText := 'Kein Proxy';
end;

function TLoginForm.GetHostName: string;
begin
  Result := trim(LabeledEdit3.Text);
  if Result = '' then
    Result := 'localhost';
end;

function TLoginForm.GetPassword: string;
begin
  Result := LabeledEdit2.Text;
end;

function TLoginForm.GetUserName: string;
begin
  Result := Trim(LabeledEdit1.Text);
end;

procedure TLoginForm.setHostList( list : TStringList );
begin
  LabeledEdit3.Items.Assign(list);
  if LabeledEdit3.Items.Count > 0 then
    LabeledEdit3.ItemIndex := 0;
end;

procedure TLoginForm.SetHostName(const Value: string);
begin
  LabeledEdit3.Text := value;
end;

procedure TLoginForm.SetPassword(const Value: string);
begin
  LabeledEdit2.Text := value;
end;

procedure TLoginForm.setUserlist(list: TStringList);
begin
  LabeledEdit1.Items.Assign(list);
  if LabeledEdit1.Items.Count >0  then
    LabeledEdit1.ItemIndex := 0;
end;

procedure TLoginForm.SetUserName(const Value: string);
begin
  LabeledEdit1.Text := Trim(value);
end;

initialization
  LoginForm := NIL;
end.
