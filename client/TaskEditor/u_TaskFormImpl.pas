unit u_TaskFormImpl;

interface

uses
  i_taskEdit, System.Generics.Collections, Vcl.Controls;

type
  TaskFormImpl = class( TInterfacedObject, ITaskForm )
  private
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

  public

    constructor Create;
    Destructor Destroy; override;

    procedure release;
    function newControl : ITaskCtrl;

    function createControl( parent : TControl; newType : TControlType; x, y : integer ) : ITaskCtrl;
  end;

implementation

uses
  System.Win.ComObj, u_TaskCtrlImpl;

{ TaskFormImpl }

constructor TaskFormImpl.Create;
begin
  m_list := Tlist<ITaskCtrl>.create;
  m_isMain := false;
  m_clid   := CreateClassID;
  m_base   := TaskCtrlImpl.create;
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

function TaskFormImpl.newControl: ITaskCtrl;
begin
  Result := TaskCtrlImpl.Create;
  m_list.Add(Result);
end;

procedure TaskFormImpl.release;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
    m_list[i].release;

  m_list.Clear;
  m_base.release;
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


end.
