unit u_TTaskContainerImpl;

interface

uses
  i_taskEdit, System.Generics.Collections, system.zip, System.Classes;

type
  TTaskContainerImpl = class(TInterfacedObject, ITaskContainer)
    private
      m_clid          : string;
      m_id            : integer;
      m_task          : ITask;
      m_files         : ITaskFiles;
      m_info          : ITaskFiles;
      m_styles        : ITaskStyles;
      m_templateCLID  : string;

      procedure setTask( value : ITask );
      function  getTask : ITask;
      function  getTestdata : ITaskFiles;
      function  getInfoFiles: ITaskFiles;
      function  getStyles : ITaskStyles;
      procedure setCLID( value : string );
      function  getCLID : string;
      procedure setID( value : integer );
      function  getID : integer;

    public
      constructor create;
      Destructor Destroy; override;

      function loadFromPath( path : string ) : boolean;
      function loadFromZip( zip : TZipFile ) : boolean;
      function import( fname : string )       : Boolean;

      function saveToPath( path : string ) : boolean;
      function saveToZip( path : string ) : boolean;
      function saveToStream( st : TStream ) : boolean;
      function exportTask( fname : string ) : boolean;

      procedure release;

  end;

implementation

uses
  u_TTaskFilesImpl, u_TTaskStylesImpl, System.SysUtils, u_Task2XML,
  System.IOUtils, system.Win.ComObj, u_TaskImpl;

{ TTaskContainerImpl }

constructor TTaskContainerImpl.create;
begin
  m_clid      := createCLassID;
  m_id        := -1;
  m_files     := TTaskFilesImpl.create;
  m_info      := TTaskFilesimpl.create;
  m_styles    := TTaskStylesImpl.create;

  m_task      := TTask.create;
  m_task.CLID := m_clid;
end;

destructor TTaskContainerImpl.Destroy;
begin
  m_task    := NIL;
  m_files   := NIL;
  m_styles  := NIL;
  m_info    := NIL;

  inherited;
end;

function TTaskContainerImpl.exportTask(fname: string): boolean;
var
  zip: TZipFile;

  function saveTask : boolean;
  var
    xw : Task2XML;
  begin
    xw := Task2XML.Create;
    Result := xw.saveToZip(zip, m_task, 'task.xml');
    xw.Free;
  end;

begin

  zip := TZipFile.Create;
  zip.Open(fname, zmWrite );

  Result := saveTask;
  Result := m_files.saveToZip( zip, 'TestData') and Result;
  Result := m_info.saveToZip(zip, 'Info') and Result;
  Result := m_styles.saveToZip(zip, 'Styles')  and Result;

  zip.Free;
end;

function TTaskContainerImpl.getCLID: string;
begin
  Result := m_clid;
  if Assigned(m_task) then
    Result := m_task.CLID;
end;

function TTaskContainerImpl.getID: integer;
begin
  result := m_id;
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

function TTaskContainerImpl.import(fname: string): Boolean;
var
  zip :TZipFile;
begin
  zip:= TZipFile.Create;
  zip.Open(fname, zmRead);
  Result := loadFromZip(zip);
  zip.Free;
end;

function TTaskContainerImpl.loadFromPath(path: string): boolean;
var
  xw : Task2XML;

  function loadForms : boolean;
  var
    fname : string;
    frm   : ITaskForm;
  begin
    Result := true;
    for frm in m_task.Forms do
    begin
      fname := TPath.Combine(path, 'forms\'+frm.Name+'.dfm');
      if FileExists(fname) then
      begin
        try
          frm.DFM.LoadFromFile(fname);
        except

        end;
      end;
    end;
  end;
begin
  Result := false;
  if not DirectoryExists( path ) then
    exit;

  xw := Task2XML.Create;
  m_task := xw.load(TPath.combine( path, 'task.xml'));
  xw.Free;
  m_task.Owner := self;

  Result := loadForms                                                       and Result;
  Result := m_files.loadFromPath(TPath.Combine(path, 'TestData'), '*.xml')  and Result;
  Result := m_info.loadFromPath(TPath.Combine(path, 'info'), '*.*')         and Result;
  Result := m_styles.loadFromPath(TPath.Combine(path, 'Styles'))            and Result;
end;

function TTaskContainerImpl.loadFromZip(zip: TZipFile): boolean;
var
  xw    : Task2XML;
  fname : string;

  function loadForms : boolean;
  var
    frm : ITaskForm;
    inx : integer;
    h   : TZipHeader;
    st  : TStream;
  begin
    Result := true;
    for frm in m_task.Forms do
    begin
      fname := TPath.Combine('forms', frm.Name+'.dfm');
      inx   := zip.IndexOf(fname);
      if inx > -1 then
      begin
        zip.Read( fname, st, h );
        frm.DFM.CopyFrom( st, -1);
        st.Free;
      end;
    end;
  end;
begin
  Result := false;

  xw := Task2XML.Create;
  m_task := xw.loadFromZip(zip, 'task.xml');
  xw.Free;
  m_task.Owner := self;

  Result := loadForms                                           and Result;
  Result := m_files.loadFromZip(zip, 'TestData', '[\w]*\.xml')  and Result;
  Result := m_info.loadFromZip(zip, 'info', '[\w]*\.[\w]*')     and Result;
  Result := m_styles.loadFromZip(zip, 'Styles')                 and Result;
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

  function saveForms : boolean;
  var
    frm   : ITaskForm;
    fname : string;
    st    : TStream;
  begin
    Result := true;

    ForceDirectories(TPath.Combine(path, 'forms'));
    for frm in m_task.Forms do
    begin
      if frm.DFM.Size > 0  then
      begin
        fname := TPath.Combine(path, 'forms\'+frm.Name+'.dfm');
        frm.DFM.Position := 0;
        st := NIL;
        try
          st := TFileStream.Create(fname, fmCreate + fmShareDenyNone);
          st.CopyFrom(frm.DFM, -1);
        finally
          if Assigned(st) then
            st.Free;
        end;
      end;
    end;
  end;
begin
  ForceDirectories(path);

  xw := Task2XML.Create;
  Result := xw.save(m_task, TPath.combine( path, 'task.xml'));
  xw.Free;

  Result := saveForms                                           and Result;
  Result := m_files.saveToPath(TPath.Combine(path, 'TestData')) and Result;
  Result := m_info.saveToPath(TPath.Combine(path, 'Info'))      and Result;
  Result := m_styles.saveToPath(TPath.Combine(path, 'Styles'))  and Result;
end;

function TTaskContainerImpl.saveToStream( st : TStream ) : boolean;
var
  zip: TZipFile;

  function saveTask : boolean;
  var
    xw : Task2XML;
  begin
    xw := Task2XML.Create;
    Result := xw.saveToZip(zip, m_task, 'task.xml');
    xw.Free;
  end;

  function saveForms : boolean;
  var
    frm : ITaskForm;
  begin
    Result := true;

    for frm in m_task.Forms do
    begin
      if frm.DFM.Size > 0  then
      begin
        frm.DFM.Position := 0;
        zip.Add(frm.DFM, 'forms\'+frm.Name+'.dfm');
      end;
    end;
  end;

begin

  zip := TZipFile.Create;
  zip.Open(st, zmWrite );

  Result := saveTask;
  Result := saveForms                             and Result;
  Result := m_files.saveToZip(  zip, 'TestData')  and Result;
  Result := m_info.saveToZip(   zip, 'Info')      and Result;
  Result := m_styles.saveToZip( zip, 'Styles')    and Result;

  zip.Free;
  st.Position := 0;
end;

function TTaskContainerImpl.saveToZip(path: string): boolean;

begin
  ForceDirectories(path);
  Result := exportTask(TPath.Combine( path, 'data.zip'));
end;

procedure TTaskContainerImpl.setCLID(value: string);
begin
  m_clid := value;
  if Assigned(m_task) then
    m_task.CLID := value;

end;

procedure TTaskContainerImpl.setID(value: integer);
begin
  m_id := value;
end;

procedure TTaskContainerImpl.setTask(value: ITask);
begin
  if Assigned(m_task) then begin
    m_task.release;
    m_task := NIL;
  end;
  m_task := value;
  m_clid := m_task.CLID;
end;

end.
