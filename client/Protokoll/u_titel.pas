unit u_titel;

interface

uses
  System.Generics.Collections, xsd_chapter;

type
  TChapterTitle = class;

  TChapterTitleList = class
    private
      m_list : TList<TChapterTitle>;
      function getIndex( cp : TChapterTitle) : integer;
      function getCount : integer;
      function getItem( inx : integer ) : TChapterTitle;
    public
      constructor Create;
      Destructor Destroy; override;

      procedure renumber;
      function NewEntry : TChapterTitle;

      property Count : integer read getCount;
      property Items[ inx : integer] : TChapterTitle read getItem;

      procedure up( cp : TChapterTitle );
      procedure down( cp : TChapterTitle );
      procedure remove( cp : TChapterTitle );
  end;

  TChapterTitle = class
    private
      m_owner   : TChapterTitleList;
      FNr       : integer;
      FText     : string;
      FID       : integer;
      FModified : boolean;
      m_xCp     : IXMLChapter;
    public
      constructor create(owner : TChapterTitleList);
      Destructor Destroy; override;

      property ID: integer read FID write FID;
      property Nr: integer read FNr write FNr;
      property Text: string read FText write FText;
      property Modified: boolean read FModified write FModified;
      property xChapter : IXMLChapter read m_xCp write m_xCp;

      procedure up;
      procedure down;

      function FullTitle : string;

  end;




implementation

uses
  System.SysUtils;

{ TChapterTitle }

constructor TChapterTitle.create(owner : TChapterTitleList);
begin
  m_xCp     := NewChapter;
  m_owner   := owner;
  FNr       := 0;
  FModified := false;
end;

destructor TChapterTitle.Destroy;
begin
  m_xCp     := NIL;
  m_owner   := NIL;

  inherited;
end;

procedure TChapterTitle.down;
begin
  m_owner.down(self);
end;

function TChapterTitle.FullTitle: string;
begin
  Result := Format('%d. %s', [FNr, FText]);
end;

procedure TChapterTitle.up;
begin
  m_owner.up(self);
end;

{ TChapterTitleList }

constructor TChapterTitleList.Create;
begin
  m_list := TList<TChapterTitle>.create;
end;

destructor TChapterTitleList.Destroy;
var
  i : integeR;
begin
  for i := 0 to pred(m_list.Count) do
  begin
    m_list[i].Free;
  end;
  FreeAndNil( m_list);

  inherited;
end;

procedure TChapterTitleList.down(cp: TChapterTitle);
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

function TChapterTitleList.getCount: integer;
begin
  Result := m_list.Count;
end;

function TChapterTitleList.getIndex(cp: TChapterTitle): integer;
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

function TChapterTitleList.getItem(inx: integer): TChapterTitle;
begin
  Result := m_list[inx];
end;

function TChapterTitleList.NewEntry: TChapterTitle;
begin
  Result := TChapterTitle.create(self);
  m_list.Add(Result);
  renumber;
  Result.Text := 'Titel '+IntToStr(Result.FNr);
end;

procedure TChapterTitleList.remove(cp: TChapterTitle);
var
  inx : Integer;
begin
  inx := getIndex(cp);
  m_list.Delete(inx);
  renumber;
end;

procedure TChapterTitleList.renumber;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
  begin
     m_list[i].Modified := m_list[i].Nr <> (i+1);
    m_list[i].Nr := i + 1;
  end;
end;

procedure TChapterTitleList.up(cp: TChapterTitle);
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
