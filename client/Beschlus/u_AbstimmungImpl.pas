unit u_AbstimmungImpl;

interface


uses
  i_beschluss, i_personen, System.Generics.Collections;

type
  TAbstimmungImpl = class(TInterfacedObject, IAbstimmung )
  private
    m_ts        : TDateTime;
    m_gremium   : IPersonenListe;
    m_abwesend  : IPersonenListe;
    m_na        : IPersonenListe;

    m_ja        : integer;
    m_nein      : integer;
    m_enthalten : integer;
    m_modified  : boolean;

    procedure setGremium( value : IPersonenListe );
    function  getGremium : IPersonenListe;
    procedure setAbwesend( value : IPersonenListe);
    function  getAbwesend : IPersonenListe;
    procedure setNichtabgetimmt( value : IPersonenListe);
    function  getNichtabgetimmt : IPersonenListe;
    procedure setZustimmung( value : integer );
    function  getZustimmung : integer;
    procedure setAbgelehnt( value : integer );
    function  getAbgelehnt : integer;
    procedure setEnthalten( value : integer );
    function  getEnthalten : integer;
    procedure setZeitpunkt( value : TDateTime);
    function  getZeitpunkt : TDateTime;
    function  GetModified: boolean;
    procedure SetModified(const Value: boolean);

    procedure CountVotes( var anz : integer; list : TList<integer>);

  public
    constructor create;
    Destructor Destroy; override;

    procedure clear;
    procedure Einstimmig( zustimmung : boolean );

    procedure Release;
    function clone : IAbstimmung;

    procedure resetVote;
    procedure listZustimmung( list : TList<integer>);
    procedure listablehnung( list : TList<integer>);
    procedure listEnthaltung( list : TList<integer>);
    procedure listNichtAbgestimmt( list : TList<integer>);

  end;
implementation

uses
  u_PersonenListeImpl;

{ TAbstimmungImpl }

procedure TAbstimmungImpl.clear;
begin
  m_ja        := 0;
  m_nein      := 0;
  m_enthalten := 0;

end;

function TAbstimmungImpl.clone: IAbstimmung;

begin
  Result := TAbstimmungImpl.create;
  Result.Gremium.release;
  Result.Abwesend.release;
  Result.NichtAbgestimmt.release;

  Result.Gremium          := m_gremium.clone;
  Result.Abwesend         := m_abwesend.clone;
  Result.NichtAbgestimmt  := m_na.clone;
  Result.Zustimmung       := m_ja;
  Result.Abgelehnt        := m_nein;
  Result.Enthalten        := m_enthalten;
end;

procedure TAbstimmungImpl.CountVotes(var anz: integer; list: TList<integer>);
var
  i : integer;
  p : IPerson;
begin
  anz := list.Count;
  for i := 0 to pred(list.Count) do begin
    p := m_abwesend.removeSamePersonByID(list[i]);
    if Assigned(p) then
      p.release;
  end;
end;

constructor TAbstimmungImpl.create;
begin
  m_gremium   := TPersonenListeImpl.create;
  m_abwesend  := TPersonenListeImpl.create;
  m_na        := TPersonenListeImpl.create;

  clear;
end;

destructor TAbstimmungImpl.Destroy;
begin
  inherited;
end;

procedure TAbstimmungImpl.Einstimmig(zustimmung: boolean);
begin
  clear;
  if zustimmung then
    m_ja    := m_gremium.count
  else
    m_nein  := m_gremium.count;
end;

function TAbstimmungImpl.getAbgelehnt: integer;
begin
  Result := m_nein;
end;

function TAbstimmungImpl.getAbwesend: IPersonenListe;
begin
  Result := m_abwesend;
end;

function TAbstimmungImpl.getEnthalten: integer;
begin
  Result := m_enthalten;
end;

function TAbstimmungImpl.getGremium: IPersonenListe;
begin
  Result := m_gremium;
end;

function TAbstimmungImpl.GetModified: boolean;
begin
  Result := m_modified;
end;

function TAbstimmungImpl.getNichtabgetimmt: IPersonenListe;
begin
  Result := m_na;
end;

function TAbstimmungImpl.getZeitpunkt: TDateTime;
begin
  Result := m_ts;
end;

function TAbstimmungImpl.getZustimmung: integer;
begin
  Result:= m_ja;
end;

procedure TAbstimmungImpl.listablehnung(list: TList<integer>);
begin
  CountVotes(m_nein, list );
end;

procedure TAbstimmungImpl.listEnthaltung(list: TList<integer>);
begin
  CountVotes( m_enthalten, list);
end;

procedure TAbstimmungImpl.listNichtAbgestimmt(list: TList<integer>);
var
  i : integer;
  p : IPerson;
begin
  for i := 0 to pred(list.Count) do begin
    p := m_abwesend.removeSamePersonByID(List[i]);
    if Assigned(p) then
      m_na.add(p);
  end;
end;

procedure TAbstimmungImpl.listZustimmung(list: TList<integer>);
begin
  CountVotes(m_ja, list);
end;

procedure TAbstimmungImpl.Release;
begin
  if Assigned(m_gremium) then
    m_gremium.release;
  m_gremium := NIL;

  if Assigned(m_abwesend) then
    m_abwesend.release;
  m_abwesend := NIL;

  if Assigned(m_na) then
    m_na.release;
  m_na := NIL;
end;

procedure TAbstimmungImpl.resetVote;
begin
  m_ja        := 0;
  m_nein      := 0;
  m_enthalten := 0;
  m_na.clear;
  m_abwesend.clear;

  m_abwesend.Assign(m_gremium);
end;

procedure TAbstimmungImpl.setAbgelehnt(value: integer);
begin
  m_nein := value;
  m_modified := true;
end;

procedure TAbstimmungImpl.setAbwesend(value: IPersonenListe);
begin
  m_abwesend := value;
end;

procedure TAbstimmungImpl.setEnthalten(value: integer);
begin
  m_enthalten := value;
  m_modified := true;
end;

procedure TAbstimmungImpl.setGremium(value: IPersonenListe);
begin
  m_gremium := value;
  m_modified := true;
end;

procedure TAbstimmungImpl.SetModified(const Value: boolean);
begin
  m_modified := value;
end;

procedure TAbstimmungImpl.setNichtabgetimmt(value: IPersonenListe);
begin
  m_na := value;
  m_modified := true;
end;

procedure TAbstimmungImpl.setZeitpunkt(value: TDateTime);
begin
  m_ts := value;
  m_modified := true;
end;

procedure TAbstimmungImpl.setZustimmung(value: integer);
begin
  m_ja := value;
  m_modified := true;
end;

end.
