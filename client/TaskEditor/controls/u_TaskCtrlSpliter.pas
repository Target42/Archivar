unit u_TaskCtrlSpliter;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlSplitter = class(TaskCtrlImpl)
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
  System.UITypes, Vcl.Graphics, Vcl.ExtCtrls;


{ TaskCtrlSplitter }


constructor TaskCtrlSplitter.Create(owner: ITaskForm);
begin
  inherited
end;

destructor TaskCtrlSplitter.Destroy;
begin

  inherited;
end;

procedure TaskCtrlSplitter.doSetMouse(md: TControlMouseDown; mv: TControlMouseMove;
  mu: TControlMouseUp);
begin
  inherited;
end;

function TaskCtrlSplitter.newControl(parent: TWinControl; x, y: Integer): TControl;
var
  ed : TSplitter;
begin
  ed        := TSplitter.Create(Parent as TComponent);
  ed.Parent := Parent as TWinControl;
  ed.Name   := 'Splitter'+intToStr(GetTickCount);
  ed.Align  := alBottom;
  ed.Top    := y;
  ed.Left   := X;


  Result := ed;
end;


procedure TaskCtrlSplitter.setControlTypeProps;
begin
  inherited;

end;

end.
