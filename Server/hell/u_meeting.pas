unit u_meeting;

interface

uses
  System.Generics.Collections, u_vote;

type
  TMeetingUser = class;
  TMeeting = class
    private
      FID: integer;
      FPRId: integer;

      m_list : TList<TMeetingUser>;
      FLeadID: integer;
      FVote: TVote;

      function getCount : integer;

    public
      constructor create;
      Destructor Destroy; override;

      property ID: integer read FID write FID;
      property PRId: integer read FPRId write FPRId;
      property count : integer read getCount;
      property LeadID: integer read FLeadID write FLeadID;

      property Vote: TVote read FVote write FVote;

      function addUser(     id : integer; sessionID : NativeInt ) : TMeetingUser;
      function findUser(    id : integer ) : TMeetingUser;
      function removeUser(  id : integer ) : TMeetingUser;

      function hasUser( id : integer ) : boolean;

      function getUserIDBySession( id : NativeInt ): integer;

      function newVote : boolean;
      procedure removeVote;
  end;

  TMeetingUser = class
    private
      FSessionID: NativeInt;
      FID: integer;
    public
      constructor create;
      Destructor Destroy; override;

      property SessionID: NativeInt read FSessionID write FSessionID;
      property ID: integer read FID write FID;
  end;

implementation

uses
  System.SysUtils;

{ TMeeting }

function TMeeting.addUser(id: integer; sessionID : NativeInt): TMeetingUser;
begin
  Result := findUser(id);
  if not Assigned(Result) then begin

    Result            := TMeetingUser.create;
    Result.ID         := id;
    Result.SessionID  := sessionID;

    m_list.Add(Result)
  end;
end;

constructor TMeeting.create;
begin
  m_list  := TList<TMeetingUser>.create;
  FLeadID := -1;
  FVote   := NIL;
end;

destructor TMeeting.Destroy;
var
  me : TMeetingUser;
begin
  for me in  m_list do
    me.Free;
  m_list.Free;

  if Assigned(FVote) then
    FreeAndNil( Fvote );

  inherited;
end;

function TMeeting.findUser(id: integer): TMeetingUser;
var
  us : TMeetingUser;
begin
  Result := NIL;
  for us in m_list do begin
    if us.ID = id  then begin
      Result := us;
      break;
    end;
  end;
end;

function TMeeting.getCount: integer;
begin
  Result := m_list.Count;
end;

function TMeeting.getUserIDBySession(id: NativeInt): integer;
var
  us : TMeetingUser;
begin
  Result := 0;

  for us in m_list do begin
    if us.FSessionID = id then
    begin
      Result := us.ID;
      break;
    end;
  end;
end;

function TMeeting.hasUser(id: integer): boolean;
begin
  Result := Assigned( findUser(id));
end;

function TMeeting.newVote: boolean;
var
  mu : TMeetingUser;
begin
  FVote := TVote.create;

  for mu in m_list do begin
    FVote.addUser( mu.ID );
  end;

  Result := Assigned(FVote);
end;

function TMeeting.removeUser(id: integer): TMeetingUser;
var
  us : TMeetingUser;
begin
  Result := NIL;
  for us in m_list do begin
    if us.ID = id  then begin
      m_list.Remove(us);
      Result := us;
      break;
    end;
  end;
end;

procedure TMeeting.removeVote;
begin
  FreeAndNil(FVote);
end;

{ TMeetingUser }

constructor TMeetingUser.create;
begin

end;

destructor TMeetingUser.Destroy;
begin

  inherited;
end;

end.
