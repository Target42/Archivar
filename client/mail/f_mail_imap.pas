unit f_mail_imap;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Buttons,
  Vcl.ExtCtrls, fr_base, m_mail, System.JSON;

type
  TMailimapConfigForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox6: TGroupBox;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    BitBtn5: TBitBtn;
    GroupBox7: TGroupBox;
    LabeledEdit14: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    LabeledEdit16: TLabeledEdit;
    LabeledEdit17: TLabeledEdit;
    BitBtn6: TBitBtn;
    LabeledEdit18: TLabeledEdit;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    GroupBox1: TGroupBox;
    LB1: TListBox;
    LB2: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure LB1DblClick(Sender: TObject);
    procedure LB2DblClick(Sender: TObject);
  private
    m_mailMod : TMailMod;
    m_changed : boolean;
    m_folder  : TStringList;
    m_data    : TJSONObject;
    m_folderUpdate : boolean;
    procedure FillData;
    procedure saveImap;
    procedure saveSmtp;
    function GetData: TJSONObject;
    procedure SetData(const Value: TJSONObject);
    procedure move( src, dest : TListBox );
  public
    property Data: TJSONObject read GetData write SetData;
    property Folder : TStringList read m_folder;
  end;

var
  MailimapConfigForm: TMailimapConfigForm;

implementation

uses
  u_json;

{$R *.dfm}

procedure TMailimapConfigForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  saveImap;
  saveSmtp;
end;

procedure TMailimapConfigForm.BitBtn5Click(Sender: TObject);
var
  i, inx : integer;
begin
  saveImap;
  try
    m_mailMod.connectImap;
    m_mailMod.updateMailFolder;

    LB2.Items.BeginUpdate;
    LB2.Items.Assign(m_mailMod.MailFolder);
    for i := pred(LB2.Items.Count) downto 0 do begin
      if LB1.Items.IndexOf(LB2.Items[i]) >-1 then
        LB2.Items.Delete(i);
    end;
    LB2.Items.EndUpdate;
    m_folderUpdate := true;
  except
    on e : exception do
      ShowMessage(e.ToString);
  end;
  m_mailMod.closeImap;
end;

procedure TMailimapConfigForm.BitBtn6Click(Sender: TObject);
var
  list : TStringList;
begin
  saveSmtp;
  if LabeledEdit18.Text <> '' then begin
    list := TSTringList.Create;
    list.Add(LabeledEdit18.Text);
    if m_mailMod.sendText(list, 'SMTP-Test', 'Testmail') then
      ShowMessage('Mail gesendet');
    list.Free;
  end else
  begin
    if m_mailMod.connectSmtp then
      ShowMessage('Verbindung erfolgreich')
    else
      ShowMessage('Verbindungsfehler')
  end;
end;

procedure TMailimapConfigForm.FillData;
var
  bst   : TStream;
  obj   : TJSONObject;
  i     : integer;
begin
  if not Assigned(m_data) then exit;
  obj := JObject( m_data, 'smtp');
  if Assigned(obj) then begin
    LabeledEdit16.Text := JString( obj, 'user' );
    LabeledEdit17.Text := JString( obj, 'pwd' );
    LabeledEdit14.Text := JString( obj, 'host' );
    LabeledEdit15.Text := IntToStr(JInt( obj, 'port' ));
  end;
  obj := JObject( m_data, 'imap');
  if Assigned(obj) then begin
    LabeledEdit12.Text := JString( obj, 'user' );
    LabeledEdit13.Text := JString( obj, 'pwd' );
    LabeledEdit10.Text := JString( obj, 'host' );
    LabeledEdit11.Text := IntToStr(JInt( obj, 'port' ));

    if m_folder.Count = 0 then
      getText(obj, 'folder', m_folder );

    m_mailMod.SelectedMailFolder.Assign(m_folder);
    LB1.Items.Assign(m_folder);
  end;
end;

procedure TMailimapConfigForm.FormCreate(Sender: TObject);
begin
  m_mailMod := TMailMod.Create(NIL);
  m_folder  := TStringList.Create;
  m_data    := NIL;
  m_folderUpdate := false;
end;

procedure TMailimapConfigForm.FormDestroy(Sender: TObject);
begin
  m_mailMod.Free;
  m_folder.Free;
end;

function TMailimapConfigForm.GetData: TJSONObject;
begin
  result := m_mailMod.currentConfig;
end;

procedure TMailimapConfigForm.LB1DblClick(Sender: TObject);
begin
  move(LB1, LB2);
end;

procedure TMailimapConfigForm.LB2DblClick(Sender: TObject);
begin
  move(LB2, LB1);
end;

procedure TMailimapConfigForm.move(src, dest: TListBox);
var
  s : string;
  inx : integer;
begin
  if src.ItemIndex = -1 then exit;

  s := src.Items[src.ItemIndex];
  src.Items.Delete(src.ItemIndex);

  if dest.Items.IndexOf(s) = -1 then
    dest.Items.Add(s);
end;

procedure TMailimapConfigForm.saveImap;
var
  i : integer;
begin
  m_mailMod.IMapHost  := LabeledEdit10.Text;
  m_mailMod.IMapUser  := LabeledEdit12.Text;
  m_mailMod.IMapPWD   := LabeledEdit13.Text;
  m_mailMod.ImapPort  := StrToIntDef( LabeledEdit11.Text, 0);

  if m_folderUpdate then begin
    m_mailMod.SelectedMailFolder.Assign(LB1.Items);
  end;
end;

procedure TMailimapConfigForm.saveSmtp;
begin
  m_mailMod.SmtpHost := LabeledEdit14.Text;
  m_mailMod.SmtpPort := StrTointDef(LabeledEdit15.Text, 0 );
  m_mailMod.SmtpUser := LabeledEdit16.Text;
  m_mailMod.SmtpPwd  := LabeledEdit17.Text;

end;

procedure TMailimapConfigForm.SetData(const Value: TJSONObject);
begin
  m_data := value;
  FillData;
end;

end.
