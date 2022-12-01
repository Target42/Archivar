unit f_textblock_edit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_editForm, Vcl.StdCtrls, Vcl.ExtCtrls,
  fr_base, Vcl.ComCtrls, xsd_TextBlock, Vcl.Buttons, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.Mask, Vcl.DBCtrls, Xml.XMLIntf, Vcl.Menus;

type
  TTextBlockEditForm = class(TForm)
    BaseFrame1: TBaseFrame;
    Panel1: TPanel;
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
    DSProviderConnection1: TDSProviderConnection;
    TBtab: TClientDataSet;
    LabeledEdit1: TDBEdit;
    LabeledEdit2: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    TBSrc: TDataSource;
    PopupMenu1: TPopupMenu;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    LabeledEdit6: TComboBox;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    procedure btnNeuClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TBtabBeforePost(DataSet: TDataSet);
    procedure EditFrame1REKeyPress(Sender: TObject; var Key: Char);
    procedure Variableeinfgen1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    m_id        : integeR;
    x_block     : IXMLBlock;
    m_modified  : boolean;

    procedure setID( value : integer );

    procedure saveXML;
    procedure loadXML;
  public
    property ID : integer read m_id write setID;
  end;

var
  TextBlockEditForm: TTextBlockEditForm;

implementation

{$R *.dfm}

uses
  ClipBrd, m_glob_client, Xml.XMLDoc, system.UITypes, f_textblock_param,
  f_textblock_preview, f_taglist, System.Win.ComObj, System.IOUtils;


procedure TTextBlockEditForm.BaseFrame1AbortBtnClick(Sender: TObject);
begin
  TBtab.Cancel;

  if TBtab.UpdatesPending then
    TBtab.CancelUpdates;
end;

procedure TTextBlockEditForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  st : TStream;
begin
  if m_modified  then
  begin
    if TBtab.FieldByName('TB_CLID').IsNull then
      TBtab.FieldByName('TB_CLID').AsString := CreateClassID;

    saveXML;

    st := TBtab.CreateBlobStream(TBtab.FieldByName('TB_TEXT'), bmWrite);
    x_block.OwnerDocument.SaveToStream(st);
    st.Free;
  end;

  TBtab.Post;

  if TBtab.UpdatesPending then
    TBtab.ApplyUpdates(-1);
end;

procedure TTextBlockEditForm.BitBtn1Click(Sender: TObject);
begin
  saveXML;

  if x_block.Fields.Count = 0 then begin
    TextBlockPreviewForm.Text := x_block.Content;
    TextBlockPreviewForm.ShowModal;
  end
  else
  begin
    Application.CreateForm(TTextBlockParameterForm, TextBlockParameterForm);
    TextBlockParameterForm.Xblock := x_block;
    if TextBlockParameterForm.ShowModal = mrOk then
    begin
      TextBlockPreviewForm.Text := TextBlockParameterForm.getContext;
      TextBlockPreviewForm.ShowModal;
    end;
    TextBlockParameterForm.free;
  end;
end;

procedure TTextBlockEditForm.btnDeleteClick(Sender: TObject);
begin
  if not Assigned(LV.Selected) then
    exit;
  LV.DeleteSelected;

  m_modified := true;
end;

procedure TTextBlockEditForm.btnEditClick(Sender: TObject);
var
  item : TListItem;
begin
  if not Assigned(LV.Selected) then
    exit;

  item := LV.Selected;

  LabeledEdit3.Text   := item.Caption;
  LabeledEdit4.Text   := item.SubItems.Strings[0];
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(item.SubItems.Strings[1]);
  LabeledEdit6.Text   := item.SubItems.Strings[2];
  LabeledEdit5.Text   := item.SubItems.Strings[3];
end;

procedure TTextBlockEditForm.btnNeuClick(Sender: TObject);
begin
  Lv.Selected := NIL;

  LabeledEdit3.Text := '';
  LabeledEdit4.Text := '';
  LabeledEdit5.Text := '';
  LabeledEdit6.Text := '';
  ComboBox1.ItemIndex := 0;
  LabeledEdit3.SetFocus;
  m_modified := true;
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
  item.SubItems.Strings[2] := trim(LabeledEdit6.Text);
  item.SubItems.Strings[3] := trim(LabeledEdit5.Text);
  m_modified := true;
end;

procedure TTextBlockEditForm.EditFrame1REKeyPress(Sender: TObject;
  var Key: Char);
begin
  m_modified := true;
end;

procedure TTextBlockEditForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  Application.CreateForm(TTextBlockPreviewForm, TextBlockPreviewForm);
  Application.CreateForm(TTagListForm, TagListForm);
  EditFrame1.prepare;
end;

procedure TTextBlockEditForm.FormDestroy(Sender: TObject);
begin
  EditFrame1.Release;
  if (TBtab.State = dsInsert) or ( TBtab.State = dsEdit)  then
  begin
    TBtab.Cancel;

    if TBtab.UpdatesPending then
      TBtab.CancelUpdates;
  end;
  TextBlockPreviewForm.free;

  TagListForm.free;
end;

procedure TTextBlockEditForm.LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key >= ' ' then begin
    if not TPath.IsValidFileNameChar( key ) then
      key := #0;
  end;
end;

procedure TTextBlockEditForm.loadXML;
var
  st  : TStream;
  xml : IXMLDocument;
  i   : integer;
  item  : TListItem;
  xi    : IXMLField;
begin
  st := TBtab.CreateBlobStream(TBtab.FieldByName('TB_TEXT'), bmRead);
  xml := NewXMLDocument;
  xml.LoadFromStream(st);
  x_block := xml.GetDocBinding('Block', TXMLBlock, TargetNamespace) as IXMLBlock;

  if Assigned(x_block) then
  begin
    EditFrame1.Text := x_block.Content;

    for i := 0 to pred(x_block.Fields.Count) do
    begin
      xi    := x_block.Fields.Field[i];
      item  := LV.Items.Add;

      item.Caption := xi.Name;
      item.SubItems.Add(xi.Caption);
      item.SubItems.Add(xi.Fieldtype);
      item.SubItems.Add(xi.DefaultValue );
      item.SubItems.Add(xi.Rem);
    end;
  end;
  st.Free;
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

procedure TTextBlockEditForm.PopupMenu1Popup(Sender: TObject);
var
  item : TMenuItem;
  i    : integer;
begin
  PopupMenu1.Items.Clear;
  for i := 0 to pred(LV.Items.Count) do begin
    item := TMenuItem.Create(PopupMenu1);
    PopupMenu1.Items.Add(item);
    item.OnClick := Variableeinfgen1Click;
    item.Caption := Lv.Items.Item[i].Caption;
  end;
end;

procedure TTextBlockEditForm.saveXML;
var
  i     : integer;
  item  : TListItem;
  xi    : IXMLField;
begin
  x_block         := NewBlock;
  x_block.Id      := TBtab.FieldByName('TB_CLID').AsString;
  x_block.Name    := trim( TBtab.FieldByName('TB_NAME').AsString);
  x_block.Tags    := Trim( TBtab.FieldByName('TB_TAGS').AsString);
  x_block.Content := EditFrame1.Text;

  for i := 0 to pred(LV.Items.Count) do
  begin
    item := LV.Items.Item[i];
    xi   := x_block.Fields.Add;

    xi.Name           := item.Caption;
    xi.Caption        := item.SubItems.Strings[0];
    xi.Fieldtype      := item.SubItems.Strings[1];
    xi.DefaultValue   := item.SubItems.Strings[2];
    xi.Rem            := item.SubItems.Strings[3];
  end;
end;

procedure TTextBlockEditForm.setID(value: integer);
begin
  m_id := value;

  TBtab.Open;
  if m_id <> -1 then
  begin
    if TBtab.Locate('TB_ID', VarArrayOf([value]), []) then
    begin
      m_id := value;
      TBtab.Edit;
      loadXML;
      m_modified := false;
    end;
  end;

  if m_id = -1 then
  begin
    TBtab.Append;
    m_modified := true;
  end;

end;

procedure TTextBlockEditForm.SpeedButton1Click(Sender: TObject);
begin
  if TagListForm.ShowModal = mrOk then begin
    LabeledEdit2.Text := LabeledEdit2.Text + ' '+ TagListForm.Selected;
  end;
end;

procedure TTextBlockEditForm.TBtabBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('TB_ID').AsInteger = 0 then
    DataSet.FieldByName('TB_ID').AsInteger := GM.autoInc('gen_tb_id');
end;

procedure TTextBlockEditForm.Variableeinfgen1Click(Sender: TObject);
var
  item : TMenuItem;
  brd : TClipboard;
  s   : string;
begin
  if not (sender is TMenuItem) then
    exit;
  item := sender as TMenuItem;
  brd := Clipboard;
  brd.Open;

  s := stringreplace( item.Caption, '&', '', [rfReplaceAll, rfIgnoreCase]);
  brd.AsText := '%%'+s+'%%';

  brd.Close;

  EditFrame1.RE.PasteFromClipboard;
end;

end.


