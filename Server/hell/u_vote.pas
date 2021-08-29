unit u_vote;

interface

uses
  System.Generics.Collections, System.JSON;

type
  TVote = class
  private
    m_votes : TDictionary<integer, integer>;
    FMeetingID: integer;
    FBEID: integer;
  public
    constructor create;
    Destructor Destroy; override;

    property MeetingID: integer read FMeetingID write FMeetingID;
    property BEID: integer read FBEID write FBEID;

    procedure clear;

    procedure addUser( id : integer );
    procedure removeUser( id : integer );

    procedure vote( id, value : integer );

    function getResult   : TJSONObject;
    function getUserList : TJSONObject;
  end;

implementation

uses
  u_json, u_Konst;

{ TVote }

procedure TVote.addUser(id: integer);
begin
  if not m_votes.ContainsKey(id) then
    m_votes.Add(id, 0);
end;

procedure TVote.clear;
var
  user : TArray<integer>;
  id   : integer;
begin
  user := m_votes.Keys.ToArray;

  for id in user do
  begin
    m_votes[id] := -2;
  end;
end;

constructor TVote.create;
begin
  m_votes := TDictionary<integer, integer>.create;
end;

destructor TVote.Destroy;
begin
  m_votes.Free;

  inherited;
end;

function TVote.getResult: TJSONObject;
var
  user  : TArray<integer>;
  id    : integer;
  na    : TJSONArray;  // nicht abgestimmt
  ja    : TJSONArray;  // zugestimmt
  en    : TJSONArray;  // enthalten
  nein  : TJSONArray;  // abgelehnt

begin
  Result:= TJSONObject.Create;

  user  := m_votes.Keys.ToArray;
  na    := TJSONArray.Create;
  ja    := TJSONArray.Create;
  en    := TJSONArray.Create;
  nein  := TJSONArray.Create;

  for id in user do
  begin
    case m_votes[id] of
      VOTE_NOT_DONE : na.AddElement(  TJSONNumber.Create(id));
      VOTE_NO       : nein.AddElement(TJSONNumber.Create(id));
      VOTE_CONTAIN  : en.AddElement(  TJSONNumber.Create(id));
      VOTE_YES      : ja.AddElement(  TJSONNumber.Create(id));
    end;
  end;
  JReplace( Result, 'meid', FMeetingID);
  JReplace( Result, 'beid', FBEID);
  JReplace( Result, 'ja',   ja);
  JReplace( Result, 'nein', nein);
  JReplace( Result, 'na',   na);
  JReplace( Result, 'en',   en);
end;

function TVote.getUserList: TJSONObject;
var
  arr   : TJSONArray;
  user  : TArray<integer>;
  id    : integer;
begin
  Result  := TJSONObject.Create;
  arr     := TJSONArray.Create;

  user  := m_votes.Keys.ToArray;
  for id in user do
    arr.AddElement(TJSONNumber.Create(id));

  JReplace( Result, 'meid', FMeetingID);
  JReplace( Result, 'beid', FBEID);

  JReplace( Result, 'user', arr);
end;

procedure TVote.removeUser(id: integer);
begin
  if m_votes.ContainsKey(id) then
    m_votes.Remove(id);
end;

procedure TVote.vote(id, value: integer);
begin
  m_votes.AddOrSetValue(id, value);
end;

end.
