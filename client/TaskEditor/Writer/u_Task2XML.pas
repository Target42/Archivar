unit u_Task2XML;

interface

uses
  i_taskEdit, xsd_Task;

type
  Task2XML = class
    private
      m_xTask : IXMLTask;
      m_task  : ITask;

      procedure saveForm( frm : ITaskForm; xFrm : IXMLForm );
      procedure saveCtrl( ctrl : ITaskCtrl; xCtrl : IXMLControl);

      procedure loadForm( frm : ITaskForm; xFrm : IXMLForm );
      procedure loadCtrl( ctrl : ITaskCtrl; xCtrl : IXMLControl );
    public
      constructor Create;
      Destructor Destroy; override;

      function load( fname : string ) : ITask;
      function save( task : ITask ; fname : string ) : boolean;
  end;

implementation

uses
  u_TaskImpl, u_TaskDataField2XML, System.SysUtils;

{ Task2XML }

constructor Task2XML.Create;
begin
  m_xTask := NIL;
  m_task  := NIL;

end;

destructor Task2XML.Destroy;
begin
  m_xTask := NIL;
  m_task  := NIL;

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
  Result.WorkDir := ExtractFilePath( fname );
  m_task := Result;

  xw := TaskDataField2XML.create;
  try
    for i := 0 to pred(m_xTask.Datafields.Count) do
      Result.Fields.add(xw.xml2DataField(m_xTask.Datafields[i]));
  finally
    xw.Free;
  end;

  for i := 0 to pred(m_xTask.Forms.Count) do
  begin
    loadForm(Result.NewForm, m_xTask.Forms[i]);
  end;
end;

procedure Task2XML.loadCtrl(ctrl: ITaskCtrl; xCtrl: IXMLControl);
var
  i : integer;
  p : ITaskCtrlProp;
begin
  ctrl.CLID         := xCtrl.Clid;
  ctrl.ControlClass := xCtrl.CtrlType;

  // datenfeld ....
  ctrl.DataField   := m_task.Fields.getByCLID(xCtrl.Fieldclid);

  // properties
  for i := 0 to pred(xCtrl.Property_.Count) do
  begin
    p := ctrl.getPropertyByName(xCtrl.Property_[i].Name);
    if Assigned(p) then
      p.Value := xCtrl.Property_[i].Value;

  end;
  // childs
  for i := 0 to pred(xCtrl.Control.Count) do
  begin
    loadCtrl( ctrl.NewChild(xCtrl.Control[i].CtrlType) , xCtrl.Control[i]);
  end;
end;

procedure Task2XML.loadForm(frm : ITaskForm; xFrm: IXMLForm);
begin
  frm.Name      := xFrm.Name;
  frm.CLID      := xFrm.Clid;
  frm.MainForm  := xFrm.Mainform;

  loadCtrl( frm.Base, xFrm.Control[0]);

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

  for i := 0  to pred(task.Forms.Count) do
  begin
    saveForm( task.Forms.Items[i], m_xTask.Forms.Add );
  end;


  try
    m_xTask.OwnerDocument.SaveToFile(fname);
  except

  end;
end;

procedure Task2XML.saveCtrl(ctrl: ITaskCtrl; xCtrl: IXMLControl);
var
  i : integer;
  p : ITaskCtrlProp;
  xp :  IXMLProperty_;
begin
  xCtrl.Clid        := ctrl.CLID;
  xCtrl.Field     := '';
  xCtrl.Fieldclid := '';

  if Assigned(ctrl.DataField) then
  begin
    xCtrl.Field     := ctrl.DataField.Name;
    xCtrl.Fieldclid := ctrl.DataField.CLID;
  end;
  xCtrl.CtrlType  := ctrl.ControlClass;

  for i := 0 to pred(ctrl.Props.Count) do
  begin
    xp := xCtrl.Property_.Add;
    p  := ctrl.Props.Items[i];

    xp.Name := p.Name;
    xp.Typ  := p.Typ;
    xp.Value:= p.Value;
  end;

  for i := 0 to pred(ctrl.Childs.Count) do
  begin
    saveCtrl(ctrl.Childs.Items[i], xCtrl.Control.Add);
  end;
end;

procedure Task2XML.saveForm(frm: ITaskForm; xFrm: IXMLForm);
begin
  xFrm.Name     := frm.Name;
  xFrm.Clid     := frm.CLID;
  xFrm.Mainform := frm.MainForm;

  saveCtrl( frm.Base, xFrm.Add );
end;

end.
