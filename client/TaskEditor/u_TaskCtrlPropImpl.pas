unit u_TaskCtrlPropImpl;

interface

uses
  i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlPropImpl = class(TInterfacedObject, ITaskCtrlProp )
  private
    m_owner : ITaskCtrl;
    m_ctrl  : TControl;
    m_name  : string;
    m_typ   : string;
    m_value : string;
    m_list  : TStringList;

    procedure setName( value : string );
    function  getName : string;
    procedure setValue( value : string );
    function  getValue : string;
    procedure setTyp( value : string );
    function  getTyp : string;
    procedure setControl( value : TControl );
    function  getControl : TControl;

    function  getLabelProps : string;
    procedure setLabelProps( value : string );

    function  getGroupboxProps : string;
    procedure setGroupboxProps( value : string );

    function  getCustomEditProps : string;
    procedure setCustomEditProps( value : string );

    function  getEditProps : string;
    procedure setdEditProps( value : string );

    function  getLabeledEditProps : string;
    procedure setLabeledEditProps( value : string );
  public

    constructor create( owner : ITaskCtrl; name, typ : string; ctrl : Tcontrol ); overload;
    constructor create( owner : ITaskCtrl; name, typ : string ); overload;

    Destructor Destroy; override;

    procedure release;

    function  isList : boolean;
    function  hasEditor : boolean;
    procedure fillPickList( list : TStrings );

    procedure config;
  end;

implementation

uses
  System.SysUtils, Vcl.StdCtrls, Vcl.ExtCtrls, u_typeHelper;


{ TaskCtrlPropImpl }

constructor TaskCtrlPropImpl.create(owner : ITaskCtrl; name, typ: string; ctrl: Tcontrol);
begin
  m_owner := owner;
  m_list  := TStringList.Create;
  m_list.StrictDelimiter := true;
  m_list.Delimiter := ';';
  m_name    := name;
  m_ctrl    := ctrl;
  setTyp(typ);
  m_value   := 'Undefined!';
end;

procedure TaskCtrlPropImpl.config;
begin
  if not Assigned(m_ctrl) then
    exit;

  setValue(m_value);

end;

constructor TaskCtrlPropImpl.create(owner : ITaskCtrl; name, typ: string);
begin
  m_owner := owner;
  m_list  := TStringList.Create;
  m_list.StrictDelimiter := true;
  m_list.Delimiter := ';';

  m_name    := name;
  m_ctrl    := NIL;
  setTyp(typ);
  m_value   := 'Undefined!';
end;

destructor TaskCtrlPropImpl.Destroy;
begin
  m_list.Free;
  inherited;
end;

procedure TaskCtrlPropImpl.fillPickList(list: TStrings);
var
  i : integer;
begin
  if SameText(m_typ, 'TaskDataField') then
  begin
    m_list.Clear;
    m_list.Add('');
    for i := 0 to pred(m_owner.Owner.Owner.Fields.Count) do
    begin
      m_list.Add(m_owner.Owner.Owner.Fields.Items[i].Name);
    end;
  end
  else if SameText(m_typ, 'TAlign') then         fillAlignList(list)
  else if SameText(m_typ, 'TEditCharCase') then  fillTEditcharList(list);

  list.Assign(m_list);
end;

function TaskCtrlPropImpl.getControl: TControl;
begin
  Result := m_ctrl;
end;

function TaskCtrlPropImpl.getCustomEditProps: string;
begin
  if SameText(m_name, 'Text') then          Result := (m_ctrl as TCustomEdit).Text;
end;

function TaskCtrlPropImpl.getEditProps: string;
begin
  if      SameText(m_name, 'CharCase') then   Result := TEditCharCase2Text((m_ctrl as TEdit).CharCase)
  else if SameText(m_name, 'Align') then      Result := TAlign2Text((m_ctrl as TEdit).Align);
end;

function TaskCtrlPropImpl.getGroupboxProps: string;
begin
  if SameText(m_name, 'Caption') then       Result := (m_ctrl as TGroupbox).Caption;
end;

function TaskCtrlPropImpl.getLabeledEditProps: string;
begin
  if      SameText(m_name, 'Caption') then    Result := (m_ctrl as TLabeledEdit).EditLabel.Caption
  else if SameText(m_name, 'CharCase') then   Result := TEditCharCase2Text((m_ctrl as TLabeledEdit).CharCase)
  else if SameText(m_name, 'Align') then      Result := TAlign2Text((m_ctrl as TLabeledEdit).Align);
end;

function TaskCtrlPropImpl.getLabelProps: string;
begin
  if SameText(m_name, 'Caption') then  Result := (m_ctrl as TLabel).Caption;
end;

function TaskCtrlPropImpl.getName: string;
begin
  Result := m_name;
end;

function TaskCtrlPropImpl.getTyp: string;
begin
  Result := m_typ;
end;

function TaskCtrlPropImpl.getValue: string;
begin
  Result := m_value;

  if not Assigned(m_ctrl) then
    exit;

  if SameText( m_name, 'Datafield') then
  begin
    Result := '';
    if Assigned(m_owner.DataField) then
      Result := m_owner.DataField.Name;
    exit;
  end;

  if      SameText(m_name, 'name') then     Result := m_ctrl.Name
  else if SameText(m_name, 'Top') then      Result := IntToStr(m_ctrl.top)
  else if SameText(m_name, 'Left') then     Result := IntToStr(m_ctrl.left)
  else if SameText(m_name, 'Width') then    Result := IntToStr(m_ctrl.Width)
  else if SameText(m_name, 'height') then   Result := IntToStr(m_ctrl.Height)
  else if SameText(m_name, 'Enabled') then  Result := BoolToStr(m_ctrl.Enabled, true)
  else if SameText(m_name, 'Visible') then  Result := BoolToStr(m_ctrl.visible, true);


  if m_ctrl is TLabel then        Result := getLabelProps;
  if m_ctrl is TGroupbox then     Result := getGroupboxProps;
  if m_ctrl is TCustomEdit then   Result := getCustomEditProps;
  if m_ctrl is TEdit then         Result := getEditProps;
  if m_ctrl is TLabeledEdit then  Result :=  getLabeledEditProps;

  m_value := Result;
end;

function TaskCtrlPropImpl.hasEditor: boolean;
begin
  Result := false;
end;

function TaskCtrlPropImpl.isList: boolean;
begin
  Result := (m_list.count > 0 ) or  SameText( m_typ, 'TaskDataField');
end;

procedure TaskCtrlPropImpl.release;
begin
  m_owner := NIL;
end;

procedure TaskCtrlPropImpl.setControl(value: TControl);
begin
  if Assigned(m_ctrl) then
    getValue;
  m_ctrl := value;
end;

procedure TaskCtrlPropImpl.setCustomEditProps(value: string);
begin
  if      SameText(m_name, 'Text') then          (m_ctrl as TCustomEdit).Text := value;
end;

procedure TaskCtrlPropImpl.setdEditProps(value: string);
begin
  if      SameText(m_name, 'CharCase') then  (m_ctrl as TEdit).CharCase := Text2TEditCharCase(value)
  else if SameText(m_name, 'Align') then     (m_ctrl as TEdit).Align := Text2TAlign(value);
end;

procedure TaskCtrlPropImpl.setGroupboxProps(value: string);
begin
  if SameText(m_name, 'Caption') then       (m_ctrl as TGroupbox).Caption := value;
end;

procedure TaskCtrlPropImpl.setLabeledEditProps(value: string);
begin
  if      SameText(m_name, 'Caption') then   (m_ctrl as TLabeledEdit).EditLabel.Caption := value
  else if SameText(m_name, 'CharCase') then  (m_ctrl as TLabeledEdit).CharCase := Text2TEditCharCase(value)
  else if SameText(m_name, 'Align') then     (m_ctrl as TLabeledEdit).Align := Text2TAlign(value);

end;

procedure TaskCtrlPropImpl.setLabelProps(value: string);
begin
  if SameText(m_name, 'Caption') then       (m_ctrl as TLabel).Caption := value;
end;

procedure TaskCtrlPropImpl.setName(value: string);
begin
  m_name := value;
end;

procedure TaskCtrlPropImpl.setTyp(value: string);
begin
  m_typ := value;
  if SameText( m_typ, 'boolean') then
    m_list.DelimitedText := 'true;false';
end;

procedure TaskCtrlPropImpl.setValue(value: string);
begin
  m_value := value;

  if not Assigned(m_ctrl) then
    exit;
  if SameText( m_name, 'Datafield') then
  begin
    m_owner.DataField := m_owner.Owner.Owner.Fields.getByName(m_value);
    exit;
  end;
  if SameText(m_name, 'name') then
  begin
    m_value := m_ctrl .Name;
    try
      m_ctrl.Name := value;
    except

    end;
    m_value := m_ctrl.Name;
  end;
  if      SameText(m_name, 'Top') then      m_ctrl.top := StrToInt( value )
  else if SameText(m_name, 'Left') then     m_ctrl.left := StrToint( value )
  else if SameText(m_name, 'Width') then    m_ctrl.Width := StrToInt( value )
  else if SameText(m_name, 'height') then   m_ctrl.Height  := StrToInt( value )
  else if SameText(m_name, 'Enabled') then  m_ctrl.Enabled := StrToBool(value)
  else if SameText(m_name, 'Visible') then  m_ctrl.visible := StrToBool(value);

  if m_ctrl is TLabel then      setLabelProps(value);
  if m_ctrl is TGroupbox then   setGroupboxProps(value);
  if m_ctrl is TCustomEdit then setCustomEditProps(value);
  if m_ctrl is TEdit then       setdEditProps( value );
  if m_ctrl is TLabeledEdit then setLabeledEditProps(value);
end;

end.
