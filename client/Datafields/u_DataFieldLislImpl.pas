unit u_DataFieldLislImpl;

interface

uses
  i_datafields, System.Generics.Collections;

type
  TDataFieldList = class(TInterfacedObject, IDataFieldList )
  private
    m_list : TList<IDataField>;

    procedure SetItems( inx : integer ; const value : IDataField );
    function  GetItems( inx : integer ) :IDataField;
    function  getCount : integer;
  public
    constructor create;
    Destructor Destroy; override;

    property Items[ inx : integer ] : IDataField read GetItems write SetItems;
    function getByName( name : string ) : IDataField;

    procedure add( value : IDataField );
    function newField( name, typ : string ) : IDataField;
    procedure delete( value : IDataField );
    procedure release;

    function clone : IDataFieldList;
  end;

implementation

uses
  System.SysUtils, u_DataFieldImpl;

{ TDataFieldList }

procedure TDataFieldList.add(value: IDataField);
begin
  if not m_list.Contains(value) then
    m_list.Add( value);
end;

function TDataFieldList.clone: IDataFieldList;
var
  i : integer;
begin
  Result := TDataFieldList.create;
  for i := 0 to pred(m_list.Count) do
  begin
    Result.Add( m_list[i].clone );
  end;
end;

constructor TDataFieldList.create;
begin
  m_list := TList<IDataField>.create;
end;

procedure TDataFieldList.delete(value: IDataField);
begin
  m_list.Remove(value);
  value.release;
end;

destructor TDataFieldList.Destroy;
begin
  release;
  m_list.Free;

  inherited;
end;

function TDataFieldList.getByName(name: string): IDataField;
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

function TDataFieldList.getCount: integer;
begin
  Result := m_list.Count;
end;

function TDataFieldList.GetItems(inx: integer): IDataField;
begin
  Result := m_list[inx];
end;

function TDataFieldList.newField( name, typ : string ): IDataField;
begin
  Result := TDataField.create(name, typ);
  m_list.Add(Result);
end;

procedure TDataFieldList.release;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
    m_list[i].Release;
  m_list.Clear;
end;

procedure TDataFieldList.SetItems(inx: integer; const value: IDataField);
begin
  m_list[inx] := value;
end;

end.
