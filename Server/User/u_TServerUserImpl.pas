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

    m_list      : TList<NativeInt>;

    function GetID: integer;
    procedure SetID(const Value: integer);
    function GetName: string;
    procedure SetName(const Value: string);
    function GetVorname: string;
    procedure SetVorname(const Value: string);

  public

    constructor create;
    Destructor Destroy; override;

    property ID         : integer     read GetID          write SetID;
    property Name       : string      read GetName        write SetName;
    property Vorname    : string      read GetVorname     write SetVorname;

    procedure addSessionID( id : NativeInt );
    procedure removeSessionID( id : NativeInt );
    function hasSessionID( id : NativeInt ) : boolean;

    function isOffline : boolean;

    procedure release;
  end;

implementation

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

procedure TServerUserImpl.SetVorname(const Value: string);
begin
  m_vorname := value;
end;

end.
