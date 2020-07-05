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
      procedure setTaskStyle( inx : integer; const value : ITaskStyle );
      function  getTaskStyle(inx : integer ) : ITaskStyle;
      function getCount : integer;

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
      function rename( style : ITaskStyle; name :string ) : boolean;

      function delete(style : ITaskStyle ) : boolean;

      procedure registerChange(  proc : TaskStylesChange );
      procedure uregisterChange( proc : TaskStylesChange );

      procedure release;
  end;

implementation

uses
  System.IOUtils, u_tTaskStyleImpl, System.SysUtils, u_zipHelper;

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
begin
  for i := 0 to pred(m_list.Count) do
  begin
    list.AddObject(m_list[i].Name, Pointer(m_list[i]));
  end;

end;

function TTaskStylesImpl.getCount: integer;
begin
  Result := m_list.Count;
end;

function TTaskStylesImpl.getStyle(name: string): ITaskStyle;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(m_list.Count) do
  begin
    if m_list[i].isName(name) then
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

function TTaskStylesImpl.loadFromZip(zip: TZipFile; path: string): boolean;
var
  list : TStringList;
  i    : integer;
  st  : ITaskStyle;
begin
  list := loadStringListFromZip( zip, TPath.combine(path, 'index.txt'));

  for i := 0 to pred(list.Count) do
  begin
    st := TTaskStyleimpl.create;
    st.loadFromZip( zip, TPath.Combine(path, list[i]));
    m_list.Add(st)
  end;
  list.Free;
  Result := true;
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
    f.Lines.Text :=
            '<!--'+sLineBreak+
            'Erzeugt am ' + DateTimeToStr(now)+sLineBreak+
            '-->';
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
  list : TStringList;
begin
  list := TStringList.Create;
  for i := 0 to pred(m_list.Count) do
  begin
    list.Add(m_list[i].CLID);
    m_list[i].saveToPath(TPath.Combine(path,m_list[i].CLID ));
  end;
  list.SaveToFile(TPath.Combine(path, 'index.txt'));
  list.Free;

  Result := true;
end;

function TTaskStylesImpl.saveToZip(zip: TZipFile; path: string): Boolean;
var
  i : integer;
  list : TStringList;
  st   : TMemoryStream;
begin
  st   := TMemoryStream.create;
  list := TStringList.Create;

  for i := 0 to pred(m_list.Count) do
  begin
    list.Add(m_list[i].CLID);
    m_list[i].saveToZip(zip, TPath.Combine(path,m_list[i].CLID ));
  end;
  list.saveToStream( st );
  st.position := 0;
  zip.Add( st, TPath.Combine(path, 'index.txt'));

  list.Free;
  st.free;

  Result := true;
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
