unit u_PropertyImpl;

interface

uses
  i_datafields, System.Generics.Collections, System.Classes;

type
  TPropertyImpl = class(TInterfacedObject, IProperty)
  private
    type
      TPropertyType = (ptUnknown, ptString, ptInteger, ptBool,
        ptEditCharCase);
  private
    m_owner: IDataField;
    m_name : string;
    m_typ  : TPropertyType;
    m_value: string;
    m_values : TStringList;

    procedure SetName( value : string );
    function  GetName : string;
    procedure SetTyp( value : string );
    function  GetTyp : string;
    procedure SetValue( value : string );
    function  GetValue : string;

  public
    constructor Create( owner : IDataField; entry : TPropertyEntry);
    destructor Destroy; override;

    property Name  : string read GetName write SetName;
    property Typ   : string read GetTyp  write SetTyp;
    property Value : string read GetValue write SetValue;

    procedure release;

    function isList : Boolean;
    procedure fillList( list : TStrings );

  end;

implementation

{ TPropertyImpl }

uses
  Win.ComObj, System.SysUtils;

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

function TPropertyImpl.GetTyp: string;
begin
  case m_typ of
    ptString:       Result := 'string';
    ptInteger:      Result := 'integer';
    ptBool:         Result := 'bool';
    ptEditCharCase: Result := 'TEditCharCase';
  else
    Result := 'unknown';
  end;
end;

function TPropertyImpl.GetValue: string;
begin
  Result := m_value;
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
    m_typ := ptEditCharCase;


  if m_typ = ptBool then
    m_values.DelimitedText := 'true;false';
  if m_typ = ptEditCharCase then
    m_values.DelimitedText := 'ecNormal;ecLowerCase;ecUpperCase';
end;

procedure TPropertyImpl.SetValue(value: string);
begin
  m_value := value;
end;

end.
