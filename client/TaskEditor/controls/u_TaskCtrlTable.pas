unit u_TaskCtrlTable;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes,
  System.Generics.Collections, Vcl.Grids, System.Types;

type
  TaskCtrlTable = class(TaskCtrlImpl, ITaskCtrlTable)
    protected
      procedure setControlTypeProps; override;
      function  newControl(parent : TWinControl; x, y : Integer) :  TControl; override;
      procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); override;

      function  getTableCtrlIF : ITaskCtrlTable; override;
      procedure setReadOnly( value : boolean ); override;
      function  getReadOnly : boolean; override;

      procedure KeyPress(Sender: TObject; var Key: Char); override;

      procedure SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
      procedure SGExit(Sender: TObject);
      procedure Enter(Sender: TObject);


    private
      m_sg  : TStringGrid;
      m_row : integer;
      m_col : integer;

      function  getCell( row, col : integer) : string;
      procedure setCell( row, col : integer; value : string );
      procedure renumber;
      function  getRowCount : integer;
      procedure setRowCount( value : integer );
      procedure DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);

      procedure SGAddRow( sender : TObject );
      procedure SGClear( sender : TObject );
      procedure SGRemoveRow( sender : TObject );
      procedure SGInsertRow( sender : TObject );

      function getCtrl( index : integer ) : ITaskCtrl;
    public

      constructor Create(owner : ITaskForm);
      destructor Destroy; override;

      procedure updateControl; override;

      procedure dropControls; override;

      function addRow : integer;

      function ColCount : integer;
      procedure deleteRow( row : integer );
      function ColDatafield( col : integer ) : string;

      procedure clearContent( recursive : boolean ); override;
  end;

implementation

uses
  u_TaskCtrlPropImpl, System.SysUtils, Winapi.Windows, Vcl.Menus, i_datafields,
  Vcl.Dialogs, Vcl.Graphics;
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

procedure TaskCtrlTable.clearContent(recursive: boolean);
var
  x, y : integer;
begin
  inherited;
  if not Assigned(m_sg) then
    exit;
  for y := 1 to pred(m_sg.RowCount) do
    for x := 1 to pred(m_sg.ColCount) do
      m_sg.Cells[x, y] := '';
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
  m_canContainData  := true;
  m_typ             := ctTable;
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

procedure TaskCtrlTable.DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  sg : TStringGrid;
  can : TCanvas;
  s   : string;
begin
  sg := sender as TStringGrid;
  can := sg.Canvas;

  if (ACol = 0) or ( ARow = 0 ) then begin
    can.Brush.Color := clBtnFace;
    can.Font.Style := [fsBold];
  end else begin
    can.Brush.Color := clWhite;
    can.Font.Style := [];
  end;
  can.FillRect(rect);

  s := sg.Cells[ACol, ARow];
  if ACol <> 0 then
    Can.TextRect(Rect, s, [tfLeft])
  else
    Can.TextRect(Rect, s, [tfCenter]);
end;

procedure TaskCtrlTable.dropControls;
begin
  inherited;
  m_sg := NIL;
end;

procedure TaskCtrlTable.Enter(Sender: TObject);
begin
  m_row := m_sg.Row;
  m_col := m_sg.Col;
end;

function TaskCtrlTable.getCell(row, col: integer): string;
begin
  Result := '';
  if not Assigned(m_sg) then
    exit;
  Result := m_sg.Cells[ col, row ];
end;

function TaskCtrlTable.getCtrl(index: integer): ITaskCtrl;
begin
  Result := NIL;
  if index < m_list.Count then
    Result := m_list[index];
end;

function TaskCtrlTable.getReadOnly: boolean;
begin
  Result := false;
  if Assigned(m_ctrl) then
    Result := (m_ctrl as TStringGrid).Enabled;

end;

function TaskCtrlTable.getRowCount: integer;
begin
  Result := 0;

  if Assigned(m_sg) then
    Result := m_sg.RowCount;
end;

function TaskCtrlTable.getTableCtrlIF: ITaskCtrlTable;
begin
  Result := self;
end;

procedure TaskCtrlTable.KeyPress(Sender: TObject; var Key: Char);
var
  ctrl  : ITaskCtrl;
begin
  if (m_sg.Col = 0) or (m_sg.Row = 0 ) then
    exit;

  ctrl := getCtrl(m_sg.Col-1);
  if not Assigned(ctrl) then
    exit;

  if Assigned(ctrl) and Assigned(ctrl.Validator) then begin
    if not ctrl.Validator.validateKey( key ) then
      key := #0;
  end;
  if key = #13 then begin
   with m_sg do
    begin
      if Col < ColCount -1 then
        Col := Col +1
      else if Row < RowCount -1 then
      begin
        Row := Row +1;
        Col := 1;
      end else
      begin
        RowCount := RowCount + 1;
        Row := RowCount -1;
        Col := 1;
        renumber;
      end;
    end;
  end;

end;

function TaskCtrlTable.newControl(parent: TWinControl; x, y: Integer): TControl;
var
  pop : TPopupMenu;

  procedure addItem( caption : string; handler : TNotifyEvent );
  var
    item : TMenuItem;
  begin
    item  := pop.CreateMenuItem;
    pop.Items.Add(item);
    item.Caption := caption;
    item.OnClick := handler;
  end;
begin
  m_sg := TStringGrid.Create(parent as TComponent);
  m_sg.Parent := parent as TWinControl;
  m_sg.Name := 'Table'+intToStr(GetTickCount);

  m_sg.OnKeyPress   := KeyPress;
  m_sg.OnSelectCell := SelectCell;
  m_sg.OnExit       := SGExit;
  m_sg.OnEnter      := Enter;

  m_sg.OnDrawCell     := DrawCell;
  m_sg.DefaultDrawing := false;


  m_sg.Top  := y;
  m_sg.Left := X;
  m_sg.Options := [ goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
                    goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing,
                    goEditing, goTabs, goAlwaysShowEditor ];

  pop   := TPopupMenu.Create( parent );
  m_sg.PopupMenu := pop;

  addItem('Zeile einfügen', Self.SGInsertRow );
  addItem('Zeile anhängen', self.SGAddRow);
  addItem('Zeile löschen',  Self.SGRemoveRow );
  addItem('-', NIL);
  addItem('Inhalt löschen', Self.SGClear );

  Result := m_sg;
end;

procedure TaskCtrlTable.renumber;
var
  y : integer;
begin
  for y := 1 to pred(m_sg.RowCount) do
    m_sg.Cells[0, y] := IntToStr(y);
end;

procedure TaskCtrlTable.SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  ctrl  : ITaskCtrl;
  s     : string;
begin
  if (m_row = -1 ) then begin
    m_row := ARow;
    m_col := ACol;
  end else begin
    ctrl := getCtrl(m_sg.Col-1);
    if Assigned(ctrl) and Assigned(ctrl.Validator) then begin
      s := m_sg.Cells[m_sg.Col, m_sg.Row ];
      if s <> '' then begin
        CanSelect := ctrl.Validator.validateData(s);
        m_sg.Cells[m_sg.Col, m_sg.Row ] := s;
      end;
    end;
  end;
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
  m_props.Add(TaskCtrlPropImpl.create(self, 'Fields',     'TFields'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',  'TaskDataField'));
end;

procedure TaskCtrlTable.setReadOnly(value: boolean);
begin
  if Assigned(m_ctrl) then
    (m_ctrl as TStringGrid).Enabled := not value;
end;

procedure TaskCtrlTable.setRowCount(value: integer);
begin
  if Assigned(m_sg) then
    m_sg.RowCount := value + 1;
end;

procedure TaskCtrlTable.SGAddRow(sender: TObject);
var
  col : integer;
begin
  m_sg.RowCount := m_sg.RowCount +1;
  m_sg.Cells[0, m_sg.RowCount-1]     := intToStr( m_sg.RowCount );
  for col := 1 to pred(m_sg.ColCount) do
    m_sg.Cells[col, m_sg.RowCount-1] := '';
  renumber;
end;

procedure TaskCtrlTable.SGClear(sender: TObject);
var
  x, y : integer;
begin
  for y := 1 to pred(m_sg.RowCount) do
    for x := 1 to pred(m_sg.ColCount) do
      m_sg.Cells[x, y] := '';
end;

procedure TaskCtrlTable.SGExit(Sender: TObject);
var
  ctrl  : ITaskCtrl;
  s     : string;
begin
  ctrl := getCtrl(m_sg.Col-1);
  if Assigned(ctrl) and Assigned(ctrl.Validator) then begin
    s := m_sg.Cells[m_sg.Col, m_sg.Row ];
    if s <> '' then begin
      if not ctrl.Validator.validateData(s) then
        m_sg.SetFocus;
      m_sg.Cells[m_sg.Col, m_sg.Row ] := s;
    end;
  end;
end;
procedure TaskCtrlTable.SGInsertRow(sender: TObject);
var
  y : integer;
  i : integer;
  x : integer;
begin
  y := m_sg.Row;
  SGAddRow( m_sg );
  for i := pred(m_sg.RowCount) downto y + 1 do
  begin
    for x := 1 to pred(m_sg.ColCount) do
      m_sg.Cells[ x, i ] := m_sg.Cells[ x, i-1 ];
  end;
  for x := 1 to pred(m_sg.ColCount) do
    m_sg.Cells[ x, y ] := '';
  renumber;
end;

procedure TaskCtrlTable.SGRemoveRow(sender: TObject);
var
  y : integer;
  x : integer;
begin
  for y := m_sg.Row to pred(m_sg.RowCount) -1 do
  begin
    for x := 1 to pred(m_sg.ColCount) do
      m_sg.Cells[ x, y ] := m_sg.Cells[ x, y+1 ];
  end;
  m_sg.RowCount := m_sg.RowCount - 1;
  renumber;
end;

procedure TaskCtrlTable.updateControl;
var
  sg : TStringGrid;
  x, y  : integer;
  ctrl  : ITaskCtrl;
begin
  if not Assigned(m_ctrl) then
    exit;
  sg := m_ctrl as TStringGrid;

  SG.Cells[0,0] := 'Nr';
  SG.ColWidths[0] := 35;

  if m_list.Count > 0 then
  begin
    sg.ColCount := m_list.Count + 1;
    for x := 0 to pred(m_list.Count) do
    begin
      SG.Cells[x+1, 0] := m_list[x].propertyValue('Header');
      SG.ColWidths[x+1] := StrToIntDef(m_list[x].propertyValue('Width'), 100);
    end;
  end
  else
  begin
    for x := 1 to pred(SG.ColCount) do
      SG.Cells[ x, 0 ] := char( 64 + x );
  end;
  // Row number
  for y := 1 to pred(SG.RowCount) do
    SG.Cells[0, y] := IntToStr( y );

  // content ...
  for y := 1 to pred(SG.RowCount) do
    for x := 1 to pred(sg.ColCount) do begin

      ctrl := getCtrl(x-1);

      if not Assigned(ctrl) or not Assigned(ctrl.DataField) then
        SG.Cells[X, y ] := SG.Cells[x, 0]+SG.Cells[0, y]
      else
        SG.Cells[X, y ] := ctrl.data;

    end;
end;

end.


