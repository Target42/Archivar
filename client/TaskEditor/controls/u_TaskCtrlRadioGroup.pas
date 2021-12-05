unit u_TaskCtrlRadioGroup;

interface
uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlRadioGroup = class(TaskCtrlImpl)
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
  Vcl.ExtCtrls, Vcl.Graphics, System.SysUtils, u_TaskCtrlPropImpl,
  Winapi.Windows;

{ TaskCtrlRadioGroup }

procedure TaskCtrlRadioGroup.clearContent(recursive: boolean);
begin
  inherited;
  if not Assigned(m_ctrl) then
    exit;

  (m_ctrl as TRadioGroup).ItemIndex := -1;

end;

procedure TaskCtrlRadioGroup.colorRequired;
var
  ed : TRadioGroup;
begin
  if not Assigned(m_ctrl) then
    exit;

  ed := m_ctrl as TRadioGroup;
  if m_required then
    ed.Color := req
  else
    ed.Color := clWindow;
end;

constructor TaskCtrlRadioGroup.Create(owner: ITaskForm);
begin
  inherited;
  m_canContainData  := true;
  m_typ             := ctRadioGrp;
end;

function TaskCtrlRadioGroup.CtrlValue: string;
begin
  Result := '';

  if Assigned( m_ctrl) then
    Result := intToStr( ( m_ctrl as TRadioGroup).ItemIndex)
  else
    Result := self.propertyValue('ImageIndex');
end;

destructor TaskCtrlRadioGroup.Destroy;
begin

  inherited;
end;

procedure TaskCtrlRadioGroup.doSetMouse(md: TControlMouseDown; mv: TControlMouseMove;
  mu: TControlMouseUp);
begin
  inherited;
end;

function TaskCtrlRadioGroup.getReadOnly: boolean;
begin
  Result := false;
  if Assigned(m_ctrl) then
    Result := not ( m_ctrl as TRadioGroup).Enabled;
end;

function TaskCtrlRadioGroup.newControl(parent: TWinControl; x, y: Integer): TControl;
var
  ed : TRadioGroup;
begin
  ed := TRadioGroup.Create(parent as TComponent);
  ed.Parent := parent as TWinControl;
  ed.Name := 'RadioGroup'+intToStr(GetTickCount);
  ed.Top  := y;
  ed.Left := X;
  ed.OnClick := doClick;

  Result := ed;
  m_ctrl := ed;
end;

procedure TaskCtrlRadioGroup.setControlTypeProps;
begin
  inherited;
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',  'TaskDataField'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'ImageIndex', 'integer'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Items',      'TStringList'));
end;

procedure TaskCtrlRadioGroup.setCtrlValue(value: string);
begin
  inherited;
  if Assigned( m_ctrl) then
    ( m_ctrl as TRadioGroup).ItemIndex := StrToIntDef(value, -1);
end;

procedure TaskCtrlRadioGroup.setReadOnly(value: boolean);
begin
  if Assigned(m_ctrl) then
    ( m_ctrl as TRadioGroup).Enabled := not value;
end;

end.
