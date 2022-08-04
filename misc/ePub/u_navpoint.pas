unit u_navpoint;

interface

uses System.Classes, Xml.XmlIntf, System.Generics.Collections;

type
  NavPoint = class
  private
    m_onwer   : NavPoint;
    m_childs  : TObjectList<NavPoint>;
    m_title   : string;
    m_content : string;

    function getPath( root : IXMLNode ; path : string ) : IXMLNode;

  public
    constructor create( owner : NavPoint );
    destructor Destroy; override;

    procedure parse( root : IXMLNode );

    property Title : string read m_title write m_title;
    property Content : string read m_content write m_content;
    property Childs : TObjectList<NavPoint> read m_childs;

    procedure add( var list : TList );
  end;

implementation

uses System.Types, System.SysUtils;

procedure NavPoint.add(var list: TList);
var
  i : integer;
begin
  list.Add(self);
  for i := 0 to pred(m_childs.Count) do
    m_childs.Items[i].add(list);
end;

constructor NavPoint.create( owner : NavPoint );
begin
  m_onwer := owner;
  m_childs  := TObjectList<NavPoint>.create;
end;

destructor NavPoint.Destroy;
begin
  inherited;
  if Assigned(m_childs) then
  begin
    FreeAndNil(m_childs);
  end;
end;


function NavPoint.getPath( root : IXMLNode ; path : string ) : IXMLNode;
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

procedure NavPoint.parse( root : IXMLNode );
var
  tmp : IXMLNode;
  sub : Navpoint;
begin
  tmp := getPath( root, 'navLabel\text');
  if tmp <> NIL then
    m_title := tmp.Text;

  tmp := root.ChildNodes['content'];
  if tmp <> NIL then
    m_content := tmp.Attributes['src'];

  tmp := root.ChildNodes.FindNode('navPoint');

  while tmp <> NIL do
  begin
    if tmp.NodeName ='navPoint' then
    begin
      sub := NavPoint.create(self);
      m_childs.Add(sub);
      sub.parse(tmp);
    end;
    tmp := tmp.NextSibling;
  end;
end;


end.
