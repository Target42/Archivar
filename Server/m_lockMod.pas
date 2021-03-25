unit m_lockMod;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Classes, u_lockInfo,
  System.JSON, IBX.IBDatabase, System.SyncObjs;

type
  TLockMod = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    type
      TLockElements = TDictionary<integer, TLockInfo>;        // document child elements
      TLockDict     = TDictionary<integer, TLockElements>;    // documents
  private
    m_mutex : TMutex;
    m_locks :  array[1..3] of TLockDict;

  public
    function LockDocument(    req : TJSONObject ) : TJSONObject;
    function UnLockDocument(  req : TJSONObject ) : TJSONObject;
    function isLocked(        req : TJSONObject ) : TJSONObject;

    function isLockedByID(  id, typ : integer ) : TJSONObject;


    procedure removeLocks( id : NativeInt );
  end;

var
  LockMod: TLockMod;

implementation

uses
  u_json, Datasnap.DSSession, m_glob_server;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TLockMod.DataModuleCreate(Sender: TObject);
var
  i : integer;
begin
  m_mutex := TMutex.Create;
  for i := low(m_locks) to High(m_locks) do
    m_locks[i] := TLockDict.Create;
end;

procedure TLockMod.DataModuleDestroy(Sender: TObject);
var
  i     : integer;
  dict  : TLockDict;
  list  : TLockElements;
  info  : TLockInfo;
begin
  for i := low(m_locks) to High(m_locks) do
  begin
    dict := m_locks[i];
    for list in dict.Values do
    begin
      for info in list.Values do
      begin
        info.Free;
      end;
      list.Free;
    end;
    m_locks[i].Free;
  end;
  m_mutex.Free;
end;


function TLockMod.isLocked(req : TJSONObject): TJSONObject;
var
  dict    : TLockDict;
  elements: TLockElements;
  info    : TLockInfo;
  id, typ : integer;
  sub     : integer;

  procedure sendFail;
  begin
    Result  := info.getJSON;
    JResponse( Result, true, 'Das Dokument ist von '+info.User+' gesperrt');
    JReplace(  Result, 'self', TDSSessionManager.GetThreadSession.Id = info.SessionID);
    DebugMsg(  Format('%s %d %d', ['TLockMod.isLocked: is locked', id, typ]));
  end;
  procedure sendOk;
  begin
    Result := TJSONObject.Create;
    JResult( Result, false, 'Das Dokument ist nicht gesperrt');
    DebugMsg(Format('%s %d %d', ['TLockMod.isLocked: is NOT locked', id, typ]));
  end;
begin
  id  := JInt( req, 'id');
  typ := JInt( req, 'typ');
  sub := JInt( req, 'sub' );

  m_mutex.Acquire;
  try
    dict := m_locks[typ];

    if dict.ContainsKey(id) then
    begin
      elements := dict[id];

      if elements.ContainsKey(0) then
      begin
        info := elements[0];
        sendFail;
      end
      else if elements.ContainsKey(sub) then
      begin
        info := elements[sub];
        sendFail;
      end
      else
        sendOk;
    end
    else
      sendOk;

  finally
    m_mutex.Release;
  end;
end;

function TLockMod.isLockedByID(id, typ: integer): TJSONObject;
var
  req : TJSONObject;
begin
  req     := TJSONObject.Create;
  JReplace(req, 'id',   id);
  JReplace(req, 'type', typ);

  Result  := isLocked(req);

  req.Free;
end;

function TLockMod.LockDocument(req : TJSONObject): TJSONObject;
var
  dict    : TLockDict;
  elements: TLockElements;
  info    : TLockInfo;
  session : TDSSession;

  id, typ : integer;
  sub     : integer;

  function addLock : TLockInfo;
  begin
    Session           := TDSSessionManager.GetThreadSession;
    Result            := TLockInfo.create;
    Result.ID         := id;
    Result.Sub        := sub;
    Result.Locked     := true;
    Result.Host       := session.GetData('host');
    Result.TimeStamp  := now;
    Result.SessionID  := session.Id;
    Result.User       := session.GetData('user');
  end;

  procedure sendOk;
  begin
    Result := info.getJSON;
    DebugMsg(Format('%s %d %d', ['TLockMod.LockDocument: is NOW locked', id, typ]));
    JResult( Result, true, 'Das Dokument wurde gesperrt');
  end;
  procedure sendFail;
  begin
    Result := info.getJSON;
    DebugMsg(Format('%s %d %d', ['TLockMod.LockDocument: is locked', id, typ]));
    JResult( Result, false, 'Das Dokument ist bereits gesperrt');
  end;

begin
  id  := JInt( req, 'id');
  typ := JInt( req, 'typ');
  sub := JInt( req, 'sub');

  m_mutex.Acquire;
  try
    dict := m_locks[typ];

    if dict.ContainsKey(id) then
    begin
      elements := dict[id];

      if elements.ContainsKey(sub) or elements.ContainsKey(0) then
        sendFail
      else
      begin
        info := addLock;
        elements.Add(sub, info);
        sendOK;
      end;
    end
    else
    begin
      elements := TLockElements.Create();
      dict.Add( id, elements);

      info := addLock;
      elements.Add(sub, info);
      sendOK;
    end;
  finally
    m_mutex.Release;
  end;


end;

procedure TLockMod.removeLocks(id: NativeInt);
var
  j       : integer;
  dict    : TLockDict;
  elements: TLockElements;
  info    : TLockInfo;
  keys    : TList<TLockInfo>;
begin

  m_mutex.Acquire;
  keys    := TList<TLockInfo>.create;
  try
    for j := Low(m_locks) to High(m_locks) do
    begin
      dict      := m_locks[j];

      for elements in dict.Values do
      begin
        for info in elements.Values do
        begin
          if info.SessionID = id then
            keys.Add(info);
        end;
        for info in keys do
        begin
          elements.Remove( info.Sub );
          DebugMsg( 'removeLocks : '+info.CLID+' session id : '+IntToStr(id ));
          info.Free;
        end;
      end;
      keys.Clear;
    end;
  finally
    keys.Free;
    m_mutex.Release;
  end;
end;

function TLockMod.UnLockDocument(Req : TJSONObject): TJSONObject;
var
  dict    : TLockDict;
  elements: TLockElements;

  info : TLockInfo;
  session : TDSSession;
  id, typ : integer;
  sub     : integer;
begin
  id  := JInt( req, 'id');
  typ := JInt( req, 'typ');
  sub := JInt( req, 'sub' );

  m_mutex.Acquire;
  try
    dict := m_locks[typ];
    if dict.ContainsKey(id) then
    begin
      elements := dict[id];
      if elements.ContainsKey(sub) then
      begin
        Session := TDSSessionManager.GetThreadSession;
        info := elements[sub];
        if info.SessionID = session.Id then
        begin
          Result := info.getJSON;
          JResponse( Result, true, 'Das Dokument wurde freigegeben.');
          DebugMsg(Format('%s %d %d', ['TLockMod.UnLockDocument: is unlocked', id, typ]));

          elements.Remove(sub);
          info.Free;
        end
        else
        begin
          Result := info.getJSON;
          JResponse( Result, false, 'Das Dokument ist in einer anderen Sitzung gesperrt');
          DebugMsg(Format('%s %d %d', ['TLockMod.UnLockDocument: locked in differend session', id, typ]));
        end;
      end
      else
      begin
        Result := TJSONObject.Create;
        DebugMsg(Format('%s %d %d', ['TLockMod.UnLockDocument: is not locked', id, typ]));
        JResult( Result, false, 'Das Dokument ist nicht gesperrt');
      end;
    end
    else
    begin
      Result := TJSONObject.Create;
      DebugMsg(Format('%s %d %d', ['TLockMod.UnLockDocument: is not locked', id, typ]));
      JResult( Result, false, 'Das Dokument ist nicht gesperrt');
    end;

  finally
    m_mutex.Release;
  end;
end;

end.
