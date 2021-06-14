unit u_TServerUserImpl;

interface

uses
  i_user, System.Generics.Collections;

type
  TServerUserImpl = class(TInterfacedObject, IServerUser)
  private
    m_id        : integer;
    m_name      : string;
    m_vorname   : string;
    m_status    : string;

    m_list      : TList<NativeInt>;

    function GetID: integer;
    procedure SetID(const Value: integer);
    function GetName: string;
    procedure SetName(const Value: string);
    function GetVorname: string;
    procedure SetVorname(const Value: string);
    function GetStatus: string;
    procedure SetStatus(const Value: string);

  public

    constructor create;
    Destructor Destroy; override;


    procedure addSessionID( id : NativeInt );
    procedure removeSessionID( id : NativeInt );
    function hasSessionID( id : NativeInt ) : boolean;

    function isOffline : boolean;

    procedure release;

    function toText : string;
  end;

implementation

uses
  System.SysUtils;

{ TServerUserImpl }

procedure TServerUserImpl.addSessionID(id: NativeInt);
begin
  if m_list.IndexOf(id) = -1 then
    m_list.Add(id);
end;

constructor TServerUserImpl.create;
begin
  m_id    := 0;
  m_list  := TList<NativeInt>.create;
end;

destructor TServerUserImpl.Destroy;
begin
  m_list.Free;
  inherited;
end;

function TServerUserImpl.GetID: integer;
begin
  Result := m_id;
end;

function TServerUserImpl.GetName: string;
begin
  Result := m_name;
end;

function TServerUserImpl.GetStatus: string;
begin
  Result := m_status;
end;

function TServerUserImpl.GetVorname: string;
begin
  Result := m_vorname;
end;

function TServerUserImpl.hasSessionID(id: NativeInt): boolean;
begin
  result := ( m_list.IndexOf(id) <> -1 );
end;

function TServerUserImpl.isOffline: boolean;
begin
  Result := ( m_list.Count = 0 );
end;

procedure TServerUserImpl.release;
begin

end;

procedure TServerUserImpl.removeSessionID(id: NativeInt);
var
  inx : integer;
begin
  inx := m_list.IndexOf(id);
  if inx <> -1 then
    m_list.Delete(inx);

end;

procedure TServerUserImpl.SetID(const Value: integer);
begin
  m_id := value;
end;

procedure TServerUserImpl.SetName(const Value: string);
begin
  m_name := value;
end;

procedure TServerUserImpl.SetStatus(const Value: string);
begin
  m_status := value;
end;

procedure TServerUserImpl.SetVorname(const Value: string);
begin
  m_vorname := value;
end;

function TServerUserImpl.toText : string;
var
  i : integer;
  s : string;
begin
  s := '';
  for i := 0 to pred(m_list.Count) do
    s := s + IntToStr(m_list[i])+', ';
  if s <> '' then
    SetLength(s, length(s)-2);

  Result := Format('%3d %20s %20s %10s sessions: %s',
  [
    m_id,
    m_name,
    m_vorname,
    m_status,
    s
  ]);
end;

end.
