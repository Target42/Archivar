unit f_set;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, Vcl.Samples.Spin;

type
  TMySettingsForm = class(TForm)
    BaseFrame1: TBaseFrame;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    LB: TListBox;
    Panel1: TPanel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    TabSheet2: TTabSheet;
    UserLB: TListBox;
    Panel2: TPanel;
    Edit2: TEdit;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    TabSheet3: TTabSheet;
    LabeledEdit1: TLabeledEdit;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    BitBtn1: TBitBtn;
    IdHTTP1: TIdHTTP;
    CheckBox1: TCheckBox;
    TabSheet4: TTabSheet;
    BitBtn2: TBitBtn;
    procedure SpeedButton1Click(Sender: TObject);
    procedure LBClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  MySettingsForm: TMySettingsForm;

implementation

uses
  m_glob_client, u_ini, System.IOUtils, u_SpellChecker;

{$R *.dfm}

procedure TMySettingsForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  GM.saveHostList;
  GM.Hostlist.Assign(LB.Items);

  GM.UserList.Assign(UserLB.Items);
  GM.saveUserList;

  IniObject.ProxyActive := CheckBox1.Checked;
  IniObject.ProxyHost   := LabeledEdit1.Text;
  IniObject.ProxyPort   := SpinEdit1.Value;
  IniObject.ProxyUser   := LabeledEdit2.Text;
  IniObject.ProxyPwd    := LabeledEdit3.Text;
  IniObject.save;
end;

procedure TMySettingsForm.BitBtn1Click(Sender: TObject);
begin
  IdHTTP1.ProxyParams.ProxyServer   := Trim(LabeledEdit1.Text);
  IdHTTP1.ProxyParams.ProxyPort     := SpinEdit1.Value;
  IdHTTP1.ProxyParams.ProxyUsername := LabeledEdit2.Text;
  IdHTTP1.ProxyParams.ProxyPassword := LabeledEdit3.Text;

  Screen.Cursor := crHourGlass;
  try
    IdHTTP1.Get(LabeledEdit4.Text);
    Screen.Cursor := crDefault;
    if IdHTTP1.ResponseCode = 200 then begin
      BaseFrame1.OKBtn.Enabled := true;
      ShowMessage('Test erfolgreich');
    end else
      ShowMessage(IdHTTP1.ResponseText);
  except
    on e : exception do begin
      Screen.Cursor := crDefault;
      ShowMessage('Test fehlgeschlagen'#13+e.ToString );
      BaseFrame1.OKBtn.Enabled := false;
    end;
  end;
end;

procedure TMySettingsForm.BitBtn2Click(Sender: TObject);
var
  check : TSpellChecker;
begin
  check := TSpellChecker.create;
  if check.config then begin

  end;
  check.Free;
end;

procedure TMySettingsForm.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet1;

  LB.Items.Assign(GM.Hostlist);
  UserLB.Items.Assign(GM.UserList);

  CheckBox1.Checked   := IniObject.ProxyActive;
  LabeledEdit1.Text   := IniObject.ProxyHost;
  SpinEdit1.Value     := IniObject.ProxyPort;
  LabeledEdit2.Text   := IniObject.ProxyUser;
  LabeledEdit3.Text   := IniObject.ProxyPwd;
end;

procedure TMySettingsForm.LBClick(Sender: TObject);
begin
  Edit1.Text := '';
  if LB.ItemIndex<>-1 then
    Edit1.Text := LB.Items.Strings[LB.ItemIndex];
end;

procedure TMySettingsForm.SpeedButton1Click(Sender: TObject);
begin
  LB.ItemIndex  := -1;
  Edit1.Text    := '';
end;

procedure TMySettingsForm.SpeedButton2Click(Sender: TObject);
var
  s : string;
begin
  s := Trim(Edit1.Text);

  if LB.ItemIndex = -1 then
    LB.Items.Add(s)
  else
    LB.Items.Strings[LB.ItemIndex] := s
end;

procedure TMySettingsForm.SpeedButton3Click(Sender: TObject);
begin
  if LB.ItemIndex <> -1 then
    LB.Items.Delete(LB.ItemIndex);
end;

procedure TMySettingsForm.SpeedButton4Click(Sender: TObject);
begin
  Edit2.Text        := '';
  UserLB.ItemIndex  := -1;
end;

procedure TMySettingsForm.SpeedButton5Click(Sender: TObject);
var
  s : string;
begin
  s := Trim(Edit2.Text);

  if UserLB.ItemIndex = -1 then
    UserLB.Items.Add(s)
  else
    UserLB.Items.Strings[LB.ItemIndex] := s
end;

procedure TMySettingsForm.SpeedButton6Click(Sender: TObject);
begin
  if UserLB.ItemIndex<> -1 then
    UserLB.DeleteSelected
end;

end.
