unit u_ChapterTitleListImpl;

interface

uses
  i_chapter, System.Generics.Collections, m_protocol;

type
  TChapterTitleListImpl = class( TInterfacedObject, IChapterTitleList )
    private
      m_proto   : IProtocol;
      m_loader  : TProtocolMod;
      m_list    : TList<IChapterTitle>;

      function getIndex( cp : IChapterTitle) : integer;
      function getCount : integer;
      function getItem( inx : integer ) : IChapterTitle;
    public
      constructor Create(loader : TProtocolMod; proto : IProtocol);
      Destructor Destroy; override;

      procedure renumber;
      function NewEntry : IChapterTitle;

      procedure up( cp      : IChapterTitle );
      procedure down( cp    : IChapterTitle );
      procedure remove( cp  : IChapterTitle );

      procedure saveChangedChapter;
      procedure AddNewChaper( cp : IChapterTitle);
      procedure updateChapter( cp : IChapterTitle );

      function findChapter( id : integer ) : IChapter;
      procedure clearModified;

      procedure release;
  end;


implementation

uses
  System.SysUtils, u_ChapterTitleImpl, m_glob_client;

procedure TChapterTitleListImpl.AddNewChaper(cp: IChapterTitle);
begin
  cp.ID := GM.autoInc('gen_cp_id');
  with m_loader do
  begin
    CPTab.Append;
    CPTab.FieldByName('PR_ID').AsInteger        := m_proto.ID;
    CPTab.FieldByName('CP_ID').AsInteger        := cp.ID;
    CPTab.FieldByName('CP_TITLE').AsString      := cp.Text;
    CPTab.FieldByName('CP_NR').AsInteger        := cp.Nr;
    CPTab.FieldByName('CP_CREATED').AsDateTime  := cp.TimeStamp;
    CPTab.Post;
  end;
end;

procedure TChapterTitleListImpl.clearModified;
var
  cpt : IChapterTitle;
begin
  for cpt in  m_list do
    cpt.clearModified;
end;

constructor TChapterTitleListImpl.Create(loader : TProtocolMod; proto : IProtocol);
begin
  m_proto   := proto;
  m_loader  := loader;
  m_list    := TList<IChapterTitle>.create;
end;

destructor TChapterTitleListImpl.Destroy;
begin
  FreeAndNil( m_list);

  inherited;
end;

procedure TChapterTitleListImpl.down(cp: iChapterTitle);
var
  inx : integer;
begin
  inx := getIndex(cp);
  if inx = m_list.Count-1 then
    exit;

  m_list[inx+1].Modified := true;
  m_list[inx].Modified := true;

  m_list.Exchange(inx, inx+1);
  renumber;
end;

function TChapterTitleListImpl.findChapter(id: integer): IChapter;
var
  cpt : IChapterTitle;
  i   : integer;
begin
  Result := NIL;

  for cpt in m_list do begin
    for i := 0 to pred(cpt.Count) do begin
      Result := cpt.Item[i].findChapter(id);
      if Assigned(Result) then
        break;
    end;
    if Assigned(Result) then
      break;
  end;
end;

function TChapterTitleListImpl.getCount: integer;
begin
  Result := m_list.Count;
end;

function TChapterTitleListImpl.getIndex(cp: IChapterTitle): integer;
var
  i : integer;
begin
  Result := -1;
  for i := 0 to pred(m_list.Count) do
  begin
    if m_list[i] = cp then
    begin
      Result := i;
      break;
    end;
  end;
end;

function TChapterTitleListImpl.getItem(inx: integer): IChapterTitle;
begin
  Result := m_list[inx];
end;

function TChapterTitleListImpl.NewEntry: IChapterTitle;
begin
  Result := TChapterTitleImpl.create(self, m_loader, m_proto);
  m_list.Add(Result);
  renumber;
  Result.Text := 'Titel '+IntToStr(Result.Nr);
end;

procedure TChapterTitleListImpl.release;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
    m_list[i].release;
  m_list.Clear;
  m_proto := NIL;
end;

procedure TChapterTitleListImpl.remove(cp: IChapterTitle);
var
  inx : Integer;
begin
  inx := getIndex(cp);
  m_list.Delete(inx);
  renumber;
end;

procedure TChapterTitleListImpl.renumber;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
  begin
     m_list[i].Modified := m_list[i].Nr <> (i+1);
    m_list[i].Nr := i + 1;
  end;
end;

procedure TChapterTitleListImpl.saveChangedChapter;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
    begin
      if m_list.Items[i].Modified then
      begin
        m_loader.UpdateCPQry.ParamByName('CP_ID').AsInteger  := m_list.Items[i].ID;
        m_loader.UpdateCPQry.ParamByName('CP_NR').AsInteger  := m_list.Items[i].Nr;
        m_loader.UpdateCPQry.ParamByName('CP_TITLE').AsString:= m_list.Items[i].Text;
        m_loader.UpdateCPQry.Execute;
        m_list.Items[i].Modified := false;
      end;

      m_loader.CPTextTab.Filter := 'CP_ID='+intToStr(m_list.Items[i].ID);
      m_loader.CPTextTab.Filtered := true;

      m_list.Items[i].Save;
    end;
end;

procedure TChapterTitleListImpl.up(cp: IChapterTitle);
var
  inx : integer;
begin
  inx := getIndex(cp);
  if inx = 0 then
    exit;

  m_list[inx-1].Modified := true;
  m_list[inx].Modified := true;

  m_list.Exchange(inx-1, inx);

  renumber;
end;

procedure TChapterTitleListImpl.updateChapter(cp: IChapterTitle);
begin
  with m_loader do
  begin
    CPTextTab.Refresh;
    CPTextTab.Filter := 'CP_ID='+intToStr(cp.ID);
    CPTextTab.Filtered := true;

    cp.Root.Childs.clear;
    cp.loadFromDataSet(CPTextTab, BETab);
  end;
end;

end.
