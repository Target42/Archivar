unit u_TaskCtrlGroupBox;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlGroupBox = class(TaskCtrlImpl)
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

{ TaskCtrlGroupBox }

constructor TaskCtrlGroupBox.Create(owner: ITaskForm);
begin
  inherited;
  m_isContainer := true;
  m_typ         := ctGroupBox;
end;

destructor TaskCtrlGroupBox.Destroy;
begin

  inherited;
end;

procedure TaskCtrlGroupBox.doSetMouse(md: TControlMouseDown; mv: TControlMouseMove;
  mu: TControlMouseUp);
begin
  inherited;
  ( m_ctrl as TGroupBox).OnMouseDown  := md;
  ( m_ctrl as TGroupBox).OnMouseUp    := mu;
  ( m_ctrl as TGroupBox).OnMouseMove  := mv;
end;

function TaskCtrlGroupBox.newControl(parent: TWinControl; x, y: Integer): TControl;
var
  grp : TGroupBox;
begin
  grp := TGroupBox.Create(Parent as TComponent);
  grp.Parent := Parent as TWinControl;
  grp.Name := 'GroupBox'+intToStr(GetTickCount);
  grp.Top  := y;
  grp.Left := X;

  Result := grp;
end;

procedure TaskCtrlGroupBox.setControlTypeProps;
begin
  inherited;

  m_props.Add(TaskCtrlPropImpl.create(self, 'Caption',    'string'));
end;

end.
