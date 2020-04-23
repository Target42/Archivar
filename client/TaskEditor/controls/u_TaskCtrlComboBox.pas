unit u_TaskCtrlComboBox;

interface
uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlComboBox = class(TaskCtrlImpl)
    protected
      procedure setControlTypeProps; override;
      function  newControl(parent : TWinControl; x, y : Integer) :  TControl; override;
      procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); override;

      function hasText( name : string; var value : string ) : boolean; override;
    private

    public
      constructor Create(owner : ITaskForm);
      destructor Destroy; override;
  end;

implementation

uses
  u_TaskCtrlPropImpl, Vcl.StdCtrls, System.SysUtils, Winapi.Windows, Vcl.Grids;

{ TaskCtrlComboBox }

constructor TaskCtrlComboBox.Create(owner: ITaskForm);
begin
  inherited;
end;

destructor TaskCtrlComboBox.Destroy;
begin

  inherited;
end;

procedure TaskCtrlComboBox.doSetMouse(md: TControlMouseDown;
  mv: TControlMouseMove; mu: TControlMouseUp);
begin
  inherited;

end;

function TaskCtrlComboBox.hasText(name: string; var value: string): boolean;
begin
  Result := inherited hasText( name, value );
end;

function TaskCtrlComboBox.newControl(parent: TWinControl; x,
  y: Integer): TControl;
var
  cb : TComboBox;
begin
  cb := TComboBox.Create(parent as TComponent);
  cb.Parent := parent as TWinControl;
  cb.Name := 'comboBox'+intToStr(GetTickCount);
  cb.Top  := y;
  cb.Left := X;

  Result := cb;
end;

procedure TaskCtrlComboBox.setControlTypeProps;
var
  s : string;
begin
  inherited;
  hasText('test', s);
  m_props.Add(TaskCtrlPropImpl.create(self, 'Items',    'TStringList'));


end;

end.
