unit u_TaskCtrlEdit;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlEdit = class(TaskCtrlImpl)
    protected
      procedure setControlTypeProps; override;
      function  newControl(parent : TWinControl; x, y : Integer) :  TControl; override;
      procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); override;

      function CtrlValue : string; override;
      procedure setCtrlValue( value : string ); override;
      procedure colorRequired; override;
      procedure setReadOnly( value : boolean ); override;
      function  getReadOnly : boolean; override;

      procedure configControl; override;
    private

    public
      constructor Create(owner : ITaskForm);
      destructor Destroy; override;

      procedure clearContent( recursive : boolean ); override;
  end;

implementation

uses
  Vcl.StdCtrls, Winapi.Windows, System.SysUtils, u_TaskCtrlPropImpl,
  System.UITypes, Vcl.Graphics, u_typeHelper;

{ TaskCtrlEdit }

procedure TaskCtrlEdit.clearContent(recursive: boolean);
begin
  inherited;
  if not Assigned(m_ctrl) then
    exit;

  (m_ctrl as TEdit).Text := '';
end;

procedure TaskCtrlEdit.colorRequired;
var
  ed : TEdit;
begin
  if not Assigned(m_ctrl) then
    exit;

  ed := m_ctrl as TEdit;
  if m_required then
    ed.Color := req
  else
    ed.Color := clWindow;
end;

procedure TaskCtrlEdit.configControl;
var
  ctrl  : TEdit;
begin
  inherited;
  if not Assigned(m_ctrl) then exit;

  ctrl := m_ctrl as TEdit;

  ctrl.Text         := propertyValue('Text');
  ctrl.NumbersOnly  := SameText( propertyValue('NumbersOnly'), 'true');
  ctrl.CharCase     := Text2TEditCharCase( propertyValue('CharCase') );

  if Assigned(m_dataField) then begin
    ctrl.ReadOnly   := SameText(m_dataField.propertyValue('Readonly'), 'true');
    ctrl.MaxLength  := StrToIntDef(m_dataField.propertyValue('Length'), 0 );
    ctrl.CharCase   := Text2TEditCharCase(m_dataField.propertyValue('CharCase'));
  end;
end;

constructor TaskCtrlEdit.Create(owner: ITaskForm);
begin
  inherited;
  m_canContainData  := true;
  m_typ             := ctEdit;
end;

function TaskCtrlEdit.CtrlValue: string;
begin
  Result := '';

  if Assigned( m_ctrl) then
    Result := trim( ( m_ctrl as TEdit).Text)
  else
    Result := self.propertyValue('Text');
end;

destructor TaskCtrlEdit.Destroy;
begin

  inherited;
end;

procedure TaskCtrlEdit.doSetMouse(md: TControlMouseDown; mv: TControlMouseMove;
  mu: TControlMouseUp);
begin
  ( m_ctrl as TEdit).OnMouseDown  := md;
  ( m_ctrl as TEdit).OnMouseUp    := mu;
  ( m_ctrl as TEdit).OnMouseMove  := mv;
end;

function TaskCtrlEdit.getReadOnly: boolean;
begin
  Result := false;
  if Assigned(m_ctrl) then
    Result := ( m_ctrl as TEdit).ReadOnly;
end;

function TaskCtrlEdit.newControl(parent: TWinControl; x, y: Integer): TControl;
var
  ed : TEdit;
begin
  ed := TEdit.Create(parent as TComponent);
  ed.Parent := parent as TWinControl;
  ed.Name := 'Edit'+intToStr(GetTickCount);
  ed.Top  := y;
  ed.Left := X;
  ed.OnKeyPress := Self.KeyPress;

  Result := ed;
  m_ctrl := ed;

  configControl;
end;

procedure TaskCtrlEdit.setControlTypeProps;
begin
  inherited;

  m_props.Add(TaskCtrlPropImpl.create(self, 'Text',       'string'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',  'TaskDataField'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'CharCase',   'TEditCharCase'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'NumbersOnly','boolean'));
end;

procedure TaskCtrlEdit.setCtrlValue(value: string);
begin
  inherited;
  if Assigned( m_ctrl) then
    ( m_ctrl as TEdit).Text := value;
end;

procedure TaskCtrlEdit.setReadOnly(value: boolean);
begin
  if Assigned(m_ctrl) then
    ( m_ctrl as TEdit).ReadOnly := value;
end;

end.
