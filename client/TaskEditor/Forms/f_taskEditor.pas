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
    m_tc   : ITaskContainer;
    procedure setTaskContainer( value : ITaskContainer);
    procedure updateVarList;
  public
    property TaskContainer : ITaskContainer read m_tc write setTaskContainer;
  end;

var
  TaksEditorForm: TTaksEditorForm;

implementation

uses
  u_TaskImpl, i_datafields, f_datafield_edit, System.IOUtils,
  u_TTaskContainerImpl;

{$R *.dfm}

procedure TTaksEditorForm.BitBtn1Click(Sender: TObject);
var
  df : IDataField;
  DatafieldEditform : TDatafieldEditform;
begin

  df := m_tc.Task.Fields.newField('Neues_Feld', 'string');
  try
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);
    DatafieldEditform.DataField := df;
    if DatafieldEditform.ShowModal = mrOk then
      updateVarList
    else
      m_tc.Task.Fields.delete(df);
  finally
    DatafieldEditform.Free;
  end;

end;

procedure TTaksEditorForm.BitBtn2Click(Sender: TObject);
var
  df : IDataField;
  DatafieldEditform : TDatafieldEditform;
begin
  df := m_tc.Task.Fields.newField('Neue_Tabelle', 'table');
  try
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);
    DatafieldEditform.DataField := df;
    if DatafieldEditform.ShowModal = mrOk then
      updateVarList
    else
      m_tc.Task.Fields.delete(df);
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
  m_tc.Task.Fields.delete(df);
  updateVarList;
end;

procedure TTaksEditorForm.FormCreate(Sender: TObject);
begin
  EditorFrame1.init;

  m_tc := TTaskContainerImpl.create;
  m_tc.loadFromPath(TPath.Combine( ExtractFilePath( Application.ExeName), 'lib\task\{D45BD078-C776-4DD2-B47F-68E6CE886C42}' ));
  setTaskContainer(m_tc);

  EditorFrame1.Task := m_tc.Task;

  ReportFrame1.init;
  ReportFrame1.TaskContainer := m_tc;

  EditorFrame1.OnNewForm := ReportFrame1.doNewForm;

end;

procedure TTaksEditorForm.FormDestroy(Sender: TObject);
begin
  m_tc.saveToPath(TPath.Combine( ExtractFilePath( Application.ExeName), 'lib\task\{D45BD078-C776-4DD2-B47F-68E6CE886C42}' ));
  EditorFrame1.release;
  ReportFrame1.release;
  m_tc.release;

end;

procedure TTaksEditorForm.setTaskContainer(value: ITaskContainer);
begin
  m_tc := value;
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
  for i := 0 to pred( m_tc.Task.Fields.Count) do
  begin
    item := LV.Items.Add;
    df   := m_tc.Task.Fields.Items[i];

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
