unit f_taskEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_editForm, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, i_taskEdit;

type
  TTaksEditorForm = class(TForm)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    EditFrame1: TEditFrame;
    LV: TListView;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    m_task : ITask;

    procedure setTask( value : ITask );
    procedure updateVarList;
  public
    property Task : ITask read m_task write setTask;
  end;

var
  TaksEditorForm: TTaksEditorForm;

implementation

uses
  u_TaskImpl, i_datafields, f_datafield_edit;

{$R *.dfm}

procedure TTaksEditorForm.BitBtn1Click(Sender: TObject);
var
  df : IDataField;
  DatafieldEditform : TDatafieldEditform;
begin
  df := m_task.Fields.newField('Neues_Feld', 'string');
  try
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);
    DatafieldEditform.DataField := df;
    if DatafieldEditform.ShowModal = mrOk then
      updateVarList
    else
      m_task.Fields.delete(df);
  finally
    DatafieldEditform.Free;
  end;

end;

procedure TTaksEditorForm.BitBtn2Click(Sender: TObject);
var
  df : IDataField;
  DatafieldEditform : TDatafieldEditform;
begin
  df := m_task.Fields.newField('Neue_Tabelle', 'table');
  try
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);
    DatafieldEditform.DataField := df;
    if DatafieldEditform.ShowModal = mrOk then
      updateVarList
    else
      m_task.Fields.delete(df);
  finally
    DatafieldEditform.Free;
  end;

end;

procedure TTaksEditorForm.BitBtn3Click(Sender: TObject);
var
  df : IDataField;
  DatafieldEditform : TDatafieldEditform;
begin
  if not Assigned(LV.Selected) then
    exit;
  df := IDataField(LV.Selected.Data);

  try
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);
    DatafieldEditform.DataField := df;
    if DatafieldEditform.ShowModal = mrOk then
      updateVarList
  finally
    DatafieldEditform.Free;
  end;

end;

procedure TTaksEditorForm.BitBtn4Click(Sender: TObject);
var
  df : IDataField;
begin
  if not Assigned(LV.Selected) then
    exit;
  df := IDataField(LV.Selected.Data);
  m_task.Fields.delete(df);
  updateVarList;
end;

procedure TTaksEditorForm.FormCreate(Sender: TObject);
begin
  m_task := NIL;
  setTask(TTask.create);
end;

procedure TTaksEditorForm.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TTaksEditorForm.setTask(value: ITask);
begin
  m_task := value;
  updateVarList;
end;

procedure TTaksEditorForm.updateVarList;
var
  i     : integer;
  item  : TListItem;
  df    : IDataField;
  old   : IDataField;
begin
  old := NIL;

  LV.Items.BeginUpdate;
  if Assigned(LV.Selected) then
    old := IDataField(LV.Selected.Data);

  LV.Items.Clear;
  for i := 0 to pred( m_task.Fields.Count) do
  begin
    item := LV.Items.Add;
    df   := m_task.Fields.Items[i];
    item.Data     := df;
    item.Caption  := df.Name;
    item.SubItems.Add(df.Typ);
    if df.Required then
      item.SubItems.Add('Ja')
    else
      item.SubItems.Add('');
    if df.Typ = 'table' then
      item.SubItems.Add('Ja')
    else
      item.SubItems.Add('');
    item.SubItems.Add(df.Rem);
    if df = old then
      LV.Selected := item;

  end;

  LV.Items.EndUpdate;
end;

end.
