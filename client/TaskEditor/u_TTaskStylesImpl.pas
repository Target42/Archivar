unit u_TTaskStylesImpl;

interface

uses
  i_taskEdit, System.Generics.Collections, System.Types;

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

      function newStyle : ITaskStyle;

      function loadFromPath( path : string ) : boolean;
      function saveToPath( path : string ) : boolean;

      procedure release;
  end;

implementation

uses
  System.IOUtils, u_tTaskStyleImpl;

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

function TTaskStylesImpl.getCount: integer;
begin
  Result := m_list.Count;
end;

function TTaskStylesImpl.getTaskStyle(inx: integer): ITaskStyle;
begin
  Result := m_list[inx];
end;

function TTaskStylesImpl.loadFromPath(path: string): boolean;
var
  arr : TStringDynArray;
  i   : integer;
  st  : ITaskStyle;
begin
  arr := TDirectory.GetDirectories(path, '{*}');
  for i := 0 to pred(Length(arr)) do
  begin
    st := TTaskStyleimpl.create;
    st.loadFromPath(arr[i]);
    m_list.Add(st)
  end;
  SetLength(arr, 0);;
  Result := true;
end;

function TTaskStylesImpl.newStyle: ITaskStyle;
begin
  Result := TTaskStyleimpl.create;
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

function TTaskStylesImpl.saveToPath(path: string): boolean;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
    m_list[i].saveToPath(path);

  Result := true;
end;

procedure TTaskStylesImpl.setTaskStyle(inx: integer; const value: ITaskStyle);
begin
  m_list[inx] := value;
end;

end.
