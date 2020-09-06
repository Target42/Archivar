unit m_lockMod;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Classes, u_lockInfo,
  System.JSON, IBX.IBDatabase;

type
  TLockMod = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_locks :  array[1..2] of TThreadlist<TLockInfo>;

    function find( ta_id:integer;list :  TList<TLockInfo>): TLockInfo;
  public
    function LockDocument( id, typ : integer ) : TJSONObject;
    function UnLockDocument( id, typ : integer ) : TJSONObject;
    function isLocked( id, typ : integer ) : TJSONObject;

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
  for i := low(m_locks) to High(m_locks) do
    m_locks[i] := TThreadlist<TLockInfo>.create;
end;

procedure TLockMod.DataModuleDestroy(Sender: TObject);
var
  i, j : integer;
  list : Tlist<TLockInfo>;
begin
  for j := low(m_locks) to High(m_locks) do
  begin
    list := m_locks[j].LockList;
    for i := 0 to pred(list.Count) do
      list[i].Free;
    m_locks[j].UnlockList;

    m_locks[j].Free;
  end;
end;

function TLockMod.find(ta_id:integer;list: TList<TLockInfo>): TLockInfo;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(list.Count) do
  begin
    if list[i].ID = ta_id then
    begin
      Result := list[i];
      break;
    end;

  end;

end;

function TLockMod.isLocked(id, typ: integer): TJSONObject;
var
  list : TList<TLockInfo>;
  info : TLockInfo;
  session : TDSSession;
begin
  list := m_locks[typ].LockList;
  info := find( id, list );
  if Assigned( info) then
  begin
    Session := TDSSessionManager.GetThreadSession;
    Result := info.getJSON;
    DebugMsg(Format('%s %d %d', ['TLockMod.isLocked: is locked', id, typ]));
    JResponse( Result, true, 'Das Dokument ist von '+info.User+' gesperrt');
    JReplace( Result, 'self', session.Id = info.SessionID);
  end
  else
  begin
    Result := TJSONObject.Create;
    JResult( Result, false, 'Das Dokument ist nicht gesperrt');
    DebugMsg(Format('%s %d %d', ['TLockMod.isLocked: is NOT locked', id, typ]));
  end;

  m_locks[typ].UnlockList;
end;

function TLockMod.LockDocument(id, typ: integer): TJSONObject;
var
  list : TList<TLockInfo>;
  info : TLockInfo;
  session : TDSSession;
begin
  list := m_locks[typ].LockList;
  info := find( id, list );
  if Assigned( info) then
  begin
    Result := info.getJSON;
    DebugMsg(Format('%s %d %d', ['TLockMod.LockDocument: is locked', id, typ]));
    JResult( Result, false, 'Das Dokument ist bereits gesperrt');
  end
  else
  begin
    Session := TDSSessionManager.GetThreadSession;

    info := TLockInfo.create;
    list.Add(info);
    info.ID         := id;
    info.Locked     := true;
    info.Host       := session.GetData('host');
    info.TimeStamp  := now;
    info.SessionID  := session.Id;
    info.User       := session.GetData('user');

    Result := info.getJSON;
    DebugMsg(Format('%s %d %d', ['TLockMod.LockDocument: is NOW locked', id, typ]));
    JResult( Result, true, 'Das Dokument wurde gesperrt');
  end;
  m_locks[typ].UnlockList;
end;

procedure TLockMod.removeLocks(id: NativeInt);
var
  i, j : integer;
  list : TList<TLockInfo>;
begin
  for j := Low(m_locks) to High(m_locks) do
  begin
    list := m_locks[j].LockList;
    for i := pred(list.Count) downto 0 do
    begin
      if list[i].SessionID = id  then
      begin
        DebugMsg( 'removeLocks : '+list[i].CLID+' session id : '+IntToStr(id ));
        list[i].Free;
        list.Delete(i);
      end;
    end;
    m_locks[j].UnlockList;
  end;
end;

function TLockMod.UnLockDocument(id, typ: integer): TJSONObject;
var
  list : TList<TLockInfo>;
  info : TLockInfo;
  session : TDSSession;
begin
  list := m_locks[typ].LockList;
  info := find( id, list );
  if Assigned( info) then
  begin
    Session := TDSSessionManager.GetThreadSession;
    if info.SessionID = session.Id then
    begin
      Result := info.getJSON;
      JResponse( Result, true, 'Das Dokument wurde freigegeben.');
      DebugMsg(Format('%s %d %d', ['TLockMod.UnLockDocument: is unlocked', id, typ]));
      list.Remove(info);
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

  m_locks[typ].UnlockList;
end;

end.
