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

    function  getLabelProps( var value : string ) : boolean;
    procedure setLabelProps( value : string );

    function  getGroupboxProps( var value : string ) : boolean;
    procedure setGroupboxProps( value : string );

    function  getCustomEditProps( var value : string ) : boolean;
    procedure setCustomEditProps( value : string );

    function  getEditProps( var value : string ) : boolean;
    procedure setdEditProps( value : string );

    function  getLabeledEditProps( var value : string ) : boolean;
    procedure setLabeledEditProps( value : string );

    function  getComboBoxProps( var value : string ) : boolean;
    procedure setComboBoxProps( value : string );

    function  getMemoProps( var value : string ) : boolean;
    procedure setMemoProps( value : string );

    function  getRichEditProps( var value : string ) : boolean;
    procedure setRichEditProps( value : string );

    function  getRadioBtnProps( var value : string ) : boolean;
    procedure setRadioBtnProps( value : string );

    function  getCheckBoxProps( var value : string ) : boolean;
    procedure setCheckBoxProps( value : string );

    function  getRadioGroupProps( var value : string ) : boolean;
    procedure setRadioGroupProps( value : string );

    function  getDateTimePickerProps( var value : string ) : boolean;
    procedure setDateTimePickerProps( value : string );


    function  getValueList : TStringList;

    procedure setAlign( value : string );
  public

    constructor create( owner : ITaskCtrl; name, typ : string; ctrl : Tcontrol ); overload;
    constructor create( owner : ITaskCtrl; name, typ : string ); overload;

    Destructor Destroy; override;

    procedure release;

    function  isList : boolean;
    function  hasEditor : boolean;
    procedure fillPickList( list : TStrings );
    function  ShowEditor : boolean;

    procedure config;
  end;

implementation

uses
  System.SysUtils, Vcl.StdCtrls, Vcl.ExtCtrls, u_typeHelper, Vcl.Dialogs,
  f_itemsEditor, Vcl.Forms, Vcl.Grids, f_tableColumns, u_helper, Vcl.ComCtrls,
  f_itemsTStringsEditor;


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
  task : ITask;
begin
  if SameText(m_typ, 'TaskDataField') then
  begin
    task := m_owner.Owner.Owner;
    m_list.Clear;
    m_list.Add('');
    for i := 0 to pred(task.Fields.Count) do
    begin
      m_list.Add(task.Fields.Items[i].Name);
    end;
    m_list.Sort;
  end
  else if SameText(m_typ, 'TAlign') then         fillAlignList(m_list)
  else if SameText(m_typ, 'TEditCharCase') then  fillTEditcharList(m_list)
  else if SameText(m_typ, 'TDateTimeKind') then  fillDateTimeKindList(m_list);

  list.Assign(m_list);
end;

function TaskCtrlPropImpl.getCheckBoxProps(var value: string): boolean;
begin
  Result := true;
  if SameText( m_name, 'checked') then begin
    if (m_ctrl as TCheckBox).Checked then
      Value := 'Ja'
    else
      value := 'Nein';
  end else
    Result := false;
end;

function TaskCtrlPropImpl.getComboBoxProps( var value : string ) : boolean;
begin
  Result := true;
  if SameText(m_name, 'Items') and Assigned(m_ctrl) then
    (m_ctrl as TComboBox).Items.Assign(m_list);


  if      SameText(m_name, 'Items') then      value := (m_ctrl as TComboBox).Items.Text
  else if SameText(m_name, 'ItemIndex') then  value := IntToStr((m_ctrl as TComboBox).ItemIndex)
  else if SameText(m_name, 'Text') then       value := (m_ctrl as TComboBox).Text
  else Result := false;
end;

function TaskCtrlPropImpl.getControl: TControl;
begin
  Result := m_ctrl;
end;

function TaskCtrlPropImpl.getCustomEditProps( var value : string ) : boolean;
begin
  Result := true;
  if SameText(m_name, 'Text') then          value := (m_ctrl as TCustomEdit).Text
  else
    Result := false;

end;

function TaskCtrlPropImpl.getDateTimePickerProps(var value: string): boolean;
begin
  Result := true;

  if SameText(m_name, 'kind') then            value := DateTimePickerKind2Text((m_ctrl as TDateTimePicker).Kind)
  else
    Result := false;
end;

function TaskCtrlPropImpl.getEditProps( var value : string ) : boolean;
begin
  Result := true;
  if      SameText(m_name, 'CharCase') then     value := TEditCharCase2Text((m_ctrl as TEdit).CharCase)
  else if SameText(m_name, 'NumbersOnly') then  Value := bool2Str((m_ctrl as TEdit).NumbersOnly)
  else if SameText(m_name, 'NumbersOnly') then  Value := bool2Str((m_ctrl as TEdit).NumbersOnly)
  else if SameText(m_name, 'TExt') then         Value := (m_ctrl as TEdit).text
  else
    Result := false;
end;

function TaskCtrlPropImpl.getGroupboxProps( var value : string ) : boolean;
begin
  Result := true;
  if SameText(m_name, 'Caption') then       value := (m_ctrl as TGroupbox).Caption
  else
    Result := false;
end;

function TaskCtrlPropImpl.getLabeledEditProps( var value : string ) : boolean;
begin
  Result := true;
  if      SameText(m_name, 'Caption') then      value := (m_ctrl as TLabeledEdit).EditLabel.Caption
  else if SameText(m_name, 'CharCase') then     value := TEditCharCase2Text((m_ctrl as TLabeledEdit).CharCase)
  else if SameText(m_name, 'NumbersOnly') then  Value := bool2Str((m_ctrl as TLabeledEdit).NumbersOnly)
  else if SameText(m_name, 'Text') then         Value := (m_ctrl as TLabeledEdit).Text
  else
    Result := false;
end;

function TaskCtrlPropImpl.getLabelProps( var value : string ) : boolean;
begin
  Result := true;
  if SameText(m_name, 'Caption') then  value := (m_ctrl as TLabel).Caption
  else
    Result := false;
end;

function TaskCtrlPropImpl.getMemoProps(var value: string): boolean;
begin
  Result := true;
  if SameText(m_name, 'Text') then  value := (m_ctrl as TMemo).Lines.Text
  else
    Result := false;
end;

function TaskCtrlPropImpl.getName: string;
begin
  Result := m_name;
end;

function TaskCtrlPropImpl.getRadioBtnProps(var value: string): boolean;
begin
  Result := true;
  if SameText( m_name, 'checked') then begin
    if (m_ctrl as TRadioButton).Checked then
      Value := 'Ja'
    else
      value := 'Nein';
  end else
    Result := false;

end;

function TaskCtrlPropImpl.getRadioGroupProps(var value: string): boolean;
begin
  Result := true;
  if SameText(m_name, 'Items') and Assigned(m_ctrl) then
    (m_ctrl as TRadioGroup).Items.Assign(m_list);


  if      SameText(m_name, 'Items') then      value := (m_ctrl as TRadioGroup).Items.Text
  else if SameText(m_name, 'ItemIndex') then  value := IntToStr((m_ctrl as TRadioGroup).ItemIndex)
  else Result := false;
end;

function TaskCtrlPropImpl.getRichEditProps(var value: string): boolean;
begin
  Result := true;
  if SameText(m_name, 'Text') then  value := (m_ctrl as TRichEdit).Lines.Text
  else
    Result := false;
end;

function TaskCtrlPropImpl.getTyp: string;
begin
  Result := m_typ;
end;

function TaskCtrlPropImpl.getValue: string;
var
  ValueSet : boolean;
begin
  Result := m_value;

  if not Assigned(m_ctrl) then
    exit;

  if SameText( m_name, 'Datafield') then
  begin
    Result := '';
    if Assigned(m_owner.DataField) then
      Result := m_owner.DataField.Name;
    m_value := Result;
    exit;
  end;

  ValueSet := true;
  if      SameText(m_name, 'name') then     Result := m_ctrl.Name
  else if SameText(m_name, 'Top') then      Result := IntToStr(m_ctrl.top)
  else if SameText(m_name, 'Left') then     Result := IntToStr(m_ctrl.left)
  else if SameText(m_name, 'Width') then    Result := IntToStr(m_ctrl.Width)
  else if SameText(m_name, 'height') then   Result := IntToStr(m_ctrl.Height)
  else if SameText(m_name, 'Enabled') then  Result := Bool2Str(m_ctrl.Enabled)
  else if SameText(m_name, 'Visible') then  Result := Bool2Str(m_ctrl.visible)
  else if SameText(m_name, 'Align') then    Result := TAlign2Text(m_ctrl.Align)
  else if SameText(m_name, 'Required') then Result := Bool2Str(m_owner.Required)
  else
    ValueSet := false;

  if not ValueSet then
  begin
    if (not ValueSet) and (m_ctrl is TLabel) then             ValueSet := getLabelProps(Result);
    if (not ValueSet) and (m_ctrl is TGroupbox) then          ValueSet := getGroupboxProps(Result);
    if (not ValueSet) and (m_ctrl is TCustomEdit) then        ValueSet := getCustomEditProps(Result);
    if (not ValueSet) and (m_ctrl is TEdit) then              ValueSet := getEditProps(Result);
    if (not ValueSet) and (m_ctrl is TLabeledEdit) then       ValueSet := getLabeledEditProps(Result);
    if (not ValueSet) and (m_ctrl is TComboBox) then          ValueSet := getComboBoxProps(Result);
    if (not ValueSet) and (m_ctrl is TMemo) then              ValueSet := getMemoProps(Result);
    if (not ValueSet) and (m_ctrl is TRichEdit) then          ValueSet := getRichEditProps(Result);
    if (not ValueSet) and (m_ctrl is TRadioButton) then       ValueSet := getRadioBtnProps(Result);
    if (not ValueSet) and (m_ctrl is TCheckBox) then          ValueSet := getCheckBoxProps(Result);
    if (not ValueSet) and (m_ctrl is TRadioGroup) then        ValueSet := getRadioGroupProps(Result);
    if (not ValueSet) and (m_ctrl is TDateTimePicker) then    getDateTimePickerProps(Result);
  end;

  m_value := Result;
end;

function TaskCtrlPropImpl.getValueList: TStringList;
begin
  Result := m_list;
end;

function TaskCtrlPropImpl.hasEditor: boolean;
begin
  Result := SameText( m_typ, 'TStringList') or SameText( m_typ, 'TFields') or SameText(m_typ, 'TStrings');
end;

function TaskCtrlPropImpl.isList: boolean;
begin
  Result := (m_list.count > 0 ) or
            SameText( m_typ, 'TaskDataField') or
            SameText( m_typ, 'TAlign') or
            SameText(m_typ, 'TEditCharCase') or
            SameText(m_typ, 'TStringList') or
            SameText(m_typ, 'TDateTimeKind');
end;

procedure TaskCtrlPropImpl.release;
begin
  m_owner := NIL;
end;

procedure TaskCtrlPropImpl.setAlign(value: string);
var
  al : TAlign;
begin
  al := Text2TAlign(value);

  case al of
    alNone:   ;
    alTop:    m_ctrl.Top  := 1080;
    alBottom: m_ctrl.Top  := 0;
    alLeft:   m_ctrl.left := 1920;
    alRight:  m_ctrl.Left := 0;
    alClient: ;
    alCustom: ;
  end;
  m_ctrl.Align := al;
end;

procedure TaskCtrlPropImpl.setCheckBoxProps(value: string);
begin
  if SameText(m_name, 'checked') then  (m_ctrl as TCheckBox).Checked := SameText(value, 'true') or SameText(value, 'ja');
end;

procedure TaskCtrlPropImpl.setComboBoxProps(value: string);
begin
  if SameText(m_name, 'Items') and Assigned(m_ctrl) then
    m_list.Text := value;

  if      SameText(m_name, 'Items') then      (m_ctrl as TComboBox).Items.Text := value
  else if SameText(m_name, 'ItemIndex') then  try (m_ctrl as TComboBox).ItemIndex := StrToint( value); except end
  else if SameText(m_name, 'Text') then       (m_ctrl as TComboBox).Text := value;
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

procedure TaskCtrlPropImpl.setDateTimePickerProps(value: string);
begin
  if SameText(m_name, 'kind') then  (m_ctrl as TDateTimePicker).Kind := Text2DateTimePickerKind(value);
end;

procedure TaskCtrlPropImpl.setdEditProps(value: string);
begin
  if      SameText(m_name, 'CharCase') then     (m_ctrl as TEdit).CharCase    := Text2TEditCharCase(value)
  else if SameText(m_name, 'NumerbsOnly') then  (m_ctrl as TEdit).NumbersOnly := str2bool(value)
  else if SameText(m_name, 'Text') then         (m_ctrl as TEdit).Text := value

end;

procedure TaskCtrlPropImpl.setGroupboxProps(value: string);
begin
  if SameText(m_name, 'Caption') then       (m_ctrl as TGroupbox).Caption := value;
end;

procedure TaskCtrlPropImpl.setLabeledEditProps(value: string);
begin
  if      SameText(m_name, 'Caption') then      (m_ctrl as TLabeledEdit).EditLabel.Caption := value
  else if SameText(m_name, 'CharCase') then     (m_ctrl as TLabeledEdit).CharCase := Text2TEditCharCase(value)
  else if SameText(m_name, 'NumerbsOnly') then  (m_ctrl as TLabeledEdit).NumbersOnly := str2bool(value)
  else if SameText(m_name, 'Text') then  (       m_ctrl as TLabeledEdit).text := value;
end;

procedure TaskCtrlPropImpl.setLabelProps(value: string);
begin
  if SameText(m_name, 'Caption') then       (m_ctrl as TLabel).Caption := value;
end;

procedure TaskCtrlPropImpl.setMemoProps(value: string);
begin
  if SameText(m_name, 'Text') then       (m_ctrl as TMemo).Lines.Text := value;
end;

procedure TaskCtrlPropImpl.setName(value: string);
begin
  m_name := value;
end;

procedure TaskCtrlPropImpl.setRadioBtnProps(value: string);
begin
  if SameText(m_name, 'checked') then  (m_ctrl as TRadiobutton).Checked := SameText(value, 'true') or SameText(value, 'ja');
end;

procedure TaskCtrlPropImpl.setRadioGroupProps(value: string);
begin
  if SameText(m_name, 'Items') and Assigned(m_ctrl) then
    m_list.Text := value;

  if      SameText(m_name, 'Items') then      (m_ctrl as TRadioGroup).Items.Text := value
  else if SameText(m_name, 'ItemIndex') then  try (m_ctrl as TRadioGroup).ItemIndex := StrToint( value); except end;
end;

procedure TaskCtrlPropImpl.setRichEditProps(value: string);
begin
    if SameText(m_name, 'Text') then       (m_ctrl as TRichEdit).Lines.Text := value;
end;

procedure TaskCtrlPropImpl.setTyp(value: string);
begin
  m_typ := value;
  if SameText( m_typ, 'boolean') then
    m_list.DelimitedText := 'Ja;Nein';
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

  if SameText(m_name, 'Top') and (m_ctrl.Align in [alNone, alCustom, alLeft, alRight, alBottom])  then
    try m_ctrl.top := StrToInt( value ); except end;

  if SameText(m_name, 'Left') and (m_ctrl.Align in [alNone, alCustom, alRight, alBottom, alTop]) then
    try m_ctrl.left := StrToint( value ); except end;

  if SameText(m_name, 'Width') and ( m_ctrl.Align in [alNone, alCustom, alLeft, alRight, alBottom, alTop]) then
    try m_ctrl.Width := StrToInt( value ); except end;

  if SameText(m_name, 'height') and ( m_ctrl.Align in [alNone, alCustom, alLeft, alRight, alBottom, alTop]) then
    try m_ctrl.Height  := StrToInt( value ); except end;
  if      SameText(m_name, 'Enabled') then  m_ctrl.Enabled := Str2Bool(value)

  else if SameText(m_name, 'Visible') then  m_ctrl.visible := Str2Bool(value)
  else if SameText(m_name, 'Align') then    setAlign(value)
  else if SameText(m_name, 'Required') then m_owner.Required := Str2Bool(value);

  if m_ctrl is TLabel then          setLabelProps(value);
  if m_ctrl is TGroupbox then       setGroupboxProps(value);
  if m_ctrl is TCustomEdit then     setCustomEditProps(value);
  if m_ctrl is TEdit then           setdEditProps( value );
  if m_ctrl is TLabeledEdit then    setLabeledEditProps(value);
  if m_ctrl is TComboBox then       setComboBoxProps(value);
  if m_ctrl is TMemo then           setMemoProps(value);
  if m_ctrl is TRichEdit then       setRichEditProps(value);
  if m_ctrl is TRadioButton then    setRadioBtnProps(value);
  if m_ctrl is TCheckBox then       setCheckBoxProps(value);
  if m_ctrl is TRadioGroup then     setRadioGroupProps(value);
  if m_ctrl is TDateTimePicker then setDateTimePickerProps(value);

end;

function TaskCtrlPropImpl.ShowEditor : boolean;
var
  ItemsEditorForm   : TItemsEditorForm;
  TableColumnsForm  : TTableColumnsForm;

  procedure setRichTExtText;
  var
    StringEditorForm  : TStringEditorForm;
  begin
    Application.CreateForm(TStringEditorForm, StringEditorForm);

    StringEditorForm.Memo1.Lines.Assign((m_ctrl as TRichEdit).Lines);
    if StringEditorForm.ShowModal = mrok then
    begin
      (m_ctrl as TRichEdit).Lines.Assign(StringEditorForm.Memo1.Lines);
      Result := true;
    end;
    StringEditorForm.Free;
  end;
  procedure setRadioGroupText;
  var
    StringEditorForm  : TStringEditorForm;
  begin
    Application.CreateForm(TStringEditorForm, StringEditorForm);

    StringEditorForm.Memo1.Lines.Assign((m_ctrl as TRadioGroup).Items);
    if StringEditorForm.ShowModal = mrok then
    begin
      (m_ctrl as TRadioGroup).items.Assign(StringEditorForm.Memo1.Lines);
      Result := true;
    end;
    StringEditorForm.Free;
  end;
begin
  Result := false;
  if m_ctrl is TComboBox then
  begin
    if Assigned(m_owner.DataField) and SameText( m_owner.DataField.Typ, 'enum') then begin
      ShowMessage('Diese Werte werden über das Datenfeld bestimmt, da es vom Typ "enum" ist.');
      exit;
    end;

    Application.CreateForm(TItemsEditorForm, ItemsEditorForm);
    ItemsEditorForm.Memo1.Lines.Assign( m_list );
    if ItemsEditorForm.ShowModal = mrOk then
    begin
      m_list.Assign( ItemsEditorForm.Memo1.Lines );
      Result := true;
    end;
    ItemsEditorForm.Free;
  end
  else if m_ctrl is TStringGrid then
  begin
    if not Assigned(m_owner.DataField) then
    begin
      ShowMessage('Es wurde noch kein Datenfeld zugewiesen!');
      exit;
    end;
    Application.CreateForm(TTableColumnsForm, TableColumnsForm);
    TableColumnsForm.Table := m_owner;
    Result := ( TableColumnsForm.ShowModal = mrOk );
    TableColumnsForm.Free;
  end
  else if m_ctrl is TRichEdit then
  begin
   if SameText(m_name, 'Text' ) then
   begin
     setRichTExtText;
   end;
  end else if m_ctrl is TRadioGroup then begin
    if SameText(m_name, 'items' ) then setRadioGroupText;
  end;
end;

end.
