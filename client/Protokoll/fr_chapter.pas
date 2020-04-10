unit fr_chapter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, xsd_chapter,
  Datasnap.DBClient, Data.DB, Datasnap.DSConnect, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, u_chapter, Vcl.Buttons, System.Generics.Collections,
  fr_taskList2, u_taskEntry;

type
  TChapterFrame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    ChapterTab: TClientDataSet;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    TV: TTreeView;
    Splitter1: TSplitter;
    SpeedButton8: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    GroupBox2: TGroupBox;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    TaskList2Frame1: TTaskList2Frame;
    Label2: TLabel;
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure TVDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TVDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TVDblClick(Sender: TObject);
    procedure TaskList2Frame1SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    m_id   : integer;
    m_xCp  : IXMLChapter;
    m_root : TChapter;
    m_cpList : TList<TChapter>;

    function GetCP_ID: integer;
    procedure SetCP_ID(const Value: integer);

    procedure loadFromClientBlob;
    procedure saveToclientBlob;

    procedure buildTree;
    procedure updateTree;

    procedure setTitle( value : string );
  public
    { Public-Deklarationen }
    property CP_ID: integer read GetCP_ID write SetCP_ID;
    property Title : string write setTitle;

    property xChapter : IXMLChapter read m_xCp;

    procedure prepare;
    procedure Shutdown;

    procedure save;
    procedure cancel;

    procedure doNewTaskEntry(Sender: TObject; var dataList : TEntryList);

  end;

implementation

uses
  m_glob_client, Xml.XMLIntf, Xml.XMLDoc,
  f_chapterEdit, u_gremium;

{$R *.dfm}

{ TChapterFrame }

procedure TChapterFrame.buildTree;
var
  i     : integer;
  cp    : TChapter;
  list  : TList<TChapter>;
  xTop  : IXMLTop;

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

begin
  list := TList<TChapter>.create;
  for i := 0 to pred(m_xCp.Top.Count) do
    begin
      cp := TChapter.create(NIL);
      xTop := m_xCp.Top.Items[i];

      cp.Name := xTop.Titel;
      cp.ID   := xTop.Id;
      cp.PID  := xTop.Pid;
      cp.Nr   := xTop.Nr;
      cp.Numbering  := xTop.Numbering;
      cp.TAID := xTop.Taid;
      list.Add(cp);
    end;
  for i := 0 to pred(list.Count) do
    begin
      addToParent(list[i]);
      if list[i].PID = 0 then
        m_root.add(list[i]);
    end;
  list.Clear;
  list.Free;
end;

procedure TChapterFrame.cancel;
begin
  if ChapterTab.State = dsEdit then
    ChapterTab.Cancel;
  if ChapterTab.UpdatesPending then
    ChapterTab.CancelUpdates;
end;

procedure TChapterFrame.ComboBox1Change(Sender: TObject);
var
  gr : TGremium;
begin
  if ComboBox1.ItemIndex = -1 then
    exit;

  gr := TGremium(ComboBox1.Items.Objects[ ComboBox1.ItemIndex]);
  TaskList2Frame1.GR_ID := gr.ID;
end;

procedure TChapterFrame.doNewTaskEntry(Sender: TObject; var dataList : TEntryList);
var
  i : integer;
  p, cp : TChapter;

begin
  p := m_root;
  if Assigned(TV.Selected) then
    p := TV.Selected.Data;

  for i := 0 to pred(dataList.Count) do
  begin
    cp            := p.newChapter;
    cp.Name       := dataList.Items[i].TaskName;
    cp.Numbering  := (p <> m_root);
    cp.TAID       := dataList.Items[i].TaskID;
  end;
  updateTree;
end;

function TChapterFrame.GetCP_ID: integer;
begin
  Result := m_id;
end;

procedure TChapterFrame.loadFromClientBlob;
var
  st : TStream;
  xml: IXMLDocument;
begin
  ChapterTab.FetchBlobs;
  st := ChapterTab.CreateBlobStream( ChapterTab.FieldByName('CP_DATA'), bmRead );
  if not Assigned(st) or ( st.Size = 0) then
  begin
    m_xCp := NewChapter;
  end
  else
  begin
    xml := NewXMLDocument;
    xml.LoadFromStream(st);
    m_xCp := xml.GetDocBinding('Chapter', TXMLChapter, TargetNamespace) as IXMLChapter;
  end;
  if Assigned(st) then
    st.Free;
  buildTree;
end;

procedure TChapterFrame.prepare;
var
  i : integer;
begin
  m_root  := TChapter.create(NIL);
  m_cpList:= TList<TChapter>.create;

  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  m_xCp := NewChapter;

  for i := 0 to pred(GM.Gremien.Count) do
  begin
    ComboBox1.Items.AddObject(GM.Gremien.Items[i].Name, GM.Gremien.Items[i]);
  end;
  TV.Images := GM.ImageList2;
  TaskList2Frame1.prepare;
  TaskList2Frame1.OnTaskEntry := doNewTaskEntry;
end;

procedure TChapterFrame.save;
begin
  saveToclientBlob;

  if ChapterTab.State = dsEdit then
    ChapterTab.Post;
  if ChapterTab.UpdatesPending then
    ChapterTab.ApplyUpdates(-1);
end;

procedure TChapterFrame.saveToclientBlob;
var
  st : TStream;
  procedure saveElements( root : TChapterList );
  var
    i : integer;
    cp: TChapter;
    xt : IXMLTop;
  begin
    for i := 0 to pred(root.Count) do
      begin
        xt := m_xCp.Top.Add;
        cp := root.Items[i];

        xt.Id       := cp.ID;
        xt.Pid      := cp.PID;
        xt.Titel    := cp.Name;
        xt.Nr       := cp.Nr;
        xt.Taid     := cp.TAID;
        xt.Numbering:= cp.Numbering;

        saveElements( cp.Childs);
      end;
  end;
begin
  m_xCp := NewChapter;
  m_root.reindex;
  saveElements( m_root.Childs);

  st := ChapterTab.CreateBlobStream( ChapterTab.FieldByName('CP_DATA'), bmWrite );
  m_xCp.OwnerDocument.SaveToStream(st);
  st.Free;
end;

procedure TChapterFrame.SetCP_ID(const Value: integer);
begin
  m_id := Value;

  if not ChapterTab.Active then
    ChapterTab.Open;

  m_root.Childs.clear;

  if ChapterTab.Locate('CP_ID', VarArrayOf([m_id]), []) then
  begin
    ChapterTab.Edit;
    loadFromClientBlob;
    updateTree;
  end
  else
  begin
    ChapterTab.ReadOnly := true;
    ShowMessage('Hauptkapitel nicht gefunden!');
  end;
end;

procedure TChapterFrame.setTitle(value: string);
begin
  Label2.Caption := value;
end;

procedure TChapterFrame.Shutdown;
begin
  TaskList2Frame1.shutdown;
  m_cpList.free;
  ChapterTab.Close;
  m_root.Free;
end;

procedure TChapterFrame.SpeedButton1Click(Sender: TObject);
var
  cp : TChapter;
  ChapterEditForm : TChapterEditForm;
begin
  cp := TChapter.create(NIL);

  Application.CreateForm(TChapterEditForm, ChapterEditForm);
  ChapterEditForm.CP := cp;
  if ChapterEditForm.ShowModal = mrOk then
  begin
    m_root.add(cp);
    TV.Items.AddChildObject(NIL, cp.fullTitle, cp);
  end
  else
    cp.Free;
  ChapterEditForm.Free;
end;

procedure TChapterFrame.SpeedButton2Click(Sender: TObject);
var
  cp : TChapter;
  ChapterEditForm : TChapterEditForm;
begin
  if not Assigned(TV.Selected) then
    exit;
  cp := TV.Selected.Data;
  Application.CreateForm(TChapterEditForm, ChapterEditForm);
  ChapterEditForm.CP := cp;
  if ChapterEditForm.ShowModal = mrOk then
  begin
    updateTree
  end;
  ChapterEditForm.Free;
end;

procedure TChapterFrame.SpeedButton3Click(Sender: TObject);
var
  cp : TChapter;
begin
  if not Assigned(TV.Selected) then
    exit;
  cp := TV.Selected.Data;
  cp.Owner.remove(cp);
  cp.Free;
  updateTree;
end;

procedure TChapterFrame.SpeedButton4Click(Sender: TObject);
var
  cp : TChapter;
begin
  if not Assigned(TV.Selected) then
    exit;

  cp := TV.Selected.Data;
  cp.up;
  updateTree;
end;


procedure TChapterFrame.SpeedButton5Click(Sender: TObject);
var
  cp : TChapter;
begin
  if not Assigned(TV.Selected) then
    exit;

  cp := TV.Selected.Data;
  cp.down;
  updateTree;
end;

procedure TChapterFrame.SpeedButton6Click(Sender: TObject);
var
  cp : TChapter;
  p  : TChapter;
begin
  if not Assigned(TV.Selected) then
    exit;
  cp := TV.Selected.Data;
  if cp.Owner = m_root then
    exit;

  p := cp.Owner.Owner;
  cp.Owner.remove(cp);
  p.add(cp);

  updateTree;
end;

procedure TChapterFrame.SpeedButton7Click(Sender: TObject);
var
  prev  : TChapter;
  cp    : TChapter;
  i     : integer;
begin
  if not Assigned(TV.Selected) then
    exit;

  cp := TV.Selected.Data;
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
    updateTree
  end;
end;

procedure TChapterFrame.SpeedButton8Click(Sender: TObject);
var
 p : TChapter;
 cp : TChapter;
begin
  p := m_root;
  if Assigned(TV.Selected) then
    p := TV.Selected.Data;

  cp := p.newChapter;
  TV.Items.AddChildObject(TV.Selected, cp.fullTitle, cp);
  if Assigned(TV.Selected) then
    TV.Selected.Expand(false);
end;

procedure TChapterFrame.TaskList2Frame1SpeedButton2Click(Sender: TObject);
begin
  TaskList2Frame1.SpeedButton2Click(Sender);

end;

procedure TChapterFrame.TVDblClick(Sender: TObject);
begin
  SpeedButton2.Click;
end;

procedure TChapterFrame.TVDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  src   : TListView;
  cp, p : TChapter;
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
        cp := m_root.newChapter
      else
      begin
        p := node.Data;
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

    cp := TV.Selected.Data;
    cp.Owner.remove(cp);

    if not Assigned(node) then
      m_root.add(cp)
    else
    begin
      p := node.Data;
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
  old : TChapter;

  procedure add( root : TTreeNode; childs : TChapterList );
  var
    node : TTreeNode;
    i    : integer;
    cp   : TChapter;
    inx   : integer;
  begin
    for i := 0 to pred(childs.Count) do
      begin
        cp := childs.Items[i];
        m_cpList.add(cp);
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
  m_cpList.Clear;
  TV.Items.BeginUpdate;
  if Assigned(TV.Selected) then
    old := TV.Selected.Data;
  TV.Items.Clear;
  add( NIL, m_root.Childs );
  TV.Items.EndUpdate;
end;

end.
