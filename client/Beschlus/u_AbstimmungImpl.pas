unit u_AbstimmungImpl;

interface


uses
  i_beschluss, i_personen;

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

  public
    constructor create;
    Destructor Destroy; override;

    procedure Release;
  end;
implementation

uses
  u_PersonenListeImpl;

{ TAbstimmungImpl }

constructor TAbstimmungImpl.create;
begin
  m_ja        := 0;
  m_nein      := 0;
  m_enthalten := 0;

  m_gremium   := TPersonenListeImpl.create;
  m_abwesend  := TPersonenListeImpl.create;
  m_na        := TPersonenListeImpl.create;
end;

destructor TAbstimmungImpl.Destroy;
begin

  inherited;
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

procedure TAbstimmungImpl.Release;
begin
  if Assigned(m_gremium) then
    m_gremium.release;
  if Assigned(m_abwesend) then
    m_abwesend.release;
  if Assigned(m_na) then
    m_na.release;
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
