unit u_taskCtrlDateTimePicker;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes,
  System.SysUtils;

type
  TaskCtrlDateTimePicker = class(TaskCtrlImpl)
    protected
      procedure setControlTypeProps; override;
      function  newControl(parent : TWinControl; x, y : Integer) :  TControl; override;
      function CtrlValue : string; override;
      procedure setCtrlValue( value : string ); override;

      procedure change( sender : TObject );
      procedure setReadOnly( value : boolean ); override;
      function  getReadOnly : boolean; override;
    private

    public
      constructor Create(owner : ITaskForm);
      destructor Destroy; override;
  end;

implementation

uses
  Vcl.ComCtrls, Winapi.Windows, u_TaskCtrlPropImpl;

{ TaskCtrlDateTimePicker }

procedure TaskCtrlDateTimePicker.change(sender: TObject);
begin
  m_changed := true;
end;

constructor TaskCtrlDateTimePicker.Create(owner: ITaskForm);
begin
  inherited;
  m_canContainData  := true;
  m_typ             := ctDateTimePicker;
end;

function TaskCtrlDateTimePicker.CtrlValue: string;
var
  cb : TDateTimepicker;
begin
  Result := '';

  if Assigned(m_ctrl) then
  begin
    cb := m_ctrl as TDateTimepicker;
    if cb.Kind = dtkDate  then
      Result := DateToStr( cb.Date )
    else
      Result := TimeToStr( cb.Time );
  end
  else begin
    Result := propertyValue('Default');
    if SameText(Result, '$date') then
      Result := DateToStr(date)
     else if SameText(Result, '$time') then
       Result := TimeToStr(time)
     else if  SameText(Result, '$now') then
       Result := DateTimeToStr(now);
  end;

end;

destructor TaskCtrlDateTimePicker.Destroy;
begin

  inherited;
end;

function TaskCtrlDateTimePicker.getReadOnly: boolean;
begin
  Result := false;
  if Assigned(m_ctrl) then
    Result := not (m_ctrl as TDateTimepicker).Enabled;
end;

function TaskCtrlDateTimePicker.newControl(parent: TWinControl; x,
  y: Integer): TControl;
var
  ed : TDateTimePicker;
begin
  ed := TDateTimePicker.Create(parent as TComponent);
  ed.Parent := parent as TWinControl;
  ed.Name := 'DateTimePicker'+intToStr(GetTickCount);
  ed.Top  := y;
  ed.Left := X;
  ed.OnKeyPress := Self.KeyPress;

  Result := ed;
  m_ctrl := ed;

end;

procedure TaskCtrlDateTimePicker.setControlTypeProps;
begin
  inherited;

  m_props.Add(TaskCtrlPropImpl.create(self, 'Kind',       'TDateTimeKind'));
end;

procedure TaskCtrlDateTimePicker.setCtrlValue(value: string);
begin
  inherited;
  if Assigned( m_ctrl) then
    ( m_ctrl as TDateTimePicker).DateTime := StrToDateTimeDef( value, now);
end;


procedure TaskCtrlDateTimePicker.setReadOnly(value: boolean);
begin
  inherited;

  if Assigned(m_ctrl) then
    (m_ctrl as TDateTimePicker).Enabled := not value;
end;

end.
