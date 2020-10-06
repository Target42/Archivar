unit f_textblock_edit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_editForm, Vcl.StdCtrls, Vcl.ExtCtrls,
  fr_base, Vcl.ComCtrls, xsd_TextBlock, Vcl.Buttons;

type
  TTextBlockEditForm = class(TForm)
    BaseFrame1: TBaseFrame;
    Panel1: TPanel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Label1: TLabel;
    EditFrame1: TEditFrame;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    LV: TListView;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    Label2: TLabel;
    ComboBox1: TComboBox;
    btnNeu: TBitBtn;
    btnEdit: TBitBtn;
    btnSave: TBitBtn;
    btnDelete: TBitBtn;
    procedure btnNeuClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
  private
    x_block : IXMLBlock;
  public
    { Public-Deklarationen }
  end;

var
  TextBlockEditForm: TTextBlockEditForm;

implementation

{$R *.dfm}

uses
  ClipBrd;


procedure TTextBlockEditForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  i     : integer;
  item  : TListItem;
  xi    : IXMLField;
begin
  x_block         := NewBlock;
  x_block.Name    := trim(LabeledEdit1.Text);
  x_block.Tags    := Trim(LabeledEdit2.Text);
  x_block.Content := EditFrame1.getText;

  for i := 0 to pred(LV.Items.Count) do
  begin
    item := LV.Items.Item[i];
    xi   := x_block.Fields.Add;

    xi.Name     := item.Caption;
    xi.Caption  := item.SubItems.Strings[0];
    xi.Fieldtype:= item.SubItems.Strings[1];
    xi.Rem      := item.SubItems.Strings[2];
  end;

  x_block.OwnerDocument.SaveToFile('textblock.xml');

end;

procedure TTextBlockEditForm.btnDeleteClick(Sender: TObject);
begin
  if not Assigned(LV.Selected) then
    exit;
  LV.DeleteSelected;
end;

procedure TTextBlockEditForm.btnEditClick(Sender: TObject);
var
  item : TListItem;
begin
  if not Assigned(LV.Selected) then
    exit;
  item := LV.Selected;

  LabeledEdit3.Text := item.Caption;
  LabeledEdit4.Text := item.SubItems.Strings[0];
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(item.SubItems.Strings[1]);
  LabeledEdit5.Text := item.SubItems.Strings[2];

end;

procedure TTextBlockEditForm.btnNeuClick(Sender: TObject);
begin
  LabeledEdit3.Text := '';
  LabeledEdit4.Text := '';
  LabeledEdit5.Text := '';
  ComboBox1.ItemIndex := 0;
  LabeledEdit3.SetFocus;
end;

procedure TTextBlockEditForm.btnSaveClick(Sender: TObject);
var
  item : TListItem;
  i    : integer;
begin
  if not Assigned(LV.Selected) then
  begin
    item := LV.Items.Add;
    for i := 1 to pred(LV.Columns.Count) do
      item.SubItems.Add('');
  end
  else
    item := LV.Selected;

  item.Caption := Trim(LabeledEdit3.Text);
  item.SubItems.Strings[0] := trim(LabeledEdit4.Text);
  item.SubItems.Strings[1] := ComboBox1.Items.Strings[ComboBox1.ItemIndex];
  item.SubItems.Strings[2] := trim(LabeledEdit5.Text);

end;

procedure TTextBlockEditForm.FormCreate(Sender: TObject);
var
  i     : integer;
  item  : TListItem;
  xi    : IXMLField;
begin
  if FileExists('textblock.xml') then
  begin
    x_block := LoadBlock('textblock.xml');
    LabeledEdit1.Text := x_block.Name;
    LabeledEdit2.Text := x_block.Tags;
    EditFrame1.setText(x_block.Content);

    for i := 0 to pred(x_block.Fields.Count) do
    begin
      xi    := x_block.Fields.Field[i];
      item  := LV.Items.Add;

      item.Caption := xi.Name;
      item.SubItems.Add(xi.Caption);
      item.SubItems.Add(xi.Fieldtype);
      item.SubItems.Add(xi.Rem);
    end;
  end;
end;

procedure TTextBlockEditForm.LVDblClick(Sender: TObject);
var
  brd : TClipboard;
begin
  if not Assigned(Lv.Selected) then
    exit;
  brd := Clipboard;
  brd.Open;

  brd.AsText := '%%'+LV.Selected.Caption+'%%';

  brd.Close;

  EditFrame1.RE.PasteFromClipboard;
end;

end.
