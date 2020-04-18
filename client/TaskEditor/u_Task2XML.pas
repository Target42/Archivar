unit u_Task2XML;

interface

uses
  i_taskEdit, xsd_Task;

type
  Task2XML = class
    private
      m_xTask : IXMLTask;
    public
      constructor Create;
      Destructor Destroy; override;

      function load( fname : string ) : ITask;
      function save( task : ITask ; fname : string ) : boolean;
  end;

implementation

uses
  u_TaskImpl, u_TaskDataField2XML;

{ Task2XML }

constructor Task2XML.Create;
begin

end;

destructor Task2XML.Destroy;
begin

  inherited;
end;

function Task2XML.load(fname: string): ITask;
var
  xw  : TaskDataField2XML;
  i   : integer;
begin
  try
    m_xTask := LoadTask(fname);
  except
    begin
      m_xTask := NewTask;
      m_xTask.Name := 'Exception';
    end;
  end;
  Result := TTask.create;

  xw := TaskDataField2XML.create;
  try
    for i := 0 to pred(m_xTask.Datafields.Count) do
      Result.Fields.add(xw.xml2DataField(m_xTask.Datafields[i]));
  finally
    xw.Free;
  end;

end;

function Task2XML.save(task: ITask; fname: string): boolean;
var
  xw  : TaskDataField2XML;
  i   : integer;
begin
  Result := false;
  if not Assigned(task) then
    exit;

  m_xTask := NewTask;
  task.Name := m_xTask.Name;
  task.CLID := m_xTask.Clid;


  xw := TaskDataField2XML.create;
  try
    for i := 0 to pred(task.Fields.Count) do
      xw.DataField2XML( task.Fields.Items[i], m_xTask.Datafields.Add );
  finally
    xw.Free;
  end;

  try
    m_xTask.OwnerDocument.SaveToFile(fname);
  except

  end;
end;

end.
