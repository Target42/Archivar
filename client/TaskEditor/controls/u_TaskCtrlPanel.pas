unit u_TaskCtrlPanel;

interface
uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlPanel = class(TaskCtrlImpl)
    protected
      procedure setControlTypeProps; override;
      function  newControl(parent : TWinControl; x, y : Integer) :  TControl; override;
      procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); override;
    private

    public
      constructor Create(owner : ITaskForm);
      destructor Destroy; override;
  end;

implementation

uses
  Vcl.StdCtrls, Winapi.Windows, System.SysUtils, u_TaskCtrlPropImpl,
  Vcl.ExtCtrls, Vcl.Graphics;
{ TaskCtrlPanel }

constructor TaskCtrlPanel.Create(owner: ITaskForm);
begin
  inherited;
  m_isContainer := true;
  m_typ         := ctPanel;
end;

destructor TaskCtrlPanel.Destroy;
begin

  inherited;
end;

procedure TaskCtrlPanel.doSetMouse(md: TControlMouseDown; mv: TControlMouseMove;
  mu: TControlMouseUp);
begin
  inherited;
  inherited;
  ( m_ctrl as TPanel).OnMouseDown  := md;
  ( m_ctrl as TPanel).OnMouseUp    := mu;
  ( m_ctrl as TPanel).OnMouseMove  := mv;


end;

function TaskCtrlPanel.newControl(parent: TWinControl; x, y: Integer): TControl;
var
  pan : TPanel;
begin
  pan := TPanel.Create(Parent as TComponent);
  pan.Parent := Parent as TWinControl;
  pan.Name := 'Panel'+intToStr(GetTickCount);
  pan.Top  := y;
  pan.Left := X;
  pan.Caption := '';
  pan.ShowCaption := false;
  pan.BevelOuter := bvNone;
  pan.Color := clWindow;


  Result := pan;
end;

procedure TaskCtrlPanel.setControlTypeProps;
begin
  inherited;

end;

end.
