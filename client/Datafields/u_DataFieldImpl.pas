unit u_DataFieldImpl;

interface

uses
  i_datafields, System.Generics.Collections, System.Classes, System.SysUtils;

type
  TDataField = class(TInterfacedObject, IDataField)
    private
      m_list : TList<IProperty>;
      m_name : string;
      m_clid : string;
      m_typ  : string;
      m_rem  : string;
      m_glob : boolean;

      procedure SetName( value : string );
      function  GetName : string;
      procedure SetCLID( value : string );
      function  GetCLID : string;
      procedure SetTyp( value : string );
      function  GetTyp : string;
      procedure setRem( value : string );
      function  getRem : string;
      procedure setIsGlobal( value : boolean );
      function  getIsGlobal : boolean;

      function  GetItems : TList<IProperty>;

      procedure config( const arr : array of TPropertyEntry);

    public
      constructor Create; overload;
      constructor Create( name, typ : string ); overload;
      Destructor Destroy; override;

      property Name  : string read GetName write SetName;
      property CLID  : string read GetCLID write SetCLID;
      property Typ   : string read GetTyp  write SetTyp;
      property Rem   : string read getRem write setRem;
      property isGlobal : boolean read getIsGlobal write setIsGlobal;

      property Items : TList<IProperty> read GetItems;
      function getPropertyByName( name : string ) : IProperty;

      procedure release;

      procedure loadFromStream( st : TStream );
      procedure saveToStream(st  : TStream );
  end;

implementation

uses
  Win.ComObj, xsd_DataField, Xml.XMLIntf, Xml.XMLDoc, u_PropertyImpl;


const
  StringProps : array[1..4] of TPropertyEntry =
  (
    (name:'Length';       typ:'integer';        value:'100'),
    (name:'Readonly';     typ:'bool';           value:'false'),
    (name:'RegEx';        typ:'string';         value:''),
    (name:'CharCase';     typ:'TEditCharCase';  value:'ecNormal';)
  );
  EnumProps : array[1..2] of TPropertyEntry =
  (
    (name:'Values';       typ:'StringList'; value:'1;2;3'),
    (name:'Default';      typ:'string';     value:'1')
  );
  IntegerProps : array[1..3] of TPropertyEntry =
  (
    (name:'Default';      typ:'integer';    value:'0'),
    (name:'Min';          typ:'integer';    value:'0'),
    (name:'Max';          typ:'integer';    value:'0')
  );
  DateProps : array[1..2] of TPropertyEntry =
  (
    (name:'Format';       typ:'string';     value:'dd.MM.yyyy'),
    (name:'Default';      typ:'string';     value:'$Date')
  );
  TimeProps : array[1..2] of TPropertyEntry =
  (
    (name:'Format';       typ:'string';     value:'hh:mm'),
    (name:'Default';      typ:'string';     value:'$time')
  );
  DateTimeProps : array[1..2] of TPropertyEntry =
  (
    (name:'Format';       typ:'string';     value:'dd.MM.yyyy hh:mm'),
    (name:'Default';      typ:'string';     value:'$now')
  );
  BoolProps : array[1..1] of TPropertyEntry =
  (
    (name:'Default';      typ:'bool';       value:'false')
  );
  FloatProps : array[1..3] of TPropertyEntry =
  (
    (name:'Default';      typ:'float';      value:'0.0'),
    (name:'Min';          typ:'float';      value:'0.0'),
    (name:'Max';          typ:'float';      value:'0.0')
  );
  TextProps : array[1..1] of TPropertyEntry =
  (
    (name:'Default';      typ:'bool';       value:'false')
  );


{ TDataField }


procedure TDataField.config(const arr: array of TPropertyEntry);
var
  i : integer;
begin
  release;
  for i := Low(arr) to High(arr) do
  begin
    m_list.Add(TPropertyImpl.Create(self, arr[i]));
  end;

end;

constructor TDataField.Create;
begin
  m_glob := false;
  m_list := TList<IProperty>.create;
end;

constructor TDataField.Create(name, typ: string);
begin
  m_glob := false;
  m_list := TList<IProperty>.create;
  m_name := name;

  SetTyp(typ);
end;

destructor TDataField.Destroy;
begin
  release;

  m_list.Free;
  inherited;
end;

function TDataField.GetCLID: string;
begin
  Result := m_clid;
end;

function TDataField.getIsGlobal: boolean;
begin
  Result := m_glob;
end;

function TDataField.GetItems: TList<IProperty>;
begin
  Result := m_list;
end;

function TDataField.GetName: string;
begin
  Result := m_name;
end;

function TDataField.getPropertyByName(name: string): IProperty;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(m_list.Count) do
    begin
      if SameText( name, m_list[i].Name) then
      begin
        Result := m_list[i];
        break;
      end;
    end;
end;

function TDataField.getRem: string;
begin
  Result := m_rem;
end;

function TDataField.GetTyp: string;
begin
  Result := m_typ;
end;

procedure TDataField.loadFromStream(st: TStream);
var
  xData : IXMLDataField;
  xml   : IXMLDocument;
  procedure addProps;
  var
    i : integer;
    xp : IXMLProperty_;
    p  : IProperty;
  begin
    for i := 0 to pred(xData.Property_.Count) do
    begin
      xp := xData.Property_[i];
      p  := getPropertyByName(xp.Name);
      if Assigned(p) then
        p.Value := xp.Value;
    end;
  end;

begin
  xData := NIL;
  xml := NewXMLDocument;
  if Assigned(st) and (st.Size > 0 ) then
  begin
    xml.LoadFromStream(st);
    xData := xml.GetDocBinding('DataField', TXMLDataField, TargetNamespace) as IXMLDataField;
  end;

  if not Assigned(xData) then
  begin
    xData := NewDataField;
    xData.Datatype := 'string';
  end;

  m_name := xData.Name;
  m_clid := xData.Clid;
  m_rem  := xData.Text;

  SetTyp(xData.Datatype);
  addProps;
end;

procedure TDataField.release;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
  begin
    m_list[i].release;
  end;
  m_list.Clear;
end;

procedure TDataField.saveToStream(st  : TStream );
var
  xData : IXMLDataField;

  procedure addProps;
  var
    i : integer;
    xp : IXMLProperty_;
    p  : IProperty;
  begin
    for i := 0 to pred(m_list.Count) do
    begin
      xp := xData.Property_.Add;
      p  := m_list[i];
      xp.Name   := p.Name;
      xp.Typ    := p.Typ;
      xp.Value  := p.Value;
    end;
  end;

begin
  xData           := NewDataField;
  xData.Name      := m_name;
  xData.Clid      := m_clid;
  xData.Datatype  := m_typ;
  xData.Text      := m_rem;
  xData. IsGlobal := m_glob;

  addProps;

  xData.OwnerDocument.SaveToStream(st);
end;

procedure TDataField.SetCLID(value: string);
begin
  m_clid := value;
end;

procedure TDataField.setIsGlobal(value: boolean);
begin
  m_glob := value;
end;

procedure TDataField.SetName(value: string);
begin
  m_name := value;
end;

procedure TDataField.setRem(value: string);
begin
  m_rem := value;
end;

procedure TDataField.SetTyp(value: string);
begin
  m_typ := value;

   if m_typ = 'string' then
     config(StringProps)
  else if m_typ = 'integer' then
    config(IntegerProps)
  else if m_typ = 'float' then
    config(FloatProps)
  else if m_typ = 'date' then
    config(DateProps)
  else if m_typ = 'time' then
    config(TimeProps)
  else if m_typ = 'datetime' then
    config(DateTimeProps)
  else if m_typ = 'bool' then
    config(BoolProps)
  else if m_typ = 'enum' then
    config(EnumProps)
  else if m_typ = 'text' then
    config(TextProps);
end;

end.
