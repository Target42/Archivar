unit fr_report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  xsd_TaskData, Vcl.ComCtrls, SynEditHighlighter, SynHighlighterXML, SynEdit,
  JvExStdCtrls, JvRichEdit, SynHighlighterHtml, JvExControls, JvXMLBrowser,
  Vcl.OleCtrls, SHDocVw, JvSimpleXml, i_taskEdit, Vcl.Menus, Vcl.ExtCtrls,
  System.Types, System.Generics.Collections, SynHighlighterDWS, Vcl.Buttons;

type
  TFilecontainer = class
    private
      m_tab       : TTabSheet;
      m_edit      : TSynEdit;
      m_tf        : ITaskFile;

      procedure setFileName( value : string );
      function  getfileName : string;
    public
      constructor Create( tf : ITaskFile ; owner : TPageControl);
      Destructor Destroy ; override;

      property Edit : TSynEdit read m_edit write m_edit;
      property Tab  : TTabSheet read m_tab write m_tab;
      property FileName : string read getFileName write setFileName;

      procedure save;
      function isFile( fname : string) : boolean;
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
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    CheckBox1: TCheckBox;
    ListBox1: TListBox;
    ListBox2: TListBox;
    GroupBox3: TGroupBox;
    ListBox3: TListBox;
    PageControl2: TPageControl;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Panel5: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ListBox3DblClick(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
  private
    m_xList: IXMLList;
    m_Path : string;
    m_tc   : ITaskContainer;
    m_form : ITaskForm;

    m_files: TList<TFilecontainer>;
    procedure OpenCode(tf : ITaskFile );

    procedure setTaskContainer( value : ITaskContainer);
    procedure addFieldName1Click(Sender: TObject);

  public

    procedure init;
    procedure release;

    property TaskContainer : ITaskContainer read m_tc write setTaskContainer;
    property Form : ITaskForm read m_form write m_form;

    procedure doNewForm( frm : ITaskForm );
  end;

implementation

uses
  Xml.XMLDoc, i_datafields, m_glob_client, System.IOUtils, m_html,
  u_taskForm2XML, Xml.XMLIntf;

{$R *.dfm}

{ TReportFrame }

procedure TReportFrame.addFieldName1Click(Sender: TObject);
begin
  (Sender as TSynEdit).SelText := ( Sender as TMenuItem).Caption;
end;

procedure TReportFrame.Button1Click(Sender: TObject);
var
  HtmlMod : THtmlMod;
  writer : TTaskForm2XML;
  xml    : IXMLDocument;
  tf     : ITaskFile;
begin
  if CheckBox1.Checked then
  begin
    if not Assigned(m_form) then
    begin
      ShowMessage('Es ist kein Formular aktiv!');
      exit;
    end;
    writer := TTaskForm2XML.create;
    m_xList := writer.getXML(m_form);
    writer.Free;
  end
  else
  begin
    if ListBox1.ItemIndex = -1 then
    begin
      ShowMessage('Es wurde keine Testdaten ausgewählt');
      exit;
    end;
    tf := ITaskFile( Pointer(ListBox1.Items.Objects[ListBox1.ItemIndex] ));
    xml := NewXMLDocument;
    xml.LoadFromStream(tf.Data );
    m_xList := xml.GetDocBinding('List', TXMLList, TargetNamespace) as IXMLList;
  end;


  Application.CreateForm(THtmlMod, HtmlMod);
  try
//    HtmlMod.HTMLDoc.Assign(SynEdit2.Lines);
    HtmlMod.TaskData := m_xList;
    HtmlMod.SaveToFile(m_path+'index.html');
  finally
    HtmlMod.Free;
  end;
  WebBrowser1.Navigate('http://localhost:42424/{B967F35E-FFAE-481A-9664-2C7621FDEB18}/index.html');
end;

procedure TReportFrame.CheckBox1Click(Sender: TObject);
begin
  ListBox1.Enabled := not CheckBox1.Checked;
end;

procedure TReportFrame.doNewForm(frm: ITaskForm);
begin
  m_form := frm;
end;

procedure TReportFrame.init;
begin
  m_files:= TList<TFilecontainer>.create;
  m_form := NIL;
  m_Path := TPath.combine(GM.wwwHome, '{967F35E-FFAE-481A-9664-2C7621FDEB18}');

  ForceDirectories(m_Path);
end;

procedure TReportFrame.ListBox2Click(Sender: TObject);
var
  st : ITaskStyle;
begin
  ListBox3.Items.Clear;
  if ListBox2.ItemIndex = -1 then
    exit;
  st := ITaskStyle( Pointer( ListBox2.Items.Objects[ ListBox2.ItemIndex]));
  st.Files.fillList(ListBox3.Items);
end;

procedure TReportFrame.ListBox3DblClick(Sender: TObject);
var
  tf : ITaskFile;
begin
  if ListBox3.ItemIndex = -1 then
    exit;

  tf := ITaskFile(Pointer(ListBox3.Items.Objects[ListBox3.ItemIndex]));

  OpenCode( tf);
end;

procedure TReportFrame.OpenCode(tf : ITaskFile );
var
  i : integer;
  fc : TFilecontainer;
begin
  for i := 0 to pred(m_files.Count) do
    begin
      if m_files[i].isFile(tf.Name) then
      begin
        PageControl2.ActivePage := m_files[i].Tab;
        exit
      end;
    end;
    fc := TFilecontainer.Create(tf, PageControl2);
    fc.Edit.PopupMenu := PopupMenu1;
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
begin
  for i := 0 to pred(m_files.Count) do
  begin
    m_files[i].save;
    m_files[i].Free;
  end;
  m_files.Free;

  m_xList := NIL;
  m_form  := NIL;
  m_tc    := NIL;
end;

procedure TReportFrame.setTaskContainer(value: ITaskContainer);
begin
  m_tc := value;
  m_tc.TestData.fillList(ListBox1.Items, false);

  m_tc.Styles.FillList( ListBox2.Items );

end;

{ TFilecontainer }

constructor TFilecontainer.Create(tf : ITaskFile ; owner : TPageControl);
var
  ext : string;
begin
  m_tf          := tf;
  m_tab         := TTabSheet.Create(owner);
  m_tab.Parent  := owner;
  m_tab.PageControl := owner;
  m_edit        := TSynEdit.Create(m_tab);
  m_edit.Parent := m_tab;
  m_edit.Align  := alClient;
  m_edit.Lines.Assign(tf.Lines);
  m_tab.Caption := m_tf.name;
  ext := LowerCase(ExtractFileExt(m_tf.Name));

  if ext = '.html' then
    m_edit.Highlighter := TSynHTMLSyn.Create(m_edit)
  else if ext = '.pas' then
    m_edit.Highlighter := TSynDWSSyn.Create(m_edit);


end;

destructor TFilecontainer.Destroy;
begin
  m_tab.Free;
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

procedure TFilecontainer.save;
begin
  m_tf.Lines.Assign(m_edit.Lines);
end;

procedure TFilecontainer.setFileName(value: string);
begin
  m_tf.Name := value
end;

end.
