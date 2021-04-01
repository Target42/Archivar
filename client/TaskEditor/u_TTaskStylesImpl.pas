unit u_TTaskStylesImpl;

interface

uses
  i_taskEdit, System.Generics.Collections, System.Types, System.Classes,
  system.zip;

type
  TTaskStylesImpl = class(TInterfacedObject, ITaskStyles)
    private
      m_list : TList<ITaskStyle>;
      m_listener : TList<TaskStylesChange>;
      m_default  : ITaskStyle;
      procedure setTaskStyle( inx : integer; const value : ITaskStyle );
      function  getTaskStyle(inx : integer ) : ITaskStyle;
      function getCount : integer;
      function  getDefaultStyle : ITaskStyle;
      procedure setDefaultStyle( value : ITaskStyle );

      procedure doChange;
    public
      constructor create;
      Destructor Destroy; override;

      property Items[ inx : integer ]: ITaskStyle read getTaskStyle write setTaskStyle;
      property Count : integer read getCount;

      function newStyle(name : String ) : ITaskStyle;

      function loadFromPath( path : string ) : boolean;
      function loadFromZip( zip : TZipFile; path : string ) : boolean;

      function saveToPath( path : string ) : boolean;
      function saveToZip( zip : TZipFile; path : string ) : Boolean;

      procedure FillList( list : TStrings );

      function getStyle( name : string ) : ITaskStyle;
      function getStyleByClid( clid : string ) : ITaskStyle;
      function rename( style : ITaskStyle; name :string ) : boolean;

      function delete(style : ITaskStyle ) : boolean;

      procedure registerChange(  proc : TaskStylesChange );
      procedure uregisterChange( proc : TaskStylesChange );

      procedure release;
  end;

implementation

uses
  System.IOUtils, u_tTaskStyleImpl, System.SysUtils, u_zipHelper, xsd_Styles,
  Xml.XMLIntf, Xml.XMLDoc, System.StrUtils;

{ TTaskStylesImpl }

constructor TTaskStylesImpl.create;
begin
  m_list := TList<ITaskStyle>.create;
  m_listener := TList<TaskStylesChange>.create;
end;

function TTaskStylesImpl.delete(style: ITaskStyle): boolean;
begin
  Result := m_list.Contains(style);
  if Result then
  begin
    m_list.Remove(style);
    style.release;

    if m_default = style then
    begin
      m_default := NIL;
      if m_list.Count > 0 then
        m_default := m_list[0];
    end;

    doChange;
  end;
end;

destructor TTaskStylesImpl.Destroy;
begin
  m_list.Free;
  m_listener.Free;
  inherited;
end;

procedure TTaskStylesImpl.doChange;
var
  i : integer;
begin
  for i := 0 to pred(m_listener.Count) do
    m_listener[i](self);
end;

procedure TTaskStylesImpl.FillList(list: TStrings);
var
  i : integer;
  s : string;
begin
  for i := 0 to pred(m_list.Count) do
  begin
    s := m_list[i].Name;
    if m_list[i] = m_default then
      s := s + '*';
    list.AddObject(s, Pointer(m_list[i]));
  end;
end;

function TTaskStylesImpl.getCount: integer;
begin
  Result := m_list.Count;
end;

function TTaskStylesImpl.getDefaultStyle: ITaskStyle;
begin
  Result := m_default;
end;

function TTaskStylesImpl.getStyle(name: string): ITaskStyle;
var
  i : integer;
begin
  Result := m_default;
  for i := 0 to pred(m_list.Count) do
  begin
    if m_list[i].isName(name) then
    begin
      Result := m_list[i];
      break;
    end;
  end;
end;

function TTaskStylesImpl.getStyleByClid(clid: string): ITaskStyle;
var
  i : integer;
begin
  Result := m_default;
  for i := 0 to pred(m_list.Count) do
  begin
    if SameText( m_list[i].CLID, clid) then
    begin
      Result := m_list[i];
      break;
    end;
  end;
end;

function TTaskStylesImpl.getTaskStyle(inx: integer): ITaskStyle;
begin
  Result := m_list[inx];
end;

function TTaskStylesImpl.loadFromPath(path: string): boolean;
var
  arr : TStringList;
  fname : string;
  i   : integer;
  st  : ITaskStyle;
  xStyles : IXMLStyles;
begin
  fname := TPath.combine(path, 'styles.xml');
  if FileExists(fname) then
  begin
    xStyles := LoadStyles( fname );
    for i := 0 to pred(xStyles.Count) do
    begin
      st := TTaskStyleimpl.create;
      st.loadFromPath( TPath.Combine(path, xStyles.Style[i].Clid));
      m_list.Add(st)
    end;
    Result := true;
  end
  else
  begin
    fname := TPath.Combine( path, 'index.txt');

    arr := TStringList.Create;
    if FileExists(fname) then
      arr.LoadFromFile(fname);

    for i := 0 to pred(arr.Count) do
    begin
      st := TTaskStyleimpl.create;
      st.loadFromPath( TPath.Combine(path, arr.Strings[i]));
      m_list.Add(st)
    end;
    arr.Free;
    Result := true;
  end;
end;

function TTaskStylesImpl.loadFromZip(zip: TZipFile; path: string): boolean;
var
  list    : TStringList;
  i       : integer;
  st      : ITaskStyle;
  fname   : string;
  xStyles : IXMLStyles;
  xml     : IXMLDocument;
  zst     : TStream;
begin
  Result := false;

  fname := TPath.combine(path, 'styles.xml');
  if hasFile( zip, fname) then
  begin
    zst := loadStreamFromZip(zip, fname);
    xml := NewXMLDocument;
    xml.LoadFromStream(zst);

    xStyles := xml.GetDocBinding('Styles', TXMLStyles, TargetNamespace) as IXMLStyles;
    zst.Free;
    if Assigned(xStyles) then
    begin
      for i := 0 to pred(xStyles.Count) do
      begin
        st := TTaskStyleimpl.create;
        st.loadFromZip( zip, TPath.Combine(path, xStyles.Style[i].Clid));
        st.Name := xStyles.Style[i].Name;
        st.CLID := xStyles.Style[i].Clid;
        m_list.Add(st)
      end;
    end;
    m_default := self.getStyle(xStyles.Def);
  end
  else
  begin
    fname := TPath.combine(path, 'index.txt');
    if hasFile( zip, fname) then
    begin
      list := loadStringListFromZip( zip, fname);

      for i := 0 to pred(list.Count) do
      begin
        st := TTaskStyleimpl.create;
        st.loadFromZip( zip, TPath.Combine(path, list[i]));
        m_list.Add(st)
      end;
      list.Free;
      Result := true;
    end;
  end;
  if not Assigned(m_default) and ( m_list.Count > 0)then
  begin
    m_default := m_list[0];
  end;

end;

function TTaskStylesImpl.newStyle(name : String ) : ITaskStyle;
var
  f : ITaskFile;
begin
  Result := TTaskStyleimpl.create;
  Result.Name := name;

  f := Result.Files.newFile('index.html');
  if Assigned(f) then
  begin
    f.Text :=
            '<!--'+sLineBreak+
            'Erzeugt am ' + DateTimeToStr(now)+sLineBreak+
            '-->'+sLineBreak+
            '<p>'+sLineBreak+
            '  <#script dumpdata.pas>'+sLineBreak+
            '</p>';
    f := Result.Files.newFile('dumpdata.pas');
    if Assigned(f) then
      f.Text :=
        'program dumpdata;'+sLineBreak+
        'begin'+sLineBreak+
        '  println( printXML );'+sLineBreak+
        'end.';
  end;
  m_list.Add(Result);
  doChange;
end;

procedure TTaskStylesImpl.registerChange(proc: TaskStylesChange);
begin
  if not m_listener.Contains(proc) then
  begin
    m_listener.Add(proc);
    proc(self);
  end;
end;

procedure TTaskStylesImpl.release;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
      m_list[i].release;
  m_list.Clear;
end;

function TTaskStylesImpl.rename(style: ITaskStyle; name: string): boolean;
var
  i : integer;
begin
  Result := true;
  name := ReplaceStr( name, '*', '');
  for i := 0 to pred(m_list.Count) do
  begin
    if (m_list[i] <> style ) then
      if m_list[i].isName(name) then
      begin
        Result := false;
        break;
      end;
  end;

  if Result then
  begin
    style.Name := name;
    doChange;
  end;
end;

function TTaskStylesImpl.saveToPath(path: string): boolean;
var
  i : integer;
  xStyle : IXMLStyles;
  xs     : IXMLStyle;
begin
  xStyle := NewStyles;
  if Assigned(m_default) then
    xStyle.Def := m_default.Name;

  for i := 0 to pred(m_list.Count) do
  begin
    xs := xStyle.Add;
    xs.Name := m_list[i].Name;
    xs.Clid := m_list[i].CLID;
    m_list[i].saveToPath(TPath.Combine(path,m_list[i].CLID ));
  end;

  xStyle.OwnerDocument.SaveToFile(TPath.Combine(path, 'styles.xml'));
  Result := true;
end;

function TTaskStylesImpl.saveToZip(zip: TZipFile; path: string): Boolean;
var
  i       : integer;
  xStyles : IXMLStyles;
  xs      : IXMLStyle;
  st      : TMemoryStream;
begin
  st       := TMemoryStream.create;
  xStyles  := NewStyles;

  if Assigned(m_default) then
    xStyles.Def := m_default.Name;

  for i := 0 to pred(m_list.Count) do
  begin
    xs := xStyles.Add;
    xs.Name := m_list[i].Name;
    xs.Clid := m_list[i].CLID;
    m_list[i].saveToZip(zip, TPath.Combine(path,m_list[i].CLID ));
  end;
  xStyles.OwnerDocument.SaveToStream(st);
  st.position := 0;
  zip.Add( st, TPath.Combine(path, 'styles.xml'));

  st.free;

  Result := true;
end;

procedure TTaskStylesImpl.setDefaultStyle(value: ITaskStyle);
begin
  m_default := value;
end;

procedure TTaskStylesImpl.setTaskStyle(inx: integer; const value: ITaskStyle);
begin
  m_list[inx] := value;
end;

procedure TTaskStylesImpl.uregisterChange(proc: TaskStylesChange);
begin
  m_listener.Remove(proc);
end;

end.
