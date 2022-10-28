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
    CheckBox1: TCheckBox;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
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
  m_glob_client, f_proxy;

{$R *.dfm}

{ TLoginForm }

procedure TLoginForm.BaseFrame1AbortBtnClick(Sender: TObject);
begin
  GM.clearProxy;
end;

procedure TLoginForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  if not CheckBox1.Checked then begin
    GM.clearProxy;
  end;
end;

procedure TLoginForm.CheckBox1Click(Sender: TObject);
begin
  BitBtn1.Enabled := CheckBox1.Checked;
end;

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  BitBtn1.Enabled := false;

  LabeledEdit1.Text := GM.UserName;
  LabeledEdit2.Text := '';
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

procedure TLoginForm.SpeedButton1Click(Sender: TObject);
begin
  if not Assigned(ProxyForm) then begin
    Application.CreateForm(TProxyForm, ProxyForm);

    if GM.ProxyInfo.host <> '' then ProxyForm.ProxyServer := GM.ProxyInfo.host;
    if GM.ProxyInfo.port <> 0  then ProxyForm.ProxyPort   := GM.ProxyInfo.port;
    if GM.ProxyInfo.user <> '' then ProxyForm.ProxyUser   := GM.ProxyInfo.user;
    if GM.ProxyInfo.pwd <> ''  then ProxyForm.ProxyPwd    := GM.ProxyInfo.pwd;
  end;

  if ProxyForm.ShowModal = mrOk then begin
    GM.ProxyInfo.host := ProxyForm.ProxyServer;
    GM.ProxyInfo.port := ProxyForm.ProxyPort;
    GM.ProxyInfo.user := ProxyForm.ProxyUser;
    GM.ProxyInfo.pwd  := ProxyForm.ProxyPwd;
  end else
    GM.clearProxy;
end;

initialization
  LoginForm := NIL;
end.
