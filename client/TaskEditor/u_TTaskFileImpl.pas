unit u_TTaskFileImpl;

interface

uses
  i_taskEdit, System.Classes, System.SysUtils, System.Generics.Collections;

type
  TTaskFileImpl = class( TInterfacedObject, ITaskFile)
    private
      m_listener : Tlist<TaskFileChange>;
      m_lines: TStrings;
      m_name : String;

      procedure setName( value : string );
      function  getName : string;
      function  getStream : TStream;
      function  getStrings: TStrings;

      procedure doChange;
    public
      constructor create;
      Destructor Destroy; override;

      property Name : string read getName write setName;
      property Data : TStream read getStream;

      function isName( name : string ) : Boolean;

      function load( fname : string ) : boolean;
      function save( path : string ) : boolean;

      procedure registerChange(  proc : TaskFileChange );
      procedure uregisterChange( proc : TaskFileChange );

      procedure release;

  end;

implementation

{ TTaskFileImpl }

uses
  System.IOUtils;

constructor TTaskFileImpl.create;
begin
  m_lines:= TStringList.Create;
  m_listener := Tlist<TaskFileChange>.create;
end;

destructor TTaskFileImpl.Destroy;
begin
  m_lines.Free;
  m_listener.free;
  inherited;
end;

procedure TTaskFileImpl.doChange;
var
  i : integer;
begin
  for i := 0 to pred(m_listener.Count) do
    m_listener[i](self);

end;

function TTaskFileImpl.getName: string;
begin
  Result := m_name;
end;

function TTaskFileImpl.getStream: TStream;
begin
  Result := TMemoryStream.Create;
  m_lines.SaveToStream(Result, TEncoding.UTF8);
  Result.Position := 0;
end;

function TTaskFileImpl.getStrings: TStrings;
begin
  Result := m_lines;
end;

function TTaskFileImpl.isName(name: string): Boolean;
begin
  Result := SameText( ExtractFileName( m_name), name );
end;

function TTaskFileImpl.load(fname: string): boolean;
begin
  Result := FileExists(fname);
  if not Result then
    exit;
  m_lines.LoadFromFile(fname);
  m_name := ExtractFileName(fname);
end;

procedure TTaskFileImpl.registerChange(proc: TaskFileChange);
begin
  if not m_listener.Contains(proc) then
    m_listener.Add(proc);
  proc(self);
end;

procedure TTaskFileImpl.release;
begin
  m_listener.Clear;
end;

function TTaskFileImpl.save(path: string): boolean;
var
  fname : string;
begin
  fname := TPath.Combine( path, m_name);
  try
    m_lines.SaveToFile(fname);
    Result := true;
  except
    Result := false;
  end;
end;

procedure TTaskFileImpl.setName(value: string);
begin
  m_name := value;
  doChange;
end;

procedure TTaskFileImpl.uregisterChange(proc: TaskFileChange);
begin
  m_listener.Remove(proc);
end;

end.
