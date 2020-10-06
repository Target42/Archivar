unit u_chapter;

interface

uses
  System.Generics.Collections;

type
  TChapter = class;
  TChapterList = class;

  TChapterList = class
    private
      m_list : TList<TChapter>;
      function getCount : integer;
      procedure setItem( inx : integer ; const value : TChapter );
      function  getItem( inx : integer ) : TChapter;

      function findIndex( cp : TChapter ) : integer;

    public
      constructor create;
      Destructor Destroy; override;

      property Count : integer read getCount;
      property Items[inx : integer] : TChapter read getItem write setItem;

      procedure clear;

      procedure up( cp : TChapter);
      procedure down(cp : TChapter );
      procedure remove( cp : TChapter );
      procedure Delete(  cp : TChapter );
      procedure add(  cp : TChapter );

      function findMax : integer;

      procedure renumber;
  end;

  TChapter = class
    private
      m_childs : TChapterList;
      m_owner  : TChapter;
      FName: string;
      FID: integer;
      FPID: integer;
      FNr: integer;
      FNumbering: boolean;
      FTAID: integer;
      FData: Pointer;
      FRem: String;
    public
      constructor create(owner : TChapter);
      Destructor Destroy; override;

      property Owner : TChapter read m_owner write m_owner;
      property Childs : TChapterList read m_childs;
      property Name: string read FName write FName;
      property ID: integer read FID write FID;
      property PID: integer read FPID write FPID;
      property Nr: integer read FNr write FNr;
      property Numbering: boolean read FNumbering write FNumbering;
      property TAID: integer read FTAID write FTAID;
      property Data: Pointer read FData write FData;
      property Rem: String read FRem write FRem;

      procedure up;
      procedure down;

      procedure add( cp : TChapter );
      procedure remove( cp : TChapter );

      function newChapter : TChapter;

      function fullTitle: string;
      procedure reindex;

      function hasID( id : integer ) : Boolean;
  end;

implementation

uses
  System.SysUtils;

{ TChapterList }

procedure TChapterList.add(cp: TChapter);
begin
  if not m_list.Contains(cp) then
    m_list.Add(cp);
end;

procedure TChapterList.clear;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
    m_list[i].Free;
  m_list.Clear;
end;

constructor TChapterList.create;
begin
  m_list := TList<TChapter>.Create;
end;

procedure TChapterList.Delete(cp: TChapter);
begin
  remove( cp );
  cp.Free;
end;

destructor TChapterList.Destroy;
begin
  clear;
  m_list.Free;
  inherited;
end;

procedure TChapterList.down(cp: TChapter);
var
  inx : integer;
begin
  inx := findIndex(cp);
  if inx = m_list.Count-1 then
    exit;

  m_list.Exchange( inx, inx +1 );
  renumber;
end;

function TChapterList.findIndex(cp: TChapter): integer;
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

function TChapterList.findMax: integer;
var
  i : integer;
begin
  Result := 0;
  for i := 0 to pred(m_list.Count) do
    if m_list[i].Nr > Result then
      Result := m_list[i].Nr;

end;

function TChapterList.getCount: integer;
begin
  Result := m_list.Count;
end;

function TChapterList.getItem(inx: integer): TChapter;
begin
  Result := m_list[inx];
end;

procedure TChapterList.remove(cp: TChapter);
var
  inx : Integer;
begin
  inx := findIndex(cp);
  if inx <> -1 then
    m_list.Remove(cp);
  renumber;
end;

procedure TChapterList.renumber;
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

procedure TChapterList.setItem(inx: integer; const value: TChapter);
begin
  m_list[inx] := value;
end;

procedure TChapterList.up(cp: TChapter);
var
  inx : integer;
begin
  inx := findIndex(cp);
  if inx = 0 then
    exit;

  m_list.Exchange( inx, inx -1 );
  renumber;
end;

{ TChapter }

procedure TChapter.add(cp: TChapter);
begin
  m_childs.add(cp);
  cp.Owner := self;

 m_childs.renumber;
end;

constructor TChapter.create(owner : TChapter);
begin
  m_childs := TChapterList.create;
  m_owner := owner;
  FID       := 0;
  FPID      := 0;
  FNr       := 0;
  FTAID     := 0;
  FNumbering:= true;
  FName     := 'Titel';
  FData     := NIL;
end;

destructor TChapter.Destroy;
begin
  m_childs.Free;
  inherited;
end;

procedure TChapter.down;
begin
  m_owner.Childs. down(self);
end;

function TChapter.fullTitle: string;
begin
  Result := '';
  if FNumbering then
    Result := IntToStr( nr ) +' ';
  Result := Result + FName;

  if FTAID <> 0 then
    Result := Result + Format(' (%d)', [FTAID]);

end;

function TChapter.hasID(id: integer): Boolean;
var
  i : integer;
begin
  Result := (FTAID = id);
  if not Result then
  begin
    for i := 0 to pred(m_childs.Count) do
    begin
      Result := m_childs.Items[i].hasID(id);
      if Result then
        break;
    end;
  end;
end;

function TChapter.newChapter: TChapter;
begin
  Result := TChapter.create(self);
  add(Result);
  m_childs.renumber;
end;

procedure TChapter.reindex;
var
  inx : integer;

  procedure indexChilds( root : TChapter; pid : integer );
  var
    i : integer;
  begin
    Inc(inx);
    root.ID   := inx;
    root.PID  := pid;
    for i := 0 to pred(root.Childs.Count) do
    begin
      indexChilds(root.Childs.Items[i], root.ID);
    end;
  end;
begin
  inx := -1;

  indexChilds(self, 0);
end;

procedure TChapter.remove(cp: TChapter);
begin
  m_childs.remove(cp);
  cp.Owner := NIL;
end;

procedure TChapter.up;
begin
  m_owner.Childs.up(self);
end;

end.
