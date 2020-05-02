unit f_taskEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_editForm, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, i_taskEdit, fr_Formeditor, fr_report;

type
  TTaksEditorForm = class(TForm)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    LV: TListView;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    SpeedButton1: TSpeedButton;
    TabSheet2: TTabSheet;
    EditFrame1: TEditFrame;
    EditorFrame1: TEditorFrame;
    TabSheet3: TTabSheet;
    ReportFrame1: TReportFrame;
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
  u_TaskImpl, i_datafields, f_datafield_edit, u_Task2XML;

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
var
  xw : Task2XML;
begin
  m_task := NIL;
  EditorFrame1.init;

  if FileExists('task.xml') then
  begin
    xw := Task2XML.create;
    try
      setTask( xw.load('task.xml'));
    except
      setTask(TTask.create);
    end;
    xw.Free;
  end
  else
    setTask(TTask.create);

  EditorFrame1.Task := m_task;
  ReportFrame1.init;
end;

procedure TTaksEditorForm.FormDestroy(Sender: TObject);
var
  xw : Task2XML;
begin
  xw := Task2XML.Create;
  try
    xw.save(m_task, 'task.xml');
  except

  end;
  xw.Free;
  EditorFrame1.release;
  m_task.release;
  ReportFrame1.release;
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
  wd    : integer;
  len   : integer;
begin
  old := NIL;

  wd := LV.Columns[0].Width;
  LV.Items.BeginUpdate;
  if Assigned(LV.Selected) then
    old := IDataField(LV.Selected.Data);

  LV.Items.Clear;
  for i := 0 to pred( m_task.Fields.Count) do
  begin
    item := LV.Items.Add;
    df   := m_task.Fields.Items[i];

    item.Data     := df;
    len := Lv.Canvas.TextWidth(df.Name) + 16;
    if len > wd then
      wd := len;

    item.Caption  := df.Name;
    item.SubItems.Add(df.Typ);
    if df.Typ = 'table' then
      item.SubItems.Add('Ja')
    else
      item.SubItems.Add('');
    item.SubItems.Add(df.Rem);
    if df = old then
      LV.Selected := item;

  end;
  LV.Columns[0].Width := wd;

  LV.Items.EndUpdate;
end;

end.
