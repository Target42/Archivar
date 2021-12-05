unit u_taskCtrlRadio;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes, System.SysUtils;

type
  TTaskCtrlRadio = class(TaskCtrlImpl)
    protected
      procedure setControlTypeProps; override;
      function  newControl(parent : TWinControl; x, y : Integer) :  TControl; override;
      procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); override;

      function CtrlValue : string; override;
      procedure setCtrlValue( value : string ); override;
      procedure colorRequired; override;
      procedure setReadOnly( value : boolean ); override;
      function  getReadOnly : boolean; override;
    private
    public
      constructor Create(owner : ITaskForm);
      destructor Destroy; override;

      procedure clearContent( recursive : boolean ); override;

  end;

implementation

uses
  u_TaskCtrlPropImpl, Vcl.StdCtrls, Vcl.Graphics, Winapi.Windows;

{ TTaskCtrlRadio }

procedure TTaskCtrlRadio.clearContent(recursive: boolean);
begin
  inherited;
  if not Assigned(m_ctrl) then
    exit;

  (m_ctrl as TRadioButton).Checked := falsE;

end;

procedure TTaskCtrlRadio.colorRequired;
var
  ed : TRadioButton;
begin
  if not Assigned(m_ctrl) then
    exit;

  ed := m_ctrl as TRadioButton;
  if m_required then
    ed.Color := req
  else
    ed.Color := clWindow;
end;

constructor TTaskCtrlRadio.Create(owner: ITaskForm);
begin
  inherited;
  m_canContainData  := true;
  m_typ             := ctRadio;
end;

function TTaskCtrlRadio.CtrlValue: string;
begin
  Result := '';

  if Assigned( m_ctrl) then begin
    if (m_ctrl as TRadioButton).Checked then
      Result := 'Ja'
    else
      Result := 'Nein';
  end else
    Result := self.propertyValue('Checked');
end;
destructor TTaskCtrlRadio.Destroy;
begin

  inherited;
end;

procedure TTaskCtrlRadio.doSetMouse(md: TControlMouseDown;
  mv: TControlMouseMove; mu: TControlMouseUp);
begin
  inherited;
  ( m_ctrl as TRadioButton).OnMouseDown  := md;
  ( m_ctrl as TRadioButton).OnMouseUp    := mu;
  ( m_ctrl as TRadioButton).OnMouseMove  := mv;

end;

function TTaskCtrlRadio.getReadOnly: boolean;
begin
  Result := false;
  if Assigned(m_ctrl) then
    Result := not ( m_ctrl as TRadioButton).Enabled;
end;

function TTaskCtrlRadio.newControl(parent: TWinControl; x,
  y: Integer): TControl;
var
  ed : TRadioButton;
begin
  ed := TRadioButton.Create(parent as TComponent);
  ed.Parent := parent as TWinControl;
  ed.Name := 'RadioBtn'+intToStr(GetTickCount);
  ed.Top  := y;
  ed.Left := X;
  ed.OnKeyPress := Self.KeyPress;
  ed.OnClick := doClick;

  Result := ed;
  m_ctrl := ed;
end;

procedure TTaskCtrlRadio.setControlTypeProps;
begin
  inherited;
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',  'TaskDataField'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Checked',    'boolean'));
end;

procedure TTaskCtrlRadio.setCtrlValue(value: string);
begin
  inherited;
  if Assigned( m_ctrl) then
    ( m_ctrl as TRadioButton).Checked := SameText( value, 'true') or SameText(value, 'ja');

end;

procedure TTaskCtrlRadio.setReadOnly(value: boolean);
begin
  inherited;
  if Assigned(m_ctrl) then
    ( m_ctrl as TRadioButton).Enabled := not value;
end;

end.
