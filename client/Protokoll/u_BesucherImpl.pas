unit u_BesucherImpl;

interface

uses
  i_chapter;

type
  TBesucherImpl = class(TInterfacedObject, IBesucher )
  private
    m_id        : integer;
    m_name      : string;
    m_vorname   : string;
    m_abteilung : string;
    m_grund     : string;
    m_von       : TDateTime;
    m_bis       : TDateTime;
    m_modified  : boolean;

    function GetName: string;
    procedure SetName(const Value: string);
    function GetVorname: string;
    procedure SetVorname(const Value: string);
    function GetAbteilung: string;
    procedure SetAbteilung(const Value: string);
    function GetGrund: string;
    procedure SetGrund(const Value: string);
    function GetVon: TDateTime;
    procedure SetVon(const Value: TDateTime);
    function Getbis: TDateTime;
    procedure Setbis(const Value: TDateTime);
    function GetModified: boolean;
    procedure SetModified(const Value: boolean);
    function Getid: integer;
    procedure Setid(const Value: integer);
  public

    constructor create;
    Destructor Destroy; override;

    procedure release;
  end;

implementation

{ TBesucherImpl }

constructor TBesucherImpl.create;
begin
  m_modified  := false;
  m_von       := 0.0;
  m_bis       := 0.0;
end;

destructor TBesucherImpl.Destroy;
begin

  inherited;
end;

function TBesucherImpl.GetAbteilung: string;
begin
  Result := m_abteilung;
end;

function TBesucherImpl.Getbis: TDateTime;
begin
  Result := m_bis;
end;

function TBesucherImpl.GetGrund: string;
begin
  Result := m_grund;
end;

function TBesucherImpl.Getid: integer;
begin
  Result := m_id;
end;

function TBesucherImpl.GetModified: boolean;
begin
  Result := m_modified;
end;

function TBesucherImpl.GetName: string;
begin
  Result := m_name;
end;

function TBesucherImpl.GetVon: TDateTime;
begin
  Result := m_von;
end;

function TBesucherImpl.GetVorname: string;
begin
  Result := m_vorname;
end;

procedure TBesucherImpl.release;
begin

end;

procedure TBesucherImpl.SetAbteilung(const Value: string);
begin
  m_abteilung := value;
  m_modified  := true;
end;

procedure TBesucherImpl.Setbis(const Value: TDateTime);
begin
  m_bis := value;
  m_modified  := true;
end;

procedure TBesucherImpl.SetGrund(const Value: string);
begin
  m_grund := value;
  m_modified  := true;
end;

procedure TBesucherImpl.Setid(const Value: integer);
begin
  m_id := value;
  m_modified  := true;
end;

procedure TBesucherImpl.SetModified(const Value: boolean);
begin
  m_modified := value;
end;

procedure TBesucherImpl.SetName(const Value: string);
begin
  m_name := value;
  m_modified  := true;
end;

procedure TBesucherImpl.SetVon(const Value: TDateTime);
begin
  m_von := value;
  m_modified  := true;
end;

procedure TBesucherImpl.SetVorname(const Value: string);
begin
  m_vorname := value;
  m_modified  := true;
end;

end.
