unit u_meeting_status;

interface


const
  Meeting_Created = 'E';
  Meeting_Invited = 'O';
  Meeting_Running = 'R';
  Meeting_Closed  = 'C';

function buildMeetingFilter( arr : array of String ) : string;

implementation

function buildMeetingFilter( arr : array of String ) : string;
var
  i : integer;
begin
  Result := '';
  for i := low(arr) to High(arr) do begin
    Result := Result + ''''+arr[i]+''''+',';
  end;
  SetLength(Result, Length(Result)-1);
end;

end.
