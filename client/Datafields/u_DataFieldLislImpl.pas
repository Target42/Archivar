unit u_DataFieldLislImpl;

interface

uses
  i_datafields, System.Generics.Collections;

type
  TDataFieldList = class(TInterfacedObject, IDataFieldList )
  private
    m_owner : IDataField;
    m_list : TList<IDataField>;
    m_listener : Tlist<TDataListChange>;

    procedure SetItems( inx : integer ; const value : IDataField );
    function  GetItems( inx : integer ) :IDataField;
    function  getCount : integer;
    procedure setOwner( value : IDataField );
    function  getOwner :IDataField;

  public
    constructor create (Owner :IDataField );
    Destructor Destroy; override;

    property Items[ inx : integer ] : IDataField read GetItems write SetItems;
    function getByName( name : string ) : IDataField;
    function getByCLID( clid : string ) : IDataField;

    procedure add( value : IDataField );
    function newField( name, typ : string ) : IDataField;
    procedure delete( value : IDataField );
    procedure release;

    function clone : IDataFieldList;

    procedure RegisterListener( evt : TDataListChange );
    procedure UnregisterListener( evt : TDataListChange );

    procedure inform( event : TDataListChangeType; value : IDataField );
  end;

implementation

uses
  System.SysUtils, u_DataFieldImpl;

{ TDataFieldList }

procedure TDataFieldList.add(value: IDataField);
begin
  value.Owner := self;

  if not m_list.Contains(value) then
  begin
    m_list.Add( value);
    inform(dlcNew, value);
  end;
end;

function TDataFieldList.clone: IDataFieldList;
var
  i : integer;
begin
  Result := TDataFieldList.create(m_owner);
  for i := 0 to pred(m_list.Count) do
  begin
    Result.Add( m_list[i].clone );
  end;
end;

constructor TDataFieldList.create(Owner :IDataField );
begin
  m_owner     := Owner;
  m_list      := TList<IDataField>.create;
  m_listener  := Tlist<TDataListChange>.create;
end;

procedure TDataFieldList.delete(value: IDataField);
begin
  inform(dlcDelete, value);
  m_list.Remove(value);
  value.release;
end;

destructor TDataFieldList.Destroy;
begin
  m_list.Free;

  m_listener.Clear;
  m_listener.Free;
  inherited;
end;

function TDataFieldList.getByCLID(clid: string): IDataField;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(m_list.Count) do
  begin
    if SameText( clid, m_list[i].clid) then
    begin
      Result := m_list[i];
      break;
    end;
  end;
  if not Assigned(Result) then
  begin
    for i := 0 to pred(m_list.Count) do
    begin
      Result := m_list[i].Childs.getByCLID( clid );
      if Assigned(Result) then
        exit;
    end;
  end;
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

function TDataFieldList.getOwner: IDataField;
begin
  Result := m_owner;
end;

procedure TDataFieldList.inform(event: TDataListChangeType; value: IDataField);
var
  i : integer;
begin
  for i := 0 to pred(m_listener.Count) do
  begin
    m_listener[i](event, value);
  end;
end;

function TDataFieldList.newField( name, typ : string ): IDataField;
begin
  Result := TDataField.create(name, typ);
  m_list.Add(Result);

  inform( dlcNew, Result);
end;

procedure TDataFieldList.RegisterListener(evt: TDataListChange);
begin
  if not m_listener.Contains(evt) then
    m_listener.Add(evt);
end;

procedure TDataFieldList.release;
var
  i : integer;
begin
  m_owner := NIL;
  for i := 0 to pred(m_list.Count) do
    m_list[i].Release;
  m_list.Clear;
end;

procedure TDataFieldList.SetItems(inx: integer; const value: IDataField);
begin
  m_list[inx] := value;
end;

procedure TDataFieldList.setOwner(value: IDataField);
begin
  m_owner := value;
end;

procedure TDataFieldList.UnregisterListener(evt: TDataListChange);
begin
  m_listener.Remove(evt);
end;

end.
