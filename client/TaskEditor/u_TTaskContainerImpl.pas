unit u_TTaskContainerImpl;

interface

uses
  i_taskEdit, System.Generics.Collections;

type
  TTaskContainerImpl = class(TInterfacedObject, ITaskContainer)
    private
      m_task    : ITask;
      m_files   : ITaskFiles;
      m_info    : ITaskFiles;
      m_styles  : ITaskStyles;

      procedure setTask( value : ITask );
      function  getTask : ITask;
      function  getTestdata : ITaskFiles;
      function  getInfoFiles: ITaskFiles;
      function  getStyles : ITaskStyles;
    public
      constructor create;
      Destructor Destroy; override;

      property Task : ITask read getTask write setTask;

      property TestData : ITaskFiles read getTestdata;
      property Styles   : ITaskStyles read getStyles;

      function loadFromPath( path : string ) : boolean;
      function saveToPath( path : string ) : boolean;

      procedure release;

  end;

implementation

uses
  u_TTaskFilesImpl, u_TTaskStylesImpl, System.SysUtils, u_Task2XML, System.IOUtils;

{ TTaskContainerImpl }

constructor TTaskContainerImpl.create;
begin
  m_task    := NIL;
  m_files   := TTaskFilesImpl.create;
  m_info    := TTaskFilesimpl.create;
  m_styles  := TTaskStylesImpl.create;
end;

destructor TTaskContainerImpl.Destroy;
begin
  m_task    := NIL;
  m_files   := NIL;
  m_styles  := NIL;
  m_info    := NIL;

  inherited;
end;

function TTaskContainerImpl.getInfoFiles: ITaskFiles;
begin
  Result := m_info;
end;

function TTaskContainerImpl.getStyles: ITaskStyles;
begin
  Result := m_styles;
end;

function TTaskContainerImpl.getTask: ITask;
begin
  Result := m_task;
end;

function TTaskContainerImpl.getTestdata: ITaskFiles;
begin
  Result := m_files;
end;

function TTaskContainerImpl.loadFromPath(path: string): boolean;
var
  xw : Task2XML;
begin
  Result := false;
  if not DirectoryExists( path ) then
    exit;
  xw := Task2XML.Create;
  m_task := xw.load(TPath.combine( path, 'task.xml'));
  xw.Free;
  m_task.CLID := ExtractFileName(path);

  Result := m_files.loadFromPath(TPath.Combine(path, 'TestData'), '*.xml') and Result;
  Result := m_info.loadFromPath(TPath.Combine(path, 'info'), '*.*') and Result;
  Result := m_styles.loadFromPath(TPath.Combine(path, 'Styles'))  and Result;
end;

procedure TTaskContainerImpl.release;
begin
  m_task.release;
  m_task := NIL;

  m_files.release;
  m_files := NIL;

  m_styles.release;
  m_styles := NIL;
  m_info.release;
  m_info := NIL;
end;

function TTaskContainerImpl.saveToPath(path: string): boolean;
var
  xw : Task2XML;
begin
  ForceDirectories(path);
  xw := Task2XML.Create;
  Result := xw.save(m_task, TPath.combine( path, 'task.xml'));
  xw.Free;

  Result := m_files.saveToPath(TPath.Combine(path, 'TestData')) and Result;
  Result := m_info.saveToPath(TPath.Combine(path, 'Info')) and Result;
  Result := m_styles.saveToPath(TPath.Combine(path, 'Styles'))  and Result;
end;

procedure TTaskContainerImpl.setTask(value: ITask);
begin
  m_task := value;
end;

end.
