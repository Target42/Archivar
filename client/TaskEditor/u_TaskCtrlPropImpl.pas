unit u_TaskCtrlPropImpl;

interface

uses
  i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlPropImpl = class(TInterfacedObject, ITaskCtrlProp )
  private
    m_ctrl  : TControl;
    m_name  : string;
    m_typ   : string;
    m_list  : TStringList;

    procedure setName( value : string );
    function  getName : string;
    procedure setValue( value : string );
    function  getValue : string;
    procedure setTyp( value : string );
    function  getTyp : string;
  public

    constructor create( name, typ : string; ctrl : Tcontrol );

    Destructor Destroy; override;

    property Name  : string read getName write setName;
    property Value : string read getValue write setValue;
    property Typ   : string read getTyp write setTyp;

    procedure release;

    function  isList : boolean;
    function  hasEditor : boolean;
    procedure fillPickList( list : TStrings );

  end;

implementation

uses
  System.SysUtils, Vcl.StdCtrls, Vcl.ExtCtrls;

{ TaskCtrlPropImpl }


constructor TaskCtrlPropImpl.create(name, typ: string; ctrl: Tcontrol);
begin
  m_name := name;
  m_ctrl := ctrl;
  m_list := TStringList.Create;
  m_list.StrictDelimiter := true;
  m_list.Delimiter := ';';
end;

destructor TaskCtrlPropImpl.Destroy;
begin
  m_list.Free;
  inherited;
end;

procedure TaskCtrlPropImpl.fillPickList(list: TStrings);
begin
  list.Assign(m_list);
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
  Result := 'Undefined!';
  if not Assigned(m_ctrl) then
    exit;

  if m_ctrl is TWinControl then
  begin
    if SameText(m_name, 'name') then
      Result := (m_ctrl as TWinControl).Name
    else if SameText(m_name, 'Top') then
      Result := IntToStr((m_ctrl as TWinControl).top)
    else if SameText(m_name, 'Left') then
      Result := IntToStr((m_ctrl as TWinControl).left)
    else if SameText(m_name, 'Width') then
      Result := IntToStr((m_ctrl as TWinControl).Width)
    else if SameText(m_name, 'height') then
      Result := IntToStr((m_ctrl as TWinControl).Height)
    else if SameText(m_name, 'Enabled') then
      Result := BoolToStr((m_ctrl as TWinControl).Enabled, true)
    else if SameText(m_name, 'Visible') then
      Result := BoolToStr((m_ctrl as TWinControl).visible, true)
  end;

  if m_ctrl is TLabel then
  begin
    if SameText(m_name, 'Caption') then
      Result := (m_ctrl as TLabel).Caption
  end;

  if m_ctrl is TGroupbox then
  begin
    if SameText(m_name, 'Caption') then
      Result := (m_ctrl as TGroupbox).Caption
  end;

  if m_ctrl is TCustomEdit then
  begin
    if SameText(m_name, 'Text') then
      Result := (m_ctrl as TCustomEdit).Text;
  end;

  if m_ctrl is TLabeledEdit then
  begin
    if SameText(m_name, 'Caption') then
      Result := (m_ctrl as TLabeledEdit).EditLabel.Caption;
  end;
end;

function TaskCtrlPropImpl.hasEditor: boolean;
begin

end;

function TaskCtrlPropImpl.isList: boolean;
begin
  Result := m_list.count > 0;
end;

procedure TaskCtrlPropImpl.release;
begin

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
  if not Assigned(m_ctrl) then
    exit;
  if m_ctrl is TWinControl then
  begin
    if SameText(m_name, 'name') then
      (m_ctrl as TWinControl).Name := value
    else if SameText(m_name, 'Top') then
      (m_ctrl as TWinControl).top := StrToInt( value )
    else if SameText(m_name, 'Left') then
      (m_ctrl as TWinControl).left := StrToint( value )
    else if SameText(m_name, 'Width') then
      (m_ctrl as TWinControl).Width := StrToInt( value )
    else if SameText(m_name, 'height') then
      (m_ctrl as TWinControl).Height  := StrToInt( value )
    else if SameText(m_name, 'Enabled') then
      (m_ctrl as TWinControl).Enabled := StrToBool(value)
    else if SameText(m_name, 'Visible') then
      (m_ctrl as TWinControl).visible := StrToBool(value);
  end;

  if m_ctrl is TLabel then
  begin
    if SameText(m_name, 'Caption') then
      (m_ctrl as TLabel).Caption := value;
  end;

  if m_ctrl is TGroupbox then
  begin
    if SameText(m_name, 'Caption') then
      (m_ctrl as TGroupbox).Caption := value;
  end;

  if m_ctrl is TCustomEdit then
  begin
    if SameText(m_name, 'Text') then
      (m_ctrl as TCustomEdit).Text := value;
  end;

  if m_ctrl is TLabeledEdit then
  begin
    if SameText(m_name, 'Caption') then
      (m_ctrl as TLabeledEdit).EditLabel.Caption := value;
  end;

end;

end.
