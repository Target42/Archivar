unit u_Konst;

interface

// Task flags
const
  taskNew         = $01;
  taskRead        = $02;
  taskInWork      = $04;
  taskWorkEnd     = $08;
  taskWaitForInfo = $10;

  taskAll =  taskNew or taskRead or taskInWork or taskWorkEnd or taskWaitForInfo;


function flagsToStr( flags : integer ) : string;

implementation

function flagsToStr( flags : integer ) : string;
begin
  Result := 'Unbekannt';

  if (flags and taskNew) = taskNew then
    Result := 'Neu'
  else if (flags and taskRead) = taskRead then
    Result := 'Gelesen'
  else if (flags and taskInWork) = taskInWork then
    Result := 'In Bearbeitung'
  else if (flags and taskWorkEnd) = taskWorkEnd then
    Result := 'Bearbeitung abgeschlossen'
  else if (flags and taskWaitForInfo) = taskWaitForInfo then
    Result := 'Klärungsbedarf';
end;

end.
