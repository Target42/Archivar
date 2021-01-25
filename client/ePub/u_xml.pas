unit u_xml;

interface

uses System.Classes, Xml.XMLDoc, Xml.XmlIntf;

function getPath( root : IXMLNode ; path : string ) : IXMLNode;
procedure initXML;

implementation


uses XML.Win.msxmldom, System.Sysutils;

procedure initXML;
begin
  Xml.Win.msxmldom.MSXMLDOMDocumentFactory.AddDOMProperty('ProhibitDTD', False);
end;

function getPath( root : IXMLNode ; path : string ) : IXMLNode;
var
  list  : TStringList;
  tmp   : IXMLNode;
  key   : string;
  i     : integer;
begin
  Result := NIL;
  if (root = NIL) or ( path.isEmpty) then
    exit;
  tmp := NIL;
  list := TStringList.Create;
  list.StrictDelimiter := true;
  list.Delimiter := '\';
  list.DelimitedText := path;

  tmp := root;
  while ( ( list.Count > 0 ) and ( tmp <> NIL ) )do
  begin
      key := list.Strings[0].Trim;
      list.Delete(0);
      if key.IsEmpty then
        Continue;
      for i := 0 to tmp.ChildNodes.Count-1 do
      begin
        if tmp.ChildNodes[i].NodeName = key then
        begin
          tmp := tmp.ChildNodes[i];
          break;
        end;
      end;
  end;

  if list.Count = 0 then
  begin
    Result := tmp;
  end;
  list.Free;
end;

end.
