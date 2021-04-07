unit u_onlineUser;

interface

uses
  System.JSON, System.Classes;

type

  TOnlineUser = class(TObject)
    public
      type
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

       function getCount : integer;
    public

      constructor create;
      Destructor Destroy; override;

      property Count : integer read getCount;
      property Data  : TEntryData read m_data;

      property OnChangeData : TNotifyEvent read m_evt write m_evt;

      procedure fillUserList( obj : TJSONObject );
      procedure updateData(   obj : TJSONObject );
      procedure clear;
  end;


var
  OnlineUser : TOnlineUser;

implementation

uses
  u_json, System.Generics.Collections;

{ TOnlineUser }

procedure TOnlineUser.clear;
begin

end;

constructor TOnlineUser.create;
begin
  inherited;
  m_evt := NIL;
end;

destructor TOnlineUser.Destroy;
begin
  m_evt := NIL;

  inherited;
end;

procedure TOnlineUser.fillUserList(obj: TJSONObject);
var
  arr : TJSONArray;
  row : TJSONObject;
  i   : integer;
begin
  SetLength(m_data, 0);

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
    m_data[i].status  := 'Unbekannt';
  end;
end;

function TOnlineUser.getCount: integer;
begin
  Result := Length(m_data);
end;

procedure TOnlineUser.updateData(obj: TJSONObject);
var
  list : TList<integer>;
  i    : integer;
begin
  list := getIntNumbers( obj, 'user' );

  for i := low(m_data) to High(m_data) do
  begin
    m_data[i].status := '';
    if list.IndexOf(m_data[i].id) <> -1 then
      m_data[i].status := 'Online';
  end;

  list.Free;

  if Assigned(m_evt) then
    m_evt(self);
end;

initialization
  OnlineUser := TOnlineUser.create;
finalization
  OnlineUser.Free;

end.
