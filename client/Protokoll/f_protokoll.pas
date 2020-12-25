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
  Vcl.OleCtrls, SHDocVw, m_taskLoader, System.Generics.Collections;

type
  TProtokollForm = class(TForm)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    MainMenu1: TMainMenu;
    Protokoll1: TMenuItem;
    Lesezeichenerstellen1: TMenuItem;
    N5: TMenuItem;
    Sperren1: TMenuItem;
    Freigeben1: TMenuItem;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    TV: TTreeView;
    Button1: TBitBtn;
    Button2: TBitBtn;
    Button3: TBitBtn;
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
    WebBrowser1: TWebBrowser;
    TN: TListView;
    DBEdit1: TEdit;
    DBEdit2: TEdit;
    JvDBDateTimePicker1: TJvDateTimePicker;
    N3: TMenuItem;
    Speichern: TMenuItem;
    Panel3: TPanel;
    TG: TListView;
    btnNeu: TBitBtn;
    btnEdit: TBitBtn;
    btnDelete: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ac_pr_bookmarkExecute(Sender: TObject);
    procedure ac_pr_lockExecute(Sender: TObject);
    procedure ac_pr_unlockExecute(Sender: TObject);
    procedure ac_addExecute(Sender: TObject);
    procedure ac_editExecute(Sender: TObject);
    procedure ac_edit_contentExecute(Sender: TObject);
    procedure ac_deleteExecute(Sender: TObject);
    procedure ac_upExecute(Sender: TObject);
    procedure ac_downExecute(Sender: TObject);
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    procedure Button2Click(Sender: TObject);
    procedure SpeichernClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBEdit1Change(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnNeuClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    m_TitelEditform : TTitelEditform;
    m_proto         : IProtocol;
    m_locked        : Boolean;

    m_grList        : TGremiumListForm;
    m_ro            : Boolean;
    m_loader        : TTaskLoaderMod;

    m_statusMap     : TDictionary<TTeilnehmerStatus, integer>;

    procedure setID( value : integer );
    function  getID : integer;

    procedure setRO( value : boolean );

    procedure updateCpList;
    procedure buildTree( root : TTreeNode; ct : IChapterTitle );

    procedure showContent;

    procedure setStatus( ts : TTeilnehmerStatus; grund : string = '' );
    procedure UpdateTN;
    procedure UpdateTG;

    procedure save;

    procedure fillStatusMap;
  public
    property ID : integer read getID write setID;
    property RO : boolean read m_ro write setRO;
  end;

var
  ProtokollForm: TProtokollForm;

implementation

uses
  m_glob_client, Xml.XMLIntf, Xml.XMLDoc, u_bookmark, m_BookMarkHandler,
  u_berTypes, System.JSON, u_json,
  m_WindowHandler, f_chapter_content, u_gremium, system.UITypes,
  u_ChapterImpl, u_ProtocolImpl, u_speedbutton, m_html, f_abwesenheit,
  f_besucher;

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

    m_proto.Chapter.AddNewChaper( cp  );

    m_proto.Modified := true;
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

  m_proto.Modified := true;
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

  m_proto.Chapter.saveChangedChapter;
  m_proto.Modified := true;
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
    m_proto.Chapter.saveChangedChapter;

    updateCpList;
    m_proto.Modified := true;
  end;
end;

procedure TProtokollForm.ac_edit_contentExecute(Sender: TObject);
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

  if m_proto.Modified then
  begin
    m_proto.saveTree;
  end;

  Application.CreateForm(TChapterContentForm, ChapterContentForm);
  ChapterContentForm.ChapterTitle := cp;
  if ChapterContentForm.ShowModal = mrOk  then
  begin
    m_proto.Chapter.updateChapter(cp);
    updateCpList;
  end;
  ChapterContentForm.Free;
end;

procedure TProtokollForm.ac_pr_bookmarkExecute(Sender: TObject);
var
  mark : u_bookmark.TBookmark;
begin
  mark            := BookMarkHandler.Bookmarks.newBookmark(m_proto.clid);
  mark.ID         := m_proto.ID;
  mark.Titel      := m_proto.Title;
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
    Caption := '*'+m_proto.Title;
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
    Caption := m_proto.Title;
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
  m_proto.Chapter.saveChangedChapter;
  m_proto.Modified := true;
end;

procedure TProtokollForm.btnDeleteClick(Sender: TObject);
var
  i : integer;
  b : IBesucher;
begin
  if m_proto.ReadOnly then
    exit;
  if not (MessageDlg('Sollen die ausgwewählten Gäste gelöscht werden?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    exit;

  for i := pred(TG.Items.Count) downto 0 do
  begin
    if TG.Items.Item[i].Selected then
    begin
      b := IBesucher( TG.Items.Item[i].Data);
      m_proto.Besucher.remove(b);
    end;
  end;
  UpdateTG;
end;

procedure TProtokollForm.btnEditClick(Sender: TObject);
var
  b : IBesucher;
begin
  if not Assigned(TG.Selected) then
    exit;

  b := m_proto.Besucher.newBesucher;
  Application.CreateForm(TBesucherForm, BesucherForm);
  BesucherForm.Besucher := b;
  if BesucherForm.ShowModal = mrOk then
  begin
    m_proto.Besucher.saveChanged;
  end
  else
    m_proto.Besucher.remove( b );

  BesucherForm.Free;
  UpdateTG;
end;

procedure TProtokollForm.btnNeuClick(Sender: TObject);
var
  b : IBesucher;
begin
  if not Assigned(TG.Selected) then
    exit;

  b := IBesucher( TG.Selected.Data);
  Application.CreateForm(TBesucherForm, BesucherForm);
  BesucherForm.Besucher := b;
  if BesucherForm.ShowModal = mrOk then
  begin
    m_proto.Besucher.saveChanged;
  end;
  BesucherForm.Free;
  UpdateTG;
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
begin
  setStatus( tsUnbekannt );
end;

procedure TProtokollForm.Button2Click(Sender: TObject);
begin
  Application.CreateForm(TAbwesenForm, AbwesenForm);
  if AbwesenForm.ShowModal = mrOk then
  begin
    setStatus( tsEntschuldigt, AbwesenForm.Grund );
  end;
  AbwesenForm.free;
end;

procedure TProtokollForm.Button3Click(Sender: TObject);
begin
  setStatus( tsUnentschuldigt );
end;

procedure TProtokollForm.DBEdit1Change(Sender: TObject);
begin
  if not m_proto.ReadOnly then
    m_proto.Modified := true;
end;

procedure TProtokollForm.fillStatusMap;
var
  inx : integer;
  procedure addGrp( status : TTeilnehmerStatus; name : string );
  var
    grp : TListGroup;
  begin
    grp             := TN.Groups.Add;
    grp.Header      := name;
    grp.GroupID     := inx;
    grp.FooterAlign := taRightJustify;

    m_statusMap.Add( status, inx);
    inc(inx);
  end;

begin
  inx := 0;
  addGrp(tsUnbekannt,     'Verfügbar');
  addGrp(tsAnwesend,      'Anwesend');
  addGrp(tsEntschuldigt,  'Entschuldigt');
  addGrp(tsUnentschuldigt,'Unentschuldigt');
  addGrp(tsLast,          'Last');
end;

procedure TProtokollForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  if m_locked then
    GM.UnLockDocument(m_proto.ID, integer(ltProtokoll));
end;

procedure TProtokollForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if m_proto.Modified then
  begin
    case MessageDlg('Die Daten wurden geändert.'+#13+#10+
                    ''+#13+#10+
                    'Änderungen speichern (Ja)'+#13+#10+
                    'Änderungen verwerfen (Nein)'+#13+#10+
                    'Im Dialog bleiben (Abbrechen)'+#13+#10+'',
                     mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes :
      begin
        save;
        CanClose := true;
      end;
      mrNo :
      begin
        m_proto.cancel;
        CanClose := true;
      end;
      else
        CanClose := false;
    end;
  end;

end;

procedure TProtokollForm.FormCreate(Sender: TObject);
begin
  m_statusMap := TDictionary<TTeilnehmerStatus, integer>.create;

  Application.CreateForm(TTitelEditform, m_TitelEditform);

  PageControl1.ActivePage             := TabSheet1;

  updateSeedBtn( self, 1 );

  TV.Images     := GM.ImageList2;
  m_locked      := true;

  m_grList      := TGremiumListForm.Create(Self);
  m_loader      := TTaskLoaderMod.Create(self);
  m_proto       := NIL;

  fillStatusMap;
end;

procedure TProtokollForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(m_grList);

  WindowHandler.closeProtoclWindow(m_proto.ID);

  m_proto.release;
  m_proto := NIL;
  m_loader.Free;
  m_statusMap.Free;
end;

function TProtokollForm.getID: integer;
begin
  Result := -1;
  if Assigned(m_proto) then
    Result := m_proto.ID;
end;

procedure TProtokollForm.save;
begin
  if m_ro then
    exit;

  m_proto.Title := trim(DBEdit1.Text);
  m_proto.Nr    := StrToIntDef(DBEdit2.Text, -1);
  m_proto.Date  := JvDBDateTimePicker1.DateTime;
  m_proto.save;
end;

procedure TProtokollForm.setID(value: integer);
begin
  if Assigned(m_proto) then
    m_proto.release;

  m_proto     := TProtocolImpl.create;
  m_proto.ID  := value;

  if m_proto.load(value) then
  begin
    caption       := m_proto.Title;
    DBEdit1.Text  := m_proto.Title;
    DBEdit2.Text  := IntToStr(m_proto.Nr);
    JvDBDateTimePicker1.DateTime := m_proto.Date;

    updateCpList;
    UpdateTN;
    UpdateTG;
  end;
  m_proto.Modified := false;
end;

procedure TProtokollForm.setRO(value: boolean);
begin
  m_ro := value;

  Label4.Visible        := m_ro;
  Sperren1.Enabled      := m_ro;
  Freigeben1.Enabled    := not m_ro;

  Panel2.Enabled        := not m_ro;
  Panel2.Visible        := not m_ro;

  Panel1.Enabled        := not m_ro;
  Panel4.Enabled        := not m_ro;

  Speichern.Enabled     := not m_ro;

  SpeedButton6.Enabled  := not m_ro;

  m_proto.ReadOnly      := m_ro;
  if m_ro then
    m_proto.cancel
  else
    m_proto.edit;
end;

procedure TProtokollForm.setStatus(ts: TTeilnehmerStatus; grund : string );
var
  i : integer;
  t : ITeilnehmer;
begin
  if m_proto.ReadOnly then
    exit;

  for i := 0 to pred(TN.Items.Count) do
  begin
    if TN.Items.Item[i].Selected then
    begin
      t := ITeilnehmer(TN.Items.Item[i].Data);
      t.Grund := grund;
      t.Status := ts
    end;
  end;
  m_proto.Teilnehmer.saveChanged;
  m_proto.Modified := true;

  UpdateTN;
end;

procedure TProtokollForm.showContent;
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

procedure TProtokollForm.SpeichernClick(Sender: TObject);
begin
  if m_ro then
    exit;
  m_proto.save;
  m_proto.edit;
end;

procedure TProtokollForm.TVChange(Sender: TObject; Node: TTreeNode);
begin
  showContent;
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

procedure TProtokollForm.UpdateTG;
var
  i     : integer;
  b     : IBesucher;
  item  : TListItem;
begin
  TG.Items.BeginUpdate;
  TG.Items.Clear;
  for i := 0 to pred(m_proto.Besucher.Count) do
  begin
    b := m_proto.Besucher.Item[i];
    item := TG.Items.Add;

    item.Data := b;
    item.Caption := b.Name;
    item.SubItems.Add( b.Vorname);
    item.SubItems.Add( b.Abteilung );
    item.SubItems.Add( FormatDateTime('hh:mm', b.Von));
    item.SubItems.Add( FormatDateTime('hh:mm', b.bis));
    item.SubItems.Add( b.Grund );
  end;
  TG.Items.EndUpdate;
end;

procedure TProtokollForm.UpdateTN;
var
  i     : integer;
  t     : ITeilnehmer;
  item  : TListItem;
  sum   : array of Integer;
begin
  SetLength(sum, integer(tsLast));
  TN.Items.BeginUpdate;
  TN.Items.Clear;

  for i := 0 to pred(m_proto.Teilnehmer.Count) do
  begin
    t := m_proto.Teilnehmer.Item[i];
    item := TN.Items.Add;

    item.Data := t;
    item.GroupID := m_statusMap[t.Status];
    item.Caption := t.Name;
    item.SubItems.Add(t.Vorname);
    item.SubItems.Add(t.Abteilung);
    item.SubItems.Add(t.Rolle);
    item.SubItems.Add(t.Grund );

    sum[integer(t.Status)] := sum[integer(t.Status)] + 1;
  end;
  for i := 0 to pred(TN.Groups.Count) do
    TN.Groups.Items[i].Footer := 'Anzahl:'+IntToStr( sum[i]);

  TN.Items.EndUpdate;
  SetLength(sum, 0);
end;

end.
