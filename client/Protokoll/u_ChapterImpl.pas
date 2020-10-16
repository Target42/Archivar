unit u_ChapterImpl;

interface

uses
  i_chapter;

type
    TChapterImpl = class( TInterfacedObject, IChapter )
    private
      m_childs : IChapterList;
      m_owner  : IChapter;
      FName: string;
      FID: integer;
      FPID: integer;
      FNr: integer;
      FNumbering: boolean;
      FTAID: integer;
      FData: Pointer;
      FRem: String;
      m_modified : boolean;


      procedure setModified(  value : boolean );
      procedure setOwner(     value : IChapter);
      procedure setName(      value : string );
      procedure SetID(        value : integer);
      procedure setPID(       value : integer );
      procedure SetNr(        value : integer );
      procedure SetNumbering( value : boolean );
      procedure setTAID(      value : integer );
      procedure setData(      value : pointer );
      procedure setRem(       value : string );

      function getModified  : boolean;
      function getOwner     : IChapter;
      function getName      : string;
      function getID        : integer;
      function getPID       : integer;
      function getNr        : integer;
      function getNumbering : boolean ;
      function getTAID      : integer;
      function getData      : pointer;
      function getRem       : string;
      function getChilds    : IChapterList;
    public
      constructor create(owner : IChapter);
      Destructor Destroy; override;

      property Owner      : IChapter      read getOwner     write setOwner;
      property Childs     : IChapterList  read getChilds;
      property Name       : string        read getName      write setName;
      property ID         : integer       read getID        write SetID;
      property PID        : integer       read getPID       write setPID;
      property Nr         : integer       read getNr        write SetNr;
      property Numbering  : boolean       read getNumbering write SetNumbering;
      property TAID       : integer       read getTAID      write setTAID;
      property Data       : Pointer       read getData      write setData;
      property Rem        : String        read getRem       write setRem;
      property Modified   : boolean       read getModified  write setModified;

      procedure clearModified;
      function isModified : boolean;

      procedure up;
      procedure down;

      procedure add( cp : IChapter );
      procedure remove( cp : IChapter );

      function newChapter : IChapter;

      function fullTitle: string;
      procedure reindex;

      function hasID( id : integer ) : Boolean;

      procedure release;
  end;

implementation

uses
  System.SysUtils, u_ChapterListImpl;

procedure TChapterImpl.add(cp: IChapter);
begin
  m_childs.add(cp);
  cp.Owner := self;

 m_childs.renumber;
end;

procedure TChapterImpl.clearModified;
var
  i : integer;
begin
  m_modified := false;
  for i := 0 to pred(m_childs.Count) do
    m_childs.Items[i].clearModified;
end;

constructor TChapterImpl.create(owner : IChapter);
begin
  m_childs := TChapterListImpl.create;
  m_owner := owner;
  FID       := 0;
  FPID      := 0;
  FNr       := 0;
  FTAID     := 0;
  FNumbering:= true;
  FName     := 'Titel';
  FData     := NIL;
  m_modified := false;
end;

destructor TChapterImpl.Destroy;
begin
  m_childs := NIL;
  inherited;
end;

procedure TChapterImpl.down;
begin
  m_owner.Childs. down(self);
end;

function TChapterImpl.fullTitle: string;
begin
  Result := '';
  if FNumbering then
    Result := IntToStr( nr ) +' ';
  Result := Result + FName;

  if FTAID <> 0 then
    Result := Result + Format(' (%d)', [FTAID]);

end;

function TChapterImpl.getChilds: IChapterList;
begin
  Result := m_childs;
end;

function TChapterImpl.getData: pointer;
begin
  Result := FData;
end;

function TChapterImpl.getID: integer;
begin
  Result := FID;
end;

function TChapterImpl.getModified: boolean;
begin
  Result := m_modified;
end;

function TChapterImpl.getName: string;
begin
  Result := FName;
end;

function TChapterImpl.getNr: integer;
begin
  Result := FNr;
end;

function TChapterImpl.getNumbering: boolean;
begin
  Result := FNumbering;
end;

function TChapterImpl.getOwner: IChapter;
begin
  Result := m_owner;
end;

function TChapterImpl.getPID: integer;
begin
  Result := FPID;
end;

function TChapterImpl.getRem: string;
begin
  Result := FRem;
end;

function TChapterImpl.getTAID: integer;
begin
  Result := FTAID;
end;

function TChapterImpl.hasID(id: integer): Boolean;
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

function TChapterImpl.isModified: boolean;
  function checkChilds( list : IChapterList ) : Boolean;
  var
    i : integer;
  begin
    Result := false;
    for i := 0 to pred(list.Count) do
    begin
      Result := list.Items[i].isModified;
      if Result then
        break;
    end;
  end;
begin
  Result := m_modified;

  if not Result then
  begin
    Result := checkChilds(m_childs);
  end;

end;

function TChapterImpl.newChapter: IChapter;
begin
  Result := TChapterImpl.create(self);
  add(Result);
  m_childs.renumber;
end;

procedure TChapterImpl.reindex;
var
  inx : integer;

  procedure indexChilds( root : IChapter; pid : integer );
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

procedure TChapterImpl.release;
var
  i : integer;
begin
  for i := 0 to pred(m_childs.Count) do
    m_childs.Items[i].release;
end;

procedure TChapterImpl.remove(cp: IChapter);
begin
  m_childs.remove(cp);
  cp.Owner := NIL;
end;

procedure TChapterImpl.setData(value: pointer);
begin
  FData := value;
  m_modified := true;
end;

procedure TChapterImpl.SetID(value: integer);
begin
  FID := value;
  m_modified := true;
end;

procedure TChapterImpl.setModified(value: boolean);
begin
  m_modified := value;
end;

procedure TChapterImpl.setName(value: string);
begin
  FName := value;
  m_modified := true;
end;

procedure TChapterImpl.SetNr(value: integer);
begin
  FNr := value;
  m_modified := true;
end;

procedure TChapterImpl.SetNumbering(value: boolean);
begin
  FNumbering := value;
  m_modified := true;
end;

procedure TChapterImpl.setOwner(value: IChapter);
begin
  m_owner := value;
  m_modified := true;
end;

procedure TChapterImpl.setPID(value: integer);
begin
  FPID := value;
  m_modified := true;
end;

procedure TChapterImpl.setRem(value: string);
begin
  FRem := value;
  m_modified := true;
end;

procedure TChapterImpl.setTAID(value: integer);
begin
  FTAID := value;
  m_modified := true;
end;

procedure TChapterImpl.up;
begin
  m_owner.Childs.up(self);
end;

end.
