unit f_tableField_editor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, fr_base, i_datafields;

type
  TTableFieldEditorForm = class(TForm)
    BaseFrame1: TBaseFrame;
    Panel1: TPanel;
    LV: TListView;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
  private
    m_root : IDataField;
    m_list : IDataFieldList;

    procedure setRoot( value : IDataField );
    function  getRoot : IDataField;
    function  getList : IDataFieldList;
    procedure updateView;
  public
    property Root       : IDataField      read getRoot write setRoot;
    property FieldList  : IDataFieldList  read getList write m_list;
  end;

var
  TableFieldEditorForm: TTableFieldEditorForm;

implementation

uses
  f_datafield_edit, f_task_datafields;

{$R *.dfm}

{ TTableFieldEditorForm }

procedure TTableFieldEditorForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  m_root.Childs := m_list;
  m_list        := NIL;
end;

procedure TTableFieldEditorForm.BitBtn1Click(Sender: TObject);
var
  DatafieldEditform : TDatafieldEditform;
  df : IDataField;
begin
  try
    df := m_list.newField('Tabellenfeld', 'string');
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);

    DatafieldEditform.FieldList := m_root.Owner;
    DatafieldEditform.DataField := df;
    if DatafieldEditform.ShowModal = mrOk then
      updateView
    else
      m_list.delete(df);
  finally
    DatafieldEditform.Free;
  end;
end;

procedure TTableFieldEditorForm.BitBtn2Click(Sender: TObject);
var
  DatafieldEditform : TDatafieldEditform;
  df : IDataField;
begin
  if not Assigned(LV.Selected) then
    exit;
  df := IDataField(LV.Selected.Data);
  try
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);
    DatafieldEditform.FieldList := m_root.Owner;
    DatafieldEditform.DataField := df;
    DatafieldEditform.ShowModal;
    updateView;
  finally
    DatafieldEditform.Free;
  end;
end;

procedure TTableFieldEditorForm.BitBtn3Click(Sender: TObject);
var
  df : IDataField;
begin
  if not Assigned(LV.Selected) then
    exit;
  df := IDataField(LV.Selected.Data);
  m_list.delete(df);
  df.release;
  updateView;
end;

procedure TTableFieldEditorForm.BitBtn5Click(Sender: TObject);
begin
  try
    Application.CreateForm(TTaskDatafieldsForm, TaskDatafieldsForm);
    TaskDatafieldsForm.Fields := m_list;
    TaskDatafieldsForm.open;
    if TaskDatafieldsForm.ShowModal = mrOk then
      updateView;
  finally
    TaskDatafieldsForm.free;
  end;
end;

procedure TTableFieldEditorForm.FormCreate(Sender: TObject);
begin
  m_root := nIL;
  m_list := NIL;
end;

procedure TTableFieldEditorForm.FormDestroy(Sender: TObject);
begin
  if Assigned(m_list) then
    m_list.release;
  m_root := NIL;
  m_list := NIL;
end;

function TTableFieldEditorForm.getList: IDataFieldList;
begin
  Result := m_list;
end;

function TTableFieldEditorForm.getRoot: IDataField;
begin
  Result := m_root;
end;

procedure TTableFieldEditorForm.LVDblClick(Sender: TObject);
begin
  BitBtn2.Click;
end;

procedure TTableFieldEditorForm.setRoot(value: IDataField);
begin
  m_root := value;
  m_list := m_root.Childs.clone;

  updateView;

end;

procedure TTableFieldEditorForm.updateView;
var
  i : integer;
  item : TListItem;
  df  : IDataField;
  old : IDataField;
  len, max : integer;
begin
  old := NIL;

  max := 100;
  LV.Items.BeginUpdate;
  if Assigned(LV.Selected) then
    old := IDataField(LV.Selected.Data);
  LV.Items.Clear;
  for i := 0 to pred(m_list.Count) do
  begin
    df := m_list.Items[i];
    item := LV.Items.Add;

    item.Data := df;
    item.Caption := df.Name;
    len := LV.Canvas.TextWidth(df.Name+'W');
    if len > max then
      max := len;

    item.SubItems.Add(df.Typ);

    if df.isGlobal then
      Item.SubItems.Add('Ja')
    else
      item.SubItems.Add('');
    item.SubItems.Add(df.Rem);
  end;
  LV.Column[0].Width := max;
  LV.Items.EndUpdate;
end;

end.
