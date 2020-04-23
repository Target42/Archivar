unit u_TaskCtrlLabeledEdit;

interface
uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlLabeledEdit = class(TaskCtrlImpl)
    protected
      procedure setControlTypeProps; override;
      function  newControl(parent : TWinControl; x, y : Integer) :  TControl; override;
      procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); override;
    private

    public
      constructor Create(owner : ITaskForm);
      destructor Destroy; override;
  end;

implementation

uses
  u_TaskCtrlPropImpl, Vcl.StdCtrls, System.SysUtils, Winapi.Windows,
  Vcl.ExtCtrls;

{ TaskCtrlLabeledEdit }

constructor TaskCtrlLabeledEdit.Create(owner: ITaskForm);
begin
  inherited;
end;

destructor TaskCtrlLabeledEdit.Destroy;
begin

  inherited;
end;

procedure TaskCtrlLabeledEdit.doSetMouse(md: TControlMouseDown;
  mv: TControlMouseMove; mu: TControlMouseUp);
begin
  inherited;

  ( m_ctrl as TLabeledEdit).OnMouseDown  := md;
  ( m_ctrl as TLabeledEdit).OnMouseUp    := mu;
  ( m_ctrl as TLabeledEdit).OnMouseMove  := mv;

end;

function TaskCtrlLabeledEdit.newControl(parent: TWinControl; x,
  y: Integer): TControl;
var
  ed : TLabeledEdit;
begin
  ed := TLabeledEdit.Create(parent as TComponent);
  ed.Parent := parent as TWinControl;
  ed.Name := 'LabeledEdit'+intToStr(GetTickCount);
  ed.Top  := y;
  ed.Left := X;
  Result := ed;
end;

procedure TaskCtrlLabeledEdit.setControlTypeProps;
begin
  inherited;
  m_props.Add(TaskCtrlPropImpl.create(self, 'Caption',    'string'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',  'TaskDataField'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'CharCase',   'TEditCharCase'));
end;

end.
