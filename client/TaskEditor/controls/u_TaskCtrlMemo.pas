unit u_TaskCtrlMemo;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlMemo= class(TaskCtrlImpl)
    protected
      procedure setControlTypeProps; override;
      function  newControl(parent : TWinControl; x, y : Integer) :  TControl; override;
      procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); override;

      function CtrlValue : string; override;
    private

    public
      constructor Create(owner : ITaskForm);
      destructor Destroy; override;
  end;

implementation

uses
  Vcl.StdCtrls, Winapi.Windows, System.SysUtils, u_TaskCtrlPropImpl;

{ TaskCtrlMemo }

constructor TaskCtrlMemo.Create(owner: ITaskForm);
begin
  inherited;
  m_canContainData := true;
end;

function TaskCtrlMemo.CtrlValue: string;
begin
  Result := '';

  if Assigned( m_ctrl) then
    Result := trim( ( m_ctrl as TMemo).Text)
  else
    Result := self.propertyValue('Text');
end;

destructor TaskCtrlMemo.Destroy;
begin

  inherited;
end;

procedure TaskCtrlMemo.doSetMouse(md: TControlMouseDown; mv: TControlMouseMove;
  mu: TControlMouseUp);
begin
  inherited;
  ( m_ctrl as TMemo).OnMouseDown  := md;
  ( m_ctrl as TMemo).OnMouseUp    := mu;
  ( m_ctrl as TMemo).OnMouseMove  := mv;
end;

function TaskCtrlMemo.newControl(parent: TWinControl; x, y: Integer): TControl;
var
  ed : TMemo;
begin
  ed := TMemo.Create(Parent as TComponent);
  ed.Parent := Parent as TWinControl;
  ed.Name := 'Memo'+intToStr(GetTickCount);
  ed.Top  := y;
  ed.Left := X;
  ed.WordWrap := true;
  ed.ScrollBars := ssVertical;
  ed.Lines.Text := '';

  Result := ed;
end;

procedure TaskCtrlMemo.setControlTypeProps;
begin
  inherited;
  m_props.Add(TaskCtrlPropImpl.create(self, 'Text',       'string'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',  'TaskDataField'));
end;

end.