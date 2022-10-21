unit u_serverTimer;

interface

uses
  System.Classes, System.Generics.Collections;

type
  TServerTimer = class(TThread)
  private
    type
      PTTimerEntry = ^TTimerEntry;
      TTimerEntry = record
        id       : integer;
        CallBack : TNotifyEvent;
        interval : boolean;
        start    : cardinal;
        timeout  : cardinal;
        ende     : cardinal;
        counter  : cardinal;
      end;
    private
      m_id    : integer;
      m_list  : TList<PTTimerEntry>;

      procedure setEnd( ptr : PTTimerEntry );
      procedure prepare;
      procedure clean;
      procedure remove( id : integer );
      procedure CheckTimeOuts;
  protected
    procedure Execute; override;

  public
    function newTimer( timeout : cardinal; interval : boolean; callback : TNotifyEvent ) : integer;
  end;

implementation


{ TServerTimer }

procedure TServerTimer.CheckTimeOuts;
var
  i : integer;
  st : cardinal;
begin
  st := GetTickCount;
  for i := pred(m_list.Count) downto 0 do begin

    if st > m_list[i]^.ende  then begin

      m_list[i]^.CallBack(self);

      if not m_list[i]^.interval then begin
        remove(m_list[i]^.id);
      end else
        setEnd(m_list[i]);
    end;
  end;

end;

procedure TServerTimer.clean;
var
  ptr : PTTimerEntry;
begin
  for ptr in m_list do
    Dispose(ptr);
  m_list.Free;
end;

procedure TServerTimer.Execute;
begin
  prepare;
  while not Terminated do begin
    Sleep(250);
    CheckTimeOuts;
  end;
  clean;
end;

function TServerTimer.newTimer(timeout: cardinal; interval: boolean;
  callback: TNotifyEvent) : integer;
var
  ptr : PTTimerEntry;
begin
  new(ptr);
  inc(m_id);

  ptr^.id       := m_id;
  ptr^.start    := GetTickCount;
  ptr^.timeout  := timeout;
  ptr^.CallBack := callback;
  ptr^.counter  := 1;
  setEnd(ptr);
  m_list.Add(ptr);

  Result := ptr^.id;
end;

procedure TServerTimer.prepare;
begin
  FreeOnTerminate := true;
  m_id    := 0;
  m_list  := TList<PTTimerEntry>.create;
end;

procedure TServerTimer.remove(id: integer);
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do begin
    if m_list[i]^.id = id then begin
      dispose(m_list[i]);
      m_list.Delete(i);
      break;
    end;
  end;
end;

procedure TServerTimer.setEnd(ptr: PTTimerEntry);
begin
  ptr^.ende    := ptr^.start + ptr^.counter * ptr^.timeout;
  ptr^.counter := ptr^.counter + 1;
end;

end.
