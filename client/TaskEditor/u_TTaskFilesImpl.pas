unit u_TTaskFilesImpl;

interface

uses
  i_taskEdit, System.Generics.Collections, System.Classes, system.zip;

type
  TTaskFilesImpl = class(TInterfacedObject, ITaskFiles)
    private
      m_files : TList<ITaskFile>;
      m_listner : TList<TaskFilesChange>;

      procedure setItems( inx : integer; const value : ITaskFile );
      function  getItems( inx : integer ) : ITaskFile;
      function  getCount : integer;

      procedure doChange;
    public
      constructor Create;
      Destructor Destroy; override;

      property Items[ inx : integer ]: ITaskFile read getItems write setItems;
      property Count : integer read getCount;

      function loadFromPath( path, mask : string ) : boolean;
      function loadFromZip( zip: TZipFile ; path, mask : string ) : boolean;

      function saveToPath( path : string ) : boolean;
      function saveToZip( zip : TZipFile; path : string ) : Boolean;

      function getFile( name : string ): ITaskFile;
      function newFile( name : string ) : ITaskFile;
      function ownfile( tf : ITaskFile ) : boolean;

      function rename( tf : ITaskFile ; name : string) : boolean;
      function delete( tf : ITaskFile ) :  boolean;

      procedure fillList( list : TStrings; ext : boolean);

      procedure registerChange(  proc : TaskFilesChange );
      procedure uregisterChange( proc : TaskFilesChange );

      procedure release;

  end;

implementation

uses
  System.SysUtils, System.IOUtils, System.Types, u_TTaskFileImpl, u_zipHelper;

{ TTaskFilesImpl }

constructor TTaskFilesImpl.Create;
begin
  m_files   := TList<ITaskFile>.create;
  m_listner := TList<TaskFilesChange>.create;
end;

function TTaskFilesImpl.delete(tf: ITaskFile): boolean;
begin
  Result := m_files.Contains(tf);
  if Result then
  begin
    m_files.Remove(tf);
    tf.release;
    Result := tf.delete;
    doChange;
  end;
end;

destructor TTaskFilesImpl.Destroy;
begin
  m_files.Free;
  m_listner.Free;
  inherited;
end;

procedure TTaskFilesImpl.doChange;
var
  i : integer;
begin
  for i := 0 to pred(m_listner.Count) do
      m_listner[i](self);
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

function TTaskFilesImpl.loadFromZip( zip: TZipFile ; path, mask : string ) : boolean;
var
  list : TStringList;
  i    : integer;
  f    : ITaskFile;
begin
  list := getZipFiles( zip, path, mask );

  for i := 0 to pred(list.Count) do begin
    f := TTaskFileImpl.create;
    f.loadFromZip(zip, list[i]);
    m_files.Add(f);
  end;
  list.Free;

  Result := true;
end;

function TTaskFilesImpl.newFile(name: string): ITaskFile;
begin
  Result := getFile(name);
  if not Assigned(Result) then
  begin
    Result := TTaskFileImpl.create;
    Result.Name := name;
    m_files.Add(Result);
    doChange;
  end;
end;

function TTaskFilesImpl.ownfile(tf: ITaskFile): boolean;
begin
  Result := m_files.Contains(tf);
end;

procedure TTaskFilesImpl.registerChange(proc: TaskFilesChange);
begin
  if not m_listner.Contains(proc) then
    m_listner.Add(proc);
  proc(self);
end;

procedure TTaskFilesImpl.release;
var
  i : integer;
begin
  m_listner.Clear;
  for i := 0 to pred(m_files.Count) do
    m_files[i].release;
  m_files.Clear;

end;

function TTaskFilesImpl.rename(tf: ITaskFile; name: string): boolean;
var
  i : integer;
begin
  Result := true;
  for i := 0 to pred(m_files.Count) do
  begin
    if m_files[i] <> tf then
    begin
      if m_files[i].isName(name) then
      begin
        Result := false;
        exit;
      end;
    end;
  end;

  if Result then
  begin
    tf.Name := name;
    doChange;
  end;
end;

function TTaskFilesImpl.saveToPath(path: string): boolean;
var
  i : integer;
begin
  for i := 0 to pred(m_files.Count) do
    m_files[i].save(path);
  Result := true;
end;

function TTaskFilesImpl.saveToZip(zip: TZipFile; path: string): Boolean;
var
  i : integer;
begin
  for i := 0 to pred(m_files.Count) do
    m_files[i].saveToZip(zip, path);
  Result := true;
end;

procedure TTaskFilesImpl.setItems(inx: integer; const value: ITaskFile);
begin
  m_files[inx] := value;
end;

procedure TTaskFilesImpl.uregisterChange(proc: TaskFilesChange);
begin
  m_listner.Remove(proc);
end;

end.
