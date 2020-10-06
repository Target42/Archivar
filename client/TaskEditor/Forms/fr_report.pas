unit fr_report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  xsd_TaskData, Vcl.ComCtrls, SynEditHighlighter, SynHighlighterXML, SynEdit,
  JvExStdCtrls, JvRichEdit, SynHighlighterHtml, JvExControls, JvXMLBrowser,
  Vcl.OleCtrls, SHDocVw, JvSimpleXml, i_taskEdit, Vcl.Menus, Vcl.ExtCtrls,
  System.Types, System.Generics.Collections, SynHighlighterDWS, Vcl.Buttons,
  m_dws;

type
  TCloseEditorFunc = procedure ( tf : ITaskFile ) of object;
  TFilecontainer = class
    private
      m_dws       : TDwsMod;
      m_tab       : TTabSheet;
      m_edit      : TSynEdit;
      m_memo      : TMemo;
      m_split     : TSplitter;
      m_tf        : ITaskFile;
      m_func      : TCloseEditorFunc;

      m_grp       : TGroupBox;
      FSTyle      : ITaskStyle;

      procedure setFileName( value : string );
      function  getfileName : string;

      procedure setStyle( value : ITaskStyle);
    public
      constructor Create( tf : ITaskFile ; owner : TPageControl);
      Destructor Destroy ; override;

      property Edit : TSynEdit read m_edit write m_edit;
      property Tab  : TTabSheet read m_tab write m_tab;
      property FileName : string read getFileName write setFileName;
      property DataFile : ITaskFile read m_tf;
      property doClose : TCloseEditorFunc read m_func write m_func;
      property Style: ITaskStyle read FSTyle write setStyle;

      procedure save;
      function isFile( fname : string) : boolean;

      procedure onCloseClick( sender : TObject );
      procedure onCompileClick( sender : TObject );
      procedure Update;
  end;

  TReportFrame = class(TFrame)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    WebBrowser1: TWebBrowser;
    PopupMenu1: TPopupMenu;
    Feldhinzufgen1: TMenuItem;
    Panel1: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    CheckBox1: TCheckBox;
    ListBox1: TListBox;
    PageControl2: TPageControl;
    GroupBox1: TGroupBox;
    ListBox2: TListBox;
    GroupBox3: TGroupBox;
    ListBox3: TListBox;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Panel5: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Panel6: TPanel;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
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
  private
    m_Path : string;
    m_tc   : ITaskContainer;
    m_form : ITaskForm;
    DwsMod : TDwsMod;

    m_files: TList<TFilecontainer>;
    procedure OpenCode(tf : ITaskFile );

    procedure setTaskContainer( value : ITaskContainer);
    procedure addFieldName1Click(Sender: TObject);

    procedure saveAllEdits;
    procedure initFile( tf : ITaskFile);
    procedure fillStyles;
    procedure updateFileContainer;
  public

    procedure init;
    procedure release;

    property TaskContainer : ITaskContainer read m_tc write setTaskContainer;
    property Form : ITaskForm read m_form write m_form;

    procedure doNewForm( frm : ITaskForm );

    procedure updateFiles( sender : ITaskFiles);

    procedure closeEditor( tf : ITaskFile );
  end;

implementation

uses
  Xml.XMLDoc, i_datafields, m_glob_client, System.IOUtils, m_html,
  u_taskForm2XML, Xml.XMLIntf, f_InputBox, u_helper, System.UITypes;

{$R *.dfm}

{ TReportFrame }

procedure TReportFrame.addFieldName1Click(Sender: TObject);
var
  tab : TTabSheet;
  i   : integer;
begin
  tab := PageControl2.ActivePage;
  for i := 0 to pred(m_files.Count) do
  begin
    if m_files[i].m_tab = tab then
    begin
      m_files[i].Edit.SelText :=  ( Sender as TMenuItem).Caption;
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
    st := tf.Data;
    xml.LoadFromStream(st);
    st.Free;
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
  m_path := TPath.Combine( GM.wwwHome, m_tc.Task.CLID);

  Application.CreateForm(THtmlMod, HtmlMod);
  try
    HtmlMod.TaskContainer := m_tc;
    HtmlMod.TaskStyle     := st;
    HtmlMod.TaskData      := xList;
    HtmlMod.show(WebBrowser1, m_tc.Task.CLID);
  finally
    HtmlMod.Free;
  end;
end;

procedure TReportFrame.CheckBox1Click(Sender: TObject);
begin
  ListBox1.Enabled := not CheckBox1.Checked;
end;

procedure TReportFrame.closeEditor(tf: ITaskFile);
var
  i : integer;
begin
  for i := 0 to pred(m_files.Count) do
  begin
    if m_files[i].DataFile = tf  then
    begin
      tf.Lines.Assign(m_files[i].Edit.Lines);
      m_files[i].Free;
      m_files.Delete(i);
      break;
    end;
  end;
end;

procedure TReportFrame.doNewForm(frm: ITaskForm);
begin
  m_form := frm;
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
  Application.CreateForm(TDwsMod, DwsMod);
  PageControl1.ActivePage := TabSheet3;
  m_files:= TList<TFilecontainer>.create;
  m_form := NIL;
end;

procedure TReportFrame.initFile(tf: ITaskFile);
var
 ext : string;
begin
  ext := LowerCase(ExtractFileExt(tf.Name));
  if ext = '.pas' then
  begin
    tf.Lines.Text :=
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
    tf.Lines.Text :=
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

  PageControl1.ActivePage := TabSheet2;
  OpenCode( tf);
end;

procedure TReportFrame.OpenCode(tf : ITaskFile );
var
  i : integer;
  fc : TFilecontainer;
begin
  for i := 0 to pred(m_files.Count) do
    begin
      if m_files[i].DataFile = tf then
      begin
        PageControl2.ActivePage := m_files[i].Tab;
        exit
      end;
    end;

  fc := TFilecontainer.Create(tf, PageControl2);
  fc.Edit.PopupMenu := PopupMenu1;
  fc.doClose := self.closeEditor;
  fc.Style   :=  ITaskStyle( Pointer( ListBox2.Items.Objects[ ListBox2.ItemIndex]));;
  m_files.Add(fc);
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
  arr : TStringDynArray;
begin
  m_tc.TestData.uregisterChange(updateFiles);

  for i := 0 to pred(m_files.Count) do
  begin
    m_files[i].save;
    m_files[i].Free;
  end;
  m_files.Free;

  m_form  := NIL;
  m_tc    := NIL;

  if m_Path <> '' then
  begin
    arr := TDirectory.GetFiles(m_Path);
    for i := 0 to pred(Length(arr)) do
      DeleteFile(arr[i]);

    TDirectory.Delete(m_Path);
  end;
end;

procedure TReportFrame.saveAllEdits;
var
  i : integer;
begin
  for i := 0 to pred(m_files.Count) do
  begin
    m_files[i].save;
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
  for i := 0 to pred(st.Files.Count) do
    closeEditor(st.Files.Items[i]);

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
  ListBox3.Items.Delete(inx);
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
  // style file löschen .
  inx := ListBox3.ItemIndex;
  if inx = -1 then
      exit;
  tf := ITaskFile( Pointer(ListBox3.Items.Objects[inx] ));
  closeEditor(tf);
end;

procedure TReportFrame.updateFileContainer;
var
  con : TFilecontainer;
begin
  for con in m_files do
    con.Update;

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

{ TFilecontainer }

constructor TFilecontainer.Create(tf : ITaskFile ; owner : TPageControl);
var
  ext : string;
  pan : TGroupBox;
  btn : TButton;
  x   : integer;
  y   : integer;
begin
  m_dws         := NIL;
  m_memo        := NIL;
  m_split       := NIL;
  m_tf          := tf;
  m_tab         := TTabSheet.Create(owner);
  m_tab.Parent  := owner;
  m_tab.PageControl := owner;
  m_func        := NIL;

  m_grp := TGroupBox.Create(m_tab);
  pan := m_grp;
  pan.Parent := m_tab;
  pan.Align := alBottom;
  pan.Height :=  48;

  y := 16;

  btn         := TButton.Create(pan);
  btn.Parent  := pan;
  btn.OnClick := self.onCloseClick;
  btn.Caption := 'Schließen';
  btn.Left    := 16;
  btn.Top     := y;

  x := btn.Left + btn.Width + 16;


  ext := LowerCase(ExtractFileExt(m_tf.Name));
  if ext = '.pas' then
  begin
    m_dws       := TDwsMod.Create(NIL);
    btn         := TButton.Create(pan);
    btn.Parent  := pan;
    btn.OnClick := self.onCompileClick;
    btn.Caption := 'Compilieren';
    btn.Left    := x;
    btn.Top     := y;

  end;

  m_edit        := TSynEdit.Create(m_tab);
  m_edit.Parent := m_tab;
  m_edit.Lines.Assign(tf.Lines);
  m_edit.Gutter.ShowLineNumbers := true;

  m_tab.Caption := m_tf.name;

  if ext = '.html' then
  begin
    m_edit.Highlighter := TSynHTMLSyn.Create(m_edit)
  end
  else if ext = '.pas' then
  begin
    m_edit.Highlighter := TSynDWSSyn.Create(m_edit);
    m_memo            := TMemo.Create(m_tab);;
    m_memo.Parent     := m_tab;
    m_memo.ScrollBars := ssBoth;
    m_memo.Align      := alBottom;

    m_split           := TSplitter.Create(m_tab);
    m_split.Parent    := m_tab;
    m_split.Align     := alBottom;
  end;
  m_edit.Align  := alClient;
  owner.ActivePage := m_tab;
end;

destructor TFilecontainer.Destroy;
begin
  m_tab.PageControl := NIL;
  m_tab.Free;

  if Assigned(m_dws) then
    m_dws.Free;
  inherited;
end;

function TFilecontainer.getfileName: string;
begin
  Result := m_tf.Name;
end;

function TFilecontainer.isFile(fname : string): boolean;
begin
  Result := SameText( fname, ExtractFileName(m_tf.Name));
end;

procedure TFilecontainer.onCloseClick(sender: TObject);
begin
  if Assigned(m_func) then
    m_func( m_tf );

end;

procedure TFilecontainer.onCompileClick(sender: TObject);
begin
  if not Assigned(m_dws) then
    exit;
  m_dws.Script := m_edit.Lines.Text;
  m_dws.compile;
  if Assigned(m_memo) then
  begin
    m_memo.Lines.Text := m_dws.MsgText;
  end;
end;

procedure TFilecontainer.save;
begin
  m_tf.Lines.Assign(m_edit.Lines);
end;

procedure TFilecontainer.setFileName(value: string);
begin
  m_tf.Name := value
end;

procedure TFilecontainer.setStyle(value: ITaskStyle);
begin
  FSTyle := value;
  m_grp.caption := 'Style: '+FSTyle.Name;
end;

procedure TFilecontainer.Update;
begin
  if Assigned(FSTyle) then
    m_grp.caption := 'Style: '+FSTyle.Name;
end;

end.
