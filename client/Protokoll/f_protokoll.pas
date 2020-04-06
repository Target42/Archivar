unit f_protokoll;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, JvExComCtrls, JvDBTreeView, Vcl.Menus,
  System.Actions, Vcl.ActnList, f_gremiumList, JvDateTimePicker,
  JvDBDateTimePicker, Vcl.Buttons, f_titel_edit, u_titel, xsd_protocol,
  fr_chapter;

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
    Panel3: TPanel;
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
    LV: TListView;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    UpdateCPQry: TClientDataSet;
    ChapterFrame1: TChapterFrame;
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
    procedure LVChange(Sender: TObject; Item: TListItem; Change: TItemChange);
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

    procedure setRO( value : boolean );

    procedure updateCpList;
    procedure saveChangedChapter;
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
  m_WindowHandler;

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
  Application.CreateForm(TTitelEditform, m_TitelEditform);
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_locked := true;
  m_treeChanged := false;

  m_grList:= TGremiumListForm.Create(Self);
  m_cpList:= TChapterTitleList.Create;

  m_proto := NewProtocol;
  ChapterFrame1.prepare;

end;

procedure TProtokollForm.FormDestroy(Sender: TObject);
begin
  ChapterFrame1.Shutdown;
  FreeAndNil(m_grList);
  FreeAndNil(m_cpList);
  WindowHandler.closeProtoclWindow(m_id);
  m_proto := NIL;
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

procedure TProtokollForm.LVChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  cp : TChapterTitle;
begin
  cp := Item.Data;
  ChapterFrame1.CP_ID := cp.ID;
end;

procedure TProtokollForm.saveChangedChapter;
var
  i : integer;
begin
  for i := 0 to pred(m_cpList.Count) do
    begin
      if m_cpList.Items[i].Modified then
      begin
        UpdateCPQry.ParamByName('PR_ID').AsInteger := m_id;
        UpdateCPQry.ParamByName('CP_NR').AsInteger := m_cpList.Items[i].Nr;
        UpdateCPQry.ParamByName('CP_TEXT').AsString:= m_cpList.Items[i].Text;
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
      cp := m_cpList.NewEntry;
      cp.ID   := CPTab.FieldByName('CP_ID').AsInteger;
      cp.Text := CPTab.FieldByName('CP_TITLE').AsString;
      cp.Nr   := CPTab.FieldByName('CP_NR').AsInteger;
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
begin
  if LV.Selected = NIL then
    exit;
  cp := LV.Selected.Data;
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
begin
  if not Assigned(LV.Selected) then
    exit;
  cp := LV.Selected.Data;
  m_cpList.remove(cp);
  updateCpList;
end;

procedure TProtokollForm.SpeedButton4Click(Sender: TObject);
var
  cp : TChapterTitle;
begin
  if not Assigned(LV.Selected)then
    exit;

  cp := LV.Selected.Data;
  cp.up;
  updateCpList;
  saveChangedChapter;

end;

procedure TProtokollForm.SpeedButton5Click(Sender: TObject);
var
  cp : TChapterTitle;
begin
  if not Assigned(LV.Selected)then
    exit;

  cp := LV.Selected.Data;
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
  cp, old  : TChapterTitle;
  i   : integeR;
  item : TListItem;
begin
  old := NIL;
  LV.Items.BeginUpdate;
  if Assigned(LV.Selected) then
    old := LV.Selected.Data;

  LV.Items.Clear;
  for i := 0 to pred(m_cpList.Count) do
  begin
    cp := m_cpList.Items[i];
    item := LV.Items.Add;
    item.Data := cp;
    item.Caption := IntToStr( cp.Nr);
    item.SubItems.Add(cp.Text);

    if cp = old then
      LV.Selected := item;

  end;
  LV.Items.EndUpdate;

end;

end.
