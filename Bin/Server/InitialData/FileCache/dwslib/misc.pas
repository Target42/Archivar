unit misc;

interface


function fullName( name, vorname, abteilung : string ) : string;
function Ergebnis( ja, nein, enthalten : integer ) : string;
function OptionalText( titel : string; datenfeld : string ) : string;

implementation

uses helper;

function fullName( name, vorname, abteilung : string ) : string;
begin
  if abteilung = '' then
    Result := Format('%s, %s', [name, vorname])
  else
    Result := Format('%s, %s (%s)', [name, vorname, abteilung]);
end;

function Ergebnis( ja, nein, enthalten : integer ) : string;
begin
  if      ( ja >0 ) and ( nein + enthalten = 0 ) then Result := Format('Zustimmung einstimmig (%d)', [ja])
  else if ( ja > nein + enthalten )              then Result := Format('Zustimmung (%d), Ablehnung(%d), Enthalten(%d)', [ja, nein, enthalten])
  else if ( ja = nein + enthalten)               then Result := Format('Ablehnung (%d), Enthalten (%d), Zustimmung(%d), ', [nein, enthalten, ja])
  else if ( nein >0 ) and ( ja + enthalten = 0 ) then Result := Format('Ablehnung einstimmig (%d)', [nein]); 
end;

function OptionalText( titel : string; datenfeld : string ) : string;
var
  val : string;
begin
  val := getFieldStr(datenfeld);
  
  if val <> '' then begin 
    if titel <> '' then 
       Result := format('<p>%s<br>%s</p>', [titel, val])
     else
       Result := format('<p>%s</p>', [val]);
   end;     
end;

end.
              
