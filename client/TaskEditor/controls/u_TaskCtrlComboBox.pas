unit u_TaskCtrlComboBox;

interface
uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes, i_datafields;

type
  TaskCtrlComboBox = class(TaskCtrlImpl)
    protected
      procedure setControlTypeProps; override;
      function  newControl(parent : TWinControl; x, y : Integer) :  TControl; override;
      procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); override;
      function CtrlValue : string; override;
      procedure setCtrlValue( value : string ); override;

      procedure setDataField( value : IDataField ); override;
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
  m_canContainData  := true;
  m_typ             := ctComboBox;
end;

function TaskCtrlComboBox.CtrlValue: string;
var
  cb : TComboBox;
begin
  Result := '';

  if Assigned(m_ctrl) then
  begin
    cb := m_ctrl as TComboBox;
    if cb.ItemIndex <> -1 then
      Result := cb.Items.Strings[cb.ItemIndex]
    else
      Result := cb.Text;
  end
  else
    Result := propertyValue('Text');
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
begin
  inherited;

  m_props.Add(TaskCtrlPropImpl.create(self, 'Items',      'TStringList'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',  'TaskDataField'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'ItemIndex',  'integer'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Text',       'string'));
end;

procedure TaskCtrlComboBox.setCtrlValue(value: string);
var
  cb : TComboBox;
begin
  if Assigned(m_ctrl) then
  begin
    cb := m_ctrl as TComboBox;
    cb.ItemIndex := cb.Items.IndexOf(value);
  end
end;

procedure TaskCtrlComboBox.setDataField(value: IDataField);
var
  cb    : TComboBox;
  prop  :IProperty;
  tprop :ITaskCtrlProp;
begin
  inherited;

  if not Assigned(value) then
    exit;

  if (value.Typ = 'enum') and  Assigned(m_ctrl) then
  begin
    cb := m_ctrl as TComboBox;

    tprop := self.getPropertyByName('items');
    prop := value.getPropertyByName('Values');

    if Assigned(prop) and Assigned(tProp) then
    begin
      //tprop.ValueList.DelimitedText := prop.Value;
      cb.Items.Delimiter := ';';
      cb.Items.DelimitedText := prop.Value;
    end;
  end;
end;

end.
