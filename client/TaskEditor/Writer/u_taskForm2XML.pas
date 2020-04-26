unit u_taskForm2XML;

interface

uses
  i_taskEdit, xsd_TaskData;

type
  TTaskForm2XML = class
    private
      m_xList: IXMLList;

      procedure SaveControl( ctrl : ITaskCtrl );
      procedure SaveTable( ctrl : ITaskCtrl );

    public
      constructor create;
      Destructor Destroy; override;

      procedure load( name : string; form : ITaskForm );
      function  save( name : string; form : ITaskForm ) : Boolean;
  end;

implementation

{ TTaskForm2XML }

constructor TTaskForm2XML.create;
begin

end;

destructor TTaskForm2XML.Destroy;
begin

  inherited;
end;

procedure TTaskForm2XML.load(name: string; form: ITaskForm);
begin
  try
    m_xList := LoadList(name);
  except
    m_xList := NewList;
  end;
end;

function TTaskForm2XML.save(name: string; form: ITaskForm): Boolean;
begin
  Result := false;
  m_xList := NewList;

  if Assigned(form) then
  begin
    SaveControl( form.Base );
  end;
  try
    m_xList.OwnerDocument.SaveToFile(name);
    Result := true;
  except

  end;
end;

procedure TTaskForm2XML.SaveControl(ctrl: ITaskCtrl);
var
  i : integer;
  xField : IXMLField;
  n, v :string;
begin
  if Assigned( ctrl.TableCtrlIF) then
    SaveTable(ctrl)
  else
  begin
    if Assigned( ctrl.DataField) then
    begin
      xField := m_xList.Values.Add;
      xField.Field      := ctrl.DataField.Name;
      xField.Fieldclid  := ctrl.DataField.CLID;
      ctrl.getData(n, v);
      xField.Value := v;
    end;
    for i := 0 to pred(ctrl.Childs.Count) do
      SaveControl(ctrl.Childs[i]);
  end;
end;

procedure TTaskForm2XML.SaveTable(ctrl: ITaskCtrl);
begin

end;

end.
