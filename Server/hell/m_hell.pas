unit m_hell;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery,
  IBX.IBDatabase, u_teilnehmer, System.Generics.Collections, u_meeting;

type
  THellMod = class(TDataModule)
    IBTransaction1: TIBTransaction;
    MeetingQry: TIBQuery;
    UpdateStateQry: TIBQuery;
    UpdateMeetingStatQry: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_list  : TThreadList<TMeeting>;

    function find( var list : TList<TMeeting>; el_id : integer ) : TMeeting;

    function saveStatus(pr_id, pe_id : integer; status : TTeilnehmerStatus) : boolean;
    function setStatus( el_id, pe_id : integer;  var prid : integer; status : TTeilnehmerStatus ) : boolean;

    procedure removeEmpty( var list : TList<TMeeting> );

    procedure SendMeetingInfo(elid: integer ; running : boolean);
  public
    function enter( elid, peid : integer; sessionID : NativeInt ) : boolean;
    function leave( elid, peid : integer) : boolean;

    procedure remove( sessionID : NativeInt );
  end;

var
  HellMod: THellMod;

implementation

uses
  m_db, System.JSON, u_json, ServerContainerUnit1, m_glob_server;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ THellMod }

procedure THellMod.DataModuleCreate(Sender: TObject);
begin
  m_list := TThreadList<TMeeting>.create;
end;

procedure THellMod.DataModuleDestroy(Sender: TObject);
var
  list  : TList<TMeeting>;
  me    : TMeeting;
begin
  list := m_list.LockList;
  try
    for me in list do
      me.Free;
    list.Clear;
  finally
    m_list.UnlockList;
  end;

  m_list.Free;
end;

function THellMod.enter(elid, peid: integer; sessionID: NativeInt) : boolean;
var
  list  : TList<TMeeting>;
  me    : TMeeting;
  prid  : integer;
begin
  DebugMsg(format('HellMod::enter : el:%d pe:%d session:%d', [elid, peid, sessionID]));
  list    := m_list.LockList;
  try
    Result  := setStatus(elid, peid, prid, tsAnwesend);

    if Result then begin
      me := find( list, elid);
      if not Assigned(me) then begin
        me      := TMeeting.create;
        me.ID   := elid;
        me.PRID := prid;
        list.Add(me);
      end;
      me.addUser( peid, sessionID);

      if me.count = 1 then
        SendMeetingInfo( elid, true );

    end;
  finally
    m_list.UnlockList;
  end;
end;

function THellMod.find(var list: TList<TMeeting>; el_id : integer): TMeeting;
var
  me : TMeeting;
begin
  Result := NIL;
  for me in list do begin
    if me.ID = el_id then begin
        Result := me;
      break;
    end;
  end;
end;

function THellMod.leave(elid, peid: integer) : boolean;
var
  list    : TList<TMeeting>;
  me      : TMeeting;
  us      : TMeetingUser;
  unused  : integer;
begin
  list := m_list.LockList;
  try
    Result := setStatus(elid, peid, unused, tsUnbekannt);
    if Result then begin
      for me in list do begin
        us := me.removeUser(peid);
        if Assigned(us) then
          us.Free;
        if me.count = 0 then
          SendMeetingInfo(elid, false);
      end;
    end;
    removeEmpty(list);
  finally
     m_list.UnlockList;
  end;
end;

procedure THellMod.remove(sessionID: NativeInt);
var
  list      : TList<TMeeting>;
  me        : TMeeting;
  id        : integer;
  msgList   : TList<TJSONObject>;
  emptyList : TList<integer>;
  obj       : TJSONObject;
  us        : TMeetingUser;
begin
  DebugMsg('hellmod::remove session:'+IntToStr(sessionID));

  list      := m_list.LockList;
  emptyList := TList<integer>.create;
  msgList   := TList<TJSONObject>.create;
  try
    for me in list do begin
      DebugMsg(format('meeting : el:%d count:%d', [me.ID, me.count]));
      id := me.getUserIDBySession(sessionID);
      if id > 0 then begin
        saveStatus(me.PRId, id, tsUnbekannt);

        obj := TJSONObject.Create;
        JReplace( obj, 'action',  'meeting');
        JReplace( obj, 'id',      me.ID);
        JReplace( obj, 'peid',    id);
        JReplace( obj, 'online',  false);

        us := me.removeUser(id);
        if Assigned(us) then
          us.Free;

        if me.count = 0 then
          emptyList.Add(me.ID);

        msgList.Add(obj)
      end;
    end;
    removeEmpty(list);

    if IBTransaction1.InTransaction then
      IBTransaction1.Commit;

    for obj in msgList do begin
      ServerContainer1.BroadcastMessage('storage', obj);
    end;

    for id in emptyList do begin
      DebugMsg('hellmod::send new meeting info');

      SendMeetingInfo( id, false);
    end;

    msglist.Free;
    emptyList.Free;
  finally
    m_list.UnlockList;
  end;
end;

procedure THellMod.removeEmpty(var list: TList<TMeeting>);
var
  i : integer;
begin
  for i := pred(list.Count) downto 0 do begin
    if list[i].count = 0 then begin
      list[i].Free;
      list.Delete(i);
    end;
  end;
end;

function THellMod.saveStatus(pr_id, pe_id: integer;
  status: TTeilnehmerStatus): boolean;
begin
  UpdateStateQry.ParamByName('pr_id').AsInteger   := pr_id;
  UpdateStateQry.ParamByName('pe_id').AsInteger   := pe_id;
  UpdateStateQry.ParamByName('status').AsInteger  := integer(status);
  UpdateStateQry.ExecSQL;

  Result := UpdateStateQry.RowsAffected > 0 ;

end;

procedure THellMod.SendMeetingInfo(elid: integer ; running : boolean);
var
  msg : TJSONObject;
begin
  UpdateMeetingStatQry.ParamByName('EL_ID').AsInteger := elid;
  if running then
    UpdateMeetingStatQry.ParamByName('status').AsString := 'R'
  else
    UpdateMeetingStatQry.ParamByName('status').AsString := 'O';
  UpdateMeetingStatQry.ExecSQL;

  if IBTransaction1.InTransaction then
    IBTransaction1.Commit;

  msg := TJSONObject.Create;
  JReplace( msg, 'action',  'updatemeeting');
  JReplace( msg, 'id',      elid);
  JReplace( msg, 'running', running);

  ServerContainer1.BroadcastMessage('storage', msg);
end;

function THellMod.setStatus(el_id, pe_id: integer; var prid : integer;
  status: TTeilnehmerStatus): boolean;
var
  msg     : TJSONObject;
begin
  Result := false;

  if el_id = 0 then begin
    exit;
  end;

  msg := NIL;
  MeetingQry.ParamByName('el_id').AsInteger := el_id;
  MeetingQry.Open;

  if not MeetingQry.IsEmpty then begin
    prid := MeetingQry.FieldByName('PR_ID').AsInteger;

    if saveStatus( prid, pe_id, status) then begin
      Result := true;

      msg := TJSONObject.Create;
      JReplace( msg, 'action',  'meeting');
      JReplace( msg, 'id',      el_id);
      JReplace( msg, 'peid',    pe_id);
      JReplace( msg, 'online',  status = tsAnwesend);
    end
  end;
  MeetingQry.Close;

  if IBTransaction1.InTransaction then
    IBTransaction1.Commit;

  if Assigned(msg) then
    ServerContainer1.BroadcastMessage('storage', msg);
end;

end.
