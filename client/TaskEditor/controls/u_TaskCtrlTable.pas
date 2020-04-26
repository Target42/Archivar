unit u_TaskCtrlTable;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes,
  System.Generics.Collections, Vcl.Grids;

type
  TaskCtrlTable = class(TaskCtrlImpl, ITaskCtrlTable)
    protected
      procedure setControlTypeProps; override;
      function  newControl(parent : TWinControl; x, y : Integer) :  TControl; override;
      procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); override;

      function getTableCtrlIF : ITaskCtrlTable; override;
    private
      m_sg : TStringGrid;
      function getCell( row, col : integer) : string;
      procedure setCell( row, col : integer; value : string );
      procedure renumber;
    public

      constructor Create(owner : ITaskForm);
      destructor Destroy; override;

      procedure updateControl; override;

      procedure dropControls; override;

      function addRow : integer;
      function RowCount : integer;
      function ColCount : integer;
      procedure deleteRow( row : integer );
      function ColDatafield( col : integer ) : string;
  end;

implementation

uses
  u_TaskCtrlPropImpl, Vcl.StdCtrls, System.SysUtils, Winapi.Windows;
{ TaskCtrlTable }

function TaskCtrlTable.addRow: integer;
var
  x : integer;
begin
  Result := -1;
  if not Assigned(m_sg) then
    exit;
  m_sg.RowCount := m_sg.RowCount + 1;
  for x := 0 to pred(m_sg.ColCount)  do
    m_sg.Cells[m_sg.RowCount-1, x] := '';

  renumber;
  Result := m_sg.RowCount;
end;

function TaskCtrlTable.ColCount: integer;
begin
  Result := m_list.Count;
end;


function TaskCtrlTable.ColDatafield(col: integer): string;
begin
  Result := '';
  if not Assigned(m_sg) then
    exit;
  if Assigned(m_list.Items[col-1].DataField) then
    Result := m_list.Items[col-1].DataField.Name;
end;

constructor TaskCtrlTable.Create(owner: ITaskForm);
begin
  inherited;
  m_sg := NIL;
end;

procedure TaskCtrlTable.deleteRow(row: integer);
var
  y, x : integer;
begin
  if not Assigned(m_sg) then
    exit;

  for y := row+1 to pred(m_sg.RowCount) do
    for x := 1 to pred(m_sg.ColCount) do
      m_sg.Cells[ x, y-1] := m_sg.Cells[x, y];

  m_sg.RowCount := m_sg.RowCount - 1;

  renumber;
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

procedure TaskCtrlTable.dropControls;
begin
  inherited;
  m_sg := NIL;
end;

function TaskCtrlTable.getCell(row, col: integer): string;
begin
  Result := '';
  if not Assigned(m_sg) then
    exit;
  Result := m_sg.Cells[ col, row ];
end;

function TaskCtrlTable.getTableCtrlIF: ITaskCtrlTable;
begin
  Result := self;
end;

function TaskCtrlTable.newControl(parent: TWinControl; x, y: Integer): TControl;
begin
  m_sg := TStringGrid.Create(parent as TComponent);
  m_sg.Parent := parent as TWinControl;
  m_sg.Name := 'Table'+intToStr(GetTickCount);

  m_sg.Top  := y;
  m_sg.Left := X;
  Result := m_sg;

end;

procedure TaskCtrlTable.renumber;
var
  y : integer;
begin
  for y := 1 to pred(m_sg.RowCount) do
    m_sg.Cells[0, y] := IntToStr(y);
end;

function TaskCtrlTable.RowCount: integer;
begin
  Result := m_sg.RowCount - 1;
end;


procedure TaskCtrlTable.setCell(row, col: integer; value: string);
begin
  if not Assigned(m_ctrl) then
    exit;
  m_sg.Cells[ col, row] := value;
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
