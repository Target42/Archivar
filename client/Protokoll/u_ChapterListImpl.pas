unit u_ChapterListImpl;

interface

uses
  i_chapter, System.Generics.Collections;

type
  TChapterListImpl = class(TInterfacedObject, IChapterList)
    private
      m_list : TList<IChapter>;
      function getCount : integer;
      procedure setItem( inx : integer ; const value : IChapter );
      function  getItem( inx : integer ) : IChapter;

      function findIndex( cp : IChapter ) : integer;

    public
      constructor create;
      Destructor Destroy; override;

      property Count : integer read getCount;
      property Items[inx : integer] : IChapter read getItem write setItem;

      procedure clear;

      procedure up(     cp : IChapter);
      procedure down(   cp : IChapter );
      procedure remove( cp : IChapter );
      procedure Delete( cp : IChapter );
      procedure add(    cp : IChapter );

      function findMax : integer;

      procedure renumber;

      procedure release;
  end;


implementation

procedure TChapterListImpl.add(cp: IChapter);
begin
  if not m_list.Contains(cp) then
    m_list.Add(cp);
end;

procedure TChapterListImpl.clear;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
    m_list[i].release;
  m_list.Clear;
end;

constructor TChapterListImpl.create;
begin
  m_list := TList<IChapter>.Create;
end;

procedure TChapterListImpl.Delete(cp: IChapter);
begin
  remove( cp );
  cp.release;
end;

destructor TChapterListImpl.Destroy;
begin
  clear;
  m_list.Free;
  inherited;
end;

procedure TChapterListImpl.down(cp: IChapter);
var
  inx : integer;
begin
  inx := findIndex(cp);
  if inx = m_list.Count-1 then
    exit;

  m_list.Exchange( inx, inx +1 );
  renumber;
end;

function TChapterListImpl.findIndex(cp: IChapter): integer;
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

function TChapterListImpl.findMax: integer;
var
  i : integer;
begin
  Result := 0;
  for i := 0 to pred(m_list.Count) do
    if m_list[i].Nr > Result then
      Result := m_list[i].Nr;

end;

function TChapterListImpl.getCount: integer;
begin
  Result := m_list.Count;
end;

function TChapterListImpl.getItem(inx: integer): IChapter;
begin
  Result := m_list[inx];
end;

procedure TChapterListImpl.release;
begin

end;

procedure TChapterListImpl.remove(cp: IChapter);
var
  inx : Integer;
begin
  inx := findIndex(cp);
  if inx <> -1 then
    m_list.Remove(cp);
  renumber;
end;

procedure TChapterListImpl.renumber;
var
  i, j : Integer;
begin
  j := 1;
  for i := 0 to pred(m_list.Count) do
    begin
      if m_list[i].Numbering then
      begin
        m_list[i].Nr := j;
        inc(j);
      end;
    end;
end;

procedure TChapterListImpl.setItem(inx: integer; const value: IChapter);
begin
  m_list[inx] := value;
end;

procedure TChapterListImpl.up(cp: IChapter);
var
  inx : integer;
begin
  inx := findIndex(cp);
  if inx = 0 then
    exit;

  m_list.Exchange( inx, inx -1 );
  renumber;
end;

end.
