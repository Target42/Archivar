unit u_DataFieldImpl;

interface

uses
  i_datafields, System.Generics.Collections, System.Classes, System.SysUtils;

type
  TDataField = class(TInterfacedObject, IDataField)
    private
      m_owner   : IDataFieldList;
      m_list    : TList<IProperty>;
      m_name    : string;
      m_gname   : string;
      m_clid    : string;
      m_typ     : string;
      m_rem     : string;
      m_glob    : boolean;
      m_childs  : IDataFieldList;
      m_dtype   : TDataFieldType;

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
      function  getChilds : IDataFieldList;
      procedure setChilds( value : IDataFieldList);

      procedure config( const arr : array of TPropertyEntry);

      procedure setOwner( value : IDataFieldList );
      function  getOwner : IDataFieldList;
      procedure setGlobalName( value : string );
      function  getGlobalName : string;

      function getDataFieldType : TDataFieldType;

    public
      constructor Create; overload;
      constructor Create( name, typ : string ); overload;
      Destructor Destroy; override;

      function getPropertyByName( name : string ) : IProperty;
      function propertyValue( name : string ) : string;

      procedure release;
      function clone : IDataField;

  end;

implementation

uses
  Win.ComObj, u_PropertyImpl,
  u_DataFieldLislImpl;

const
  StringProps : array[1..4] of TPropertyEntry =
  (
    (name:'Length';       typ:'integer';        value:'100'),
    (name:'Readonly';     typ:'bool';           value:'Nein'),
    (name:'RegEx';        typ:'string';         value:''),
    (name:'CharCase';     typ:'TEditCharCase';  value:'ecNormal';)
  );
  EnumProps : array[1..3] of TPropertyEntry =
  (
    (name:'Values';       typ:'EnumList';   value:'1;2;3'),
    (name:'Default';      typ:'string';     value:'1'),
    (name:'Eigene Werte'; typ:'bool';       value:'Nein')
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
    (name:'Default';      typ:'bool';       value:'Nein')
  );
  FloatProps : array[1..4] of TPropertyEntry =
  (
    (name:'Default';      typ:'float';      value:'0.0'),
    (name:'Min';          typ:'float';      value:'0.0'),
    (name:'Max';          typ:'float';      value:'0.0'),
    (name:'Format';       typ:'string';     value:'#,##')
  );
  TextProps : array[1..1] of TPropertyEntry =
  (
    (name:'Default';      typ:'bool';       value:'Nein')
  );
  TableProps : array[1..2] of TPropertyEntry =
  (
    (name:'MinLines';      typ:'integer';       value:'0'),
    (name:'MaxLines';      typ:'integer';       value:'0')
  );
  LinkTableProps  : array[1..1] of TPropertyEntry =
  (
    (name:'TableName';     typ:'TableLink';     value:'')
  );
  DateTimePickerProps : array[1..1] of TPropertyEntry =
  (
    (name:'Kind';          typ:'TDateTimeKind'; value:'dtkDate')
  );


{ TDataField }


function TDataField.clone: IDataField;
var
  i : integer;
  p : IProperty;
begin
  Result            := TDataField.Create;
  Result.Name       := m_name;
  Result.CLID       := m_clid;
  Result.isGlobal   := m_glob;
  Result.Typ        := m_typ;
  Result.GlobalName := m_gname;
  Result.Rem        := m_rem;

  for i := 0 to pred(m_list.Count) do
  begin
    p := Result.getPropertyByName(m_list[i].Name);
    if Assigned(p) then
      p.Value := m_list[i].Value;
  end;
  Result.Childs := self.getChilds.clone;
end;

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
  m_owner     := NIL;
  m_glob      := false;
  m_list      := TList<IProperty>.create;
  m_childs    := TDataFieldList.create(self);
  m_clid      := CreateClassID;
  m_dtype     := dtUnkown;
end;

constructor TDataField.Create(name, typ: string);
begin
  m_owner     := NIL;
  m_glob      := false;
  m_list      := TList<IProperty>.create;
  m_childs    := TDataFieldList.create(self);
  m_name      := name;
  m_clid      := CreateClassID;

  SetTyp(typ);
end;

destructor TDataField.Destroy;
begin
  m_list.Free;
  inherited;
end;

function TDataField.getChilds: IDataFieldList;
begin
  Result := m_childs;
end;

function TDataField.GetCLID: string;
begin
  Result := m_clid;
end;

function TDataField.getDataFieldType: TDataFieldType;
begin
  Result := m_dtype;
end;

function TDataField.getGlobalName: string;
begin
  Result := m_gname;
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

function TDataField.getOwner: IDataFieldList;
begin
  Result := m_owner;
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

function TDataField.propertyValue(name: string): string;
var
  p : IProperty;
begin
  Result := '';
  p := getPropertyByName(name);
  if Assigned(p) then begin
    Result := p.Value;
  end;
end;

procedure TDataField.release;
var
  i : integer;
begin
  m_owner := NIL;

  for i := 0 to pred(m_list.Count) do
  begin
    m_list[i].release;
  end;

  m_childs.release;
  m_list.Clear;
end;

procedure TDataField.setChilds(value: IDataFieldList);
begin
  m_childs.release;
  m_childs := value;
end;

procedure TDataField.SetCLID(value: string);
begin
  m_clid := value;
  if m_clid = '' then
   m_clid  := CreateClassID;

end;

procedure TDataField.setGlobalName(value: string);
begin
  m_gname := value;
end;

procedure TDataField.setIsGlobal(value: boolean);
begin
  m_glob := value;
end;

procedure TDataField.SetName(value: string);
begin
  m_name := value;
  if Assigned(m_owner) then
    m_owner.inform(dlcChange, self);
end;

procedure TDataField.setOwner(value: IDataFieldList);
begin
  m_owner := value;
end;

procedure TDataField.setRem(value: string);
begin
  m_rem := value;
end;

procedure TDataField.SetTyp(value: string);
var
  i : integer;
begin
  m_typ := value;

  for i := low(StrMap) to High(StrMap) do begin
    if SameText( m_typ, StrMap[i].name) then begin
      m_dtype := strMap[i].typ;
      break;
    end;
  end;

  case m_dtype of
    dtUnkown: ;
    dtBool:           config(BoolProps);
    dtDate:           config(DateProps);
    dtDatetime:       config(DateTimeProps);
    dtEnum:           config(EnumProps);
    dtFloat:          config(FloatProps);
    dtInteger:        config(IntegerProps);
    dtString:         config(StringProps);
    dtText:           config(TextProps);
    dtTime:           config(TimeProps);
    dtLinktable:      config(LinkTableProps);
    dtTable:          config(TableProps);
    dtDateTimePicker: config(DateTimePickerProps);
  end;
end;

end.
