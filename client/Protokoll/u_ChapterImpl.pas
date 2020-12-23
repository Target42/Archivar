unit u_ChapterImpl;

interface

uses
  i_chapter, xsd_chapter, System.Classes, i_beschluss;

type
    TChapterImpl = class( TInterfacedObject, IChapter )
    private
      m_childs    : IChapterList;
      m_owner     : IChapter;
      FName       : string;
      FID         : integer;
      FPID        : integer;
      FNr         : integer;
      FNumbering  : boolean;
      FTAID       : integer;
      FData       : Pointer;
      FRem        : String;
      m_modified  : boolean;
      m_xData     : IXMLChapter;
      m_pos       : integer;
      m_votes     : IBeschlussListe;


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
      procedure setxData(     value : IXMLChapter);
      procedure setPos(       value : integer );

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
      function getxData     : IXMLChapter;
      function getPos       : integer;
      function getVotes     : IBeschlussListe;

    public
      constructor create(owner : IChapter);
      Destructor Destroy; override;

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
  System.SysUtils, u_ChapterListImpl, u_BeschlussListeImpl;

procedure TChapterImpl.add(cp: IChapter);
begin
  if cp = IChapter(self) then
    exit;

  m_childs.add(cp);

  cp.Owner  := self;
  cp.PID    := self.getPID;

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
  m_votes  := TBeschlussListeImpl.create;
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
  m_owner.Childs.down(self);
  m_modified    := true;
end;

function TChapterImpl.fullTitle: string;
var
  cp : IChapter;
begin
  Result := '';
  if FNumbering then
  begin
    cp := self;
    while Assigned(cp) do
    begin
      if cp.Numbering then
        Result := IntToStr( cp.getNr ) +'.'+Result;
      cp := cp.Owner;
    end;
    Result := Result + ' ';

  end;
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

function TChapterImpl.getPos: integer;
begin
  Result := m_pos;
end;

function TChapterImpl.getRem: string;
begin
  Result := FRem;
end;

function TChapterImpl.getTAID: integer;
begin
  Result := FTAID;
end;

function TChapterImpl.getVotes: IBeschlussListe;
begin
  Result := m_votes;
end;

function TChapterImpl.getxData: IXMLChapter;
begin
  Result := m_xData;
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
    root.pos  := inx;
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
  m_childs.clear;
  m_votes.Release;
end;

procedure TChapterImpl.remove(cp: IChapter);
begin
  m_childs.remove(cp);
  cp.Owner := NIL;
end;

procedure TChapterImpl.setData(value: pointer);
begin
  m_modified  := m_modified or (value <> FData);
  FData := value;
end;

procedure TChapterImpl.SetID(value: integer);
begin
  m_modified  := m_modified or (value <> FID);
  FID := value;
end;

procedure TChapterImpl.setModified(value: boolean);
begin
  m_modified := value;
end;

procedure TChapterImpl.setName(value: string);
begin
  m_modified  := m_modified or (value <> FName);
  FName := value;
end;

procedure TChapterImpl.SetNr(value: integer);
begin
  m_modified  := m_modified or (value <> FNr);
  FNr := value;
end;

procedure TChapterImpl.SetNumbering(value: boolean);
var
  i : integer;
begin
  m_modified  := m_modified or (value <> FNumbering);
  FNumbering := value;

  if Assigned(m_owner) then
  begin
    if FNumbering then
      m_owner.Numbering := true
    else
    begin
      for i := 0 to pred(m_childs.Count) do
        m_childs.Items[i].Numbering := false;
    end;
  end;
  m_childs.renumber;
end;

procedure TChapterImpl.setOwner(value: IChapter);
begin
  m_modified  := m_modified or (value <> m_owner);
  m_owner := value;
end;

procedure TChapterImpl.setPID(value: integer);
begin
  m_modified  := m_modified or (value <> FPID);
  FPID := value;
end;

procedure TChapterImpl.setPos(value: integer);
begin
  m_modified  := m_modified or (value <> m_pos);
  m_pos       := value;
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

procedure TChapterImpl.setxData(value: IXMLChapter);
begin
  m_xData := value;
end;

procedure TChapterImpl.up;
begin
  m_owner.Childs.up(self);
  m_modified := true;
end;

end.
