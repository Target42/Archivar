unit u_PersonImpl;

interface

uses
  i_personen;

type
  TPersonImpl = class( TInterfacedObject, IPerson )
  private
    m_owner   : IPersonenListe;
    m_name    : string;
    m_vorname : string;
    m_id      : integer;
    m_dept    : string;
    m_rolle   : string;

    procedure setID( value : integer );
    function  getID : integer;
    procedure setName( value : string );
    function  getName : string;
    procedure setVorname( value : string );
    function  getVorname : string;
    procedure setAbteilung( value : string );
    function  getAbteilung : string;
    procedure setOwner( value : IPersonenListe );
    function getOwner : IPersonenListe;
    procedure setRolle( value : string );
    function  getRolle : string;
  public
    constructor create;
    Destructor Destroy; override;

    function clone : IPerson;

    procedure release;

  end;

implementation

{ TPersonImpl }

function TPersonImpl.clone: IPerson;
begin
  Result            := TPersonImpl.create;
  Result.Name       := m_name;
  Result.Vorname    := m_vorname;
  Result.Abteilung  := m_dept;
  Result.ID         := m_id;
  Result.Rolle      := m_rolle;
end;

constructor TPersonImpl.create;
begin
  m_owner := NIL;
  m_id    := -1;

end;

destructor TPersonImpl.Destroy;
begin
  m_owner := NIL;
  inherited;
end;

function TPersonImpl.getAbteilung: string;
begin
  Result := m_dept;
end;

function TPersonImpl.getID: integer;
begin
  Result := m_id;
end;

function TPersonImpl.getName: string;
begin
  Result := m_name;
end;

function TPersonImpl.getOwner: IPersonenListe;
begin
  Result := m_owner;
end;

function TPersonImpl.getRolle: string;
begin
  Result := m_rolle;
end;

function TPersonImpl.getVorname: string;
begin
  Result := m_vorname;
end;

procedure TPersonImpl.release;
begin
  m_owner := NIL;
end;

procedure TPersonImpl.setAbteilung(value: string);
begin
  m_dept := value;
end;

procedure TPersonImpl.setID(value: integer);
begin
  m_id := value;
end;

procedure TPersonImpl.setName(value: string);
begin
  m_name := value;
end;

procedure TPersonImpl.setOwner(value: IPersonenListe);
begin
  m_owner := value;
end;

procedure TPersonImpl.setRolle(value: string);
begin
  m_rolle := value;
end;

procedure TPersonImpl.setVorname(value: string);
begin
  m_vorname := value;
end;

end.
