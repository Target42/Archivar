unit f_admin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_stub, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TAdminForm = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    Senden: TBitBtn;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    LabeledEdit1: TLabeledEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SendenClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    client : TAdminModClient;
  public
    { Public-Deklarationen }
  end;

var
  AdminForm: TAdminForm;

procedure ShowAdminform;

implementation

uses
  m_glob_client, System.JSON, u_json, u_Konst;

{$R *.dfm}

procedure ShowAdminform;
begin
  Application.CreateForm(TAdminForm, AdminForm);
  AdminForm.ShowModal;
  AdminForm.Free;
end;

procedure TAdminForm.BitBtn1Click(Sender: TObject);
var
  req : TJSONObject;
begin
  req := TJSONObject.Create;
  JReplace( req, 'action', BRD_ADMIN);
  JReplace( req, 'cmd',    BRD_ADMIN_CLOSE_EDIT);

  client.ServiceAction(req);
end;

procedure TAdminForm.BitBtn2Click(Sender: TObject);
var
  req : TJSONObject;
begin
  req := TJSONObject.Create;
  JReplace( req, 'action',  BRD_ADMIN);
  JReplace( req, 'cmd',     BRD_ADMIN_REBOOT);
  JReplace( req, 'counter', SpinEdit1.Value);
  JReplace( req, 'text',    LabeledEdit1.Text);

  client.ServiceAction(req);
end;


procedure TAdminForm.BitBtn3Click(Sender: TObject);
var
  req : TJSONObject;
begin
  req := TJSONObject.Create;
  JReplace( req, 'action',  BRD_ADMIN);
  JReplace( req, 'cmd',     BRD_ADMIN_TERMINATE);

  client.ServiceAction(req);
end;

procedure TAdminForm.FormCreate(Sender: TObject);
begin
  client := TAdminModClient.Create(GM.SQLConnection1.DBXConnection);
  Memo1.Lines.Clear;
end;

procedure TAdminForm.FormDestroy(Sender: TObject);
begin
  client.Free;
end;

procedure TAdminForm.SendenClick(Sender: TObject);
var
  req : TJSONObject;
begin
  req := TJSONObject.Create;
  JReplace( req, 'action',  BRD_ADMIN);
  JReplace( req, 'cmd',     BRD_ADMIN_MSG);
  JReplace( req, 'urgend',  CheckBox1.Checked);
  setText(  req, 'text',    Memo1.Lines);

  client.ServiceAction(req);
end;

end.


