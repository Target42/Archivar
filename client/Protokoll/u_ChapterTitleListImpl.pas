unit u_ChapterTitleListImpl;

interface

uses
  i_chapter, System.Generics.Collections;

type
  TChapterTitleListImpl = class( TInterfacedObject, IChapterTitleList )
    private
      m_list : TList<IChapterTitle>;
      function getIndex( cp : IChapterTitle) : integer;
      function getCount : integer;
      function getItem( inx : integer ) : IChapterTitle;
    public
      constructor Create;
      Destructor Destroy; override;

      procedure renumber;
      function NewEntry : IChapterTitle;

      procedure up( cp      : IChapterTitle );
      procedure down( cp    : IChapterTitle );
      procedure remove( cp  : IChapterTitle );

      procedure release;
  end;


implementation

uses
  System.SysUtils, u_ChapterTitleImpl;

constructor TChapterTitleListImpl.Create;
begin
  m_list := TList<IChapterTitle>.create;
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
  Result := TChapterTitleImpl.create(self);
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

end.
