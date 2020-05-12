unit u_TTaskFileImpl;

interface

uses
  i_taskEdit, System.Classes, System.SysUtils;

type
  TTaskFileImpl = class( TInterfacedObject, ITaskFile)
    private
      m_lines: TStrings;
      m_name : String;

      procedure setName( value : string );
      function  getName : string;
      function  getStream : TStream;
      function  getStrings: TStrings;
    public
      constructor create;
      Destructor Destroy; override;

      property Name : string read getName write setName;
      property Data : TStream read getStream;

      function isName( name : string ) : Boolean;

      function load( fname : string ) : boolean;
      function save( path : string ) : boolean;

      procedure release;

  end;

implementation

{ TTaskFileImpl }

uses
  System.IOUtils;

constructor TTaskFileImpl.create;
begin
  m_lines:= TStringList.Create;
end;

destructor TTaskFileImpl.Destroy;
begin
  m_lines.Free;
  inherited;
end;

function TTaskFileImpl.getName: string;
begin
  Result := m_name;
end;

function TTaskFileImpl.getStream: TStream;
begin
  Result := TMemoryStream.Create;
  m_lines.SaveToStream(Result);
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

procedure TTaskFileImpl.release;
begin

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
end;

end.
