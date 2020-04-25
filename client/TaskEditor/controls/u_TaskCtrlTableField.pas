unit u_TaskCtrlTableField;

interface


uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlTableField = class(TaskCtrlImpl)
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
  u_TaskCtrlPropImpl, Vcl.StdCtrls, System.SysUtils, Winapi.Windows;


{ TaskCtrlTableField }

constructor TaskCtrlTableField.Create(owner: ITaskForm);
begin
  inherited;

  setControlClass( 'TTableField' );
end;

destructor TaskCtrlTableField.Destroy;
begin

  inherited;
end;

procedure TaskCtrlTableField.doSetMouse(md: TControlMouseDown;
  mv: TControlMouseMove; mu: TControlMouseUp);
begin

end;

function TaskCtrlTableField.newControl(parent: TWinControl; x,
  y: Integer): TControl;
begin
  Result := NIL;
end;

procedure TaskCtrlTableField.setControlTypeProps;
begin
//  inherited;
  m_props.Add(TaskCtrlPropImpl.create(self, 'Header',       'string'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Width',        'integer'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',    'TaskDataField'));

end;

end.
