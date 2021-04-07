unit u_TOnlineUserServerImpl;

interface

uses
  i_user, System.Generics.Collections, System.SyncObjs;

type
  TOnlineUserServerImpl = class(TInterfacedObject, IOnlineUserServer )
  private
    m_mutex     : TMutex;
    m_list      : TList<IServerUser>;
    m_map       : TDictionary<integer,IServerUser>;
    m_sessions  : TDictionary<NativeInt,IServerUser>;

    function  GetCount: integer;
    function  GetItems(inx : integer ): IServerUser;
    procedure SetItems(inx : integer; const Value: IServerUser);

    procedure SendUserList;
  public
    constructor create;
    Destructor Destroy; override;

    property Count: integer read GetCount;
    property Items[inx : integer ]: IServerUser read GetItems write SetItems;

    function addUser( id : integer; name, vorname : string; sessionID : NativeInt ) :IServerUser;
    procedure removeSessionID( id : NativeInt );

    procedure lockServer;
    procedure unlockServer;

    procedure release;
  end;

implementation

uses
  u_TServerUserImpl, System.JSON, u_json, m_glob_server, ServerContainerUnit1;

{ TOnlineUserServerImpl }

function TOnlineUserServerImpl.addUser(id: integer; name, vorname: string;
  sessionID: NativeInt): IServerUser;
begin
  m_mutex.Acquire;
  try
    if m_map.ContainsKey(id) then
      Result := m_map[id]
    else
    begin
      Result          := TServerUserImpl.create;
      Result.ID       := id;
      Result.Name     := name;
      Result.Vorname  := vorname;
      Result.addSessionID(sessionID);

      m_list.Add(Result);
      m_map.AddOrSetValue(id, Result);
    end;

    m_sessions.AddOrSetValue(sessionID, Result);
    Result.addSessionID(sessionID);

    SendUserList;
  except

  end;
  m_mutex.Release;

end;

constructor TOnlineUserServerImpl.create;
begin
  m_list      := TList<IServerUser>.create;
  m_map       := TDictionary<integer,IServerUser>.create;
  m_sessions  := TDictionary<NativeInt,IServerUser>.create;
  m_mutex     := TMutex.Create;
end;

destructor TOnlineUserServerImpl.Destroy;
var
  us :IServerUser;
begin
  for us in m_list do
    us.Release;

  m_list.Clear;
  m_list.Free;

  m_map.Free;
  m_sessions.Free;

  m_mutex.Free;
  inherited;
end;

function TOnlineUserServerImpl.GetCount: integer;
begin
  Result := m_list.Count;
end;


function TOnlineUserServerImpl.GetItems(inx : integer) : IServerUser;
begin
  Result := m_list[inx];
end;

procedure TOnlineUserServerImpl.lockServer;
begin
  m_mutex.Acquire;
end;

procedure TOnlineUserServerImpl.release;
begin

end;

procedure TOnlineUserServerImpl.removeSessionID(id: NativeInt);
var
  user : IServerUser;
begin
  m_mutex.Acquire;
  try
    if m_sessions.ContainsKey(id) then
    begin
      user := m_sessions[id];
      user.removeSessionID(id);

      if user.isOffline then
      begin
        m_map.Remove(user.ID);
        m_list.Remove(user);

        user.release;

        SendUserList;
      end;
    end;
  except

  end;
  m_mutex.Release;
end;

procedure TOnlineUserServerImpl.SendUserList;
var
  data : TJSONObject;
  arr  : TJSONArray;
  user : IServerUser;
begin
  data := TJSONObject.Create;
  arr  := TJSONArray.Create;

  JReplace(data, 'action', 'onlineuser');

  for user in m_list do
    arr.AddElement( TJSONNumber.Create(user.ID ));

  JReplace( data, 'user', arr);

  ServerContainer1.BroadcastMessage('storage', data);
end;


procedure TOnlineUserServerImpl.SetItems(inx : integer; const Value: IServerUser);
begin
  m_list[inx] := value;
end;

procedure TOnlineUserServerImpl.unlockServer;
begin
  m_mutex.Release;
end;

end.
