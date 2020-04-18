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
    m_root : TWinControl;
    m_base : ITaskCtrl;

    procedure setName( value : string );
    function  getName : string;
    procedure setCLID( value : string );
    function  getCLID : string;
    procedure setMainForm( value : boolean );
    function  getMainForm : Boolean;
    function  getControls : Tlist<ITaskCtrl>;
    procedure setRoot( value : TWinControl );
    function  getRoot : TWinControl;

  public

    constructor Create;
    Destructor Destroy; override;

    property Name  : string read getName write setName;
    property CLID   : string read getCLID write setCLID;
    property MainForm : boolean read getMainForm write setMainForm;
    property Controls : Tlist<ITaskCtrl> read getControls;
    property Root     : TWinControl read getRoot write setRoot;

    procedure release;

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
  m_root   := NIL;
  m_base   := NIL;
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
  m_root := NIL;
  m_list.Free;
  inherited;
end;

function TaskFormImpl.getCLID: string;
begin
  Result := m_clid;
end;

function TaskFormImpl.getControls: Tlist<ITaskCtrl>;
begin
  Result := m_list;
end;

function TaskFormImpl.getMainForm: Boolean;
begin
  Result := m_isMain;
end;

function TaskFormImpl.getName: string;
begin
  Result := m_name;
end;

function TaskFormImpl.getRoot: TWinControl;
begin
  Result := m_root;
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

procedure TaskFormImpl.setRoot(value: TWinControl);
begin
  m_root := value;
  if Assigned(m_base) then
  begin
    m_base.release;
  end;
  m_base := TaskCtrlImpl.create;
  m_base.Control := value;

end;

end.
