unit u_teilnehmerImpl;

interface

uses
  i_chapter, i_personen;

type
  TTeilnehmerImpl = class( TInterfacedObject, ITeilnehmer )
    private
      m_id        : integer;
      m_name      : string;
      m_vorname   : string;
      m_abteilung : string;
      m_rolle     : string;
      m_status    : TTeilnehmerStatus;
      m_peid      : integer;
      m_modified  : boolean;

      function GetName: string;
      procedure SetName(const Value: string);
      function GetVorname: string;
      procedure SetVorname(const Value: string);
      function GetAbteilung: string;
      procedure SetAbteilung(const Value: string);
      function GetRolle: string;
      procedure SetRolle(const Value: string);
      function GetID: integer;
      procedure SetID(const Value: integer);
      function GetStatus: TTeilnehmerStatus;
      procedure SetStatus(const Value: TTeilnehmerStatus);
      procedure setPEID( value : integer );
      function  getPEID : integer;
      procedure setModified( value : boolean );
      function  getModified : boolean;

    public
      constructor create;
      Destructor Destroy; override;

      procedure Assign( pe : IPerson );
      procedure release;
  end;

function TeilnehmerStatusToStr( status : TTeilnehmerStatus ): string;
function StrToTeilnehmerStatus( status : string ) : TTeilnehmerStatus;

implementation

uses
  System.SysUtils;

function TeilnehmerStatusToStr( status : TTeilnehmerStatus ): string;
begin
  case status of
    tsAnwesend:       Result := 'Anwesend';
    tsEntschuldigt:   Result := 'Entschuldigt';
    tsUnentschuldigt: Result := 'Unentschuldigt';
    else
      Result := 'Unentschuldigt';
  end;
end;

function StrToTeilnehmerStatus( status : string ) : TTeilnehmerStatus;
begin
  Result := tsUnentschuldigt;
  if SameText( status, 'Entschuldigt') then
    Result := tsEntschuldigt
  else if Sametext( status, 'Anwesend') then
    Result := tsAnwesend;
end;

{ TTeilnehmerImpl }

procedure TTeilnehmerImpl.Assign(pe: IPerson);
begin
  SetName(      pe.Name);
  SetVorname(   pe.Vorname);
  SetAbteilung( pe.Abteilung);
  setPEID(      pe.ID);
  SetRolle(     pe.Rolle);

  m_modified := true;
end;

constructor TTeilnehmerImpl.create;
begin
  m_id        := 0;
  m_peid      := 0;
  m_status    := tsUnentschuldigt;
  m_modified  := false;
end;

destructor TTeilnehmerImpl.Destroy;
begin

  inherited;
end;

function TTeilnehmerImpl.GetAbteilung: string;
begin
  Result := m_abteilung;
end;

function TTeilnehmerImpl.GetID: integer;
begin
  Result := m_id;
end;

function TTeilnehmerImpl.getModified: boolean;
begin
  Result := m_modified;
end;

function TTeilnehmerImpl.GetName: string;
begin
  Result := m_name;
end;

function TTeilnehmerImpl.getPEID: integer;
begin
  Result := m_peid;
end;

function TTeilnehmerImpl.GetRolle: string;
begin
  Result := m_rolle;
end;

function TTeilnehmerImpl.GetStatus: TTeilnehmerStatus;
begin
  Result := m_status;
end;

function TTeilnehmerImpl.GetVorname: string;
begin
  Result := m_vorname;
end;

procedure TTeilnehmerImpl.release;
begin

end;

procedure TTeilnehmerImpl.SetAbteilung(const Value: string);
begin
  m_abteilung := value;
  m_modified  := true;
end;

procedure TTeilnehmerImpl.SetID(const Value: integer);
begin
  m_id := value;
  m_modified  := true;
end;

procedure TTeilnehmerImpl.setModified(value: boolean);
begin
  m_modified := value;
end;

procedure TTeilnehmerImpl.SetName(const Value: string);
begin
  m_name := value;
  m_modified  := true;
end;

procedure TTeilnehmerImpl.setPEID(value: integer);
begin
  m_peid := value;
  m_modified  := true;
end;

procedure TTeilnehmerImpl.SetRolle(const Value: string);
begin
  m_rolle := value;
  m_modified  := true;
end;

procedure TTeilnehmerImpl.SetStatus(const Value: TTeilnehmerStatus);
begin
  m_status := value;
  m_modified  := true;
end;

procedure TTeilnehmerImpl.SetVorname(const Value: string);
begin
  m_vorname := value;
  m_modified  := true;
end;

end.
