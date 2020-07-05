{ 
  Erzeugt am 20:38 17.05.2020
}
program script;

var
  i : integer;
  j : integer;
begin
  print('<h1>XML</h1>');
  print( '<pre>'+printXML+'</pre>');
  print('<h1>Einstellungen: ');
  print(getFieldStr('MA_NACHNAME')+', '+getFieldStr('MA_VORNAME'));
  printLN('</h1>');                        
end.                 
