unit u_TaskCtrlTable;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlTable = class(TaskCtrlImpl)
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
  u_TaskCtrlPropImpl, Vcl.StdCtrls, System.SysUtils, Winapi.Windows, Vcl.Grids;
{ TaskCtrlTable }

constructor TaskCtrlTable.Create(owner: ITaskForm);
begin
  inherited;
end;

destructor TaskCtrlTable.Destroy;
begin

  inherited;
end;

procedure TaskCtrlTable.doSetMouse(md: TControlMouseDown; mv: TControlMouseMove;
  mu: TControlMouseUp);
begin
  ( m_ctrl as TStringGrid).OnMouseDown  := md;
  ( m_ctrl as TStringGrid).OnMouseUp    := mu;
  ( m_ctrl as TStringGrid).OnMouseMove  := mv;

end;

function TaskCtrlTable.newControl(parent: TWinControl; x, y: Integer): TControl;
var
  sg : TStringGrid;
begin
  sg := TStringGrid.Create(parent as TComponent);
  sg.Parent := parent as TWinControl;
  sg.Name := 'Table'+intToStr(GetTickCount);

  sg.Top  := y;
  sg.Left := X;
  Result := sg;
end;

procedure TaskCtrlTable.setControlTypeProps;
begin
  inherited;

end;

end.
