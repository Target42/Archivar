unit u_Konst;

interface

uses
  System.Classes;

// Task flags
const
  taskNew         = $01;
  taskRead        = $02;
  taskInWork      = $04;
  taskWorkEnd     = $08;
  taskWaitForInfo = $10;
  taskWaitForOK   = $20;
  taskProtocol    = $40;

  taskAll       =  taskNew or taskRead or taskInWork or taskWorkEnd or
                   taskWaitForInfo or taskWaitForOK or taskProtocol;

  taskReady     =  taskWaitForOK or taskWaitForInfo or taskProtocol;


function flagsToStr( flags : integer ) : string;
procedure FillFlagslist( list : TStrings; filter : integer = 0 );

implementation

type
  FlagsRec = record
    Name : string;
    flag : integer;
  end;

var
  FlagData : array[0..6] of FlagsRec =
  (
    (name:'Neu';                        flag:taskNew),
    (name:'Gelesen';                    flag:taskRead),
    (name:'In Bearbeitung';             flag:taskInWork),
    (name:'Bearbeitung abgeschlossen';  flag:taskWorkEnd),
    (name:'Klärungsbedarf';             flag:taskWaitForInfo),
    (name:'Beschlusvorlage';            flag:taskWaitForOK),
    (name:'Protokoll';                  flag:taskProtocol)

  );

function flagsToStr( flags : integer ) : string;
var
  i : integer;
begin
  Result := 'Unbekannt';
  for i := Low(FlagData) to High(FlagData) do
  begin
    if (FlagData[i].flag and flags)  <> 0 then
    begin
      Result := FlagData[i].Name;
      break;
    end;
  end;
end;

procedure FillFlagslist(  list : TStrings ; filter : integer );
var
  i : integer;
begin
  if filter = 0 then
    filter := taskAll;

  for i := low(FlagData) to High(FlagData) do
  begin
    if (FlagData[i].flag and filter) <> 0 then
    begin
      list.AddObject(FlagData[i].Name, Pointer(FlagData[i].flag));
    end;
  end;
end;

end.
