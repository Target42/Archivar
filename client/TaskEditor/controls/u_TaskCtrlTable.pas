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
      procedure updateControl; override;
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
  m_props.Add(TaskCtrlPropImpl.create(self, 'Fields',   'TFields'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',  'TaskDataField'));
end;

procedure TaskCtrlTable.updateControl;
var
  sg : TStringGrid;
  x, y  : integer;
begin
  if not Assigned(m_ctrl) then
    exit;
  sg := m_ctrl as TStringGrid;

  SG.Cells[0,0] := 'Nr';

  if m_list.Count > 0 then
  begin
    sg.ColCount := m_list.Count + 1;
    for x := 0 to pred(m_list.Count) do
    begin
      SG.Cells[x+1, 0] := m_list[x].propertyValue('Header');
      SG.ColWidths[x+1] := StrToint(m_list[x].propertyValue('Width'));
    end;
  end
  else
  begin
    for x := 1 to pred(SG.ColCount) do
      SG.Cells[ x, 0 ] := char( 64 + x );
  end;
  for y := 1 to pred(SG.RowCount) do
    SG.Cells[0, y] := IntToStr( y );

  for y := 1 to pred(SG.RowCount) do
    for x := 1 to pred(sg.ColCount) do
      SG.Cells[X, y ] := SG.Cells[x, 0]+SG.Cells[0, y];
end;

end.
