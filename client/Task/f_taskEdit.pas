unit f_taskEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, fr_file, System.Actions,
  Vcl.ActnList, Vcl.Menus, i_taskEdit, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect,
  JvDBDatePickerEdit, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.OleCtrls, SHDocVw, JvColorCombo, fr_form, fr_log, JvExStdCtrls,
  JvCombobox, JvExMask, JvToolEdit, JvMaskEdit, JvCheckedMaskEdit,
  JvDatePickerEdit, Vcl.Mask, u_ForceClose;

type
  TTaskEditForm = class(TForm, IForceClose)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    FileFrame1: TFileFrame;
    MainMenu1: TMainMenu;
    Dokument1: TMenuItem;
    ActionList1: TActionList;
    ac_bearbeiten: TAction;
    ac_save: TAction;
    Bearbeiten1: TMenuItem;
    N1: TMenuItem;
    Lesezeichenerstellen1: TMenuItem;
    ac_unlock: TAction;
    Bearbeitenbeenden1: TMenuItem;
    TaskSrc: TDataSource;
    TaskTab: TClientDataSet;
    DSProviderConnection1: TDSProviderConnection;
    GroupBox1: TGroupBox;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    JvDBDatePickerEdit1: TJvDBDatePickerEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    TemplateTab: TClientDataSet;
    TaskTabTA_REST: TStringField;
    Label7: TLabel;
    ComboBox1: TComboBox;
    Label8: TLabel;
    ComboBox2: TComboBox;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    WebBrowser1: TWebBrowser;
    ac_refresh: TAction;
    N2: TMenuItem;
    acsave1: TMenuItem;
    N3: TMenuItem;
    Aktualisieren1: TMenuItem;
    ac_bookmark: TAction;
    Label9: TLabel;
    DBEdit5: TDBEdit;
    Label10: TLabel;
    TaskTabTE_ID: TIntegerField;
    TaskTabTA_ID: TIntegerField;
    TaskTabTY_ID: TIntegerField;
    TaskTabTA_STARTED: TDateField;
    TaskTabTA_CREATED: TSQLTimeStampField;
    TaskTabTA_NAME: TStringField;
    TaskTabTA_DATA: TBlobField;
    TaskTabTA_CREATED_BY: TStringField;
    TaskTabTA_TERMIN: TDateField;
    TaskTabTA_CLID: TStringField;
    TaskTabTA_FLAGS: TIntegerField;
    TaskTabTA_STATUS: TStringField;
    TaskTabTA_STYLE: TStringField;
    TaskTabTA_STYLE_CLID: TStringField;
    TaskTabTA_REM: TStringField;
    TaskTabTA_COLOR: TIntegerField;
    TaskTabTA_DELETED: TStringField;
    FormFrame1: TFormFrame;
    TabSheet5: TTabSheet;
    LogTab: TClientDataSet;
    LogFrame1: TLogFrame;
    JvColorComboBox1: TJvColorComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ac_bearbeitenExecute(Sender: TObject);
    procedure ac_unlockExecute(Sender: TObject);
    procedure TaskTabTA_RESTGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure TaskTabReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure TaskTabPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure JvDBDatePickerEdit1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure ac_bookmarkExecute(Sender: TObject);
    procedure ac_saveExecute(Sender: TObject);
    procedure ac_refreshExecute(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure JvColorComboBox1Change(Sender: TObject);
  private
    m_ta_id : integer;
    m_ty_id : integeR;

    m_form  : ITaskForm;
    m_tc    : ITaskContainer;
    m_style : ITaskStyle;

    m_ro    : boolean;
    m_changed : boolean;

    procedure setRO( value : boolean );
    function  getRO : boolean;

    function changed : boolean;
    procedure save;
    procedure cancel;

    procedure LoadTemplate(teid : integer );
    procedure LoadData;

    procedure renderPreview;

    procedure reload;
  public
    procedure setID( ta_id, ty_id: integer );
    property RO : Boolean read getRO write setRO;

    procedure LockCheck;

    procedure resizeForm;

    procedure ForceClose( force : boolean);
  end;

var
  TaskEditForm: TTaskEditForm;

implementation

uses
  m_WindowHandler, Vcl.Dialogs, m_glob_client, System.UITypes,
  System.JSON, u_json, u_bookmark, u_berTypes, m_BookMarkHandler, DateUtils,
  u_taskForm2XML, u_konst, m_html, xsd_TaskData, u_templateCache, u_kategorie;

{$R *.dfm}

procedure TTaskEditForm.ac_bearbeitenExecute(Sender: TObject);
var
  data : TJSONObject;
  s : string;
begin
  data := GM.LockDocument(m_ta_id, integer(ltTask));
  if JBool( data, 'result') then
  begin
    self.RO := false;
    reload;

    TaskTab.Edit;

    ShowMessage('Das Dokument kann jetzt bearbeitet werden.');
  end
  else
  begin
    s := 'Das Dokument wird von:'+sLineBreak+
     'Benutzer: '+JString( data, 'user')+sLineBreak+
     'Host : '+JString( data, 'host')+sLineBreak+
     'Zeitpunkt: '+DateTimeToStr(JDouble( data, 'timestamp'))+sLineBreak+
     'bearbeitet';
    ShowMessage(s);
  end;
end;

procedure TTaskEditForm.ac_bookmarkExecute(Sender: TObject);
var
  mark : TBookmark;
begin
  mark := BookMarkHandler.Bookmarks.newBookmark(TaskTab.FieldByName('TA_CLID').AsString);
  mark.ID         := TaskTab.FieldByName('TA_ID').AsInteger;
  mark.Titel      := TaskTab.FieldByName('TA_NAME').AsString;
  mark.Group      := 'Einstellung';
  mark.Internal   := false;
  mark.TypeID     := integer(dstEinstellung);
  mark.DocType    := dtTask;
 PostMessage( Application.MainFormHandle, msgNewBookMark, 0, 0 );
end;

procedure TTaskEditForm.ac_refreshExecute(Sender: TObject);
begin
  reload;
end;

procedure TTaskEditForm.ac_saveExecute(Sender: TObject);
begin
  if not changed then
    exit;

  save;
  reload;
  TaskTab.Edit;
end;

procedure TTaskEditForm.ac_unlockExecute(Sender: TObject);
var
  data : TJSONObject;
begin
  if changed then
  begin
    case MessageDlg('Die Daten wurden geändert.'+#13+#10+
                    ''+#13+#10+
                    'Änderungen speichern (Ja)'+#13+#10+
                    'Änderungen verwerfen (Nein)'+#13+#10+
                    'Im Dialog bleiben (Abbrechen)'+#13+#10+'',
                     mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes : save;
      mrNo  : cancel;
      else
        exit;
    end;
  end;

  data := GM.UnlockDocument(m_ta_id, integer(ltTask));
  if JBool( data, 'result') then
    self.RO := true
  else
    ShowMessage(JString(data, 'text'));

end;


procedure TTaskEditForm.cancel;
begin
  TaskTab.Cancel;
  LogTab.Cancel;
end;

function TTaskEditForm.changed: boolean;
begin
  Result := m_changed or TaskTab.Modified or TaskTab.Modified;
  if not Result then
  begin
    if Assigned(m_form) then
      Result := m_form.Changed;
  end;
end;

procedure TTaskEditForm.ComboBox1Change(Sender: TObject);
begin
  m_changed := true;
end;

procedure TTaskEditForm.ComboBox2Change(Sender: TObject);
var
  inx: integer;
begin
  inx := ComboBox2.ItemIndex;
  if inx = -1 then
    exit;

  m_style := m_tc.Styles.Items[ integer(ComboBox2.Items.Objects[inx])];
  m_changed := true;

  renderPreview;
end;

procedure TTaskEditForm.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  m_changed := true;
end;

procedure TTaskEditForm.ForceClose(force: boolean);
begin
  if force then begin
    if changed and (TaskTab.State  = dsEdit) then begin
      save;
    end;
  end;
  self.Close;
end;

procedure TTaskEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TTaskEditForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
  if changed and (TaskTab.State =  dsEdit ) then
  begin
    case MessageDlg('Die Daten wurden geändert.'+#13+#10+
                    ''+#13+#10+
                    'Änderungen speichern (Ja)'+#13+#10+
                    'Änderungen verwerfen (Nein)'+#13+#10+
                    'Im Dialog bleiben (Abbrechen)'+#13+#10+'',
                     mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes :
      begin
        LogFrame1.AddLogEntry(m_ta_id);
        save;
        CanClose := true;
      end;
      mrNo :
      begin
        cancel;
        CanClose := true;
      end;
      else
        CanClose := false;
    end;
  end;
end;

procedure TTaskEditForm.FormCreate(Sender: TObject);
var
  i : integer;
begin

  FormFrame1.prepare;
  LogFrame1.prepare;
  FileFrame1.prepare;

  PageControl1.ActivePage := TabSheet1;
  PageControl2.ActivePage := TabSheet3;

  m_form  := NIL;
  m_tc    := NIL;
  m_style := NIL;

  FillFlagslist( ComboBox1.Items);


  Label10.Visible           := Kategorien.count > 0 ;
  JvColorComboBox1.Visible  := Kategorien.count > 0 ;

  for i := 0 to pred(Kategorien.count) do
  begin
    JvColorComboBox1.AddColor( Kategorien.Items[i].Color, Kategorien.Items[i].Name );
  end;
end;

procedure TTaskEditForm.FormDestroy(Sender: TObject);
begin
  if not m_ro then
    GM.UnLockDocument(m_ta_id, integer(ltTask));

  FileFrame1.release;
  FormFrame1.release;
  LogFrame1.release;

  if Assigned(m_tc) then
    m_tc.release;

  m_form  := NIL;
  m_tc    := NIL;
  m_style := NIL;

  WindowHandler.closeTaskWindow(m_ta_id);
  PostMessage(Application.MainFormHandle, msgFilterTasks, 1, 0);
end;

function TTaskEditForm.getRO: boolean;
begin
  Result := m_ro;
end;

procedure TTaskEditForm.JvColorComboBox1Change(Sender: TObject);
begin
  m_changed := true;
end;

procedure TTaskEditForm.JvDBDatePickerEdit1Change(Sender: TObject);
begin
  m_changed := true;
end;

procedure TTaskEditForm.LoadData;
var
  st : TStream;
  loader : TTaskForm2XML;
begin
  if not Assigned(m_form) then
    exit;

  st := TaskTab.CreateBlobStream(TaskTab.FieldByName('TA_DATA'), bmRead);
  if st.Size > 0 then
  begin
    loader := TTaskForm2XML.create;
    loader.load( st, m_form);
    loader.Free;
  end;
  st.Free;

  m_form.Changed := false;
end;

procedure TTaskEditForm.LoadTemplate(teid: integer);
var
  i, inx  : integer;
begin
  m_tc  := TemplateCacheMod.load(teid);
  if Assigned(m_tc) then
  begin
    m_style := m_tc.Styles.getStyle(TaskTab.FieldByName('TA_STYLE_CLID').AsString);

     m_form  := m_tc.Task.getMainForm;
     if Assigned(m_form) then begin
       FormFrame1.TaskForm := m_form;
     end;
  end;

  ComboBox2.Items.Clear;
  ComboBox2.Text := '';
  for i := 0 to pred(m_tc.Styles.Count) do
  begin
    inx := ComboBox2.Items.AddObject(m_tc.Styles.Items[i].Name, TObject(i));
    if m_style = m_tc.Styles.Items[i] then
      ComboBox2.ItemIndex := inx;
  end;
end;
{$ifdef unused}
var
  st  : TStream;
  i   : integer;
  inx : integer;
  s   : string;
begin
  TemplateTab.Filter    := 'TE_ID = '+IntToStr(teid);
  TemplateTab.Filtered  := true;
  TemplateTab.Open;
  if not TemplateTab.IsEmpty then
  begin
   st   := TemplateTab.CreateBlobStream(TemplateTab.FieldByName('TE_DATA'), bmRead);
   m_tc := loadTaskContainer(st, TemplateTab.FieldByName('TE_NAME').AsString);
   if Assigned(m_tc) then begin
     m_form  := m_tc.Task.getMainForm;
     if Assigned(m_form) then begin
        m_form.Base.Control := ScrollBox1;
        m_form.Base.build;
        m_form.Base.clearContent(true);
     end;
   end;
  end;
  s := TaskTab.FieldByName('TA_STYLE_CLID').AsString;

  ComboBox2.Text := '';
  for i := 0 to pred(m_tc.Styles.Count) do
  begin
    inx := ComboBox2.Items.AddObject(m_tc.Styles.Items[i].Name, TObject(i));
    if s = '' then
    begin
      if ( m_tc.Styles.DefaultStyle = m_tc.Styles.Items[i] ) then
        ComboBox2.ItemIndex := inx;
    end
    else
    begin
      if m_tc.Styles.Items[i].CLID = s then
        ComboBox2.ItemIndex := inx;
    end;
  end;

  TemplateTab.Close;
end;
{$endif}

procedure TTaskEditForm.LockCheck;
var
  data : TJSONObject;
begin
  data := GM.isLocked(m_ta_id, integer(ltTask));
  if JBool( data, 'result') then
  begin
    if not JBool( data, 'self') then
      ShowMessage( JString( data, 'text'));
  end;
end;

procedure TTaskEditForm.PageControl2Change(Sender: TObject);
begin
  if PageControl2.ActivePage = TabSheet4  then
    renderPreview;
end;

procedure TTaskEditForm.reload;
var
  i : integer;
begin
  screen.Cursor := crSQLWait;

  if Assigned(m_tc) then
    m_tc.release;
  m_tc := NIL;

  LogTab.Close;

  TaskTab.Close;
  TaskTab.Open;

  if not TaskTab.Locate('TA_ID', VarArrayOf([m_ta_id]), []) then
  begin
    TaskTab.Close;
    exit;
  end;

  LogTab.Filter := 'TA_ID = '+IntToStr(m_ta_id);
  LogTab.Filtered := true;
  LogTab.Open;
  LogFrame1.updateData(LogTab);

  JvColorComboBox1.ColorValue := TColor(TaskTab.FieldByName('TA_COLOR').AsInteger);


  if not Assigned(m_tc) then
    LoadTemplate( TaskTab.FieldByName('TE_ID').AsInteger );

  LoadData;

  FileFrame1.RootID := m_ta_id;
  for i := 0 to pred(ComboBox1.Items.Count) do
  begin
    if integer(ComboBox1.Items.Objects[i]) = TaskTab.FieldByName('TA_FLAGS').AsInteger then
    begin
      ComboBox1.ItemIndex := i;
      break;
    end;
  end;
  m_changed := false;
  Screen.Cursor := crDefault;
end;

procedure TTaskEditForm.renderPreview;
var
  writer  : TTaskForm2XML;
  xList   : IXMLList;
begin
  if not Assigned(m_form) then
    exit;

  writer := TTaskForm2XML.create;
  xList := writer.getXML(m_form);
  writer.Free;

  Application.CreateForm(THtmlMod, HtmlMod);
  try
    HtmlMod.TaskContainer := m_tc;
    HtmlMod.TaskStyle     := m_style;
    HtmlMod.TaskData      := xList;
    HtmlMod.show(WebBrowser1);
  finally
    HtmlMod.Free;
  end;

end;

procedure TTaskEditForm.resizeForm;
var
  x, y : Integer;
begin
  FormFrame1.getSize(x, y);

  if x > ClientWidth then
    ClientWidth :=x;

  if TabSheet1.Height < y then begin
    ClientHeight := ClientHeight + ( y - TabSheet1.Height );
  end;
  Self.Position := poOwnerFormCenter;
end;

procedure TTaskEditForm.save;
var
  writer  : TTaskForm2XML;
  st      : TStream;
  mem     : TMemoryStream;
begin

  TaskTab.FieldByName('TA_COLOR').AsInteger := integer(JvColorComboBox1.ColorValue);
  if Assigned(m_style) then
  begin
    TaskTab.FieldByName('TA_STYLE').AsString      := m_style.Name;
    TaskTab.FieldByName('TA_STYLE_CLID').AsString := m_style.CLID;
  end;

  mem := TMemoryStream.Create;
  if Assigned(m_form) then
  begin
    writer := TTaskForm2XML.create;
    writer.save(mem, m_form);
    writer.Free;
    mem.Position := 0;
  end;

  st := TaskTab.CreateBlobStream(TaskTab.FieldByName('TA_DATA'), bmWrite);
  st.CopyFrom(mem, 0);
  st.free;

  mem.Free;
  if ComboBox1.ItemIndex > -1 then
    TaskTab.FieldByName('TA_FLAGS').AsInteger := integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);

  if (TaskTab.State = dsInsert) or ( TaskTab.State = dsEdit) then
    TaskTab.Post;

  if TaskTab.UpdatesPending then
    TaskTab.ApplyUpdates(-1);

  if LogTab.UpdatesPending then
    LogTab.ApplyUpdates(-1);

  m_changed := false;
  if Assigned(m_form) then
    m_form.Changed := false;
end;

procedure TTaskEditForm.setID(ta_id, ty_id: integer);
begin
  m_ta_id := ta_id;
  m_ty_id := ty_id;

  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  reload;
end;

procedure TTaskEditForm.setRO(value: boolean);
begin
  if not m_ro and m_changed then
  begin
    m_changed := false;
    if Assigned(m_form) then
      m_form.Changed := false;
  end;

  m_ro                        := value;
  ac_bearbeiten.Enabled       := m_ro;
  ac_unlock.Enabled           := not m_ro;
  ac_save.Enabled             := not m_ro;
  ac_refresh.Enabled          := m_ro;

  GroupBox1.Enabled           := not m_ro;
  LogFrame1.Enabled           := not m_ro;

  TaskTab.ReadOnly  := m_ro;

  if Assigned(m_form) then
    m_form.ReadOnly := m_ro;
  FileFrame1.RO := m_ro;

  if m_ro then
    StatusBar1.Panels.Items[0].Text := 'Schreibgeschützt'
  else
    StatusBar1.Panels.Items[0].Text := 'Bearbeitbar';
  StatusBar1.Invalidate;
end;

procedure TTaskEditForm.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  RectForText: TRect;
begin
  StatusBar1.Canvas.Font.Style := [];
  if Panel.ID = 0 then begin
    if m_ro then begin
      StatusBar1.Canvas.Font.Color := clRed;
      StatusBar1.Canvas.Font.Style := [fsBold ];
    end
    else
      StatusBar1.Canvas.Font.Color := clGreen;
  end
  else begin
    StatusBar.Canvas.Font.Color := clBlack;
  end;

  RectForText := Rect;
  StatusBar1.Canvas.FillRect(RectForText);
  DrawText(StatusBar1.Canvas.Handle, PChar(Panel.Text), -1, RectForText, DT_SINGLELINE or DT_VCENTER or DT_LEFT);
end;

procedure TTaskEditForm.TaskTabPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  ShowMessage(e.Message);
end;

procedure TTaskEditForm.TaskTabReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  ShowMessage(e.Message);
end;

procedure TTaskEditForm.TaskTabTA_RESTGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
var
  dif : integer;
begin
  dif := DaysBetween( TaskTab.FieldByName('TA_TERMIN').AsDateTime, Date);
  if date > TaskTab.FieldByName('TA_TERMIN').AsDateTime then
    dif := -dif;

  if dif <= 0 then
    DBEdit4.Font.Color := clRed
  else if dif < 3  then
    DBEdit4.Font.Style := [fsBold]
  else
    DBEdit4.Font.Color := clGreen;
  Text := IntToStr( dif );
end;

end.
