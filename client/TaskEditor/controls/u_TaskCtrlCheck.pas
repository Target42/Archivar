unit u_TaskCtrlCheck;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes, System.SysUtils,
  Vcl.StdCtrls;

type
  TTaskCtrlCheck = class(TaskCtrlImpl)
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
  Vcl.Graphics, Winapi.Windows, u_TaskCtrlPropImpl;

{ TTaskCtrlCheck }

procedure TTaskCtrlCheck.clearContent(recursive: boolean);
begin
  inherited;

  if Assigned(m_ctrl) then
    (m_ctrl as TCheckBox).Checked := false;
end;

procedure TTaskCtrlCheck.colorRequired;
var
  ed : TCheckBox;
begin
  if not Assigned(m_ctrl) then
    exit;

  ed := m_ctrl as TCheckBox;
  if m_required then
    ed.Color := req
  else
    ed.Color := clWindow;
end;

procedure TTaskCtrlCheck.configControl;
var
  ctrl : TCheckBox;
begin
  inherited;
  if not Assigned(m_ctrl) then exit;

  ctrl := m_ctrl as TCheckBox;

  ctrl.Checked := SameText(propertyValue('checked'), 'true') or SameText(propertyValue('checked'), 'ja');

  if Assigned(m_dataField) then begin
    ctrl.Checked := SameText(m_dataField.propertyValue('checked'), 'true') or SameText(m_dataField.propertyValue('checked'), 'ja');
  end;
end;

constructor TTaskCtrlCheck.Create(owner: ITaskForm);
begin
  inherited;
  m_canContainData  := true;
  m_typ             := ctCheckBox;
end;

function TTaskCtrlCheck.CtrlValue: string;
begin
  Result := '';

  if Assigned( m_ctrl) then begin
    if ( m_ctrl as TCheckBox).Checked then
      Result := 'Ja'
    else
      Result := 'Nein';
  end else
    Result := self.propertyValue('Checked');
end;

destructor TTaskCtrlCheck.Destroy;
begin

  inherited;
end;

procedure TTaskCtrlCheck.doSetMouse(md: TControlMouseDown;
  mv: TControlMouseMove; mu: TControlMouseUp);
begin
  inherited;
  ( m_ctrl as TCheckBox).OnMouseDown  := md;
  ( m_ctrl as TCheckBox).OnMouseUp    := mu;
  ( m_ctrl as TCheckBox).OnMouseMove  := mv;

end;

function TTaskCtrlCheck.getReadOnly: boolean;
begin
  Result := false;
  if Assigned(m_ctrl) then
    Result := not ( m_ctrl as TCheckBox).Enabled;
end;

function TTaskCtrlCheck.newControl(parent: TWinControl; x,
  y: Integer): TControl;
var
  ed : TCheckBox;
begin
  ed := TCheckBox.Create(parent as TComponent);
  ed.Parent := parent as TWinControl;
  ed.Name := 'CheckBox'+intToStr(GetTickCount);
  ed.Top  := y;
  ed.Left := X;
  ed.OnKeyPress := Self.KeyPress;
  ed.OnClick    := doClick;

  Result := ed;
  m_ctrl := ed;

  configControl;
end;

procedure TTaskCtrlCheck.setControlTypeProps;
begin
  inherited;
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',  'TaskDataField'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Checked',    'boolean'));
end;

procedure TTaskCtrlCheck.setCtrlValue(value: string);
begin
  inherited;
  if Assigned( m_ctrl) then
    ( m_ctrl as TcheckBox).Checked := SameText(value, 'ja') or SameText( value, 'true');
end;

procedure TTaskCtrlCheck.setReadOnly(value: boolean);
begin
  inherited;

  if Assigned(m_ctrl) then
    ( m_ctrl as TCheckBox).Enabled := not value;
end;

end.
