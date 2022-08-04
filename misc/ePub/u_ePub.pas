unit u_ePub;

interface

uses u_navpoint, System.Classes;

type
  ePub = class
    private
      m_filename  : string;

      m_rootFile  : string;
      m_indexFile : String;
      m_title     : string;

      m_home      : string;

      m_root      : NavPoint;
      m_list      : TList;

      procedure extractePub;
      function  loadOpf : boolean;
      procedure loadNcx;
      function getTile : string;
    public
      constructor create;
      destructor Destroy; override;

      function setFileName( fname : string ) : boolean;
      function extractTo( dir : string ) : boolean;

      property FileName : String read m_filename;
      property Title : string read getTile;
      property Root  : NavPoint read m_root;
      property Home  : string read m_home;

      function search( pattern : string ) : TList;

      procedure deleteData;
  end;

implementation

uses Xml.XmlIntf, XML.Win.msxmldom, Xml.XMLDoc, System.SysUtils, System.IoUtils,
  u_xml, System.zip, StrUtils, System.Types, ShellAPI ;

constructor ePub.create;
begin
  m_list :=  TList.create;
  m_root := NIL;
  Xml.Win.msxmldom.MSXMLDOMDocumentFactory.AddDOMProperty('ProhibitDTD', False);
end;

function ePub.getTile: string;
begin
  Result := m_title;
end;

function ePub.extractTo( dir : string ) : boolean;
begin
  m_home := dir;
  ForceDirectories( m_home);
  TZipFile.ExtractZipFile(m_FileName, m_home);

  Result := true;
end;

function ePub.search(pattern: string): TList;
var
  i : integer;
  np : NavPoint;
begin
  Result := Tlist.create;
  for i := 0 to pred(m_list.Count) do
  begin
    np := NavPoint(m_list[i]);
    if ContainsText( np.Title, pattern) then
      Result.Add(np)
    else
    begin
      if ContainsText(np.Content, pattern) then
        Result.Add(np);
    end;
  end;
end;

function ePub.setFileName( fname : string ) : boolean;
var
  xmlDoc  : IXMLDocument;
  root    : IXMLNode;
  node    : IXMLNode;
begin
  Result := false;
  m_filename := fname;
  if FileExists( m_filename) = false then
    exit;

  extractePub;
  fname := TPath.Combine(m_home, 'META-INF/container.xml');
  if FileExists( fname ) = true  then
  begin
    xmlDoc := LoadXMlDocument( fname );
    root := xmlDoc.DocumentElement;
    if (root <> NIL) and ( root.NodeName = 'container') then
    begin
      node := GetPath( root, 'rootfiles\rootfile');
      if node <> NIL then
      begin
        m_rootFile := node.Attributes['full-path'];
        m_indexFile := m_rootFile.Substring(0, m_rootFile.Length - ExtractFileExt(m_rootFile).Length)+'.ncx';
        if loadOpf then
        begin
          loadNcx;
          Result := true;
        end;
      end;
    end;
  end;
end;

procedure ePub.deleteData;
var
  FileOp  : TSHFileOpStruct;
  path    : string;
begin
  path := m_home;

  FillChar(FileOp, SizeOf(FileOp), 0);
  FileOp.wFunc := FO_DELETE;
  FileOp.pFrom := PChar(path+#0);//double zero-terminated
  FileOp.fFlags := FOF_SILENT or FOF_NOERRORUI or FOF_NOCONFIRMATION;
  SHFileOperation(FileOp);
end;

destructor ePub.Destroy;
begin
  inherited;
  FreeAndNil(m_list);
  FreeAndNil(m_root);
end;

procedure ePub.extractePub;
begin
  if m_home.IsEmpty then
  begin
    m_home := m_filename;
    SetLength(m_home, m_home.Length - ExtractFileExt( m_filename).Length );
    if DirectoryExists(m_home) = false then
    begin
      ForceDirectories(m_home);
      TZipFile.ExtractZipFile(m_FileName, m_home);
    end;
  end;
end;

function ePub.loadOpf : boolean;
var
  xmlDoc  : IXMLDocument;
  root    : IXMLNode;
  node    : IXMLNode;
  fname   : string;
begin
  Result := false;
  fname := TPath.Combine( m_home, m_rootFile);

  if FileExists( fname ) = false then
    exit;

    xmlDoc := LoadXMlDocument( fname );
    root := xmlDoc.DocumentElement;
    if (root <> NIL) and ( root.NodeName = 'package') then
    begin
      node := GetPath( root, 'metadata\dc:title' );
      if node <> NIL then
        m_title := node.Text;
      Result := true;
    end;
end;


procedure ePub.loadNcx;
var
  xmlDoc : IXMLDocument;
  root   : IXMlNode;
  nav    : IXMLNode;
  fname  : string;
begin
  fname :=  TPath.Combine(m_home, m_indexFile);
  if FileExists(fname) then
  begin
    xmlDoc := LoadXMLDocument(fname);
    xmlDoc.Active := true;
    root := xmlDoc.DocumentElement;

    if (root <> NIL) and ( root.NodeName ='ncx') then
    begin
      nav := getPath(root, 'navMap\navPoint');
      m_root  := NavPoint.create(NIL);
      m_root.parse(nav);
    end;
  end;
   m_root.add(m_list);
end;

end.
