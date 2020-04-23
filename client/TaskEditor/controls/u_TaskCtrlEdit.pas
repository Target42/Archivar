unit u_TaskCtrlEdit;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlEdit = class(TaskCtrlImpl)
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
  Vcl.StdCtrls, Winapi.Windows, System.SysUtils, u_TaskCtrlPropImpl;

{ TaskCtrlEdit }

constructor TaskCtrlEdit.Create(owner: ITaskForm);
begin
  inherited;
end;

destructor TaskCtrlEdit.Destroy;
begin

  inherited;
end;

procedure TaskCtrlEdit.doSetMouse(md: TControlMouseDown; mv: TControlMouseMove;
  mu: TControlMouseUp);
begin
  ( m_ctrl as TEdit).OnMouseDown  := md;
  ( m_ctrl as TEdit).OnMouseUp    := mu;
  ( m_ctrl as TEdit).OnMouseMove  := mv;
end;

function TaskCtrlEdit.newControl(parent: TWinControl; x, y: Integer): TControl;
var
  ed : TEdit;
begin
  ed := TEdit.Create(parent as TComponent);
  ed.Parent := parent as TWinControl;
  ed.Name := 'Edit'+intToStr(GetTickCount);
  ed.Top  := y;
  ed.Left := X;

  Result := ed;
end;

procedure TaskCtrlEdit.setControlTypeProps;
begin
  inherited;
  m_props.Add(TaskCtrlPropImpl.create(self, 'Text',       'string'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',  'TaskDataField'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'CharCase',   'TEditCharCase'));

end;

end.
