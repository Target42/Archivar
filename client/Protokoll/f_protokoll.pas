unit f_protokoll;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, JvExComCtrls, JvDBTreeView, Vcl.Menus,
  System.Actions, Vcl.ActnList, f_gremiumList, JvDateTimePicker,
  JvDBDateTimePicker, Vcl.Buttons, f_titel_edit, xsd_protocol,
  fr_chapter, xsd_chapter, i_personen, i_chapter, System.ImageList, Vcl.ImgList,
  Vcl.OleCtrls, SHDocVw, m_taskLoader;

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
    UpdateCPQry: TClientDataSet;
    TV: TTreeView;
    Button1: TBitBtn;
    Button2: TBitBtn;
    Button3: TBitBtn;
    TNTabPE_ID: TIntegerField;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ac_add: TAction;
    ac_edit: TAction;
    ac_edit_content: TAction;
    ac_delete: TAction;
    ac_up: TAction;
    ac_down: TAction;
    PopupMenu1: TPopupMenu;
    Hinzufgen1: TMenuItem;
    Bearbeiten1: TMenuItem;
    Inhaltbearbeiten1: TMenuItem;
    N1: TMenuItem;
    Lschen1: TMenuItem;
    N2: TMenuItem;
    Abschnitthoch1: TMenuItem;
    Abschnittrunter1: TMenuItem;
    CPTextTab: TClientDataSet;
    WebBrowser1: TWebBrowser;
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
    procedure TVClick(Sender: TObject);
    procedure ac_addExecute(Sender: TObject);
    procedure ac_editExecute(Sender: TObject);
    procedure ac_edit_contentExecute(Sender: TObject);
    procedure ac_deleteExecute(Sender: TObject);
    procedure ac_upExecute(Sender: TObject);
    procedure ac_downExecute(Sender: TObject);
  private
    m_TitelEditform : TTitelEditform;
    m_proto         : IProtocol;
    m_treeChanged   : Boolean;
    m_locked        : Boolean;

    m_grList        : TGremiumListForm;
    m_ro            : Boolean;
    m_loader        : TTaskLoaderMod;

    procedure setID( value : integer );
    function  getID : integer;

    procedure loadFromClientBlob( tab : TClientDataSet; FieldName : string );
    procedure saveToclientBlob( tab : TClientDataSet; FieldName : string );

    procedure setRO( value : boolean );

    procedure updateCpList;
    procedure saveChangedChapter;
    procedure buildTree( root : TTreeNode; ct : IChapterTitle );

    procedure UpdateGremium;

    procedure save;
    procedure reopen;
  public
    property ID : integer read getID write setID;
    property RO : boolean read m_ro write setRO;
  end;

var
  ProtokollForm: TProtokollForm;

implementation

uses
  m_glob_client, Xml.XMLIntf, Xml.XMLDoc, u_bookmark, m_BookMarkHandler,
  u_berTypes, System.JSON, u_json, System.Generics.Collections,
  m_WindowHandler, f_chapter_content, u_gremium, system.UITypes,
  u_ChapterImpl, u_ProtocolImpl, u_speedbutton, m_html;

{$R *.dfm}

{ TProtokollForm }

procedure TProtokollForm.ac_addExecute(Sender: TObject);
var
  cp : IChapterTitle;
begin
  m_TitelEditform.TitelText := 'Titel '+IntToStr( m_proto.Chapter.Count+1);
  if m_TitelEditform.ShowModal = mrOk then
  begin
    cp := m_proto.Chapter.NewEntry;
    cp.Text := m_TitelEditform.TitelText;
    updateCpList;

    cp.ID := GM.autoInc('gen_cp_id');
    cp.Modified := true;

    CPTab.Append;
    CPTab.FieldByName('PR_ID').AsInteger    := m_proto.ID;
    CPTab.FieldByName('CP_ID').AsInteger    := cp.ID;
    CPTab.FieldByName('CP_TITLE').AsString  := cp.Text;
    CPTab.FieldByName('CP_NR').AsInteger    := cp.Nr;
    CPTab.Post;

    m_treeChanged := true;
  end;
end;

procedure TProtokollForm.ac_deleteExecute(Sender: TObject);
var
  cp   : IChapterTitle;
  node : TTreeNode;
begin
  node := TV.Selected;
  if (node = NIL) then
    exit;
  if not (MessageDlg('Soll das Kapitel gelöscht werden?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    exit;

  while Assigned(node.Parent)  do
    node := node.Parent;

  cp := IChapterTitle(node.Data);
  m_proto.Chapter.remove(cp);
  updateCpList;

  m_treeChanged := true;
end;

procedure TProtokollForm.ac_downExecute(Sender: TObject);
var
  cp : IChapterTitle;
  node : TTreeNode;
begin
  node := TV.Selected;
  if (node = NIL) then
    exit;
  while Assigned(node.Parent)  do
    node := node.Parent;

  cp := IChapterTitle(node.Data);
  cp.down;
  updateCpList;

  saveChangedChapter;
  m_treeChanged := true;
end;

procedure TProtokollForm.ac_editExecute(Sender: TObject);
var
  cp   : IChapterTitle;
  node : TTreeNode;
begin
  node := TV.Selected;
  if (node = NIL) then
    exit;
  while Assigned(node.Parent)  do
    node := node.Parent;

  cp := IChapterTitle(node.Data);
  m_TitelEditform.TitelText := cp.Text;
  if m_TitelEditform.ShowModal = mrOk then
  begin
    cp.Text := m_TitelEditform.TitelText;
    cp.Modified := true;
    saveChangedChapter;
    updateCpList;
    m_treeChanged := true;
  end;
end;

procedure TProtokollForm.ac_edit_contentExecute(Sender: TObject);
var
  cp : IChapterTitle;
  node : TTreeNode;
begin

  node := TV.Selected;
  if (node = NIL) then
    exit;
  while Assigned(node.Parent)  do
    node := node.Parent;

  cp := IChapterTitle(node.Data);

  if m_treeChanged then
    save;

  Application.CreateForm(TChapterContentForm, ChapterContentForm);
  ChapterContentForm.ChapterTitle := cp;
  if ChapterContentForm.ShowModal = mrOk  then
  begin

    CPTextTab.Refresh;
    CPTextTab.Filter := 'CP_ID='+intToStr(cp.ID);
    CPTextTab.Filtered := true;

    cp.Root.Childs.clear;
    cp.loadFromDataSet(CPTextTab);

    updateCpList;
  end;
  CPTextTab.Filtered := false;
  ChapterContentForm.Free;
  reopen;
end;

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
  obj := GM.LockDocument( m_proto.ID, integer(ltProtokoll));
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
  data := GM.UnlockDocument(m_proto.ID, integer(ltProtokoll));
  if JBool( data, 'result') then
  begin
    self.RO := true;
    Caption := PRTab.FieldByName('PR_NAME').AsString;
    m_locked := false;
  end;
  ShowMessage(JString(data, 'text'));
end;

procedure TProtokollForm.ac_upExecute(Sender: TObject);
var
  cp   : IChapterTitle;
  node : TTreeNode;
begin
  node := TV.Selected;
  if (node = NIL) then
    exit;
  while Assigned(node.Parent)  do
    node := node.Parent;

  cp := IChapterTitle(node.Data);
  cp.up;
  updateCpList;
  saveChangedChapter;
  m_treeChanged := true;
end;

procedure TProtokollForm.buildTree(root: TTreeNode; ct : IChapterTitle);
  procedure add( root : TTreeNode; items : IChapterList );
  var
    j :    integer;
    node  : TTreeNode;
    inx   : integer;
    cp    : IChapter;
  begin
    for j := 0 to pred(items.Count) do
    begin
      cp := items.Items[j];
      node := TV.Items.AddChildObject(root, cp.fullTitle, cp);
      inx := 2;
      if items.Items[j].TAID > 0 then
        inx := 1;
      node.SelectedIndex := inx;
      node.ImageIndex    := inx;

      add(node, items.Items[j].Childs);
    end;
  end;

begin
  if ct.Root.Childs.Count = 0 then
    exit;

  add( root, ct.Root.Childs );
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

procedure TProtokollForm.DBNavigator3Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  if Button = nbInsert then
    CPTab.FieldByName('CP_NR').AsInteger := CPTab.RecordCount + 1;
end;

procedure TProtokollForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  save;

  Action := caFree;
  if m_locked then
    GM.UnLockDocument(m_proto.ID, integer(ltProtokoll));

end;

procedure TProtokollForm.FormCreate(Sender: TObject);
begin
  updateSeedBtn( self, 1 );

  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  TV.Images := GM.ImageList2;
  Application.CreateForm(TTitelEditform, m_TitelEditform);
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_locked := true;
  m_treeChanged := false;

  m_grList:= TGremiumListForm.Create(Self);

  m_proto   := NIL;
  m_loader  := TTaskLoaderMod.Create(self);
end;

procedure TProtokollForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(m_grList);

  WindowHandler.closeProtoclWindow(m_proto.ID);

  m_proto.release;
  m_proto := NIL;
  m_loader.Free;
end;

function TProtokollForm.getID: integer;
begin
  Result := -1;
  if Assigned(m_proto) then
    Result := m_proto.ID;

end;


procedure TProtokollForm.loadFromClientBlob(tab: TClientDataSet;
  FieldName: string);
var
  st : TStream;
begin
  tab.FetchBlobs;
  st := tab.CreateBlobStream( tab.FieldByName(FieldName), bmRead );

  m_proto.loadFromStream(st);

  if Assigned(st) then
    st.Free;
  m_treeChanged := false;
end;

procedure TProtokollForm.reopen;
begin
  PRTab.Edit;
end;

procedure TProtokollForm.save;
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

  if CPTextTab.UpdatesPending then
    CPTextTab.ApplyUpdates(-1);

  m_treeChanged := false;
end;

procedure TProtokollForm.saveChangedChapter;
var
  i : integer;
begin
  for i := 0 to pred(m_proto.Chapter.Count) do
    begin
      if m_proto.Chapter.Items[i].Modified then
      begin
        UpdateCPQry.ParamByName('CP_ID').AsInteger  := m_proto.Chapter.Items[i].ID;
        UpdateCPQry.ParamByName('CP_NR').AsInteger  := m_proto.Chapter.Items[i].Nr;
        UpdateCPQry.ParamByName('CP_TITLE').AsString:= m_proto.Chapter.Items[i].Text;
        UpdateCPQry.Execute;
        m_proto.Chapter.Items[i].Modified := false;
      end;
    end;
end;

procedure TProtokollForm.saveToclientBlob(tab: TClientDataSet;
  FieldName: string);
var
  st : TStream;
begin
  st := tab.CreateBlobStream( tab.FieldByName(fieldname), bmWrite );
  m_proto.SaveToStream(st);
  st.Free;
end;

procedure TProtokollForm.setID(value: integer);
var
  opts    : TLocateOptions;
  filter  : string;
  cp      : IChapterTitle;
begin
  if Assigned(m_proto) then
    m_proto.release;
  m_proto := TProtocolImpl.create;

  m_proto.ID := value;

  filter := 'PR_ID = '+IntToStr( m_proto.ID);
  PRTab.Open;
  if PRTab.Locate('PR_ID', VarArrayOf([m_proto.ID]), opts) then
  begin
    loadFromClientBlob( PRTab, 'PR_DATA');

    Caption := PRTab.FieldByName('PR_NAME').AsString;

    CPTextTab.Open;

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
      cp          := m_proto.Chapter.NewEntry;
      cp.ID       := CPTab.FieldByName('CP_ID').AsInteger;
      cp.Text     := CPTab.FieldByName('CP_TITLE').AsString;
      cp.Nr       := CPTab.FieldByName('CP_NR').AsInteger;


      CPTextTab.Filter := 'CP_ID='+intToStr(cp.ID);
      CPTextTab.Filtered := true;

      cp.loadFromDataSet(CPTextTab);

      CPTab.Next;
    end;
    updateCpList;
    UpdateGremium;
  end;
end;

procedure TProtokollForm.setRO(value: boolean);
begin
  m_ro := value;

  Label4.Visible        := m_ro;
  Sperren1.Enabled      := m_ro;
  Freigeben1.Enabled    := not m_ro;

  Panel2.Enabled        := not m_ro;
  Panel2.Visible        := not m_ro;

  DBNavigator1.Enabled  := not m_ro;
  DBNavigator2.Enabled  := not m_ro;

  Panel1.Enabled        := not m_ro;
  Panel4.Enabled        := not m_ro;

  SpeedButton6.Enabled  := true;
end;


procedure TProtokollForm.TGTabAfterInsert(DataSet: TDataSet);
begin
  TGTab.FieldByName('PR_ID').AsInteger := m_proto.ID;
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

procedure TProtokollForm.TVClick(Sender: TObject);
var
  cp    : IChapter;
  ct    : IChapterTitle;
  html  : THtmlMod;

  procedure ShowText( text : string );
  var
    st : TStream;
  begin
    st := THtmlMod.Test2HTML(text);
    THtmlMod.SetHTML(st, WebBrowser1 );
  end;
begin
  if not Assigned(TV.Selected.Data) then
    exit;

  if TV.Selected.Level = 0 then
  begin
    ct := IChapterTitle(TV.Selected.Data);
    ShowText( ct.Text );
  end
  else
  begin
    cp := IChapter( TV.Selected.Data);

    if cp.TAID > 0   then
    begin
      if m_loader.load(cp.TAID) then
      begin
        html  := THtmlMod.Create(self);
        html.TaskContainer  := m_loader.TaskContainer;
        html.TaskData       := m_loader.TaskData;
        html.TaskStyle      := m_loader.TaskStyle;

        html.show(WebBrowser1);
        html.Free;
      end;
    end
    else
    begin
      ShowText( cp.Rem );
    end;
  end;
end;

procedure TProtokollForm.updateCpList;
var
  cp, old   : IChapterTitle;
  i         : integer;
  node      : TTreeNode;
begin
  old := NIL;
  TV.Items.BeginUpdate;

  if Assigned(TV.Selected) and not Assigned(TV.Selected.Parent) then
    old := IChapterTitle(tV.Selected.Data);

  TV.Items.Clear;
  for i := 0 to pred(m_proto.Chapter.Count) do
  begin
    cp   := m_proto.Chapter.Items[i];
    node := TV.Items.AddObject(NIL, cp.FullTitle, cp);
    node.ImageIndex := 0;
    node.SelectedIndex := 0;

    buildTree( node, cp );

    if cp = old then
      TV.Selected := node;

  end;
  TV.Items.EndUpdate;
end;

procedure TProtokollForm.UpdateGremium;
var
  list  : IPersonenListe;
  p     : IPerson;
  i     : integer;

begin
  list := GM.getGremiumMa(PRTab.FieldByName('GR_ID').Asinteger );
  if not Assigned(list) then
    exit;
  try
  for i := 0 to pred(list.count) do begin
    p := list.Items[i];

    if not TNTab.Locate('PR_ID;PE_ID', VarArrayOf([m_proto.id, p.ID]), []) then begin
      TNTab.Append;
      TNTab.FieldByName('PR_ID').AsInteger        := m_proto.ID;
      TNTab.FieldByName('TN_ID').AsInteger        := GM.autoInc('gen_tn_id');
      TNTab.FieldByName('TN_NAME').AsString       := p.Name;
      TNTab.FieldByName('TN_VORNAME').AsString    := p.Vorname;
      TNTab.FieldByName('TN_DEPARTMENT').AsString := p.Abteilung;
      TNTab.FieldByName('TN_ROLLE').AsString      := p.Rolle;
      TNTab.FieldByName('TN_STATUS').AsInteger    := 0;
      TNTab.FieldByName('PE_ID').AsInteger        := p.ID;
      TNTab.Post;
    end;
  end;
  finally
    list.release;
  end;

end;

end.
