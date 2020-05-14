unit u_TTaskStylesImpl;

interface

uses
  i_taskEdit, System.Generics.Collections, System.Types, System.Classes;

type
  TTaskStylesImpl = class(TInterfacedObject, ITaskStyles)
    private
      m_list : TList<ITaskStyle>;
      procedure setTaskStyle( inx : integer; const value : ITaskStyle );
      function  getTaskStyle(inx : integer ) : ITaskStyle;
      function getCount : integer;
    public
      constructor create;
      Destructor Destroy; override;

      property Items[ inx : integer ]: ITaskStyle read getTaskStyle write setTaskStyle;
      property Count : integer read getCount;

      function newStyle(name : String ) : ITaskStyle;

      function loadFromPath( path : string ) : boolean;
      function saveToPath( path : string ) : boolean;

      procedure FillList( list : TStrings );

      function getStyle( name : string ) : ITaskStyle;
      function rename( style : ITaskStyle; name :string ) : boolean;

      procedure release;
  end;

implementation

uses
  System.IOUtils, u_tTaskStyleImpl, System.SysUtils;

{ TTaskStylesImpl }

constructor TTaskStylesImpl.create;
begin
  m_list := TList<ITaskStyle>.create;
end;

destructor TTaskStylesImpl.Destroy;
begin
  m_list.Free;
  inherited;
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
    style.Name := name;
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
    m_list[i].saveToPath(path);
  end;
  list.SaveToFile(TPath.Combine(path, 'index.txt'));
  list.Free;

  Result := true;
end;

procedure TTaskStylesImpl.setTaskStyle(inx: integer; const value: ITaskStyle);
begin
  m_list[inx] := value;
end;

end.
