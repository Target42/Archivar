unit f_taskEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_editForm, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, i_taskEdit, fr_Formeditor, fr_report,
  System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.Mask, Vcl.DBCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect;

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
    TabSheet2: TTabSheet;
    EditFrame1: TEditFrame;
    EditorFrame1: TEditorFrame;
    TabSheet3: TTabSheet;
    ReportFrame1: TReportFrame;
    MainMenu1: TMainMenu;
    Vorlageneditor1: TMenuItem;
    ActionList1: TActionList;
    ac_lload: TAction;
    Laden1: TMenuItem;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DSProviderConnection1: TDSProviderConnection;
    TETab: TClientDataSet;
    TESrc: TDataSource;
    N1: TMenuItem;
    ac_export: TAction;
    SaveDialog1: TSaveDialog;
    Export1: TMenuItem;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ac_lloadExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn5Click(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
    procedure ac_exportExecute(Sender: TObject);
    procedure ReportFrame1Button1Click(Sender: TObject);
  private
    m_teid : integer;
    m_tc   : ITaskContainer;

    procedure setTEID( value : integer );
    procedure setTaskContainer( value : ITaskContainer);
    procedure updateVarList;

    procedure loadFromStream( st : TStream; tname : string );
    procedure saveToStream;
    procedure CheckDefaultStype;
  public
    property TaskContainer : ITaskContainer read m_tc   write setTaskContainer;
    property TEID          : integer        read m_teid write setTEID;

    procedure load;
    procedure new;
    procedure save;
  end;

var
  TaksEditorForm: TTaksEditorForm;

implementation

uses
  u_TaskImpl, i_datafields, f_datafield_edit, System.IOUtils,
  u_TTaskContainerImpl, system.zip, m_glob_client, f_task_datafields,
  System.UITypes, u_templateCache;

{$R *.dfm}

procedure TTaksEditorForm.ac_exportExecute(Sender: TObject);
var
  path : string;
begin
  path := TPath.Combine(Gm.ExportDir, 'tasks');
  try
    ForceDirectories(path)
  except

  end;
  SaveDialog1.InitialDir  := path;
  SaveDialog1.FileName    := m_tc.Task.Name+'.task';

  if SaveDialog1.Execute then
    m_tc.exportTask(SaveDialog1.FileName);
end;

procedure TTaksEditorForm.ac_lloadExecute(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    m_tc.import( OpenDialog1.FileName );
    setTaskContainer( m_tc);
  end;
end;

procedure TTaksEditorForm.BitBtn1Click(Sender: TObject);
var
  df : IDataField;
  DatafieldEditform : TDatafieldEditform;
begin

  df := m_tc.Task.Fields.newField('Neues_Feld', 'string');
  try
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);
    DatafieldEditform.FieldList := m_tc.Task.Fields;
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
    DatafieldEditform.FieldList := m_tc.Task.Fields;
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

    DatafieldEditform.FieldList := m_tc.Task.Fields;
    DatafieldEditform.DataField := df;
    DatafieldEditform.ReadOnly  := df.isGlobal;

    if DatafieldEditform.ShowModal = mrOk then
      updateVarList;
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

procedure TTaksEditorForm.BitBtn5Click(Sender: TObject);
begin
  try
    Application.CreateForm(TTaskDatafieldsForm, TaskDatafieldsForm);
    TaskDatafieldsForm.Fields := m_tc.Task.Fields;
    TaskDatafieldsForm.setServer(DSProviderConnection1);
    TaskDatafieldsForm.open;
    if TaskDatafieldsForm.ShowModal = mrOk then
      updateVarList;
  finally
    TaskDatafieldsForm.free;
  end;
end;

procedure TTaksEditorForm.CheckDefaultStype;
begin
  if not Assigned(m_tc) then
    exit;
  if m_tc.Styles.Count = 0 then
    m_tc.Styles.newStyle('default');
end;

procedure TTaksEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TTaksEditorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

  if (MessageDlg('Sollen die Änderungen übernommen werden?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    saveToStream;
    TETab.Post;
    if TETab.UpdatesPending then
      TETab.ApplyUpdates(0);
  end  else begin
    TETab.Cancel;
    if TETab.UpdatesPending then
      TETab.CancelUpdates;
  end;
end;

procedure TTaksEditorForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_tc := NIL;
  EditorFrame1.init;

  ReportFrame1.init;
  EditorFrame1.OnNewForm := ReportFrame1.doNewForm;
end;

procedure TTaksEditorForm.FormDestroy(Sender: TObject);
begin
  EditorFrame1.release;
  ReportFrame1.release;

  m_tc.release;
end;

procedure TTaksEditorForm.load;
begin
  ac_lload.Execute;
end;

procedure TTaksEditorForm.loadFromStream(st: TStream ; tname : string);
begin
  m_tc := loadTaskContainer( st, name );

  CheckDefaultStype;
  setTaskContainer(m_tc);
end;

procedure TTaksEditorForm.LVDblClick(Sender: TObject);
begin
  if LV.ItemIndex > -1 then
    BitBtn3.Click
  else
    BitBtn1.Click;
end;

procedure TTaksEditorForm.new;
begin
  m_tc := TTaskContainerImpl.create;
  setTaskContainer( m_tc );
end;

procedure TTaksEditorForm.ReportFrame1Button1Click(Sender: TObject);
begin
  ReportFrame1.Button1Click(Sender);

end;

procedure TTaksEditorForm.save;
begin
  saveToStream;
end;

procedure TTaksEditorForm.saveToStream;
var
  st : TStream;
  clid : String;
begin
  EditorFrame1.saveCurrentForm;

  st := TETab.CreateBlobStream(  TETab.FieldByName('TE_DATA'), bmWrite);
  m_tc.saveToStream(st);
  st.Position := 0;

  TETab.FieldByName('TE_MD5').AsString := GM.md5(st);
  clid := TETab.FieldByName('TE_CLID').AsString;
  st.Free;

  TemplateCacheMod.setDirty(CLID);
end;

procedure TTaksEditorForm.setTaskContainer(value: ITaskContainer);
begin
  m_tc := value;
  EditorFrame1.Task := m_tc.Task;
  ReportFrame1.TaskContainer := m_tc;

  CheckDefaultStype;

  updateVarList;
end;

procedure TTaksEditorForm.setTEID(value: integer);
begin
  m_teid := value;

  TETab.Filter    := 'TE_ID = '+IntToStr( m_teid);
  TETab.Filtered  := true;
  TETab.Open;

  if TETab.IsEmpty then
    exit;
  TETab.Edit;

  loadFromStream( TETab.CreateBlobStream(TETab.FieldByName('TE_DATA'), bmRead),
    TETab.FieldByName('TE_NAME').AsString);
  if TETab.FieldByName('TE_SYSTEM').AsString = 'T' then
  begin
    GroupBox3.Enabled := false;
  end;

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
    if SameText(df.Typ, 'table') or SameText( df.Typ, 'linktable') then
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
