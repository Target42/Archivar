unit u_TaskCtrlLabeledEdit;

interface
uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes, u_typeHelper;

type
  TaskCtrlLabeledEdit = class(TaskCtrlImpl)
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
  u_TaskCtrlPropImpl, Vcl.StdCtrls, System.SysUtils, Winapi.Windows,
  Vcl.ExtCtrls, Vcl.Graphics;

{ TaskCtrlLabeledEdit }

procedure TaskCtrlLabeledEdit.clearContent(recursive: boolean);
begin
  inherited;
  if not Assigned(m_ctrl) then
    exit;

    (m_ctrl as TLabeledEdit).Text := '';
end;

procedure TaskCtrlLabeledEdit.colorRequired;
var
  ed : TLabeledEdit;
begin
  if not Assigned(m_ctrl) then
    exit;

  ed := m_ctrl as TLabeledEdit;
  if m_required then
    ed.Color := RequiredColor
  else
    ed.Color := clWindow;
end;

procedure TaskCtrlLabeledEdit.configControl;
var
  ctrl  : TEdit;
begin
  inherited;
  if not Assigned(m_ctrl) then exit;

  ctrl := m_ctrl as TEdit;

  ctrl.Text         := propertyValue('Text');
  ctrl.NumbersOnly  := SameText( propertyValue('NumbersOnly'), 'true') or SameText( propertyValue('NumbersOnly'), 'ja');
  ctrl.CharCase     := Text2TEditCharCase( propertyValue('CharCase') );

  if Assigned(m_dataField) then begin
    ctrl.ReadOnly   := SameText(m_dataField.propertyValue('Readonly'), 'true') or SameText(m_dataField.propertyValue('Readonly'), 'ja');
    ctrl.MaxLength  := StrToIntDef(m_dataField.propertyValue('Length'), 0 );
    ctrl.CharCase   := Text2TEditCharCase(m_dataField.propertyValue('CharCase'));
  end;
end;

constructor TaskCtrlLabeledEdit.Create(owner: ITaskForm);
begin
  inherited;
  m_canContainData  := true;
  m_typ             := ctLabeledEdit;
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

function TaskCtrlLabeledEdit.getReadOnly: boolean;
begin
  Result := false;
  if Assigned(m_ctrl) then
    Result := (m_ctrl as TLabeledEdit).ReadOnly;

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
  ed.OnKeyPress := KeyPress;
  Result := ed;

  configControl;
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

procedure TaskCtrlLabeledEdit.setReadOnly(value: boolean);
begin
  if Assigned(m_ctrl) then
    (m_ctrl as TLabeledEdit).ReadOnly := value;
end;

end.
