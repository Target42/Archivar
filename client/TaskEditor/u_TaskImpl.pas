unit u_TaskImpl;

interface

uses
  i_taskEdit, System.Generics.Collections, i_datafields;

type
  TTask = class( TInterfacedObject, ITask )
  private
    m_name    : string;
    m_clid    : string;
    m_fields  : IDataFieldList;
    m_forms   : TList<ITaskForm>;

    procedure setName( value : string );
    function  getName : string;
    procedure setCLID( value : string );
    function  getCLID : string;
    function  getFields :IDataFieldList;
    function  getForms : TList<ITaskForm>;
  public
    constructor create;
    Destructor Destroy; override;

    property Name   : string read getName write setName;
    property CLID   : string read getCLID write setCLID;
    property Fields : IDataFieldList read getFields;
    property Forms  : TList<ITaskForm> read getForms;

    function NewForm : ITaskForm;
    function getFormByCLID( clid : string ) : ITaskForm;

    procedure release;

  end;
implementation

{ TTask }
uses
  System.Win.ComObj, u_DataFieldLislImpl, u_TaskFormImpl, System.SysUtils;

constructor TTask.create;
begin
  m_fields  := TDataFieldList.create(NIL);
  m_forms   := TList<ITaskForm>.create;
  m_clid    := CreateClassID;
end;

destructor TTask.Destroy;
begin
  release;
  m_forms.Free;
  inherited;
end;

function TTask.getCLID: string;
begin
  Result := m_clid;
end;

function TTask.getFields: IDataFieldList;
begin
  Result := m_fields;
end;

function TTask.getFormByCLID(clid: string): ITaskForm;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(m_forms.Count) do
  begin
    if SameText( m_forms[i].CLID, clid) then
    begin
      Result := m_forms[i];
      break;
    end;
  end;
end;

function TTask.getForms: TList<ITaskForm>;
begin
  Result := m_forms;
end;

function TTask.getName: string;
begin
  Result := m_name;
end;

function TTask.NewForm: ITaskForm;
begin
  Result := TaskFormImpl.create(self);
  m_forms.Add(Result);
end;

procedure TTask.release;
var
  i : integer;
begin
  m_fields.release;

  for i := 0 to pred(m_forms.Count) do
    m_forms[i].release;
  m_forms.Clear;
end;

procedure TTask.setCLID(value: string);
begin
  m_clid := value;
end;

procedure TTask.setName(value: string);
begin
  m_name := value;
end;

end.
