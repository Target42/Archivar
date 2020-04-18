unit u_TaskCtrlImpl;

interface

uses
  i_taskEdit, i_datafields, System.Generics.Collections, Vcl.Controls;

type
  TaskCtrlImpl = class(TInterfacedObject, ITaskCtrl)
  private
    m_dataField : IDataField;
    m_ctrl      : TControl;
    m_list      : TList<ITaskCtrl>;
    m_props     : TList<ITaskCtrlProp>;
    m_parent    : ITaskCtrl;

    procedure setDataField( value : IDataField );
    function  getDataField : IDataField;

    function  getChilds : TList<ITaskCtrl>;
    function  getProps  : TList<ITaskCtrlProp>;

    procedure setControl( value : TControl );
    function  getControl : TControl;

    procedure setParent( value : ITaskCtrl );
    function  getParent : ITaskCtrl;

    function createControl( p : ITaskCtrl; newType : TControlType; x, y : integer) : ITaskCtrl;
    function newEdit(     parent : TWinControl; x, y : Integer) :  TControl;
    function newLabel(    parent : TWinControl; x, y : Integer) :  TControl;
    function newGroupbox( parent : TWinControl; x, y : Integer) :  TControl;
   public
    constructor Create;
    destructor Destroy; override;

    property DataField : IDataField read getDataField write setDataField;
    property Control   : TControl read getControl write setControl;
    property Childs    : TList<ITaskCtrl> read getChilds;
    property Props     : TList<ITaskCtrlProp> read getProps;

    procedure release;

    function findCtrl( name : string ) : ITaskCtrl; overload;
    function findCtrl( ctrl : TControl): ITaskCtrl; overload;

    function NewChild( newType : TControlType; x, y : integer ) : ITaskCtrl;
    procedure setMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp );
  end;

implementation

uses
  System.SysUtils, Vcl.StdCtrls, System.Classes, Winapi.Windows,
  u_TaskCtrlPropImpl, Vcl.ExtCtrls, Generics.Defaults;

{ TaskCtrlImpl }

constructor TaskCtrlImpl.Create;
begin
  m_dataField := NIL;
  m_parent    := NIL;
  m_ctrl      := NIL;
  m_list      := TList<ITaskCtrl>.create;
  m_props     := TList<ITaskCtrlProp>.create;

end;

function TaskCtrlImpl.createControl(p: ITaskCtrl; newType: TControlType; x,
  y: integer): ITaskCtrl;
var
  ctrl : TControl;
  win  : TWinControl;
begin
  Result := TaskCtrlImpl.Create;
  Result.Parent := self;
  m_list.Add(Result);

  win  := m_ctrl as TWinControl;
  ctrl := NIL;
  case newType of
    ctNone: ;
    ctEdit:         ctrl := newEdit( win, x, y );
    ctLabeledEdit: ;
    ctLabel:        ctrl := newLabel(win, x, y );
    ctGroupBox:     ctrl := newGroupbox( win, x, y);
    ctPanel: ;
    ctMemo: ;
    ctRichEdit: ;
    ctRadio: ;
    ctRadioGrp: ;
  end;
  Result.Control := ctrl;

  // create properties
  if ctrl is TWinControl then
  begin
    m_props.Add(TaskCtrlPropImpl.create('Name',       'String',     m_ctrl));
    m_props.Add(TaskCtrlPropImpl.create('Top',        'integer',    m_ctrl));
    m_props.Add(TaskCtrlPropImpl.create('Left',       'integer',    m_ctrl));
    m_props.Add(TaskCtrlPropImpl.create('Height',     'integer',    m_ctrl));
    m_props.Add(TaskCtrlPropImpl.create('Enabled',    'boolean',    m_ctrl));
    m_props.Add(TaskCtrlPropImpl.create('Visible',    'boolean',    m_ctrl));
  end;

  if (ctrl is TLabel) or ( ctrl is TGroupBox) then
  begin
    m_props.Add(TaskCtrlPropImpl.create('Caption',    'string',    m_ctrl));
  end;
  if (ctrl is TEdit) or ( ctrl is TLabeledEdit) then
  begin
    m_props.Add(TaskCtrlPropImpl.create('Caption',    'string',    m_ctrl));
    m_props.Add(TaskCtrlPropImpl.create('Text',       'string',    m_ctrl));
  end;

  m_props.Sort(
    TComparer<ITaskCtrlProp>.Construct(
      function(const Left, Right: ITaskCtrlProp): Integer
      begin
        Result := CompareStr(left.Name, Right.Name);
      end
    )
  );
end;

destructor TaskCtrlImpl.Destroy;
begin
  m_props.Free;
  m_list.Free;
  inherited;
end;

function TaskCtrlImpl.findCtrl(ctrl: TControl): ITaskCtrl;
var
  i : integer;
begin
  if m_ctrl = ctrl then
    Result := self
  else
  begin
    for i := 0 to pred(m_list.Count) do
    begin
      Result := m_list[i].findCtrl(ctrl);
      if Assigned(Result) then
        break;
    end;
  end;
end;

function TaskCtrlImpl.findCtrl(name: string): ITaskCtrl;
var
  i : integer;
begin
  if SameText( m_ctrl.Name, name ) then
    Result := self
  else
  begin
    for i := 0 to pred(m_list.Count) do
    begin
      Result := m_list[i].findCtrl(name);
      if Assigned(Result) then
        break;
    end;
  end;
end;

function TaskCtrlImpl.getChilds: TList<ITaskCtrl>;
begin
  Result := m_list;
end;

function TaskCtrlImpl.getControl: TControl;
begin
  Result := m_ctrl;
end;

function TaskCtrlImpl.getDataField: IDataField;
begin
  Result := m_dataField;
end;

function TaskCtrlImpl.getParent: ITaskCtrl;
begin
  Result := m_parent;
end;

function TaskCtrlImpl.getProps: TList<ITaskCtrlProp>;
begin
  Result := m_props;
end;

function TaskCtrlImpl.NewChild(newType: TControlType; x, y: integer): ITaskCtrl;
begin
  Result := createControl( self, newType, x, y );
end;

function TaskCtrlImpl.newEdit(parent: TWinControl; x, y: Integer): TControl;
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

function TaskCtrlImpl.newGroupbox(parent: TWinControl; x, y: Integer): TControl;
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

function TaskCtrlImpl.newLabel(parent: TWinControl; x, y: Integer): TControl;
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

procedure TaskCtrlImpl.release;
var
  i : integer;
begin
  m_parent := NIL;

  for i := 0 to pred(m_list.Count) do
    m_list[i].release;
  m_list.Clear;

  for i := 0 to pred(m_props.Count) do
    m_props[i].release;
  m_props.Clear;

end;

procedure TaskCtrlImpl.setControl(value: TControl);
begin
  m_ctrl := value;
end;

procedure TaskCtrlImpl.setDataField(value: IDataField);
begin
  m_dataField := value;
end;

procedure TaskCtrlImpl.setMouse(md: TControlMouseDown; mv: TControlMouseMove;
  mu: TControlMouseUp);
begin
  if not Assigned(m_ctrl) then
    exit;
  if m_ctrl is TEdit then
  begin
    ( m_ctrl as TEdit).OnMouseDown  := md;
    ( m_ctrl as TEdit).OnMouseUp    := mu;
    ( m_ctrl as TEdit).OnMouseMove  := mv;
  end
  else if m_ctrl is TLabel then
  begin
    ( m_ctrl as TLabel).OnMouseDown  := md;
    ( m_ctrl as TLabel).OnMouseUp    := mu;
    ( m_ctrl as TLabel).OnMouseMove  := mv;
  end
  else if m_ctrl is TGroupBox then
  begin
    ( m_ctrl as TGroupBox).OnMouseDown  := md;
    ( m_ctrl as TGroupBox).OnMouseUp    := mu;
    ( m_ctrl as TGroupBox).OnMouseMove  := mv;
  end;
end;

procedure TaskCtrlImpl.setParent(value: ITaskCtrl);
begin
  m_parent := value;
end;

end.
