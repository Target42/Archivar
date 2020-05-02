unit u_TaskCtrlImpl;

interface

uses
  i_taskEdit, i_datafields, System.Generics.Collections, Vcl.Controls,
  System.Types, System.Classes;

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

    m_canContainData : boolean;
    m_isContainer    : boolean;
    m_required  : boolean;

    procedure setControlTypeProps; virtual;
    function  newControl(parent : TWinControl; x, y : Integer) :  TControl; virtual;
    procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); virtual;

    procedure setControlClass( value : string );
    function  getControlClass : string;

    function getTableCtrlIF : ITaskCtrlTable; virtual;
    function CtrlValue : string; virtual;
    procedure setCtrlValue( value : string ); virtual;

    procedure colorRequired; virtual;

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

    function  getOwner : ITaskForm;

    procedure sortProps;

    procedure setRequired( value : boolean );
    function  getRequired : boolean;

   public
    constructor Create(owner : ITaskForm);
    destructor Destroy; override;

    property isBase : boolean read m_isBase write m_isBase;
    property Required : boolean read getRequired write setRequired;

    procedure release;

    function findCtrlByCLID( clid : string ) : ITaskCtrl;
    function findCtrl( name : string ) : ITaskCtrl; overload;
    function findCtrl( ctrl : TControl): ITaskCtrl; overload;
    function find( pkt : TPoint ) : ITaskCtrl;

    function NewChild( newType : TControlType; x, y : integer ) : ITaskCtrl; overload;
    function NewChild( clName : string ) : ITaskCtrl;   overload;
    procedure setMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp );

    function getPropertyByName( name : string ) : ITaskCtrlProp;
    function propertyValue( name : string ) : string;
    procedure build;

    procedure dropControls; virtual;
    procedure drop;

    procedure up;
    procedure down;

    procedure updateControl; virtual;
    procedure check( list : TStringList ); virtual;

    procedure setData( value : string );
    function getData( var name, value : string ) : boolean;

    function containData : boolean;
    function isContainer : boolean;
  end;

implementation

uses
  System.SysUtils, Vcl.StdCtrls, Winapi.Windows,
  u_TaskCtrlPropImpl, Vcl.ExtCtrls, Generics.Defaults, Win.ComObj, Vcl.Grids,
  u_TaskCtrlLabel, u_TaskControlFactory;

{ TaskCtrlImpl }

procedure TaskCtrlImpl.build;
var
  i : integer;
begin
  if not Assigned(m_ctrl) and (m_ctrlClass <> '') then
  begin
    m_ctrl := newControl( m_parent.Control as TWinControl, 0, 1000 );
    updateControl;

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

procedure TaskCtrlImpl.check(list: TStringList);
var
  i : integer;
begin
  if not Assigned( m_dataField ) and Assigned(Self.getPropertyByName('Datafield')) then
  begin
    list.Add('Datenfeld "'+self.propertyValue('name')+'" fehlt');
  end;

  for i := 0 to pred(m_list.Count) do
  begin
    m_list[i].check(list);
  end;
end;

procedure TaskCtrlImpl.colorRequired;
begin

end;

function TaskCtrlImpl.containData: boolean;
begin
  Result := m_canContainData;
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
  m_canContainData := false;
  m_isContainer := false;
  m_required  := false;

end;

function TaskCtrlImpl.CtrlValue: string;
begin
  Result := '';
end;

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

procedure TaskCtrlImpl.down;
var
  inx : integer;
begin
  inx := m_parent.Childs.IndexOf(self);
  if inx = m_list.Count-1 then
    exit;

  m_parent.Childs.Exchange( inx, inx +1 );
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
  begin
    m_props[i].Value;
    m_props[i].Control := NIL;
  end;

  // call drop before the drop is executed
  for i := 0 to pred(m_list.Count) do
    m_list[i].dropControls;

  if not m_isBase then
  begin
    if Assigned(m_ctrl) then
      m_ctrl.Free;
    m_ctrl := NIL;
  end;
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
  Result := NIL;
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

function TaskCtrlImpl.findCtrlByCLID(clid: string): ITaskCtrl;
var
  i : integer;
begin
  Result := NIL;
  if Assigned(m_ctrl) and SameText( m_clid, clid ) then
    Result := self
  else
  begin
    for i := 0 to pred(m_list.Count) do
    begin
      Result := m_list[i].findCtrlByCLID(clid);
      if Assigned(Result) then
        break;
    end;
  end;
end;

function TaskCtrlImpl.findCtrl(name: string): ITaskCtrl;
var
  i : integer;
begin
  Result := NIL;
  if Assigned(m_ctrl) and SameText( m_ctrl.Name, name ) then
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

function TaskCtrlImpl.getData( var name, value :string) : boolean;
begin
  Result := false;
  name := propertyValue('name');
  value := CtrlValue;
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

function TaskCtrlImpl.getRequired: boolean;
begin
  Result := m_required;
end;

function TaskCtrlImpl.getTableCtrlIF: ITaskCtrlTable;
begin
  Result := NIL;
end;

function TaskCtrlImpl.isContainer: boolean;
begin
  Result := m_isContainer;
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

  Result.Control :=  Result.newControl(m_ctrl as TWinControl, x, y );
end;

function TaskCtrlImpl.newControl(parent: TWinControl; x, y: Integer): TControl;
begin
  Result := NIL;
end;


function TaskCtrlImpl.propertyValue(name: string): string;
var
  p : ITaskCtrlProp;
begin
  Result := '';

  p := self.getPropertyByName(name);
  if Assigned(p) then
    Result := p.Value;
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
  if (m_ctrlClass = value) and ( m_props.Count >0 ) then
    exit;

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
  m_props.Add(TaskCtrlPropImpl.create(self, 'Width',      'integer'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Align',      'TAlign'));

  if m_canContainData then
  begin
    m_props.Add(TaskCtrlPropImpl.create(self, 'Required',    'boolean'));
  end;

end;

procedure TaskCtrlImpl.setCtrlValue(value: string);
begin
 // nix
end;

procedure TaskCtrlImpl.setData(value: string);
begin
  setCtrlValue(value);
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

procedure TaskCtrlImpl.setRequired(value: boolean);
begin
  m_required := value;

  colorRequired;
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

procedure TaskCtrlImpl.up;
var
  inx : integer;
begin
  inx := m_parent.Childs.IndexOf(self);
  if inx = 0 then
    exit;

  m_parent.Childs.Exchange( inx, inx -1 );
end;

procedure TaskCtrlImpl.updateControl;
begin
 // nix
end;


end.
