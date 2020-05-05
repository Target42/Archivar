unit u_TaskCtrlLabel;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlLabel = class(TaskCtrlImpl)
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
  u_TaskCtrlPropImpl, Vcl.StdCtrls, System.SysUtils, Winapi.Windows;

{ TaskCtrlLabel }

constructor TaskCtrlLabel.Create(owner: ITaskForm);
begin
  inherited;
  m_typ := ctLabel;
end;

destructor TaskCtrlLabel.Destroy;
begin

  inherited;
end;

function TaskCtrlLabel.newControl(parent: TWinControl; x, y: Integer): TControl;
var
  lab : TLabel;
begin
  lab := TLabel.Create(parent as TComponent);
  lab.Parent := parent as TWinControl;
  lab.Name := 'Label'+intToStr(GetTickCount);
  lab.Top  := y;
  lab.Left := X;
  Result := lab;
end;

procedure TaskCtrlLabel.setControlTypeProps;
begin
  inherited;
  m_props.Add(TaskCtrlPropImpl.create(self, 'Caption',    'string'));
end;

procedure TaskCtrlLabel.doSetMouse(md: TControlMouseDown; mv: TControlMouseMove;
  mu: TControlMouseUp);
begin
  ( m_ctrl as TLabel).OnMouseDown  := md;
  ( m_ctrl as TLabel).OnMouseUp    := mu;
  ( m_ctrl as TLabel).OnMouseMove  := mv;
end;

end.
