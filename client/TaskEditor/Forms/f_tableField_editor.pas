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
  private
    m_root : IDataField;
    m_list : IDataFieldList;

    procedure setRoot( value : IDataField );
    procedure updateView;
  public
    property Root : IDataField read m_root write setRoot;
  end;

var
  TableFieldEditorForm: TTableFieldEditorForm;

implementation

uses
  f_datafield_edit;

{$R *.dfm}

{ TTableFieldEditorForm }

procedure TTableFieldEditorForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  m_root.Childs := m_list;
end;

procedure TTableFieldEditorForm.BitBtn1Click(Sender: TObject);
var
  DatafieldEditform : TDatafieldEditform;
  df : IDataField;
begin
  try
    df := m_list.newField('Tabellenfeld', 'string');
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);
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
    DatafieldEditform.DataField := df;
    if DatafieldEditform.ShowModal = mrOk then
      updateView
    else
      m_list.delete(df);
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

procedure TTableFieldEditorForm.FormCreate(Sender: TObject);
begin
  m_root := nIL;
  m_list := NIL;
end;

procedure TTableFieldEditorForm.FormDestroy(Sender: TObject);
begin
  m_root := NIL;
  m_list := NIL;
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
begin
  old := NIL;

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
    item.SubItems.Add(df.Typ);

    if df.isGlobal then
      Item.SubItems.Add('Ja')
    else
      item.SubItems.Add('');
    item.SubItems.Add(df.Rem);
  end;

  LV.Items.EndUpdate;
end;

end.
