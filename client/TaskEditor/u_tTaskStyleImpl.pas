unit u_tTaskStyleImpl;

interface

uses
  i_taskEdit;

type
  TTaskStyleImpl = class(TInterfacedObject, ITaskStyle)
    private
      m_clid  : string;
      m_files : ITaskFiles;
      m_name  : string;
      procedure setName( value : string );
      function  getName : string;
      function  getFiles : ITaskFiles;
      procedure setCLID( value : string );
      function  getCLID : string;

    public
      constructor create;
      Destructor Destroy; override;

      property Name : string read getName write setName;
      property Files: ITaskFiles read getFiles;

      function loadFromPath( path : string ) : boolean;
      function saveToPath( path : string ) : boolean;

      function isName( name : string ) : Boolean;

      procedure release;

  end;

implementation

uses
  u_TTaskFilesImpl, System.SysUtils, System.Win.ComObj;

{ TTaskStyleImpl }

constructor TTaskStyleImpl.create;
begin
  m_files := TTaskFilesImpl.create;
  m_clid  :=  CreateClassID;
  m_name  := 'Style';
end;

destructor TTaskStyleImpl.Destroy;
begin
   m_files:= NIL;
  inherited;
end;

function TTaskStyleImpl.getCLID: string;
begin
  Result := m_clid;
end;

function TTaskStyleImpl.getFiles: ITaskFiles;
begin
  Result := m_files;
end;

function TTaskStyleImpl.getName: string;
begin
  Result := m_name;
end;

function TTaskStyleImpl.isName(name: string): Boolean;
begin
  Result := SameText(m_name, name);
end;

function TTaskStyleImpl.loadFromPath(path: string): boolean;
begin
  Result := DirectoryExists( path );
  if not Result then
    exit;
  m_clid := ExtractFileName(path);
  m_files.loadFromPath(path, '*.*');
end;

procedure TTaskStyleImpl.release;
begin
  m_files.release;
end;

function TTaskStyleImpl.saveToPath(path: string): boolean;
begin
  ForceDirectories(path);
  Result := true;
end;

procedure TTaskStyleImpl.setCLID(value: string);
begin
  m_clid := value;
end;

procedure TTaskStyleImpl.setName(value: string);
begin
  m_name := value;
end;

end.
