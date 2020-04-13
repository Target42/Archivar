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
  public
    constructor create;
    Destructor Destroy; override;

    property Items[ inx : integer ] : IDataField read GetItems write SetItems;
    function getByName( name : string ) : IDataField;

    procedure release;

  end;

implementation

uses
  System.SysUtils;

{ TDataFieldList }

constructor TDataFieldList.create;
begin
  m_list := TList<IDataField>.create;
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

function TDataFieldList.GetItems(inx: integer): IDataField;
begin
  Result := m_list[inx];
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
