unit u_TaskCtrlLabeledEdit;

interface
uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlLabeledEdit = class(TaskCtrlImpl)
    protected
      procedure setControlTypeProps; override;
      function  newControl(parent : TWinControl; x, y : Integer) :  TControl; override;
      procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); override;

      function CtrlValue : string; override;
      procedure setCtrlValue( value : string ); override;
      procedure colorRequired; override;
    private

    public
      constructor Create(owner : ITaskForm);
      destructor Destroy; override;
  end;

implementation

uses
  u_TaskCtrlPropImpl, Vcl.StdCtrls, System.SysUtils, Winapi.Windows,
  Vcl.ExtCtrls, Vcl.Graphics;

{ TaskCtrlLabeledEdit }

procedure TaskCtrlLabeledEdit.colorRequired;
var
  ed : TLabeledEdit;
begin
  if not Assigned(m_ctrl) then
    exit;

  ed := m_ctrl as TLabeledEdit;
  if m_required then
    ed.Color := TColor( RGB(255, 200, 200))
  else
    ed.Color := clWindow;
end;

constructor TaskCtrlLabeledEdit.Create(owner: ITaskForm);
begin
  inherited;
  m_canContainData := true;
end;

function TaskCtrlLabeledEdit.CtrlValue: string;
begin
  if Assigned(m_ctrl) then
    Result := trim((m_ctrl as TLabeledEdit).Text)
  else
    Result := self.propertyValue('Text');
end;

destructor TaskCtrlLabeledEdit.Destroy;
begin

  inherited;
end;

procedure TaskCtrlLabeledEdit.doSetMouse(md: TControlMouseDown;
  mv: TControlMouseMove; mu: TControlMouseUp);
begin
  inherited;

  ( m_ctrl as TLabeledEdit).OnMouseDown  := md;
  ( m_ctrl as TLabeledEdit).OnMouseUp    := mu;
  ( m_ctrl as TLabeledEdit).OnMouseMove  := mv;

end;

function TaskCtrlLabeledEdit.newControl(parent: TWinControl; x,
  y: Integer): TControl;
var
  ed : TLabeledEdit;
begin
  ed := TLabeledEdit.Create(parent as TComponent);
  ed.Parent := parent as TWinControl;
  ed.Name := 'LabeledEdit'+intToStr(GetTickCount);
  ed.EditLabel.Caption := ed.Name;
  ed.Top  := y;
  ed.Left := X;
  Result := ed;
end;

procedure TaskCtrlLabeledEdit.setControlTypeProps;
begin
  inherited;
  m_props.Add(TaskCtrlPropImpl.create(self, 'Caption',    'string'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',  'TaskDataField'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'CharCase',   'TEditCharCase'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'NumbersOnly','boolean'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Text',       'string'));
end;

procedure TaskCtrlLabeledEdit.setCtrlValue(value: string);
begin
  if Assigned(m_ctrl) then
    (m_ctrl as TLabeledEdit).Text := value;

end;

end.
