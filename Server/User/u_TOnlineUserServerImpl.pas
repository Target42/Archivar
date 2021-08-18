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
    procedure sendUserStatus( us : IServerUser );
  public
    constructor create;
    Destructor Destroy; override;

    property Count: integer read GetCount;
    property Items[inx : integer ]: IServerUser read GetItems write SetItems;

    function addUser( id : integer; name, vorname : string; sessionID : NativeInt ) :IServerUser;
    procedure changeStatus( id : integer;  text : string );
    procedure removeSessionID( id : NativeInt );
    function isSessionOnline( id : NativeInt ) : boolean;

    procedure lockServer;
    procedure unlockServer;

    procedure release;
  end;

implementation

uses
  u_TServerUserImpl, System.JSON, u_json, m_glob_server, ServerContainerUnit1,
  System.SysUtils, u_Konst;

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

      SendUserList;
    end;

    if not m_sessions.ContainsKey(sessionID) then
      m_sessions.AddOrSetValue(sessionID, Result);

    Result.addSessionID(sessionID);
  except

  end;
  m_mutex.Release;

end;

procedure TOnlineUserServerImpl.changeStatus(id: integer; text: string);
var
  fi : IServerUser;
begin
  m_mutex.Acquire;
  try
  if m_map.ContainsKey(id) then
  begin
    fi := m_map[id];
    if Assigned(fi) then
    begin
      if SameText( text, 'offline') then
        fi.Status := ''
      else
        fi.Status := text;
    end;
    sendUserStatus( fi );
  end;

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

function TOnlineUserServerImpl.isSessionOnline(id: NativeInt): boolean;
begin
  m_mutex.Acquire;
  try
    Result := m_sessions.ContainsKey(id);
  finally
    m_mutex.Release;
  end;
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
  obj  : TJSONObject;
begin
  data := TJSONObject.Create;
  arr  := TJSONArray.Create;

  JAction(data, BRD_ONLINE_USER);

  for user in m_list do
  begin
    obj := TJSONObject.Create;
    JReplace( obj, 'id',      user.ID);
    JReplace( obj, 'state',   user.Status);
    arr.Add(obj);
  end;
  JReplace( data, 'user', arr);

  ServerContainer1.BroadcastMessage(BRD_CHANNEL, data);
end;

procedure TOnlineUserServerImpl.sendUserStatus(us: IServerUser);
var
  data : TJSONObject;
begin
  data := TJSONObject.Create;

  JAction(  data, BRD_ONLINE_STATE);
  JReplace( data, 'id',     us.ID);
  JReplace( data, 'state',  us.Status );

  ServerContainer1.BroadcastMessage(BRD_CHANNEL, data);
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
