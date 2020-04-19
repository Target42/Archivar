unit u_TaskCtrlImpl;

interface

uses
  i_taskEdit, i_datafields, System.Generics.Collections, Vcl.Controls;

type
  TaskCtrlImpl = class(TInterfacedObject, ITaskCtrl)
  private
    m_clid      :  string;
    m_dataField : IDataField;
    m_ctrl      : TControl;
    m_ctrlClass : string;
    m_list      : TList<ITaskCtrl>;
    m_props     : TList<ITaskCtrlProp>;
    m_parent    : ITaskCtrl;
    m_isBase    : boolean;

    procedure setDataField( value : IDataField );
    function  getDataField : IDataField;

    function  getChilds : TList<ITaskCtrl>;
    function  getProps  : TList<ITaskCtrlProp>;

    procedure setControl( value : TControl );
    function  getControl : TControl;

    procedure setParent( value : ITaskCtrl );
    function  getParent : ITaskCtrl;

    procedure setCLID( value : string );
    function  getCLID : string;

    procedure setControlClass( value : string );
    function  getControlClass : string;

    function createControl( p : ITaskCtrl; newType : TControlType; x, y : integer) : ITaskCtrl;
    function newEdit(     parent : TWinControl; x, y : Integer) :  TControl;
    function newLabel(    parent : TWinControl; x, y : Integer) :  TControl;
    function newGroupbox( parent : TWinControl; x, y : Integer) :  TControl;

   public
    constructor Create;
    destructor Destroy; override;

    property isBase : boolean read m_isBase write m_isBase;

    procedure release;

    function findCtrl( name : string ) : ITaskCtrl; overload;
    function findCtrl( ctrl : TControl): ITaskCtrl; overload;

    function NewChild( newType : TControlType; x, y : integer ) : ITaskCtrl; overload;
    function NewChild : ITaskCtrl;   overload;
    procedure setMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp );

    function getPropertyByName( name : string ) : ITaskCtrlProp;
    procedure build;
    procedure dropControls;
    procedure clearProps;
  end;

implementation

uses
  System.SysUtils, Vcl.StdCtrls, System.Classes, Winapi.Windows,
  u_TaskCtrlPropImpl, Vcl.ExtCtrls, Generics.Defaults, Win.ComObj;

{ TaskCtrlImpl }

procedure TaskCtrlImpl.build;
var
  i : integer;
begin
  if not Assigned(m_ctrl) and (m_ctrlClass <> '')then
  begin
    if SameText(m_ctrlClass, 'TEdit') then
      m_ctrl := newEdit( m_parent.Control as TWinControl, 0, 0 )
    else if SameText(m_ctrlClass, 'TLabel') then
      m_ctrl := newLabel( m_parent.Control as TWinControl, 0, 0 )
    else if SameText(m_ctrlClass, 'TGroupBox') then
      m_ctrl := newGroupbox( m_parent.Control as TWinControl, 0, 0 );

    if Assigned( m_ctrl) then
    begin
      for i := 0 to pred(m_props.Count) do
      begin
        m_props[i].Control := m_ctrl;
        m_props[i].config;
      end;
    end;
  end;


  for i := 0 to pred(m_list.Count) do
    m_list[i].build;
end;

procedure TaskCtrlImpl.clearProps;
var
  i : integer;
begin
  for i := 0 to pred(m_props.Count) do
    m_props[i].release;
  m_props.Clear;

end;

constructor TaskCtrlImpl.Create;
begin
  m_clid      := CreateClassID;
  m_dataField := NIL;
  m_parent    := NIL;
  m_ctrl      := NIL;
  m_list      := TList<ITaskCtrl>.create;
  m_props     := TList<ITaskCtrlProp>.create;
  m_isBase    := false;

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

end;

destructor TaskCtrlImpl.Destroy;
begin
  m_props.Free;
  m_list.Free;
  inherited;
end;

procedure TaskCtrlImpl.dropControls;
var
  i : integer;
begin
  // get the current values
  for i := 0 to pred(m_props.Count) do
    m_props[i].Value;

  for i := 0 to pred(m_list.Count) do
    m_list[i].dropControls;

  m_ctrl := NIL;
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

function TaskCtrlImpl.getCLID: string;
begin
  Result := m_clid;
end;

function TaskCtrlImpl.getControl: TControl;
begin
  Result := m_ctrl;
end;

function TaskCtrlImpl.getControlClass: string;
begin
  Result := m_ctrlClass;
end;

function TaskCtrlImpl.getDataField: IDataField;
begin
  Result := m_dataField;
end;

function TaskCtrlImpl.getParent: ITaskCtrl;
begin
  Result := m_parent;
end;

function TaskCtrlImpl.getPropertyByName(name: string): ITaskCtrlProp;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(m_props.Count) do
  begin
    if SameText( name, m_props.Items[i].Name) then
    begin
      Result := m_props.Items[i];
      break;
    end;
  end;
end;

function TaskCtrlImpl.getProps: TList<ITaskCtrlProp>;
begin
  Result := m_props;
end;

function TaskCtrlImpl.NewChild: ITaskCtrl;
begin
  Result := TaskCtrlImpl.Create;
  Result.Parent := self;
  m_list.Add(Result);
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

procedure TaskCtrlImpl.setCLID(value: string);
begin
  m_clid := value;
end;

procedure TaskCtrlImpl.setControl(value: TControl);
var
  i : integer;
  needConfig : boolean;
begin
  m_ctrl := value;
  if m_isBase then
    exit;

  needConfig := (m_ctrlClass <> '');

  if not needConfig then
     setControlClass(m_ctrl.ClassName);

  for i := 0 to pred(m_props.Count) do
  begin
    m_props.Items[i].Control := m_ctrl;
    if needConfig then
      m_props.Items[i].config;
  end;
end;

procedure TaskCtrlImpl.setControlClass(value: string);
begin
  m_ctrlClass := value;

  m_props.Add(TaskCtrlPropImpl.create('Name',       'String'));
  m_props.Add(TaskCtrlPropImpl.create('Top',        'integer'));
  m_props.Add(TaskCtrlPropImpl.create('Left',       'integer'));
  m_props.Add(TaskCtrlPropImpl.create('Height',     'integer'));
  m_props.Add(TaskCtrlPropImpl.create('Enabled',    'boolean'));
  m_props.Add(TaskCtrlPropImpl.create('Visible',    'boolean'));

  if SameText(m_ctrlClass, 'TLabel') or SameText( m_ctrlClass, 'TGroupBox') then
  begin
    m_props.Add(TaskCtrlPropImpl.create('Caption',    'string'));
  end;
  if sameText(m_ctrlClass, 'TEdit') or SameText(m_ctrlClass, 'TLabeledEdit') then
  begin
    m_props.Add(TaskCtrlPropImpl.create('Text',       'string'));
  end;
  if  SameText( m_ctrlClass, 'TLabeledEdit') then
  begin
    m_props.Add(TaskCtrlPropImpl.create('Caption',    'string'));
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
