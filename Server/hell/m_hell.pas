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
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_list  : TThreadList<TMeeting>;

    function find( var list : TList<TMeeting>; el_id : integer ) : TMeeting;

    function saveStatus(pr_id, pe_id : integer; status : TTeilnehmerStatus) : boolean;
    function setStatus( el_id, pe_id : integer;  var prid : integer; status : TTeilnehmerStatus ) : boolean;
  public
    function enter( elid, peid : integer; sessionID : NativeInt ) : boolean;
    function leave( elid, peid : integer) : boolean;

    procedure remove( sessionID : NativeInt );
  end;

var
  HellMod: THellMod;

implementation

uses
  m_db, System.JSON, u_json, ServerContainerUnit1;

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
  list    := m_list.LockList;
  try
    Result  := setStatus(elid, peid, prid, tsAnwesend);

    if Result then begin
      me := find( list, elid);
      if not Assigned(me) then begin
        me      := TMeeting.create;
        me.ID   := elid;
        me.PRID := prid;
      end;
      me.addUser( peid, sessionID);
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
  unused  : integer;
begin
  list := m_list.LockList;
  try
    Result := setStatus(elid, peid, unused, tsUnbekannt);
    if Result then begin
      for me in list do begin
        me.removeUser(peid);
      end;
    end;
  finally
     m_list.UnlockList;
  end;
end;

procedure THellMod.remove(sessionID: NativeInt);
var
  list    : TList<TMeeting>;
  me      : TMeeting;
  id      : integer;
  msgList : TList<TJSONObject>;
  obj     : TJSONObject;
begin
  msgList := TList<TJSONObject>.create;
  list := m_list.LockList;
  try
    for me in list do begin
      id := me.getUserIDBySession(sessionID);
      if id > 0 then begin
        saveStatus(me.PRId, id, tsUnbekannt);

        obj := TJSONObject.Create;
        JReplace( obj, 'action',  'meeting');
        JReplace( obj, 'id',      me.ID);
        JReplace( obj, 'peid',    id);
        JReplace( obj, 'online',  false);
        msgList.Add(obj)
      end;
    end;
  finally
    m_list.UnlockList;
  end;
  if IBTransaction1.InTransaction then
    IBTransaction1.Commit;

  for obj in msgList do begin
    ServerContainer1.BroadcastMessage('storage', obj);
  end;

  list.Free;
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