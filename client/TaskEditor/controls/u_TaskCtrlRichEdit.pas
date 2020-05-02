unit u_TaskCtrlRichEdit;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlRichEdit = class(TaskCtrlImpl)
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
  Vcl.ComCtrls;


{ TaskCtrlRichEdit }

constructor TaskCtrlRichEdit.Create(owner: ITaskForm);
begin
  inherited;
end;

destructor TaskCtrlRichEdit.Destroy;
begin

  inherited;
end;

procedure TaskCtrlRichEdit.doSetMouse(md: TControlMouseDown;
  mv: TControlMouseMove; mu: TControlMouseUp);
begin
  inherited;
  ( m_ctrl as TRichEdit).OnMouseDown  := md;
  ( m_ctrl as TRichEdit).OnMouseUp    := mu;
  ( m_ctrl as TRichEdit).OnMouseMove  := mv;
end;

function TaskCtrlRichEdit.newControl(parent: TWinControl; x,
  y: Integer): TControl;
var
  ed : TRichEdit;
begin
  ed := TRichEdit.Create(Parent as TComponent);
  ed.Parent := Parent as TWinControl;
  ed.Name := 'RichEdit'+intToStr(GetTickCount);
  ed.Top  := y;
  ed.Left := X;
  ed.WordWrap := true;
  ed.ScrollBars := ssVertical;

  Result := ed;
end;

procedure TaskCtrlRichEdit.setControlTypeProps;
begin
  inherited;
  m_props.Add(TaskCtrlPropImpl.create(self, 'Text',       'TStrings'));
end;

end.
