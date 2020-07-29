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
  public
    constructor create;
    Destructor Destroy; override;

    procedure Release;
  end;
implementation

{ TAbstimmungImpl }

constructor TAbstimmungImpl.create;
begin
  m_ja        := 0;
  m_nein      := 0;
  m_enthalten := 0;
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
  m_gremium.release;
  m_abwesend.release;
  m_na.release;
end;

procedure TAbstimmungImpl.setAbgelehnt(value: integer);
begin
  m_nein := value;
end;

procedure TAbstimmungImpl.setAbwesend(value: IPersonenListe);
begin
  m_abwesend := value;
end;

procedure TAbstimmungImpl.setEnthalten(value: integer);
begin
  m_enthalten := value;
end;

procedure TAbstimmungImpl.setGremium(value: IPersonenListe);
begin
  m_gremium := value;
end;

procedure TAbstimmungImpl.setNichtabgetimmt(value: IPersonenListe);
begin
  m_na := value;
end;

procedure TAbstimmungImpl.setZeitpunkt(value: TDateTime);
begin
  m_ts := value;
end;

procedure TAbstimmungImpl.setZustimmung(value: integer);
begin
  m_ja := value;
end;

end.
