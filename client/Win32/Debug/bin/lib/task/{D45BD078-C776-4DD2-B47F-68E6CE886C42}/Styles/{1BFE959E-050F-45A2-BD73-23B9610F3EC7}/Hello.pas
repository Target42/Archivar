{ 
  Erzeugt am 20:38 17.05.2020
}
program script;

var
  i : integer;
  j : integer;
begin
  print('<h1>Einstellunge: ');
  print(getFieldStr('MA_NACHNAME')+', '+getFieldStr('MA_VORNAME'));
  printLN('</h1>');             
end.                 
