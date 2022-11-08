unit u_serverTimer;

interface

uses
  System.Classes, System.Generics.Collections;

type
  TServerTimer = class(TThread)
  private
    type
      TRunThread = class(TThread)
        private
          m_event : TNotifyEvent;
        protected
          procedure Execute; override;
        public
          constructor create( event : TNotifyEvent);
      end;

    type
      TimerType = (shortTimer, dayTimer);
      PTTimerEntry = ^TTimerEntry;
      TTimerEntry = record
        typ       : TimerType;
        id        : integer;
        CallBack  : TNotifyEvent;

        interval  : boolean;

        Timer     : record
          start   : cardinal;
          timeout : cardinal;
          ende    : cardinal;
          counter : cardinal;
        end;

        Day       : record
          Times   : TTime;
          NextDay : TDate;
          Hour    : word;
          Minute  : word;
        end;

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
    constructor create;
    function newTimer( timeout : cardinal;  interval : boolean; callback : TNotifyEvent ) : integer; overload;
    function newTimer( hour, minute : word; interval : boolean; callback : TNotifyEvent ) : integer; overload;
  end;

implementation


uses
  System.DateUtils, System.SysUtils;

{TServerTimer.TRunThread}
constructor TServerTimer.TRunThread.create( event : TNotifyEvent);
begin
  m_event := event;
  inherited create;
end;

procedure TServerTimer.TRunThread.Execute;
begin
  FreeOnTerminate := true;
  if Assigned(m_event) then
    m_event(self);
end;


{ TServerTimer }

procedure TServerTimer.CheckTimeOuts;
var
  i : integer;
  st : cardinal;
begin
  st := GetTickCount;
  for i := pred(m_list.Count) downto 0 do begin

    case m_list[i].typ of
      shortTimer : begin
        if st > m_list[i]^.Timer.ende  then begin

          m_list[i]^.CallBack(self);

          if not m_list[i]^.interval then begin
            remove(m_list[i]^.id);
          end else
            setEnd(m_list[i]);
        end;
      end;
      dayTimer : begin
        if IsSameDay(m_list[i].Day.NextDay, Date) then begin
          if ( HourOfTheDay( time) = m_list[i]^.Day.Hour) and
             ( MinuteOfTheHour(time) = m_list[i]^.Day.Minute )
          then begin

            TRunThread.create(m_list[i]^.CallBack);

            if not m_list[i]^.interval then begin
              remove(m_list[i]^.id);
            end else
              setEnd(m_list[i]);
          end;
        end;
      end;
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

constructor TServerTimer.create;
begin
  prepare;
  inherited create(false);
end;

procedure TServerTimer.Execute;
begin
//  prepare;
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
  ptr^.typ      := shortTimer;
  ptr^.CallBack := callback;
  ptr^.interval := interval;

  ptr^.Timer.start    := GetTickCount;
  ptr^.Timer.timeout  := timeout;
  ptr^.Timer.counter  := 1;
  setEnd(ptr);

  m_list.Add(ptr);

  Result := ptr^.id;
end;

function TServerTimer.newTimer( hour, minute : word; interval : boolean; callback : TNotifyEvent ) : integer;
var
  ptr : PTTimerEntry;
begin
  new(ptr);
  inc(m_id);

  ptr^.id         := m_id;
  ptr^.typ        := dayTimer;
  ptr^.CallBack   := callback;
  ptr^.interval   := interval;

  ptr^.Day.Hour   := hour;
  ptr^.Day.Minute := minute;
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
  case ptr^.typ of
    shortTimer : begin
      ptr^.Timer.ende    := ptr^.Timer.start + ptr^.Timer.counter * ptr^.Timer.timeout;
      ptr^.Timer.counter := ptr^.Timer.counter + 1;
    end;
    dayTimer : begin
      if (HourOfTheDay(time) <= ptr^.Day.Hour) and
         ( MinuteOfTheHour(time) < ptr.Day.Minute )
      then
        ptr^.Day.NextDay := date
      else
        ptr^.Day.NextDay := IncDay(date);
    end;
  end;
end;

end.
