unit fr_chapter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, xsd_chapter,
  Datasnap.DBClient, Data.DB, Datasnap.DSConnect, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, u_chapter, Vcl.Buttons;

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
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    m_id   : integer;
    m_xCp  : IXMLChapter;
    m_root : TChapter;

    function GetCP_ID: integer;
    procedure SetCP_ID(const Value: integer);

    procedure loadFromClientBlob;
    procedure saveToclientBlob;

    procedure buildTree;
    procedure updateTree;
  public
    { Public-Deklarationen }
    property CP_ID: integer read GetCP_ID write SetCP_ID;
    procedure prepare;
    procedure Shutdown;
    procedure save;

  end;

implementation

uses
  m_glob_client, Xml.XMLIntf, Xml.XMLDoc, System.Generics.Collections,
  f_chapterEdit;

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
      if list[i].ID = cp.PID then
      begin
        list[i].add(cp);
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
begin
  m_root := TChapter.create(NIL);

  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  m_xCp := NewChapter;
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
  saveElements( m_root.Childs);

  st := ChapterTab.CreateBlobStream( ChapterTab.FieldByName('CP_BLOB'), bmWrite );
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

procedure TChapterFrame.Shutdown;
begin
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

procedure TChapterFrame.updateTree;
var
  old : TChapter;

  procedure add( root : TTreeNode; childs : TChapterList );
  var
    node : TTreeNode;
    i    : integer;
    cp   : TChapter;
  begin
    for i := 0 to pred(childs.Count) do
      begin
        cp := childs.Items[i];
        node := TV.Items.AddChildObject(root, cp.fullTitle, cp);
        if cp = old then
          TV.Selected := node;
        add( node, cp.Childs);
      end;
  end;

begin
  old := NIL;
  TV.Items.BeginUpdate;
  if Assigned(TV.Selected) then
    old := TV.Selected.Data;
  TV.Items.Clear;
  add( NIL, m_root.Childs );
  TV.Items.EndUpdate;
end;

end.
