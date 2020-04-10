unit f_protokoll;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, JvExComCtrls, JvDBTreeView, Vcl.Menus,
  System.Actions, Vcl.ActnList, f_gremiumList, JvDateTimePicker,
  JvDBDateTimePicker, Vcl.Buttons, f_titel_edit, u_titel, xsd_protocol,
  fr_chapter, xsd_chapter;

type
  TProtokollForm = class(TForm)
    DSProviderConnection1: TDSProviderConnection;
    StatusBar1: TStatusBar;
    PRTab: TClientDataSet;
    TGTab: TClientDataSet;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    TNSrc: TDataSource;
    PrSrc: TDataSource;
    TabSheet3: TTabSheet;
    TGSrc: TDataSource;
    DBGrid2: TDBGrid;
    DBNavigator1: TDBNavigator;
    AutoIncValue: TClientDataSet;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    TNTab: TClientDataSet;
    DBNavigator2: TDBNavigator;
    TNTabPR_ID: TIntegerField;
    TNTabTN_ID: TIntegerField;
    TNTabTN_NAME: TWideStringField;
    TNTabTN_VORNAME: TWideStringField;
    TNTabTN_DEPARTMENT: TWideStringField;
    TNTabTN_ROLLE: TWideStringField;
    TNTabStatusText: TStringField;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    TNTabTN_STATUS: TIntegerField;
    MainMenu1: TMainMenu;
    Protokoll1: TMenuItem;
    Lesezeichenerstellen1: TMenuItem;
    N5: TMenuItem;
    Sperren1: TMenuItem;
    Freigeben1: TMenuItem;
    Panel4: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    JvDBDateTimePicker1: TJvDBDateTimePicker;
    CPTab: TClientDataSet;
    CpSrc: TDataSource;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    UpdateCPQry: TClientDataSet;
    Button4: TButton;
    TV: TTreeView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TNTabStatusTextGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure TNTabStatusTextSetText(Sender: TField; const Text: string);
    procedure TGTabAfterInsert(DataSet: TDataSet);
    procedure Button3Click(Sender: TObject);
    procedure TNTabStatusTextChange(Sender: TField);
    procedure FormDestroy(Sender: TObject);
    procedure ac_pr_bookmarkExecute(Sender: TObject);
    procedure ac_pr_lockExecute(Sender: TObject);
    procedure ac_pr_unlockExecute(Sender: TObject);
    procedure DBNavigator3Click(Sender: TObject; Button: TNavigateBtn);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    m_TitelEditform : TTitelEditform;
    m_proto : IXMLProtocol;
    m_id : integer;
    m_treeChanged : boolean;
    m_locked : boolean;

    m_grList: TGremiumListForm;
    m_ro    : boolean;

    m_cpList: TChapterTitleList;
    procedure setID( value : integer );

    procedure loadFromClientBlob( tab : TClientDataSet; FieldName : string );
    procedure saveToclientBlob( tab : TClientDataSet; FieldName : string );

    function loadFromChapterBlob( tab : TClientDataSet; FieldName : string ) : IXMLChapter;

    procedure setRO( value : boolean );

    procedure updateCpList;
    procedure saveChangedChapter;
    procedure buildTree( root : TTreeNode; xCp : IXMLChapter );
  public
    property ID : integer read m_id write setID;
    property RO : boolean read m_ro write setRO;
  end;

var
  ProtokollForm: TProtokollForm;

implementation

uses
  m_glob_client, Xml.XMLIntf, Xml.XMLDoc, u_bookmark, m_BookMarkHandler,
  u_berTypes, System.JSON, u_json, System.Generics.Collections,
  m_WindowHandler, f_chapter_content, u_chapter;

{$R *.dfm}

{ TProtokollForm }

procedure TProtokollForm.ac_pr_bookmarkExecute(Sender: TObject);
var
  mark : u_bookmark.TBookmark;
begin
  mark            := BookMarkHandler.Bookmarks.newBookmark(PRTab.FieldByName('PR_CLID').AsString);
  mark.ID         := PRTab.FieldByName('PR_ID').AsInteger;
  mark.Titel      := PRTab.FieldByName('PR_NAME').AsString;
  mark.Group      := 'Protokoll';
  mark.Internal   := true;
  mark.TypeID     := 0;
  mark.DocType    := dtProtokoll;
 PostMessage( Application.MainFormHandle, msgNewBookMark, 0, 0 );
end;

procedure TProtokollForm.ac_pr_lockExecute(Sender: TObject);
var
  obj : TJSONObject;
begin
  //lock
  obj := GM.LockDocument( m_id, integer(ltProtokoll));
  if not JBool( obj, 'result') then
    ShowMessage( JString( obj, 'text'))
  else
  begin
    m_locked := true;
    Caption := '*'+PRTab.FieldByName('PR_NAME').AsString;
    self.RO := false;
    ShowMessage('Das Protokoll kann jetzt bearbeitet werden.');
  end;
end;

procedure TProtokollForm.ac_pr_unlockExecute(Sender: TObject);
var
  data : TJSONObject;
begin
  data := GM.UnlockDocument(m_id, integer(ltProtokoll));
  if JBool( data, 'result') then
  begin
    self.RO := true;
    Caption := PRTab.FieldByName('PR_NAME').AsString;
    m_locked := false;
  end;
  ShowMessage(JString(data, 'text'));
end;

procedure TProtokollForm.buildTree(root: TTreeNode; xCp: IXMLChapter);
var
  list  : TList<TChapter>;

  procedure addToParent( cp : TChapter );
  var
    j : integer;
  begin
    if cp.PID = 0 then
      exit;
    for j := 0 to pred(list.Count) do
    begin
      if list[j].ID = cp.PID then
      begin
        list[j].add(cp);
        break;
      end;
    end;
  end;

  procedure add( root : TTreeNode; items : TChapterList );
  var
    j : integer;
    node : TTreeNode;
    inx : integer;
  begin
    for j := 0 to pred(items.Count) do
    begin
      node := TV.Items.AddChild(root, items.Items[j].fullTitle);
      inx := 2;
      if items.Items[j].TAID > 0 then
        inx := 1;
      node.SelectedIndex := inx;
      node.ImageIndex    := inx;

      add(node, items.Items[j].Childs);
    end;
  end;

var
  cp    : TChapter;
  base  : Tchapter;
  xTop  : IXMLTop;
  i     : integer;

begin
  if xCp.Top.Count = 0 then
    exit;

  base := TChapter.create(NIL);
  list := TList<TChapter>.create;
  for i := 0 to pred(xCp.Top.Count) do
    begin
      cp := TChapter.create(NIL);
      xTop := xCp.Top.Items[i];

      cp.Name := xTop.Titel;
      cp.ID   := xTop.Id;
      cp.PID  := xTop.Pid;
      cp.Nr   := xTop.Nr;
      cp.Numbering  := xTop.Numbering;
      cp.TAID := xTop.Taid;
      list.Add(cp)
    end;
  for i := 0 to pred(list.Count) do
    begin
      addToParent(list[i]);
      if list[i].PID = 0 then
        base.add(list[i]);
    end;
  add( root, base.Childs );
  list.Clear;
  list.Free;
  base.Free;
  root.Expand(true);
end;

procedure TProtokollForm.Button1Click(Sender: TObject);
var
  list : TBookmarkList;
  i    : integer;
  mark : Data.DB.TBookmark;
begin
  list := DBGrid1.SelectedRows;
  for i := 0 to pred(list.Count) do
  begin
    mark := list.Items[i];
    TNTab.GotoBookmark(mark);
    TNTab.Edit;
    TNTab.FieldByName('StatusText').AsString := 'Anwesend';
    TNTab.Post;
  end;
end;

procedure TProtokollForm.Button3Click(Sender: TObject);
begin
  TNTab.ApplyUpdates(0);
end;

procedure TProtokollForm.Button4Click(Sender: TObject);
var
  cp : TChapterTitle;
  node : TTreeNode;
begin
  node := TV.Selected;
  if (node = NIL) then
    exit;
  while Assigned(node.Parent)  do
    node := node.Parent;

  cp := node.Data;

  Application.CreateForm(TChapterContentForm, ChapterContentForm);
  ChapterContentForm.ChapterTitle := cp;
  if ChapterContentForm.ShowModal = mrOk  then
  begin
    updateCpList;
  end;
  ChapterContentForm.Free;
end;

procedure TProtokollForm.DBNavigator3Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  if Button = nbInsert then
    CPTab.FieldByName('CP_NR').AsInteger := CPTab.RecordCount + 1;
end;

procedure TProtokollForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if m_treeChanged then
    saveToclientBlob(prTab, 'PR_DATA');

  if (PRTab.State = dsEdit) or ( PRTab.State = dsInsert) then
    PRTab.Post;

  if PRTab.UpdatesPending then
    PRTab.ApplyUpdates(-1);

  if TNTab.UpdatesPending then
    TNTab.ApplyUpdates(-1);

  if TGTab.UpdatesPending then
    TGTab.ApplyUpdates(-1);

  if CPTab.UpdatesPending then
    CPTab.ApplyUpdates(-1);

  Action := caFree;
  if m_locked then
    GM.UnLockDocument(m_id, integer(ltProtokoll));

end;

procedure TProtokollForm.FormCreate(Sender: TObject);
begin
  TV.Images := GM.ImageList2;
  Application.CreateForm(TTitelEditform, m_TitelEditform);
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_locked := true;
  m_treeChanged := false;

  m_grList:= TGremiumListForm.Create(Self);
  m_cpList:= TChapterTitleList.Create;

  m_proto := NewProtocol;

end;

procedure TProtokollForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(m_grList);
  FreeAndNil(m_cpList);
  WindowHandler.closeProtoclWindow(m_id);
  m_proto := NIL;
end;

function TProtokollForm.loadFromChapterBlob(tab: TClientDataSet;
  FieldName: string): IXMLChapter;
var
  st : TStream;
  xml: IXMLDocument;
begin
  Result := NewChapter;
  tab.FetchBlobs;
  st := tab.CreateBlobStream( tab.FieldByName(FieldName), bmRead );
  if Assigned(st) and ( st.Size > 0) then
  begin
    xml := NewXMLDocument;
    xml.LoadFromStream(st);
    Result := xml.GetDocBinding('Chapter', TXMLChapter, TargetNamespace) as IXMLChapter;
  end;
  if Assigned(st) then
    st.Free;
end;

procedure TProtokollForm.loadFromClientBlob(tab: TClientDataSet;
  FieldName: string);
var
  st : TStream;
  xml: IXMLDocument;
begin
  tab.FetchBlobs;
  st := tab.CreateBlobStream( tab.FieldByName(FieldName), bmRead );
  if not Assigned(st) or ( st.Size = 0) then
  begin
    m_proto := NewProtocol;
  end
  else
  begin
    xml := NewXMLDocument;
    xml.LoadFromStream(st);
    m_proto := xml.GetDocBinding('Protocol', TXMLProtocol, TargetNamespace) as TXMLProtocol;
  end;
  if Assigned(st) then
    st.Free;
  m_treeChanged := false;
end;

procedure TProtokollForm.saveChangedChapter;
var
  i : integer;
begin
  for i := 0 to pred(m_cpList.Count) do
    begin
      if m_cpList.Items[i].Modified then
      begin
        UpdateCPQry.ParamByName('CP_ID').AsInteger  := m_cpList.Items[i].ID;
        UpdateCPQry.ParamByName('CP_NR').AsInteger  := m_cpList.Items[i].Nr;
        UpdateCPQry.ParamByName('CP_TITLE').AsString:= m_cpList.Items[i].Text;
        UpdateCPQry.Execute;
        m_cpList.Items[i].Modified := false;
      end;
    end;
end;

procedure TProtokollForm.saveToclientBlob(tab: TClientDataSet;
  FieldName: string);
var
  st : TStream;
begin
  st := tab.CreateBlobStream( tab.FieldByName(fieldname), bmWrite );
  m_proto.OwnerDocument.SaveToStream(st);
  st.Free;
end;

procedure TProtokollForm.setID(value: integer);
var
  opts : TLocateOptions;
  filter : string;
  cp : TChapterTitle;
begin
  m_id := value;
  filter := 'PR_ID = '+IntToStr( m_id);
  PRTab.Open;
  if PRTab.Locate('PR_ID', VarArrayOf([m_id]), opts) then
  begin
    loadFromClientBlob( PRTab, 'PR_DATA');

    Caption := PRTab.FieldByName('PR_NAME').AsString;

    PRTab.Edit;
    TNTab.Filter := filter;
    TNTab.Filtered := true;
    TNTab.Open;

    TGTab.Filter := filter;
    TGTab.Filtered := true;
    TGTab.Open;

    CPTab.Filter := filter;
    CPTab.Filtered := true;
    CPTab.Open;

    while not CPTab.Eof do
    begin
      cp          := m_cpList.NewEntry;
      cp.ID       := CPTab.FieldByName('CP_ID').AsInteger;
      cp.Text     := CPTab.FieldByName('CP_TITLE').AsString;
      cp.Nr       := CPTab.FieldByName('CP_NR').AsInteger;
      cp.xChapter := loadFromChapterBlob(CPTab, 'CP_DATA');
      CPTab.Next;
    end;
    updateCpList;
  end;
end;

procedure TProtokollForm.setRO(value: boolean);
begin
  m_ro := value;

  Panel2.Enabled      := not m_ro;

  DBNavigator1.Enabled := not m_ro;
  DBNavigator2.Enabled := not m_ro;

  Panel1.Enabled       := not m_ro;
  Panel4.Enabled       := not m_ro;

  Button4.Enabled      := true;
end;


procedure TProtokollForm.SpeedButton1Click(Sender: TObject);
var
  cp : TChapterTitle;
begin
  m_TitelEditform.TitelText := 'Titel '+IntToStr( m_cpList.Count+1);
  if m_TitelEditform.ShowModal = mrOk then
  begin
    cp := m_cpList.NewEntry;
    cp.Text := m_TitelEditform.TitelText;
    updateCpList;

    cp.ID := GM.autoInc('gen_cp_id');
    cp.Modified := true;


    CPTab.Append;
    CPTab.FieldByName('PR_ID').AsInteger    := m_id;
    CPTab.FieldByName('CP_ID').AsInteger    := cp.ID;
    CPTab.FieldByName('CP_TITLE').AsString  := cp.Text;
    CPTab.FieldByName('CP_NR').AsInteger    := cp.Nr;
    CPTab.Post;

  end;
end;

procedure TProtokollForm.SpeedButton2Click(Sender: TObject);
var
  cp : TChapterTitle;
  node : TTreeNode;
begin
  node := TV.Selected;
  if (node = NIL) then
    exit;
  while Assigned(node.Parent)  do
    node := node.Parent;

  cp := node.Data;
  m_TitelEditform.TitelText := cp.Text;
  if m_TitelEditform.ShowModal = mrOk then
  begin
    cp.Text := m_TitelEditform.TitelText;
    cp.Modified := true;
    saveChangedChapter;
    updateCpList;
  end;
end;

procedure TProtokollForm.SpeedButton3Click(Sender: TObject);
var
  cp : TChapterTitle;
  node : TTreeNode;
begin
  node := TV.Selected;
  if (node = NIL) then
    exit;
  while Assigned(node.Parent)  do
    node := node.Parent;

  cp := node.Data;
  m_cpList.remove(cp);
  updateCpList;
end;

procedure TProtokollForm.SpeedButton4Click(Sender: TObject);
var
  cp : TChapterTitle;
  node : TTreeNode;
begin
  node := TV.Selected;
  if (node = NIL) then
    exit;
  while Assigned(node.Parent)  do
    node := node.Parent;

  cp := node.Data;
  cp.up;
  updateCpList;
  saveChangedChapter;

end;

procedure TProtokollForm.SpeedButton5Click(Sender: TObject);
var
  cp : TChapterTitle;
  node : TTreeNode;
begin
  node := TV.Selected;
  if (node = NIL) then
    exit;
  while Assigned(node.Parent)  do
    node := node.Parent;

  cp := node.Data;
  cp.down;
  updateCpList;

  saveChangedChapter;
end;

procedure TProtokollForm.TGTabAfterInsert(DataSet: TDataSet);
begin
  TGTab.FieldByName('PR_ID').AsInteger := m_id;
  AutoIncValue.Open;
  TGTab.FieldByName('TG_ID').AsInteger := AutoIncValue.FieldByName('GEN_ID').AsInteger;
  AutoIncValue.close;
end;

procedure TProtokollForm.TNTabStatusTextChange(Sender: TField);
var
  s : string;
begin
  s := Lowercase(Sender.AsString);
  if s = 'anwesend' then
    TNTab.FieldByName('TN_STATUS').Asinteger := 1
  else if s = 'entschuldigt' then
    TNTab.FieldByName('TN_STATUS').Asinteger := 2
  else if s = 'abwesend' then
    TNTab.FieldByName('TN_STATUS').Asinteger := 3
  else
    TNTab.FieldByName('TN_STATUS').Asinteger := 0;
end;

procedure TProtokollForm.TNTabStatusTextGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
var
  nr : integer;
begin
  nr := TNTab.FieldByName('TN_STATUS').Asinteger;
  case nr of
    1 : Text := 'Anwesend';
    2 : Text := 'Entschuldigt';
    3 : Text := 'Abwesend';
    else
      Text := 'Eingeladen';
  end;
end;

procedure TProtokollForm.TNTabStatusTextSetText(Sender: TField;
  const Text: string);
var
  s : string;
begin
  s := Lowercase(text);
  if s = 'anwesend' then
    TNTab.FieldByName('TN_STATUS').Asinteger := 1
  else if s = 'entschuldigt' then
    TNTab.FieldByName('TN_STATUS').Asinteger := 2
  else if s = 'abwesend' then
    TNTab.FieldByName('TN_STATUS').Asinteger := 3
  else
    TNTab.FieldByName('TN_STATUS').Asinteger := 0;
end;

procedure TProtokollForm.updateCpList;
var
  cp, old   : TChapterTitle;
  i         : integer;
  node      : TTreeNode;
begin
  old := NIL;
  TV.Items.BeginUpdate;

  if Assigned(TV.Selected) and not Assigned(TV.Selected.Parent) then
    old := tV.Selected.Data;

  TV.Items.Clear;
  for i := 0 to pred(m_cpList.Count) do
  begin
    cp   := m_cpList.Items[i];
    node := TV.Items.AddObject(NIL, cp.FullTitle, cp);
    node.ImageIndex := 0;
    node.SelectedIndex := 0;

    buildTree( node, cp.xChapter );

    if cp = old then
      TV.Selected := node;

  end;
  TV.Items.EndUpdate;
end;

end.
