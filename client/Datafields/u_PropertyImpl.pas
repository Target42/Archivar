unit u_PropertyImpl;

interface

uses
  i_datafields, System.Generics.Collections, System.Classes, Vcl.Forms,
  f_df_listbox, Vcl.Controls;

type
  TPropertyImpl = class(TInterfacedObject, IProperty)
  private
    type
      TPropertyType = (ptUnknown, ptString, ptInteger, ptBool,
        ptEditCharCase,
        ptEnumList,
        ptLinkTable);
  private
    m_owner   : IDataField;
    m_name    : string;
    m_typ     : TPropertyType;
    m_value   : string;
    m_values  : TStringList;
    m_ptr     : Pointer;

    procedure SetName( value : string );
    function  GetName : string;
    procedure SetTyp( value : string );
    function  GetTyp : string;
    procedure SetValue( value : string );
    function  GetValue : string;
    procedure setPtr( value : pointer );
    function  getPtr : Pointer;

    function getOwner : IDataField;

  public
    constructor Create( owner : IDataField; entry : TPropertyEntry);
    destructor Destroy; override;

    property Name  : string read GetName write SetName;
    property Typ   : string read GetTyp  write SetTyp;
    property Value : string read GetValue write SetValue;

    function hasEditor : boolean;
    Function ShowEditor : boolean;

    procedure release;

    function isList : Boolean;
    procedure fillList( list : TStrings );

  end;

implementation

{ TPropertyImpl }

uses
  Win.ComObj, System.SysUtils, f_df_EnumList, u_helper, u_typeHelper;

constructor TPropertyImpl.Create( owner : IDataField; entry : TPropertyEntry);
begin
  m_owner     := owner;
  m_values    := TStringList.create;
  m_values.StrictDelimiter := true;
  m_values.Delimiter := ';';
  self.Name   := entry.name;
  self.Typ    := entry.typ;
  self.Value  := entry.value;
end;

destructor TPropertyImpl.Destroy;
begin
  m_values.Free;
  inherited;
end;

procedure TPropertyImpl.fillList(list: TStrings);

begin
  list.Assign(m_values);
end;

function TPropertyImpl.GetName: string;
begin
  Result := m_name;
end;

function TPropertyImpl.getOwner: IDataField;
begin
  Result := m_owner;
end;

function TPropertyImpl.getPtr: Pointer;
begin
  Result := m_ptr;
end;

function TPropertyImpl.GetTyp: string;
begin
  case m_typ of
    ptString:       Result := 'string';
    ptInteger:      Result := 'integer';
    ptBool:         Result := 'bool';
    ptEditCharCase: Result := 'TEditCharCase';
    ptEnumList:     Result := 'EnumList';
    ptLinkTable:    Result := 'TableLink';
  else
    Result := 'unknown';
  end;
end;

function TPropertyImpl.GetValue: string;
begin
  Result := m_value;
end;

function TPropertyImpl.hasEditor: boolean;
begin
  Result := m_typ in [ptEnumList, ptLinkTable];
end;

function TPropertyImpl.isList: Boolean;
begin
  Result := (m_values.Count > 0 );
end;

procedure TPropertyImpl.release;
begin
  m_owner := NIL;
end;

procedure TPropertyImpl.SetName(value: string);
begin
  m_name := value;
end;

procedure TPropertyImpl.setPtr(value: pointer);
begin
  m_ptr := value;
end;

procedure TPropertyImpl.SetTyp(value: string);
begin
  m_typ := ptUnknown;

  value := LowerCase(value);
  if value = 'integer' then
    m_typ := ptInteger
  else if value ='string' then
    m_typ := ptString
  else if value = 'bool' then
    m_typ := ptBool
  else if value = 'teditcharcase' then
    m_typ := ptEditCharCase
  else if value = 'enumlist' then
    m_typ := ptEnumList
  else if value = 'tablelink' then
    m_typ := ptLinkTable;

  if m_typ = ptBool then
    m_values.DelimitedText := 'Ja;Nein';
  if m_typ = ptEditCharCase then
    m_values.DelimitedText := 'ecNormal;ecLowerCase;ecUpperCase';
end;

procedure TPropertyImpl.SetValue(value: string);
begin
  case m_typ of
    ptUnknown:      m_value := value;
    ptString:       m_value := value;
    ptInteger:      m_value := intToStr(StrToIntDef(value, 0));
    ptBool:         m_value := Bool2Str( SameText(value, 'true') or SameText(value, 'ja'));
    ptEditCharCase: m_value := TEditCharCase2Text(Text2TEditCharCase(value));
    ptEnumList: ;
    ptLinkTable:    m_value := value;
    else
      m_value := value;
  end;
end;

function TPropertyImpl.ShowEditor: boolean;
begin
  Result := false;

  if m_typ = ptEnumList then begin
    try
      Application.CreateForm(TDFEnumListForm, DFEnumListForm);
      DFEnumListForm.Prop := self;
      Result := (DFEnumListForm.ShowModal = mrOk);
    finally
      DFEnumListForm.Free;
    end;
  end else if m_typ = ptLinkTable then
  begin
    try
      Application.CreateForm(TListBoxForm, ListBoxForm);
      ListBoxForm.FieldList := IDataFieldList( m_ptr );
      ListBoxForm.Prop := self;
      Result := ( ListBoxForm.ShowModal = mrOk );
    finally
      ListBoxForm.Free;
    end;
  end;
end;

end.
