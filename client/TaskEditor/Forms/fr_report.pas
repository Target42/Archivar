unit fr_report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  xsd_TaskData, Vcl.ComCtrls, SynEditHighlighter, SynHighlighterXML, SynEdit,
  SynHighlighterHtml, JvExControls,
  Vcl.OleCtrls, SHDocVw, i_taskEdit, Vcl.Menus, Vcl.ExtCtrls,
  System.Types, System.Generics.Collections, SynHighlighterDWS, Vcl.Buttons,
  fr_ReportEditor, m_dws;

type
  TReportFrame = class(TFrame)
    PopupMenu1: TPopupMenu;
    Feldhinzufgen1: TMenuItem;
    SaveDialog1: TSaveDialog;
    GroupBox5: TGroupBox;
    Panel2: TPanel;
    Panel8: TPanel;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    Splitter7: TSplitter;
    GroupBox1: TGroupBox;
    ListBox2: TListBox;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton10: TSpeedButton;
    GroupBox3: TGroupBox;
    ListBox3: TListBox;
    Panel5: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton9: TSpeedButton;
    GroupBox4: TGroupBox;
    Panel7: TPanel;
    ListBox4: TListBox;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Panel6: TPanel;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton11: TSpeedButton;
    CheckBox1: TCheckBox;
    WebBrowser2: TWebBrowser;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    PageControl1: TPageControl;
    TabSheet3: TTabSheet;
    WebBrowser1: TWebBrowser;
    Panel1: TPanel;
    Button1: TButton;
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ListBox3DblClick(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure ListBox4Click(Sender: TObject);
  private
    m_tc   : ITaskContainer;
    m_form : ITaskForm;
    DwsMod : TDwsMod;

    m_files     : TList<TReportFrameEditor>;
    m_libFiles  : TList<ITaskFile>;

    function OpenCode(tf : ITaskFile;style : ITaskStyle ) : TReportFrameEditor;

    procedure setTaskContainer( value : ITaskContainer);
    procedure addFieldName1Click(Sender: TObject);

    procedure saveAllEdits;
    procedure initFile( tf : ITaskFile);
    procedure fillStyles;
    procedure updateFileContainer;
    procedure closeEditor( tf : ITaskFile);
    procedure doCloseFrame( value : TReportFrameEditor );

    procedure fillHelp;

    procedure clearLibFiles;
    procedure fillDWS;
  public

    procedure init;
    procedure release;

    property TaskContainer : ITaskContainer read m_tc write setTaskContainer;
    property Form : ITaskForm read m_form write m_form;

    procedure save;
    procedure doNewForm( frm : ITaskForm );

    procedure updateFiles( sender : ITaskFiles);
  end;

implementation

uses
  Xml.XMLDoc, i_datafields, m_glob_client, System.IOUtils, m_html,
  u_taskForm2XML, Xml.XMLIntf, f_InputBox, u_helper, System.UITypes,
  fr_ReportEditor_pas, fr_ReportEditor_html, u_TTaskFileImpl, m_fileCache;

{$R *.dfm}

{ TReportFrame }

procedure TReportFrame.addFieldName1Click(Sender: TObject);
var
  tab : TTabSheet;
  i   : integer;
begin
  tab := PageControl1.ActivePage;
  for i := 0 to pred(m_files.Count) do
  begin
    if m_files[i].Tab = tab then
    begin
      m_files[i].insertFieldName(( Sender as TMenuItem).Caption);
    end;
  end;
end;

procedure TReportFrame.Button1Click(Sender: TObject);
var
  HtmlMod : THtmlMod;
  st      : ITaskStyle;
  xList   : IXMLList;
  procedure currentFormData;
  var
    writer : TTaskForm2XML;
  begin
    if not Assigned(m_form) then
      exit;
    writer := TTaskForm2XML.create;
    xList := writer.getXML(m_form);
    writer.Free;
  end;
  procedure useTestData;
  var
    xml : IXMLDocument;
    st  : TStream;
    tf  : ITaskFile;
  begin
    if ListBox1.ItemIndex = -1 then
      exit;
    tf := ITaskFile( Pointer(ListBox1.Items.Objects[ListBox1.ItemIndex] ));
    xml := NewXMLDocument;
    st := tf.DataStream;
    xml.LoadFromStream(st);
    xList := xml.GetDocBinding('List', TXMLList, TargetNamespace) as IXMLList;
  end;
  procedure getStyle;
  begin
    if ListBox2.ItemIndex <> -1 then
      st := ITaskStyle(Pointer(ListBox2.Items.Objects[ListBox2.ItemIndex]));
  end;
begin
  xList := NIL;
  st    := NIL;

  saveAllEdits;

  if CheckBox1.Checked then
    currentFormData
  else
    useTestData;

  getStyle;

  Application.CreateForm(THtmlMod, HtmlMod);
  try
    HtmlMod.TaskContainer := m_tc;
    HtmlMod.TaskStyle     := st;
    HtmlMod.TaskData      := xList;
    HtmlMod.Title         := 'Titeltext';
    HtmlMod.show(WebBrowser1);
  finally
    HtmlMod.Free;
  end;

  xList := NIL;
  st    := NIL;
end;

procedure TReportFrame.CheckBox1Click(Sender: TObject);
begin
  ListBox1.Enabled := not CheckBox1.Checked;
end;

procedure TReportFrame.clearLibFiles;
var
  tf : ITaskFile;
begin
  for tf in m_libFiles do
    tf.release;
  m_libFiles.Clear;

end;

procedure TReportFrame.closeEditor(tf: ITaskFile);
var
  i : integer;
begin
  for i := 0 to pred(m_files.Count) do
  begin
    if (m_files[i].DataFile = tf)  then
    begin
      if m_files[i].IsChanged then begin
        if (MessageDlg('Sollen die Änderungen gespeichert werden?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
          m_files[i].save;
      end;
      m_files[i].closeEditor;
      break;
    end;
  end;
end;

procedure TReportFrame.doCloseFrame(value: TReportFrameEditor);
begin
  m_files.Extract(value);
  value.Tab.PageControl := NIL;
end;

procedure TReportFrame.doNewForm(frm: ITaskForm);
begin
  m_form := frm;
end;

procedure TReportFrame.fillDWS;
var
  i   : integer;
  tf  : ITaskFile;
  ptr : TFileCacheMod.TPentry;
  list: TList<TFileCacheMod.TPentry>;
  fname : string;
begin
  clearLibFiles;

  ListBox4.Items.BeginUpdate;
  ListBox4.Items.Clear;
  list := FileCacheMod.getFiles('dwslib');

  for i := 0 to pred(list.Count) do begin
    ptr := list[i];
    fname := FileCacheMod.getFile(ptr);
    if fname <>''  then begin
      tf := TTaskFileImpl.create;
      tf.load(fname);
      tf.Readonly := ptr^.userid <> GM.UserID;
      m_libFiles.Add(tf);

      ListBox4.Items.AddObject( tf.Name, TObject(i));
    end;
  end;
  ListBox4.Items.EndUpdate;
  list.Free;
end;

procedure TReportFrame.fillHelp;
var
  RS: TResourceStream;
begin
  RS := TResourceStream.Create(HInstance, 'dws_html', RT_RCDATA);
  try
    THtmlMod.SetHTML( RS, WebBrowser2);
  finally

  end;
end;

procedure TReportFrame.fillStyles;
begin
  ListBox2.Items.Clear;
  m_tc.Styles.FillList( ListBox2.Items );
  if ListBox2.Items.Count > 0 then
  begin
    ListBox2.ItemIndex := 0;
    ListBox2Click(Self);
  end;
end;

procedure TReportFrame.init;
begin
  m_libFiles  := TList<ITaskFile>.create;

  Application.CreateForm(TDwsMod, DwsMod);
  PageControl1.ActivePage := TabSheet3;
  m_files:= TList<TReportFrameEditor>.create;
  m_form := NIL;

  fillHelp;

  fillDWS;

  CheckBox1Click( self );
end;

procedure TReportFrame.initFile(tf: ITaskFile);
var
 ext : string;
begin
  ext := LowerCase(ExtractFileExt(tf.Name));
  if ext = '.pas' then
  begin
    tf.Text :=
    '{ ' +sLineBreak+
    '  Erzeugt am '+FormatDateTime('hh:mm dd.MM.yyyy', now)+sLineBreak+
    '}'+ sLineBreak+
    'program script;'+sLineBreak+sLineBreak+
    'begin'+sLineBreak+
    '  printLN(''neuen Text hier eingeben'');'+sLineBreak+
    'end.';
  end
  else if ext = '.html' then
  begin
    tf.Text :=
    '<!--'+sLineBreak+
    '  Erzeugt am '+FormatDateTime('hh:mm dd.MM.yyyy', now)+sLineBreak+
    '-->';
  end;
end;

procedure TReportFrame.ListBox2Click(Sender: TObject);
var
  st : ITaskStyle;
begin
  ListBox3.Items.Clear;

  if ListBox2.ItemIndex = -1 then
    exit;

  st := ITaskStyle( Pointer( ListBox2.Items.Objects[ ListBox2.ItemIndex]));
  st.Files.fillList(ListBox3.Items, true);
end;

procedure TReportFrame.ListBox3DblClick(Sender: TObject);
var
  tf : ITaskFile;
begin
  if ListBox3.ItemIndex = -1 then
    exit;

  tf := ITaskFile(Pointer(ListBox3.Items.Objects[ListBox3.ItemIndex]));

  OpenCode( tf, ITaskStyle( Pointer( ListBox2.Items.Objects[ ListBox2.ItemIndex])));
end;

procedure TReportFrame.ListBox4Click(Sender: TObject);
var
  tf  : ITaskFile;
  inx : integer;
begin
  if ListBox4.ItemIndex = -1 then
    exit;

  inx := integer(ListBox4.Items.Objects[ListBox4.ItemIndex]);
  tf  := m_libFiles[inx];

  OpenCode( tf, NIL );
end;

function TReportFrame.OpenCode(tf : ITaskFile; style : ITaskStyle ) : TReportFrameEditor;
var
  i   : integer;
  ext : string;
begin

  Result := NIL;
  for i := 0 to pred(m_files.Count) do begin
    if m_files[i].DataFile = tf then begin
      PageControl1.ActivePage := m_files[i].Tab;
      exit
    end;
  end;

  ext := LowerCase(ExtractFileExt(tf.Name));

  if      ext = '.pas' then     result := TReportFrameEditorPas.create(PageControl1)
  else if ext = '.html' then    result := TReportFrameEditorHtml.create(PageControl1)
  else                          result := NIL;

  if Assigned(result) then
  begin
    result.init;
    result.Name             := 'ED'+IntToStr(GetTickCount);
    result.Tab              := TTabSheet.Create(PageControl1);
    result.Style            := style;
    result.CacheFile        := not Assigned(style);
    result.DataFile         := tf;
    result.onCloseFrame     := self.doCloseFrame;
    result.setPopup(self.PopupMenu1);

    m_files.Add(result);
    PageControl1.ActivePage := result.Tab;
  end
  else
    ShowMessage('Für diesen Dateityp gibt es keinen Editor!');
end;

procedure TReportFrame.PopupMenu1Popup(Sender: TObject);
var
  i, j : integer;
  item : TMenuItem;
  sub  : TMenuItem;
  df   : IDataField;
begin
  Feldhinzufgen1.Clear;

  if not Assigned(m_tc) then
    exit;

  for i := 0 to pred(m_tc.Task.Fields.Count) do
  begin
    df := m_tc.Task.Fields.Items[i];
    item := TMenuItem.Create(Feldhinzufgen1);

    item.Caption := df.Name;
    if df.Childs.Count = 0 then
      item.OnClick := self.addFieldName1Click;
    Feldhinzufgen1.Add(item);
    if df.Childs.Count > 0 then
    begin
      sub := TMenuItem.Create(item);
      sub.Caption := df.Name;
      sub.OnClick := self.addFieldName1Click;
      item.Add(sub);
      for j := 0 to pred(df.Childs.Count)  do
      begin
        sub := TMenuItem.Create(item);
        sub.Caption := df.Name+'.'+df.Childs.Items[j].Name;
        sub.OnClick := self.addFieldName1Click;
        item.Add(sub);
      end;
    end;
  end;
end;

procedure TReportFrame.release;
var
  i : integer;
begin
  for i := m_files.Count-1 downto 0 do
  begin
    m_files[i].release;
    m_files[i].Tab.PageControl := NIL;
    m_files[i].free;
  end;
  m_files.Free;

  m_tc.TestData.uregisterChange(updateFiles);

  m_form  := NIL;
  m_tc    := NIL;

  clearLibFiles;
  m_libFiles.Free;
end;

procedure TReportFrame.save;
var
  tf : TReportFrameEditor;
  cacheChanged : boolean;
begin
  cacheChanged := falsE;
  for tf in m_files do begin
    tf.save;

    if Assigned(tf.DataFile) and ( tf.CacheFile) then begin
      tf.DataFile.save( TPath.Combine(GM.Cache, 'dwslib'));
      cacheChanged := true;
    end;
  end;
  if cacheChanged then
    PostMessage( Application.MainFormHandle, msgShowFileCache, 0, 0 );
end;

procedure TReportFrame.saveAllEdits;
var
  i : integer;
begin
  for i := 0 to pred(m_files.Count) do
  begin
    m_files[i].save;
    if m_files[i].CacheFile then
      m_files[i].DataFile.save( TPath.Combine(GM.Cache, 'dwslib'));
  end;
end;

procedure TReportFrame.setTaskContainer(value: ITaskContainer);
begin
  if Assigned(m_tc) then
    m_tc.TestData.uregisterChange(updateFiles);

  m_tc := value;

  m_tc.TestData.fillList(ListBox1.Items, false);
  m_tc.TestData.registerChange(updateFiles);


  fillStyles;

  if ListBox1.Items.Count > 0 then
    ListBox1.ItemIndex := 0;
end;

procedure TReportFrame.SpeedButton10Click(Sender: TObject);
var
  st : ITaskStyle;
  inx : Integer;
begin
  inx := ListBox2.ItemIndex;
  if inx = -1 then
    exit;
  st := ITaskStyle( Pointer( ListBox2.Items.Objects[ ListBox2.ItemIndex]));
  m_tc.Styles.DefaultStyle := st;
  fillStyles;
  ListBox2.ItemIndex := inx;
  ListBox2Click(Sender);
end;

procedure TReportFrame.SpeedButton11Click(Sender: TObject);
var
  tf    : ITaskFile;
begin
  if ListBox1.ItemIndex = -1 then
    exit;

  SaveDialog1.FileName := ListBox1.Items.Strings[ListBox1.ItemIndex]+'.xml';
  if SaveDialog1.Execute then
  begin
    tf := ITaskFile( Pointer(ListBox1.Items.Objects[ListBox1.ItemIndex] ));
    TFile.WriteAllText( SaveDialog1.FileName, tf.Text, TEncoding.UTF8);
  end;
end;

procedure TReportFrame.SpeedButton1Click(Sender: TObject);
var
  InputBoxForm : TInputBoxForm;
  st : ITaskStyle;
begin
  Application.CreateForm(TInputBoxForm, InputBoxForm);
  InputBoxForm.Caption := 'Neuer Style';
  if InputBoxForm.ShowModal = mrOk then
  begin
    if Assigned( m_tc.Styles.getStyle(InputBoxForm.Text)) then
      ShowMessage('Dieser Name existiert schon!')
    else
    begin
      st := m_tc.Styles.newStyle(InputBoxForm.Text);
      ListBox2.ItemIndex := ListBox2.Items.AddObject(st.Name, Pointer(st));
      ListBox2Click(Sender);
    end;
  end;
  InputBoxForm.free;
end;

procedure TReportFrame.SpeedButton2Click(Sender: TObject);
var
  InputBoxForm : TInputBoxForm;
  st  : ITaskStyle;
begin
  // renmae
  if ListBox2.ItemIndex = -1 then
    exit;
  st := ITaskStyle( Pointer( ListBox2.Items.Objects[ ListBox2.ItemIndex]));
  Application.CreateForm(TInputBoxForm, InputBoxForm);
  InputBoxForm.Caption := 'Style umbenennen';

  InputBoxForm.Text := st.Name;
  if InputBoxForm.ShowModal = mrOk then
  begin
    m_tc.Styles.rename( st, InputBoxForm.Text);
    ListBox2.Items.Strings[ListBox2.ItemIndex] := st.Name;
  end;
  InputBoxForm.Free;
  updateFileContainer;
end;

procedure TReportFrame.SpeedButton3Click(Sender: TObject);
var
  st  : ITaskStyle;
  i   : integer;
begin
  // renmae
  if ListBox2.Items.Count =1  then
  begin
    ShowMessage('Es muss immer mindestens 1 Style geben');
    exit;
  end;

  if ListBox2.ItemIndex = -1 then
    exit;

  st := ITaskStyle( Pointer( ListBox2.Items.Objects[ ListBox2.ItemIndex]));
  if not (MessageDlg('Soll der Style "'+st.Name+'" wirklich gelöscht werden?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
    exit;

  // close the editors ...
  for i := m_files.Count-1 downto 0 do
  begin
    if m_files[i].Style = st then
      m_files[i].closeEditor;
  end;

  m_tc.Styles.delete( st );
  // delete ...

  fillStyles;
end;

procedure TReportFrame.SpeedButton4Click(Sender: TObject);
var
  InputBoxForm : TInputBoxForm;
  tf  : ITaskFile;
  st : ITaskStyle;
begin
  if ListBox2.ItemIndex = -1 then
    exit;
  st := ITaskStyle( Pointer( ListBox2.Items.Objects[ ListBox2.ItemIndex]));
  // neue Datei ...
  Application.CreateForm(TInputBoxForm, InputBoxForm);
  InputBoxForm.Caption := 'Neue Datei';
  if InputBoxForm.ShowModal = mrOk then
  begin
    tf := st.Files.getFile(InputBoxForm.Text);
    if Assigned(tf) then
      ShowMessage('Eine Datei mit diesem Namen gibt es schon!')
    else
    begin
      tf := st.Files.newFile(InputBoxForm.Text);
      ListBox3.Items.AddObject(tf.name, Pointer(tf));
      initFile( tf );
    end;

  end;
  InputBoxForm.Free;
end;

procedure TReportFrame.SpeedButton5Click(Sender: TObject);
var
  inx : integer;
  InputBoxForm : TInputBoxForm;
  tf : ITaskFile;
  st : ITaskStyle;
begin
  if ListBox2.ItemIndex = -1 then
    exit;
  st := ITaskStyle( Pointer( ListBox2.Items.Objects[ ListBox2.ItemIndex]));

  inx := ListBox3.ItemIndex;
  if inx = -1 then
    exit;

  tf := ITaskFile( Pointer(ListBox3.Items.Objects[inx] ));

  if tf.isName('index.html') then
  begin
    ShowMessage('Die Datei "index.html" kann nicht umbenannt werden!');
    exit;
  end;

  Application.CreateForm(TInputBoxForm, InputBoxForm);
  InputBoxForm.Caption := 'Datei umbenennen';
  InputBoxForm.Text := tf.Name;
  if InputBoxForm.ShowModal = mrOk then
  begin
    st.Files.rename(tf, InputBoxForm.Text );
    ListBox3.Items.Strings[ inx ] := tf.Name;
  end;
  InputBoxForm.Free;
end;

procedure TReportFrame.SpeedButton6Click(Sender: TObject);
var
  inx : integer;
  tf  : ITaskFile;
  st  : ITaskStyle;
begin
  if ListBox2.ItemIndex = -1 then
    exit;
  st := ITaskStyle( Pointer( ListBox2.Items.Objects[ ListBox2.ItemIndex]));

  // style file löschen .
  inx := ListBox3.ItemIndex;
  if inx = -1 then
      exit;
  tf := ITaskFile( Pointer(ListBox3.Items.Objects[inx] ));
  if tf.isName('index.html') then
  begin
    ShowMessage('die Datei "index.html" kann nicht gelöscht werden!');
    exit;
  end;
  if not (MessageDlg('Soll die Datei "'+tf.Name+'" wirklich gelöscht werden?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    exit;
  closeEditor(tf);
  st.Files.delete(tf);
  ListBox2Click(Sender);
end;

procedure TReportFrame.SpeedButton7Click(Sender: TObject);
var
  inx : integer;
  InputBoxForm : TInputBoxForm;
  tf : ITaskFile;
begin
  inx := ListBox1.ItemIndex;
  if inx = -1 then
    exit;
  tf := ITaskFile( Pointer(ListBox1.Items.Objects[inx] ));

  Application.CreateForm(TInputBoxForm, InputBoxForm);
  InputBoxForm.Caption := 'Testdaten umbenennen';
  InputBoxForm.Text := ListBox1.Items.Strings[inx];
  if InputBoxForm.ShowModal = mrOk then
  begin
    m_tc.TestData.rename(tf, InputBoxForm.Text );
  end;
  InputBoxForm.Free;
end;

procedure TReportFrame.SpeedButton8Click(Sender: TObject);
var
  inx : integer;
  tf : ITaskFile;
begin
  inx := ListBox1.ItemIndex;
  if inx = -1 then
    exit;

  tf := ITaskFile( Pointer(ListBox1.Items.Objects[inx] ));

  if not (MessageDlg('Soll die Datei wirklich geklöscht werden?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
    exit;
  m_tc.TestData.delete( tf );
end;

procedure TReportFrame.SpeedButton9Click(Sender: TObject);
var
  inx : integer;
  tf  : ITaskFile;
begin
  inx := ListBox3.ItemIndex;
  if inx = -1 then
      exit;
  tf := ITaskFile( Pointer(ListBox3.Items.Objects[inx] ));
  closeEditor(tf);
end;

procedure TReportFrame.updateFileContainer;
var
  con :TReportFrameEditor;
begin
  for con in m_files do
    con.UpdateCaption;

end;

procedure TReportFrame.updateFiles(sender: ITaskFiles);
var
  old : pointer;
begin
  old := getOldObject( ListBox1 );

  ListBox1.Items.Clear;
  m_tc.TestData.fillList(ListBox1.Items, false);
  selectItem( ListBox1, old );

end;


end.
