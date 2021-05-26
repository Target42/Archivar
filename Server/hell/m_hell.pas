unit m_hell;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery,
  IBX.IBDatabase, u_teilnehmer, System.Generics.Collections, u_meeting,
  System.JSON;

type
  THellMod = class(TDataModule)
    IBTransaction1: TIBTransaction;
    MeetingQry: TIBQuery;
    UpdateStateQry: TIBQuery;
    UpdateMeetingStatQry: TIBQuery;
    PEqry: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_list  : TThreadList<TMeeting>;

    function find( var list : TList<TMeeting>; el_id : integer ) : TMeeting;

    function saveStatus(pr_id, pe_id : integer; status : TTeilnehmerStatus) : boolean;
    function setStatus( el_id, pe_id : integer;  var prid : integer; status : TTeilnehmerStatus ) : boolean;

    procedure removeEmpty( var list : TList<TMeeting> );

    procedure SendMeetingInfo(elid: integer ; running : boolean; leadID : integer);

    procedure fillUser( peid : integer ; var obj : TJSONObject );
    procedure sendStopLead( id : integer );
  public
    function enter( elid, peid : integer; sessionID : NativeInt ) : boolean;
    function leave( elid, peid : integer) : boolean;

    procedure remove( sessionID : NativeInt );

    function changeStatus( obj : TJSONObject ) : TJSONObject;

    function requestLead( obj : TJSONObject ) : TJSONObject;
    function changeLead( obj : TJSONObject ) : TJSONObject;

  end;

var
  HellMod: THellMod;

implementation

uses
  m_db, u_json, ServerContainerUnit1, m_glob_server;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ THellMod }

function THellMod.changeLead(obj: TJSONObject): TJSONObject;
var
  el    : Integer;
  list  : TList<TMeeting>;
  me    : TMeeting;
  msg   : TJSONObject;
begin
  Result  := TJSONObject.Create;
  list    := m_list.LockList;
  try
    el    := JInt( obj, 'id');
    for me in list do begin
      if me.ID = el then begin
        me.LeadID := JInt( obj, 'newid');

        msg := TJSONObject.Create;
        JReplace( msg, 'action',  'changelead');
        JReplace( msg, 'id',      el);
        JReplace( msg, 'newid',   me.LeadID);

        fillUser( me.LeadID, msg );

        ServerContainer1.BroadcastMessage('storage', msg);

        break;
      end;
    end;
  finally
    m_list.UnlockList;
  end;

end;

function THellMod.changeStatus(obj: TJSONObject): TJSONObject;
var
  ts    : TTeilnehmerStatus;
  list  : TList<integer>;
  id    : integer;
  elid  : integer;
  prid  : integer;
  msg   : TJSONObject;
  arr   : TJSONArray;
begin
  Result  := TJSONObject.Create;
  ts      := TTeilnehmerStatus(JInt(obj, 'status' ));
  elid    := JInt(obj, 'elid');
  list    := getIntNumbers( obj, 'list' );
  arr     := TJSONArray.Create;

  prid    := -1;

  MeetingQry.ParamByName('el_id').AsInteger := elid;
  MeetingQry.Open;
  if not MeetingQry.IsEmpty then
    prid := MeetingQry.FieldByName('PR_ID').AsInteger;
  MeetingQry.Close;

  if (prid <> -1) then begin
    for id in list do begin
      saveStatus(prid, id, ts);
      arr.AddElement(TJSONNumber.Create(id));
    end;
  end;

  if IBTransaction1.InTransaction then
    IBTransaction1.Commit;

  msg := TJSONObject.Create;
  JReplace( msg, 'action',  'meeting');
  JReplace( msg, 'id',      elid);
  JReplace( msg, 'status',  integer(ts));
  JReplace( msg, 'list',    arr);
  ServerContainer1.BroadcastMessage('storage', msg);

  list.Free;

  JResult( Result, true, '');
end;


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
        SendMeetingInfo( elid, true, me.LeadID );

    end;
  finally
    m_list.UnlockList;
  end;
end;

procedure THellMod.fillUser(peid: integer; var obj: TJSONObject);
begin
  PEqry.ParamByName('pe_id').AsInteger := peid;
  PEqry.Open;
  if not PEqry.IsEmpty then begin
    JReplace( obj, 'name', PEqry.FieldByName('pe_name').AsString);
    JReplace( obj, 'vorname', PEqry.FieldByName('pe_vorname').AsString);
    JReplace( obj, 'dept', PEqry.FieldByName('PE_DEPARTMENT').AsString);
  end;
  PEqry.Close;

  if IBTransaction1.InTransaction then
    IBTransaction1.Commit;
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

        if me.LeadID = peid then begin
          me.LeadID := -1;
          sendStopLead(me.ID);
        end;

        if Assigned(us) then
          us.Free;
        if me.count = 0 then
          SendMeetingInfo(elid, false, me.leadID);
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

        if me.LeadID = id  then begin
          DebugMsg('hellmod::remove stop lead: '+IntToStr(me.LeadID));
          me.LeadID := -1;
          sendStopLead(me.ID);
        end;

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

      SendMeetingInfo( id, false, -1);
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

function THellMod.requestLead(obj: TJSONObject): TJSONObject;
var
  el    : integer;
  peid  : integer;
  list  : TList<TMeeting>;
  me    : TMeeting;
  msg   : TJSONObject;
begin
  Result  := TJSONObject.Create;
  el      := JInt( obj, 'id');
  peid    := JInt( obj, 'peid');

  list    := m_list.LockList;
  try
    for me in list do begin
      if me.ID = el then begin
        msg := TJSONObject.Create;
        JReplace( msg, 'id',      el);
        fillUser( peid, msg);
        if me.LeadID <> -1 then begin
          JReplace( msg, 'action',  'requestlead');
          JReplace( msg, 'newid',   peid);
          JReplace( msg, 'lead',    me.LeadID);
        end
        else
        begin
          me.LeadID := peid;

          JReplace( msg, 'action',  'changelead');
          JReplace( msg, 'lead',    me.LeadID);
        end;
        ServerContainer1.BroadcastMessage('storage', msg);

        break;
      end;
    end;
  finally
    m_list.UnlockList;
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

procedure THellMod.SendMeetingInfo(elid: integer ; running : boolean; leadID : integer);
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
  JReplace( msg, 'leadid',  leadID );

  ServerContainer1.BroadcastMessage('storage', msg);
end;

procedure THellMod.sendStopLead(id: integer);
var
  msg : TJSONObject;
begin
  msg := TJSONObject.Create;
  JReplace( msg, 'action',  'changelead');
  JReplace( msg, 'id',      id);
  JReplace( msg, 'lead',   -1);

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
