unit u_TTaskFilesImpl;

interface

uses
  i_taskEdit, System.Generics.Collections, System.Classes;

type
  TTaskFilesImpl = class(TInterfacedObject, ITaskFiles)
    private
      m_files : TList<ITaskFile>;

      procedure setItems( inx : integer; const value : ITaskFile );
      function  getItems( inx : integer ) : ITaskFile;
      function  getCount : integer;
    public
      constructor Create;
      Destructor Destroy; override;

      property Items[ inx : integer ]: ITaskFile read getItems write setItems;
      property Count : integer read getCount;

      function loadFromPath( path, mask : string ) : boolean;
      function saveToPath( path : string ) : boolean;

      function getFile( name : string ): ITaskFile;

      procedure fillList( list : TStrings; ext : boolean = true );

      procedure release;

  end;

implementation

uses
  System.SysUtils, System.IOUtils, System.Types, u_TTaskFileImpl;

{ TTaskFilesImpl }

constructor TTaskFilesImpl.Create;
begin
  m_files := TList<ITaskFile>.create;
end;

destructor TTaskFilesImpl.Destroy;
begin
  m_files.Free;
  inherited;
end;

procedure TTaskFilesImpl.fillList(list: TStrings; ext: boolean);
var
  i : integer;
  s : string;
begin
  for i := 0 to pred( m_files.Count) do
  begin
    s := m_files[i].Name;
    if not ext then
      SetLength( s, Length(s)-Length(ExtractFileExt(s)));
    list.AddObject(s, Pointer(m_files[i]));
  end;
end;

function TTaskFilesImpl.getCount: integer;
begin
  Result := m_files.Count;
end;

function TTaskFilesImpl.getFile(name: string): ITaskFile;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(m_files.Count) do
    begin
      if m_files[i].isName(name) then
      begin
        Result := m_files[i];
        break;
      end;
    end;
end;

function TTaskFilesImpl.getItems(inx: integer): ITaskFile;
begin
  Result := m_files[inx];
end;

function TTaskFilesImpl.loadFromPath(path, mask: string): boolean;
var
  arr : TStringDynArray;
  i   : integer;
  f   : ITaskFile;
begin
  Result := false;
  if not directoryExists( path) then
    exit;
  arr := TDirectory.GetFiles(path, mask);

  for i := 0 to pred(Length(arr)) do
  begin
    f := TTaskFileImpl.create;
    f.load(arr[i]);
    m_files.Add(f);
  end;
  SetLength(arr, 0);
end;

procedure TTaskFilesImpl.release;
var
  i : integer;
begin
  for i := 0 to pred(m_files.Count) do
    m_files[i].release;
  m_files.Clear;

end;

function TTaskFilesImpl.saveToPath(path: string): boolean;
begin
  Result := false;
end;

procedure TTaskFilesImpl.setItems(inx: integer; const value: ITaskFile);
begin
  m_files[inx] := value;
end;

end.
