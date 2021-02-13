unit fr_chapter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, xsd_chapter,
  Datasnap.DBClient, Data.DB, Datasnap.DSConnect, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, System.Generics.Collections,
  fr_taskList2, u_taskEntry, i_chapter, Data.SqlExpr, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Menus;

type
  TChapterFrame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    ChapterTab: TClientDataSet;
    GroupBox1: TGroupBox;
    TV: TTreeView;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    TaskList2Frame1: TTaskList2Frame;
    Label2: TLabel;
    ActionList1: TActionList;
    ac_new_chapter: TAction;
    ac_edit_chapter: TAction;
    ImageList1: TImageList;
    ac_sub_chapter: TAction;
    ac_del_chapter: TAction;
    ac_chapter_up: TAction;
    ac_chapter_down: TAction;
    ac_chapter_left: TAction;
    ac_chapter_right: TAction;
    PopupMenu1: TPopupMenu;
    NeuesKapitel1: TMenuItem;
    Kapitelbearbeiten1: TMenuItem;
    Unterkapitel1: TMenuItem;
    N1: TMenuItem;
    Kapitellschen1: TMenuItem;
    N2: TMenuItem;
    Kapitelhoch1: TMenuItem;
    Kapitelrunter1: TMenuItem;
    Kapitelausrcken1: TMenuItem;
    Kapiteleinrcken1: TMenuItem;
    ChapterTextTab: TClientDataSet;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton7: TSpeedButton;
    BitBtn1: TBitBtn;
    procedure ComboBox1Change(Sender: TObject);
    procedure TVDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TVDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TVDblClick(Sender: TObject);
    procedure ac_new_chapterExecute(Sender: TObject);
    procedure ac_edit_chapterExecute(Sender: TObject);
    procedure ac_sub_chapterExecute(Sender: TObject);
    procedure ac_del_chapterExecute(Sender: TObject);
    procedure ac_chapter_upExecute(Sender: TObject);
    procedure ac_chapter_downExecute(Sender: TObject);
    procedure ac_chapter_leftExecute(Sender: TObject);
    procedure ac_chapter_rightExecute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    m_ct : IChapterTitle;


    procedure updateTree;

    procedure setChapter( value : IChapterTitle );

    procedure saveCP( cp : IChapter; append : boolean = false );

  public
    { Public-Deklarationen }
    property Chapter : IChapterTitle read m_ct write setChapter;

    procedure prepare(con : TSQLConnection);
    procedure Shutdown;

    procedure save;
    procedure cancel;

    procedure doNewTaskEntry(Sender: TObject; var dataList : TEntryList);

  end;

implementation

uses
  m_glob_client, Xml.XMLIntf, Xml.XMLDoc,
  f_chapterEdit, u_gremium, f_chapterTask, u_ChapterImpl;

{$R *.dfm}

{ TChapterFrame }

procedure TChapterFrame.ac_chapter_downExecute(Sender: TObject);
var
  cp : IChapter;
begin
  if not Assigned(TV.Selected) then
    exit;

  cp := IChapter(TV.Selected.Data);
  cp.down;
  updateTree;
end;

procedure TChapterFrame.ac_chapter_leftExecute(Sender: TObject);
var
  cp : IChapter;
  p  : IChapter;
begin
  if not Assigned(TV.Selected) then
    exit;
  cp := IChapter(TV.Selected.Data);
  if cp.Owner = m_ct.Root then
    exit;

  p := cp.Owner.Owner;
  cp.Owner.remove(cp);
  p.add(cp);
  cp.Modified := true;

  updateTree;
end;

procedure TChapterFrame.ac_chapter_rightExecute(Sender: TObject);
var
  prev  : IChapter;
  cp    : IChapter;
  i     : integer;
begin
  if not Assigned(TV.Selected) then
    exit;

  cp := IChapter(TV.Selected.Data);
  prev := NIL;

  for i := 1 to pred(cp.Owner.Childs.Count) do
  begin
    if cp.Owner.Childs.Items[i] = cp  then
    begin
      prev := cp.Owner.Childs.Items[i-1];
      break;
    end;
  end;

  if Assigned(prev) then
  begin
    cp.Owner.Childs.remove(cp);
    prev.add(cp);
    cp.Modified := true;
    updateTree
  end;
end;

procedure TChapterFrame.ac_chapter_upExecute(Sender: TObject);
var
  cp : IChapter;
begin
  if not Assigned(TV.Selected) then
    exit;

  cp := IChapter(TV.Selected.Data);
  cp.up;
  updateTree;
end;

procedure TChapterFrame.ac_del_chapterExecute(Sender: TObject);
var
  cp : IChapter;
begin
  if not Assigned(TV.Selected) then
    exit;
  cp := IChapter(TV.Selected.Data);
  cp.Owner.remove(cp);
  cp.release;
  updateTree;
end;

procedure TChapterFrame.ac_edit_chapterExecute(Sender: TObject);
var
  cp : IChapter;
  ChapterEditForm : TChapterEditForm;
begin
  if not Assigned(TV.Selected) then
    exit;
  cp := IChapter(TV.Selected.Data);

  if cp.TAID = 0 then begin
    Application.CreateForm(TChapterEditForm, ChapterEditForm);
    ChapterEditForm.CP := cp;
    if ChapterEditForm.ShowModal = mrOk then
    begin
      saveCP(cp);
      updateTree
    end;
    ChapterEditForm.Free;
  end
  else
  begin
    Application.CreateForm(TChapterTaskForm, ChapterTaskForm);
    ChapterTaskForm.CP := cp;
    if ChapterTaskForm.ShowModal = mrok then
    begin
      saveCP(cp);
      updateTree;
    end;
    ChapterTaskForm.Free;
  end;
end;

procedure TChapterFrame.ac_new_chapterExecute(Sender: TObject);
var
  cp, p : IChapter;
  ChapterEditForm : TChapterEditForm;
  node : TTreeNode;
begin
  p := m_ct.Root;
  if Assigned(TV.Selected) then
    p := IChapter(TV.Selected.Data);

  cp := p.newChapter;

  Application.CreateForm(TChapterEditForm, ChapterEditForm);
  ChapterEditForm.CP := cp;
  if ChapterEditForm.ShowModal = mrOk then
  begin
    node := TV.Items.AddChildObject(NIL, cp.fullTitle, cp);
    node.SelectedIndex := 2;
    node.ImageIndex    := 2;

    saveCP(cp, true);

  end
  else
    p.remove(cp);

  ChapterEditForm.Free;
end;

procedure TChapterFrame.ac_sub_chapterExecute(Sender: TObject);
var
 p : IChapter;
 cp : IChapter;
 node : TTreeNode;
begin
  p := m_ct.Root;
  if Assigned(TV.Selected) then
    p := IChapter(TV.Selected.Data);

  cp := p.newChapter;
  saveCP(cp, true);

  node := TV.Items.AddChildObject(TV.Selected, cp.fullTitle, cp);
    node.SelectedIndex := 2;
    node.ImageIndex    := 2;

  if Assigned(TV.Selected) then
    TV.Selected.Expand(false);
end;

procedure TChapterFrame.BitBtn1Click(Sender: TObject);
begin
  TaskList2Frame1.ShowFilterDlg;
end;

procedure TChapterFrame.cancel;
begin
  if ChapterTab.State = dsEdit then
    ChapterTab.Cancel;

  if ChapterTab.UpdatesPending then
    ChapterTab.CancelUpdates;

  if ChapterTextTab.UpdatesPending then
    ChapterTextTab.CancelUpdates;
end;

procedure TChapterFrame.ComboBox1Change(Sender: TObject);
var
  gr : TGremium;
begin
  if ComboBox1.ItemIndex = -1 then
     TaskList2Frame1.GR_ID :=  0
  else
  begin
    gr := TGremium(ComboBox1.Items.Objects[ ComboBox1.ItemIndex]);
    if not Assigned(gr) then
      TaskList2Frame1.GR_ID :=  0
    else
      TaskList2Frame1.GR_ID := gr.ID;
  end;
end;

procedure TChapterFrame.doNewTaskEntry(Sender: TObject; var dataList : TEntryList);
var
  i : integer;
  p, cp : IChapter;

begin
  p := m_ct.Root;
  if Assigned(TV.Selected) then
    p := IChapter(TV.Selected.Data);

  for i := 0 to pred(dataList.Count) do
  begin
    if not m_ct.root.hasID(dataList.Items[i].TaskID) then
    begin
      cp            := p.newChapter;
      cp.Name       := dataList.Items[i].TaskName;
      cp.Numbering  := (p <> m_ct.Root);
      cp.TAID       := dataList.Items[i].TaskID;

      saveCP(cp, true);
    end;
  end;
  updateTree;
end;

procedure TChapterFrame.prepare(con : TSQLConnection );
var
  i : integer;
begin
  PageControl1.ActivePage := TabSheet1;
  m_ct  := NIL;
  if Assigned(con) then
    DSProviderConnection1.SQLConnection := con
  else
    DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  ComboBox1.Items.Add('');
  for i := 0 to pred(GM.Gremien.Count) do
  begin
    ComboBox1.Items.AddObject(GM.Gremien.Items[i].Name, GM.Gremien.Items[i]);
  end;
  TV.Images := GM.ImageList2;
  TaskList2Frame1.prepare;
  TaskList2Frame1.OnTaskEntry := doNewTaskEntry;
end;

procedure TChapterFrame.save;
  procedure saveChilds( list : IChapterList );
  var
    i : integer;
  begin
    for i := 0 to pred(list.Count) do
    begin
      if list.Items[i].Modified then
        saveCP(list.Items[i]);

      saveChilds(list.Items[i].Childs);
    end;
  end;

begin
  m_ct.Root.reindex;
  saveChilds(m_ct.Root.Childs);

  if ChapterTextTab.UpdatesPending then
    ChapterTextTab.ApplyUpdates(-1);

  if ChapterTab.State = dsEdit then
    ChapterTab.Post;
  if ChapterTab.UpdatesPending then
    ChapterTab.ApplyUpdates(-1);

end;

procedure TChapterFrame.saveCP(cp: IChapter; append: boolean);
begin
  if append then
  begin
    if cp.ID = 0 then
      cp.ID := GM.autoInc('GEN_CT_ID');

    ChapterTextTab.Append;
    ChapterTextTab.FieldByName('CP_ID').AsInteger     := m_ct.ID;
    ChapterTextTab.FieldByName('CT_ID').AsInteger     := cp.ID;
  end
  else
  begin
    ChapterTextTab.Locate('CT_ID', VarArrayOf([cp.ID]), []);
    ChapterTextTab.Edit;
  end;

  ChapterTextTab.FieldByName('ct_parent').AsInteger := cp.PID;
  ChapterTextTab.FieldByName('CT_NUMBER').AsInteger := cp.Nr;
  ChapterTextTab.FieldByName('CT_TITLE').AsString   := cp.Name;
  ChapterTextTab.FieldByName('CT_POS').AsInteger    := cp.Pos;
  ChapterTextTab.FieldByName('CT_DATA').AsString    := cp.Rem;

  if cp.TAID <> 0 then
    ChapterTextTab.FieldByName('TA_ID').AsInteger     := cp.TAID
  else
    ChapterTextTab.FieldByName('TA_ID').Clear;

  ChapterTextTab.Post;

  cp.Modified := false;

end;

procedure TChapterFrame.setChapter(value: IChapterTitle);
begin
  m_ct := value;
  Label2.Caption := m_ct.FullTitle;

  updateTree;

  TaskList2Frame1.GR_ID :=  0;

  ChapterTab.Open;
  if ChapterTab.Locate('CP_ID', VarArrayOf([m_ct.ID]), []) then
    ChapterTab.Edit;

  ChapterTextTab.Filter   := 'CP_ID='+IntToStr(m_ct.ID);
  ChapterTextTab.Filtered := true;
  ChapterTextTab.Open;

end;

procedure TChapterFrame.Shutdown;
begin
  TaskList2Frame1.shutdown;
  ChapterTab.Close;
end;

procedure TChapterFrame.TVDblClick(Sender: TObject);
begin
  ac_edit_chapter.Execute;
end;

procedure TChapterFrame.TVDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  src   : TListView;
  cp, p : IChapter;
  node  : TTreeNode;
  entry : TTaskEntry;
  i     : integer;
begin
  node := TV.GetNodeAt(X, Y);

  if (Sender = TV) and ( Source = TaskList2Frame1.LV) then
  begin
    src  := Source as TListView;

    for i := 0 to pred(src.Items.Count) do
    begin
      if not src.Items.Item[i].Selected then
        Continue;

      if not Assigned( node ) then
        cp := m_ct.Root.newChapter
      else
      begin
        p := IChapter(node.Data);
        cp := p.newChapter;
        cp.Numbering := false;
      end;
      entry := src.Items.Item[i].Data;
      cp.Name := entry.TaskName;
      cp.Data := entry;
    end;
    updateTree;
  end;

  if (Sender = Source) and ( Sender = TV) then
  begin
    if node = TV.Selected then
      exit;

    cp := IChapter(TV.Selected.Data);
    cp.Owner.remove(cp);

    if not Assigned(node) then
      m_ct.Root.add(cp)
    else
    begin
      p := IChapter(node.Data);
      p.add(cp);
    end;
    updateTree;
  end;
end;

procedure TChapterFrame.TVDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;

procedure TChapterFrame.updateTree;
var
  old : IChapter;

  procedure add( root : TTreeNode; childs : IChapterList );
  var
    node : TTreeNode;
    i    : integer;
    cp   : IChapter;
    inx   : integer;
  begin
    for i := 0 to pred(childs.Count) do
      begin
        cp := childs.Items[i];
        node := TV.Items.AddChildObject(root, cp.fullTitle, cp);
        inx := 2;
        if cp.TAID > 0 then
          inx := 1;
        node.SelectedIndex := inx;
        node.ImageIndex    := inx;

        if cp = old then
          TV.Selected := node;
        add( node, cp.Childs);
        if not Assigned(root) then
          node.Expand(true);
      end;
  end;

begin
  old := NIL;
  TV.Items.BeginUpdate;
  if Assigned(TV.Selected) then
    old := IChapter(TV.Selected.Data);
  TV.Items.Clear;
  add( NIL, m_ct.Root.Childs );
  TV.Items.EndUpdate;
end;

end.
