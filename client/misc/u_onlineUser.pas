unit u_onlineUser;

interface

uses
  System.JSON, System.Classes, System.Generics.Collections, Vcl.ComCtrls;

type

  TOnlineUser = class(TObject)
    public
      type
        pREntry= ^REntry;
        REntry = record
          id      : integer;
          name    : string;
          vorname : string;
          dept    : string;
          status  : string;
        end;
        TEntryData = array of REntry;
    private
       m_evt  : TNotifyEvent;
       m_data : TEntryData;
       m_map  : TDictionary<integer, pREntry>;

       function getCount : integer;
       function handle_onlineUser( const arg : TJSONObject ): boolean;
       function handle_stateChange( const arg : TJSONObject ): boolean;
    public

      constructor create;
      Destructor Destroy; override;

      property Count : integer read getCount;
      property Data  : TEntryData read m_data;

      property OnChangeData : TNotifyEvent read m_evt write m_evt;

      procedure fillUserList( obj : TJSONObject );
      procedure updateData(   obj : TJSONObject );
      procedure changeState(  obj : TJSONObject );
      procedure clear;
  end;


var
  OnlineUser : TOnlineUser;

procedure createGroups( lv : TListView );
function getOnlineGroupID( text : string ) : integer;

implementation

uses
  u_json, System.SysUtils, u_eventHandler, u_Konst;

var
  OnlineGrps : array[0..3] of string;

procedure createGroups( lv : TListView );
var
  i : integer;
  grp : TListGroup;
begin
  LV.Groups.Clear;
  for i := Low(OnlineGrps) to High(OnlineGrps) do
  begin
    grp := lv.Groups.Add;
    grp.Header  := OnlineGrps[i];
    grp.GroupID := i;
  end;
end;


function getOnlineGroupID( text : string ) : integer;
var
  i : integer;
begin
  Result := 0;
  for i := Low(OnlineGrps) to High(OnlineGrps) do
  begin
    if SameText( text, OnlineGrps[i]) then
    begin
      Result := i;
      break;
    end;

  end;

end;

{ TOnlineUser }

procedure TOnlineUser.changeState(obj: TJSONObject);
var
  ptr : pREntry;
  id  : Integer;
begin
  id := JInt( obj, 'id');
  if m_map.ContainsKey(id) then
  begin
    ptr := m_map[id];
    ptr^.status := JString( obj, 'state');
    if Assigned(m_evt) then
      m_evt(self);
  end;
end;

procedure TOnlineUser.clear;
begin

end;

constructor TOnlineUser.create;
begin
  inherited;
  m_evt := NIL;
  m_map := TDictionary<integer, pREntry>.create;

  EventHandler.Register( self, handle_onlineUser,   BRD_ONLINE_USER );
  EventHandler.Register( self, handle_stateChange,  BRD_ONLINE_STATE );
end;

destructor TOnlineUser.Destroy;
begin
  if Assigned(EventHandler) then
    EventHandler.Unregister(self);

  m_evt := NIL;
  m_map.free;
  inherited;
end;

procedure TOnlineUser.fillUserList(obj: TJSONObject);
var
  arr : TJSONArray;
  row : TJSONObject;
  i   : integer;
begin
  SetLength(m_data, 0);
  m_map.Clear;

  arr := JArray( obj, 'user');
  if not Assigned(arr) then
    exit;

  SetLength(m_data, arr.Count);

  for i := 0 to pred(arr.Count) do
  begin
    row := getRow(arr, i);

    m_data[i].id      := JInt( row, 'id');
    m_data[i].name    := JString( row, 'name');
    m_data[i].vorname := JString( row, 'vorname');
    m_data[i].dept    := JString( row, 'dept');
    m_data[i].status  := '';

    m_map.AddOrSetValue( m_data[i].id, @m_data[i]);
  end;
end;

function TOnlineUser.getCount: integer;
begin
  Result := Length(m_data);
end;

function TOnlineUser.handle_onlineUser(const arg: TJSONObject): boolean;
begin
  updateData(arg);
  Result := true;
end;

function TOnlineUser.handle_stateChange(const arg: TJSONObject): boolean;
begin
  changeState(arg);
  Result := true;
end;

procedure TOnlineUser.updateData(obj: TJSONObject);
var
  ptr   : pREntry;
  i, id : integer;
  arr   : TJSONArray;
  row   : TJSONObject;
begin
  arr := JArray( obj, 'user');
  if not Assigned(arr) then
    exit;
  for i := low(m_data) to High(m_data) do
    m_data[i].status := '';

  for i := 0 to pred(arr.Count) do
  begin
    row := getRow(arr, i);
    id  := JInt( row, 'id');

    if m_map.ContainsKey(id) then
    begin
      ptr := m_map[id];
      ptr^.status := JString( row, 'state');
    end;
  end;

  if Assigned(m_evt) then
    m_evt(self);
end;

initialization
  OnlineUser := TOnlineUser.create;

  OnlineGrps[0] := 'Unbekannt';
  OnlineGrps[1] := 'Online';
  OnlineGrps[2] := 'Beschäftigt';
  OnlineGrps[3] := 'Offline;';

finalization
  OnlineUser.Free;

end.
