unit u_TaskCtrlImpl;

interface

uses
  i_taskEdit, i_datafields, System.Generics.Collections, Vcl.Controls,
  System.Types;

type
  TaskCtrlImpl = class(TInterfacedObject, ITaskCtrl)
  protected
    m_owner     : ITaskForm;
    m_clid      :  string;
    m_dataField : IDataField;
    m_ctrl      : TControl;
    m_ctrlClass : string;
    m_list      : TList<ITaskCtrl>;
    m_props     : TList<ITaskCtrlProp>;
    m_parent    : ITaskCtrl;
    m_isBase    : boolean;

    procedure setControlTypeProps; virtual;
    function  newControl(parent : TWinControl; x, y : Integer) :  TControl; virtual;
    procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); virtual;

    function hasText( name : string; var value : string ) : boolean; virtual;

  private
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

    function  getOwner : ITaskForm;

    procedure sortProps;

   public
    constructor Create(owner : ITaskForm);
    destructor Destroy; override;

    property isBase : boolean read m_isBase write m_isBase;

    procedure release;

    function findCtrl( name : string ) : ITaskCtrl; overload;
    function findCtrl( ctrl : TControl): ITaskCtrl; overload;
    function find( pkt : TPoint ) : ITaskCtrl;

    function NewChild( newType : TControlType; x, y : integer ) : ITaskCtrl; overload;
    function NewChild( clName : string ) : ITaskCtrl;   overload;
    procedure setMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp );

    function getPropertyByName( name : string ) : ITaskCtrlProp;
    procedure build;

    procedure dropControls;
    procedure clearProps;
    procedure drop;
  end;

implementation

uses
  System.SysUtils, Vcl.StdCtrls, System.Classes, Winapi.Windows,
  u_TaskCtrlPropImpl, Vcl.ExtCtrls, Generics.Defaults, Win.ComObj, Vcl.Grids,
  u_TaskCtrlLabel, u_TaskControlFactory;

{ TaskCtrlImpl }

procedure TaskCtrlImpl.build;
var
  i : integer;
begin
  if not Assigned(m_ctrl) and (m_ctrlClass <> '')then
  begin
    m_ctrl := Self.newControl( m_parent.Control as TWinControl, 0, 0 );

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

constructor TaskCtrlImpl.Create(owner : ITaskForm);
begin
  m_owner     := owner;
  m_clid      := CreateClassID;
  m_dataField := NIL;
  m_parent    := NIL;
  m_ctrl      := NIL;
  m_list      := TList<ITaskCtrl>.create;
  m_props     := TList<ITaskCtrlProp>.create;
  m_isBase    := false;

end;

{function TaskCtrlImpl.createControl(p: ITaskCtrl; newType: TControlType; x,
  y: integer): ITaskCtrl;
var
  win  : TWinControl;
begin
  Result := TTaskControlFactory.GetInstance.createControl(m_owner, p, newType, x, y);
  Result.Parent := self;
  m_list.Add(Result);

  win  := m_ctrl as TWinControl;
  Result.Control := Result.newControl(win, x, y );
end;}

destructor TaskCtrlImpl.Destroy;
begin
  m_props.Free;
  m_list.Free;
  inherited;
end;

procedure TaskCtrlImpl.doSetMouse(md: TControlMouseDown; mv: TControlMouseMove;
  mu: TControlMouseUp);
begin
end;

procedure TaskCtrlImpl.drop;
begin
  m_parent.Childs.Remove(self);
  release;
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

function TaskCtrlImpl.find(pkt: TPoint): ITaskCtrl;
var
  i : integer;
  re : TRect;
begin
  Result := NIL;
  for i := 0 to pred(m_list.Count) do
    begin
      Result := m_list[i].find(pkt);
      if Assigned(Result) then
        break;
    end;
  if not Assigned(Result) and not m_isBase then
  begin
    if Assigned(m_ctrl) then
    begin
      re := Rect( m_ctrl.Left, m_ctrl.Top, m_ctrl.Left + m_ctrl.left, m_ctrl.Top + m_ctrl.Height );
      if re.Contains(pkt) then
        Result := self;
    end;
  end;
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

function TaskCtrlImpl.getOwner: ITaskForm;
begin
  Result := m_owner;
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

function TaskCtrlImpl.hasText(name: string; var value: string): boolean;
begin
  Result := false;

  if name = 'test' then
  begin
    value := 'Hallo welt';
    Result := true;
  end;


end;

function TaskCtrlImpl.NewChild( clName : string ): ITaskCtrl;
begin
  Result := TTaskControlFactory.GetInstance.createControl( m_owner, m_parent, clName);
  Result.Parent := self;
  m_list.Add(Result);
end;

function TaskCtrlImpl.NewChild(newType: TControlType; x, y: integer): ITaskCtrl;
begin
  Result := TTaskControlFactory.GetInstance.createControl(m_owner, m_parent, newType, x, y);
  Result.Parent := self;
  m_list.Add(Result);

  Result.Control := Result.newControl(m_ctrl as TWinControl, x, y );

end;


function TaskCtrlImpl.newControl(parent: TWinControl; x, y: Integer): TControl;
begin
  Result := NIL;
end;


procedure TaskCtrlImpl.release;
var
  i : integer;
begin
  m_parent  := NIL;
  m_owner   := NIL;

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
  if not Assigned(m_ctrl) then
    exit;
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

  if m_isBase then
    exit;

  setControlTypeProps;
  sortProps;
end;

procedure TaskCtrlImpl.setControlTypeProps;
begin
  m_props.Add(TaskCtrlPropImpl.create(self, 'Name',       'String'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Top',        'integer'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Left',       'integer'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Height',     'integer'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Enabled',    'boolean'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Visible',    'boolean'));

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
  doSetMouse( md, mv, mu );

end;

procedure TaskCtrlImpl.setParent(value: ITaskCtrl);
begin
  m_parent := value;
end;

procedure TaskCtrlImpl.sortProps;
begin
  m_props.Sort(
    TComparer<ITaskCtrlProp>.Construct(
      function(const Left, Right: ITaskCtrlProp): Integer
      begin
        Result := CompareStr(left.Name, Right.Name);
      end
    )
  );
end;

end.
