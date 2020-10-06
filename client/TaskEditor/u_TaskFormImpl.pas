unit u_TaskFormImpl;

interface

uses
  i_taskEdit, System.Generics.Collections, Vcl.Controls;

type
  TaskFormImpl = class( TInterfacedObject, ITaskForm )
  private
    m_owner : ITask;
    m_name : string;
    m_clid : string;
    m_list : Tlist<ITaskCtrl>;
    m_isMain : boolean;
    m_base : ITaskCtrl;

    procedure setName( value : string );
    function  getName : string;
    procedure setCLID( value : string );
    function  getCLID : string;
    procedure setMainForm( value : boolean );
    function  getMainForm : Boolean;
    function  getBase : ITaskCtrl;
    function getOwner : ITask;
    procedure setReadOnly( value : boolean );
    function  getReadOnly : boolean;

    procedure setChanged( value : boolean );
    function  getChanged : boolean;
  public

    constructor Create(Owner : ITask );
    Destructor Destroy; override;

    procedure release;
    procedure clearContent;
    function newControl : ITaskCtrl;

    function createControl( parent : TControl; newType : TControlType; x, y : integer ) : ITaskCtrl;
  end;

implementation

uses
  System.Win.ComObj, u_TaskCtrlImpl;

{ TaskFormImpl }

procedure TaskFormImpl.clearContent;
begin
  m_base.clearContent( true );
end;

constructor TaskFormImpl.Create(owner : ITask);
begin
  m_owner := owner;
  m_list := Tlist<ITaskCtrl>.create;
  m_isMain := false;
  m_clid   := CreateClassID;
  m_base   := TaskCtrlImpl.create(self);
  (m_base as TaskCtrlImpl).isBase := true;
  m_name   := 'Form';
end;

function TaskFormImpl.createControl(parent: TControl; newType: TControlType; x,
  y: integer): ITaskCtrl;
var
  pTaskCtrl : ITaskCtrl;
begin
  Result := NIL;

  pTaskCtrl := m_base.findCtrl( parent);
  if Assigned(pTaskCtrl) then
  begin
    Result := pTaskCtrl.NewChild( newType, x, y );
  end;
end;

destructor TaskFormImpl.Destroy;
begin
  m_base := NIL;
  m_list.Free;
  inherited;
end;

function TaskFormImpl.getBase: ITaskCtrl;
begin
  Result := m_base;
end;

function TaskFormImpl.getChanged: boolean;
  function get( base : ITaskCtrl) : boolean;
  var
    i : integer;
  begin
    Result := false;
    if not Assigned(base) then
      exit;

    Result := base.Changed;
    if not Result then begin
      for i := 0 to pred(base.Childs.Count) do
      begin
        Result := get(base.Childs.Items[i]);
        if Result then
          break;
      end;
    end;
  end;
begin
  Result := get(m_base);
end;

function TaskFormImpl.getCLID: string;
begin
  Result := m_clid;
end;

function TaskFormImpl.getMainForm: Boolean;
begin
  Result := m_isMain;
end;

function TaskFormImpl.getName: string;
begin
  Result := m_name;
end;

function TaskFormImpl.getOwner: ITask;
begin
  Result := m_owner;
end;

function TaskFormImpl.getReadOnly: boolean;
  function getRO( ctrl : ITaskCtrl) : boolean;
  var
    i : integer;
  begin
    Result := ctrl.ReadOnly;
    if not Result then
    begin
      for i := 0 to pred(ctrl.Childs.Count) do
      begin
        Result := getRO(ctrl.Childs.Items[i]);
        if Result then
          break;
      end;
    end;
  end;

begin
  Result := false;
  if Assigned(m_base) then
    Result := getRO( m_base );
end;

function TaskFormImpl.newControl: ITaskCtrl;
begin
  Result := TaskCtrlImpl.Create(self);
  m_list.Add(Result);
end;

procedure TaskFormImpl.release;
var
  i : integer;
begin
  m_owner := NIL;
  for i := 0 to pred(m_list.Count) do
    m_list[i].release;

  m_list.Clear;
  m_base.release;
end;

procedure TaskFormImpl.setChanged(value: boolean);
  procedure clear( base : ITaskCtrl);
  var
    i : integer;
  begin
    base.Changed := false;
    for i := 0 to pred(base.Childs.Count) do
      base.Childs.Items[i].Changed := false;
  end;
begin
  if Assigned(m_base) then
    m_base.Changed := false;
end;

procedure TaskFormImpl.setCLID(value: string);
begin
 m_clid := value;
end;

procedure TaskFormImpl.setMainForm(value: boolean);
begin
  m_isMain := value;
end;

procedure TaskFormImpl.setName(value: string);
begin
  m_name := value;
end;


procedure TaskFormImpl.setReadOnly(value: boolean);
  procedure setRO( ctrl : ITaskCtrl);
  var
    i : integer;
  begin
    ctrl.ReadOnly := value;
    for i := 0 to pred(ctrl.Childs.Count) do
      setRO(ctrl.Childs[i]);
  end;
begin
  if Assigned(m_base) then
    setRO(m_base);
end;

end.
