unit u_teilnehmer;

interface

uses
  System.Classes;

type
  TTeilnehmerStatus = (
    tsUnbekannt = 0,

    tsVerfuegbar,
    tsAnwesend,
    tsEntschuldigt,
    tsEingeladen,
    tsUnentschuldigt,
    tsZugesagt,
    tsAbgelehnt,

    tsLast);
  TTeilnehmerStatusSet = set of TTeilnehmerStatus;

function TeilnehmerStatusToString( st : TTeilnehmerStatus; ShowAll : boolean = false) : string;
function StringToTTeilnehmerStatus( value : string ) : TTeilnehmerStatus;
procedure FillTeilnehmerStatusList( list : TStrings );

implementation

uses
  System.SysUtils;

function TeilnehmerStatusToString( st : TTeilnehmerStatus; ShowAll : boolean) : string;
begin
  case st of
    tsUnbekannt:      Result := 'Unbekannt';
    tsVerfuegbar:     Result := 'Verfügbar';
    tsAnwesend:       Result := 'Anwesend';
    tsEntschuldigt:   Result := 'Entschuldigt';
    tsUnentschuldigt: Result := 'Unentschuldigt';
    tsEingeladen:     Result := 'Eingeladen';
    tsZugesagt:       Result := 'Zugesagt';
    tsAbgelehnt:      Result := 'Abgelehnt';
    tsLast:           Result := 'Last';
    else
      Result := '??';
  end;

  if not ShowAll and ( (st = tsUnbekannt) or (st = tsLast)) then
    Result := '';
end;

function StringToTTeilnehmerStatus( value : string ) : TTeilnehmerStatus;
begin
  if SameText(value, 'unbekannt') then
    Result := tsUnbekannt
  else if sameText(value, 'Verfügbar') then
    Result := tsVerfuegbar
  else if sameText(value, 'Anwesend') then
    Result := tsAnwesend
  else if SameTExt( value, 'Entschuldigt') then
    Result := tsEntschuldigt
  else if SameText(value, 'Eingeladen') then
    Result := tsEingeladen
  else if SameText(value, 'Unentschuldigt') then
    Result := tsUnentschuldigt
  else if SameText(value, 'Zugesagt') then
    Result := tsZugesagt
  else if SameText(value, 'Abgelehnt') then
    Result := tsAbgelehnt
  else
    Result := tsUnbekannt;

end;

procedure FillTeilnehmerStatusList( list : TStrings );
var
  i : TTeilnehmerStatus;
begin
  for i := tsVerfuegbar to tsUnentschuldigt do
  begin
    list.AddObject(TeilnehmerStatusToString(i), (TObject(i)));
  end;

end;

end.
