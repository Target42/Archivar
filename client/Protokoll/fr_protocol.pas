unit fr_protocol;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList, Vcl.Menus, System.Actions,
  Vcl.ActnList, Vcl.OleCtrls, SHDocVw, i_chapter, i_beschluss, u_renderer,
  m_taskLoader, f_titel_edit;

type
  TProtocolFrame = class(TFrame)
    ActionList1: TActionList;
    ac_add: TAction;
    ac_edit: TAction;
    ac_edit_content: TAction;
    ac_delete: TAction;
    ac_up: TAction;
    ac_down: TAction;
    ac_beschluss: TAction;
    ac_be_bearbeiten: TAction;
    ac_be_delete: TAction;
    PopupMenu1: TPopupMenu;
    Hinzufgen1: TMenuItem;
    Bearbeiten1: TMenuItem;
    Inhaltbearbeiten1: TMenuItem;
    N1: TMenuItem;
    Lschen1: TMenuItem;
    N2: TMenuItem;
    Abschnitthoch1: TMenuItem;
    Abschnittrunter1: TMenuItem;
    ImageList1: TImageList;
    GroupBox1: TGroupBox;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    TabSheet5: TTabSheet;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    TV: TTreeView;
    ac_edit_task: TAction;
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    procedure TVDblClick(Sender: TObject);
    procedure ac_addExecute(Sender: TObject);
    procedure ac_editExecute(Sender: TObject);
    procedure ac_edit_contentExecute(Sender: TObject);
    procedure ac_deleteExecute(Sender: TObject);
    procedure ac_upExecute(Sender: TObject);
    procedure ac_downExecute(Sender: TObject);
    procedure ac_beschlussExecute(Sender: TObject);
    procedure ac_be_bearbeitenExecute(Sender: TObject);
    procedure ac_be_deleteExecute(Sender: TObject);
    procedure TVCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure ac_edit_taskExecute(Sender: TObject);
  private type
    TEntryType = (etNothing, etChapterText, etTask, etBeschluss, etTitle);

    TEntry = class(TObject)
    private
      FPtr: pointer;
      FTyp: TEntryType;
    public
      constructor create; overload;
      constructor create(cp: IChapterTitle); overload;
      constructor create(cp: IChapter); overload;
      constructor create(be: IBeschluss); overload;

      Destructor Destroy; override;

      property Ptr: pointer read FPtr write FPtr;
      property Typ: TEntryType read FTyp write FTyp;


    end;

  private
    m_proto         : IProtocol;
    m_renderer      : TProtocolRenderer;
    m_loader        : TTaskLoaderMod;
    m_ro            : boolean;
    m_TitelEditform : TTitelEditform;

    // selected
    m_sel_type  : TEntryType;
    m_sel_id    : integer;

    FBrowser: TWebBrowser;
    FonBeschlusChange: TBeschlusChange;
    FMeetingMode: boolean;
    function GetProtocol: IProtocol;
    procedure SetProtocol(const Value: IProtocol);

    procedure showContent;
    function GetReadOnly: boolean;
    procedure SetReadOnly(const Value: boolean);

    procedure updateCpList;

    procedure buildTree(root: TTreeNode; ct: IChapterTitle);

    procedure clearTree;
    function findNode(Node: TTreeNode; Typ: TEntryType): TEntry;

    procedure saveSelected;
    procedure restoreSelected;
  public
    procedure init;
    procedure release;

    property Protocol: IProtocol read GetProtocol write SetProtocol;
    property Browser: TWebBrowser read FBrowser write FBrowser;
    property ReadOnly: boolean read GetReadOnly write SetReadOnly;

    property onBeschlusChange: TBeschlusChange read FonBeschlusChange write FonBeschlusChange;
    property MeetingMode: boolean read FMeetingMode write FMeetingMode;

  end;

implementation


uses
  f_chapter_content, f_bechlus, system.UITypes, m_glob_client, u_speedbutton,
  f_chapterEdit, f_chapterTask;
{$R *.dfm}

{ TProtocolFrame }

procedure TProtocolFrame.ac_addExecute(Sender: TObject);
var
  cp: IChapterTitle;
begin

  m_TitelEditform.TitelText := 'Titel ' + IntToStr(m_proto.Chapter.Count + 1);
  if m_TitelEditform.ShowModal = mrOk then
  begin
    cp := m_proto.Chapter.NewEntry;
    cp.Text := m_TitelEditform.TitelText;
    updateCpList;

    m_proto.Chapter.AddNewChaper(cp);

    m_proto.Modified := true;
  end;
end;

procedure TProtocolFrame.ac_beschlussExecute(Sender: TObject);
var
  be: IBeschluss;
  en: TEntry;
  cp: IChapter;
begin
  if m_proto.ReadOnly or not Assigned(TV.Selected) then
    exit;

  en := TEntry(TV.Selected.Data);
  if not(en.Typ in [etTask, etChapterText]) then
    exit;

  cp := IChapter(en.Ptr);
  be := cp.Votes.newBeschluss;
  be.CTID := cp.ID;

  m_proto.SyncUser( be, false );

  Application.CreateForm(TBeschlusform, Beschlusform);
  Beschlusform.Beschluss := be;

  if Beschlusform.ShowModal = mrOk then
  begin
    cp.Votes.saveModified;
    updateCpList;
  end
  else
    cp.Votes.delete(be);

  Beschlusform.Free;
end;

procedure TProtocolFrame.ac_be_bearbeitenExecute(Sender: TObject);
var
  be  : IBeschluss;
  en  : TEntry;
  cp  : IChapter;
begin
  if m_proto.ReadOnly or not Assigned(TV.Selected) then
    exit;
  en := TEntry(TV.Selected.Data);
  if not(en.Typ = etBeschluss) then
    exit;
  be := IBeschluss(en.Ptr);

  en := TEntry(TV.Selected.Parent.Data);
  if not (en.Typ in [etTask, etChapterText]) then
    exit;
  cp := IChapter( en.Ptr);

  m_proto.SyncUser( be, false );

  Application.CreateForm(TBeschlusform, Beschlusform);
  Beschlusform.Beschluss := be;

  if Beschlusform.ShowModal = mrOk then
  begin
    cp.Votes.saveModified;
    updateCpList;
  end;
  Beschlusform.Free;

  if FMeetingMode then
    onBeschlusChange( be );
end;

procedure TProtocolFrame.ac_be_deleteExecute(Sender: TObject);
var
  be: IBeschluss;
  en: TEntry;
  pen: TEntry;
  cp: IChapter;
begin
  if m_proto.ReadOnly or not Assigned(TV.Selected) then
    exit;
  en := TEntry(TV.Selected.Data);
  if not(en.Typ = etBeschluss) then
    exit;
  be := IBeschluss(en.Ptr);

  if not Assigned(TV.Selected.Parent) then
    exit;
  pen := TEntry(TV.Selected.Parent.Data);
  if not(pen.Typ in [etTask, etTitle]) then
    exit;

  if not(MessageDlg('Soll der Beschluss wirklich gelöscht werden?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    exit;

  cp.Votes.delete(be);

  updateCpList;
end;

procedure TProtocolFrame.ac_deleteExecute(Sender: TObject);
var
  cp: IChapterTitle;
  Node: TTreeNode;
  en: TEntry;
begin
  Node := TV.Selected;
  if (Node = NIL) then
    exit;
  if not(MessageDlg('Soll das Kapitel gelöscht werden?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes) then
    exit;

  en := findNode(Node, etTitle);
  if not Assigned(en) then
    exit;

  cp := IChapterTitle(en.Ptr);
  m_proto.Chapter.remove(cp);
  updateCpList;

  m_proto.Modified := true;
end;

procedure TProtocolFrame.ac_downExecute(Sender: TObject);
var
  cp: IChapterTitle;
  Node: TTreeNode;
  en: TEntry;
begin
  Node := TV.Selected;
  if (Node = NIL) then
    exit;

  en := findNode(Node, etTitle);
  if not Assigned(en) then
    exit;

  cp := IChapterTitle(en.Ptr);
  cp.down;
  updateCpList;

  m_proto.Chapter.saveChangedChapter;
  m_proto.Modified := true;
end;

procedure TProtocolFrame.ac_editExecute(Sender: TObject);
var
  cp: IChapterTitle;
  Node: TTreeNode;
  en: TEntry;
begin
  Node := TV.Selected;
  if (Node = NIL) then
    exit;

  en := findNode(Node, etTitle);
  if not Assigned(en) then
    exit;

  cp := IChapterTitle(en.Ptr);
  m_TitelEditform.TitelText := cp.Text;
  if m_TitelEditform.ShowModal = mrOk then
  begin
    cp.Text := m_TitelEditform.TitelText;
    m_proto.Chapter.saveChangedChapter;

    updateCpList;
    m_proto.Modified := true;
  end;
end;

procedure TProtocolFrame.ac_edit_contentExecute(Sender: TObject);
var
  cp: IChapterTitle;
  Node: TTreeNode;
  en: TEntry;
begin
  Node := TV.Selected;
  if (Node = NIL) then
    exit;

  en := findNode(Node, etTitle);
  if not Assigned(en) then
    exit;

  cp := IChapterTitle(en.Ptr);

  if m_proto.Modified then
  begin
    m_proto.saveTree;
  end;

  Application.CreateForm(TChapterContentForm, ChapterContentForm);
  ChapterContentForm.ChapterTitle := cp;
  if ChapterContentForm.ShowModal = mrOk then
  begin
    m_proto.Chapter.updateChapter(cp);
    updateCpList;
  end;
  ChapterContentForm.Free;
end;

procedure TProtocolFrame.ac_edit_taskExecute(Sender: TObject);
var
  cp : IChapter;
  en : TEntry;
  ChapterEditForm : TChapterEditForm;
  upd : boolean;
begin
  if not Assigned(TV.Selected) then
    exit;

  en := TEntry( TV.Selected.Data );
  cp := IChapter(en.ptr);

  if  en.Typ =  etChapterText then begin
    Application.CreateForm(TChapterEditForm, ChapterEditForm);
    ChapterEditForm.CP := cp;
    upd := (ChapterEditForm.ShowModal = mrOk);
    ChapterEditForm.Free;
  end
  else
  begin
    Application.CreateForm(TChapterTaskForm, ChapterTaskForm);
    ChapterTaskForm.CP := cp;
    upd :=  (ChapterTaskForm.ShowModal = mrok);
    ChapterTaskForm.Free;
  end;

  TVChange( self, TV.Selected);
  if upd then
  begin
    updateCpList
  end;


end;

procedure TProtocolFrame.ac_upExecute(Sender: TObject);
var
  cp: IChapterTitle;
  Node: TTreeNode;
  en: TEntry;
begin
  Node := TV.Selected;
  if (Node = NIL) then
    exit;

  en := findNode(Node, etTitle);
  if not Assigned(en) then
    exit;

  cp := IChapterTitle(en.Ptr);
  cp.up;

  updateCpList;

  m_proto.Chapter.saveChangedChapter;
  m_proto.Modified := true;
end;

procedure TProtocolFrame.buildTree(root: TTreeNode; ct: IChapterTitle);
  procedure setInx(Node: TTreeNode; inx: integer);
  begin
    Node.SelectedIndex  := inx;
    Node.ImageIndex     := inx;
  end;

  procedure addVotes(root: TTreeNode; cp: IChapter);
  var
    j: integer;
    en: TEntry;
    sub: TTreeNode;
    be: IBeschluss;
  begin
    for j := 0 to pred(cp.Votes.Count) do
    begin
      be := cp.Votes.Item[j];
      en := TEntry.create(be);

      sub := TV.Items.AddChildObject(root, 'Beschluss: ' + be.Titel, en);
      case be.Status of
        bsGeplant:
          setInx(sub, 6);
        bsZugestimmt:
          setInx(sub, 3);
        bsAbgelehnt:
          setInx(sub, 4);
        bsWarten:
          setInx(sub, 5);
      end;
    end;
  end;

  procedure add(root: TTreeNode; Items: IChapterList);
  var
    j: integer;
    Node: TTreeNode;
    cp: IChapter;
    en: TEntry;
  begin
    for j := 0 to pred(Items.Count) do
    begin
      cp := Items.Items[j];
      en := TEntry.create(cp);
      Node := TV.Items.AddChildObject(root, cp.fullTitle, en);
      if Items.Items[j].TAID > 0 then
        setInx(Node, 1)
      else
        setInx(Node, 2);
      addVotes(Node, cp);
      add(Node, Items.Items[j].Childs);
    end;
  end;

begin
  if ct.root.Childs.Count = 0 then
    exit;

  add(root, ct.root.Childs);
  root.Expand(true);
end;

procedure TProtocolFrame.clearTree;
var
  i: integer;
begin
  for i := 0 to pred(TV.Items.Count) do
  begin
    if Assigned(TV.Items.Item[i].Data) then
    begin
      TEntry(TV.Items.Item[i].Data).Free;
      TV.Items.Item[i].Data := NIL;
    end;
  end;
  TV.Items.Clear;
end;

function TProtocolFrame.findNode(Node: TTreeNode; Typ: TEntryType): TEntry;
var
  en: TEntry;
begin
  Result := NIL;

  while Assigned(Node) do
  begin
    en := TEntry(Node.Data);
    if en.Typ = Typ then
    begin
      Result := en;
      break;
    end;
    Node := Node.Parent;
  end;
end;

function TProtocolFrame.GetProtocol: IProtocol;
begin
  Result := m_proto;
end;

function TProtocolFrame.GetReadOnly: boolean;
begin
  Result := m_ro;
end;

procedure TProtocolFrame.init;
begin
  FBrowser    := NIL;
  m_proto     := NIL;
  m_renderer  := TProtocolRenderer.create;
  m_loader    := TTaskLoaderMod.create(self);
  TV.Images   := GM.ImageList2;
  FonBeschlusChange := NIL;
  FMeetingMode:= false;

  m_renderer.Loader := m_loader;

  Application.CreateForm(TTitelEditform, m_TitelEditform);

  SetReadOnly( true );
  updateSeedBtn(self, 1);
end;

procedure TProtocolFrame.release;
begin
  m_proto := NIL;
  m_renderer.Free;
  cleartree;
end;

procedure TProtocolFrame.restoreSelected;
var
  i : integer;
  en : TEntry;
begin
  if Assigned(TV.Selected) or ( ( m_sel_type <> etNothing) and (m_sel_id = 0) ) then
    exit;

  for i := 0 to pred(tv.Items.Count) do begin
    en := TEntry( tv.Items.Item[i].Data);

    if Assigned(en) then begin
      if en.Typ = m_sel_type then begin
        case en.Typ of
          etNothing:      TV.Selected := tv.Items.Item[i];
          etChapterText:  if IChapter(en.Ptr).ID = m_sel_id       then TV.Selected := tv.Items.Item[i];
          etTask:         if IChapter(en.Ptr).ID = m_sel_id       then TV.Selected := tv.Items.Item[i];
          etBeschluss:    if IBeschluss(en.Ptr).ID = m_sel_id     then TV.Selected := tv.Items.Item[i];
          etTitle:        if IChapterTitle(en.Ptr).ID = m_sel_id  then TV.Selected := tv.Items.Item[i];
        end;
      end;
    end;
    if Assigned(tv.Selected) then
      break;
  end;
  //showContent;
end;

procedure TProtocolFrame.saveSelected;
var
  en : TEntry;
begin
  m_sel_id    := 0;
  m_sel_type  := etNothing;

  if not Assigned(Tv.Selected) or not Assigned( TV.Selected.Data) then
    exit;

  en := TEntry(TV.Selected.Data);

  m_sel_type := en.Typ;
  case en.Typ of
    etNothing     : m_sel_id  := 0;
    etChapterText : m_sel_id  := IChapter(en.Ptr).ID;
    etTask        : m_sel_id  := IChapter(en.Ptr).ID;
    etBeschluss   : m_sel_id  := IBeschluss(en.Ptr).ID;
    etTitle       : m_sel_id  := IChapterTitle(en.Ptr).ID;
  end;

end;

procedure TProtocolFrame.SetProtocol(const Value: IProtocol);
begin
  saveSelected;

  m_proto := value;
  updateCpList;

  restoreSelected;

end;

procedure TProtocolFrame.SetReadOnly(const Value: boolean);
begin
  m_ro := value;

  PageControl2.Enabled      := not m_ro;
  PageControl2.Visible      := not m_ro;

  ac_add.Enabled            := not m_ro;
  ac_edit.Enabled           := not m_ro;
  ac_edit_content.Enabled   := not m_ro;
  ac_delete.Enabled         := not m_ro;
  ac_up.Enabled             := not m_ro;
  ac_down.Enabled           := not m_ro;
  ac_beschluss.Enabled      := not m_ro;
  ac_be_bearbeiten.Enabled  := not m_ro;
  ac_be_delete.Enabled      := not m_ro;

  SpeedButton6.Enabled      := not m_ro;

end;

procedure TProtocolFrame.showContent;
var
  en: TEntry;
  procedure showBeschluss( be : IBeschluss );
  var
    cp : IChapter;
  begin

    m_proto.SyncUser( be, not FMeetingMode );

    cp := IChapter(be.Owner.Owner);
    m_renderer.renderChapter( cp, false );
    if not FMeetingMode then
      m_renderer.renderBeschluss(be);

    if Assigned(FonBeschlusChange) and FMeetingMode then
      FonBeschlusChange(be);
  end;

  procedure showChapter ( cp : IChapter );
  begin
    if (cp.Votes.Count = 1) then
      m_proto.SyncUser( cp.Votes.Item[0], not FMeetingMode );

    m_renderer.renderChapter( cp, FMeetingMode = false );

    if Assigned(FonBeschlusChange) and FMeetingMode and (cp.Votes.Count = 1) then
      FonBeschlusChange(cp.Votes.Item[0]);
  end;
begin
  if not Assigned(TV.Selected) or not Assigned(TV.Selected.Data) then
    exit;
  en := TEntry(TV.Selected.Data);

  if Assigned(FonBeschlusChange) and FMeetingMode then
    FonBeschlusChange(nil);

  m_renderer.renderStart;
  case en.Typ of
    etNothing:      m_renderer.renderProtocol(m_proto);
    etChapterText:  showChapter(IChapter(en.Ptr));
    etTask:         showChapter(IChapter(en.Ptr));
    etBeschluss:    showBeschluss(IBeschluss(en.Ptr));
    etTitle:        m_renderer.renderChapterTitle(IChapterTitle(en.Ptr));
  end;
  m_renderer.Show(FBrowser);
end;

procedure TProtocolFrame.TVChange(Sender: TObject; Node: TTreeNode);
begin
  showContent;
end;

procedure TProtocolFrame.TVCollapsing(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: Boolean);
begin
  AllowCollapse := false;
end;

procedure TProtocolFrame.TVDblClick(Sender: TObject);
var
  en : TEntry;
begin
  if m_ro  or not Assigned(tv.Selected) then
    exit;

  en := TEntry(TV.Selected.Data);
  case en.Typ of
    etChapterText : ac_edit_task.Execute;
    etTask        : ac_edit_task.Execute;
    etBeschluss   : ac_be_bearbeiten.Execute;
    etTitle       : ac_edit.Execute;
  end;
end;

procedure TProtocolFrame.updateCpList;
var
  cp, old: IChapterTitle;
  i: integer;
  Node: TTreeNode;
  root: TTreeNode;
  en: TEntry;

  procedure setIndex(Node: TTreeNode; inx: integer);
  begin
    Node.ImageIndex := inx;
    Node.SelectedIndex := inx;
  end;

begin
  old := NIL;
  Screen.Cursor := crHourGlass;
  TV.Items.BeginUpdate;
  try
    if Assigned(TV.Selected) and not Assigned(TV.Selected.Parent) then
    begin
      en  := TV.Selected.Data;
      old := IChapterTitle(en.Ptr);
    end;

    clearTree;

    en   := TEntry.create;
    root := TV.Items.AddChildObject(NIL, 'Dokument', en);
    setIndex(root, 7);

    for i := 0 to pred(m_proto.Chapter.Count) do
    begin
      cp := m_proto.Chapter.Items[i];
      en := TEntry.create(cp);
      Node := TV.Items.AddChildObject(root, cp.fullTitle, en);
      setIndex(Node, 0);

      buildTree(Node, cp);

      if cp = old then
        TV.Selected := Node;

    end;
  finally
    TV.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
  root.Expand(true);
end;

{ TProtocolFrame.TEntry }

constructor TProtocolFrame.TEntry.create;
begin
  FPtr := NIL;
  FTyp := etNothing;

end;

constructor TProtocolFrame.TEntry.create(cp: IChapterTitle);
begin
  FPtr := pointer(cp);
  FTyp := etTitle;

end;

constructor TProtocolFrame.TEntry.create(be: IBeschluss);
begin
  FPtr := pointer(be);
  FTyp := etBeschluss;
end;

constructor TProtocolFrame.TEntry.create(cp: IChapter);
begin
  FPtr := pointer(cp);
  if cp.TAID <> 0 then
    FTyp := etTask
  else
    FTyp := etChapterText;
end;

destructor TProtocolFrame.TEntry.Destroy;
begin
  FPtr := NIL;
  inherited;
end;

end.
