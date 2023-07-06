unit u_PersonenListeImpl;

interface

uses
  i_personen, System.Generics.Collections;

type
  TPersonenListeImpl = class(TInterfacedObject, IPersonenListe )
  private
    m_name : string;
    m_list : TList<IPerson>;

    procedure setName( value : string );
    function  getName : string;
    function  getCount : integer;
    procedure setItems( inx : integer; const value : IPerson );
    function  getItems( inx : integer ) :  IPerson;


  public
    constructor create;
    Destructor Destroy; override;

    procedure add( value : IPerson );
    function remove( value : IPerson ) : boolean;
    function  newPerson : IPerson;

    function clone : IPersonenListe;
    procedure Assign( list : IPersonenListe );
    procedure clear;

    function hasSamePerson( p : IPerson ) : boolean;
    procedure removeSamePerson( p : IPerson );
    function removeSamePersonByID( id : integer ) : IPerson;

    procedure release;

  end;

implementation

uses
  u_PersonImpl;

{ TPersonenListeImpl }

procedure TPersonenListeImpl.add(value: IPerson);
begin
  if Assigned(value.Owner) then
    value.Owner.remove(value);

  value.Owner := self;

  if not m_list.Contains( value ) then
    m_list.Add(value);

end;

procedure TPersonenListeImpl.Assign(list: IPersonenListe);
var
  i : integer;
begin
  clear;
  for i := 0 to pred(list.count) do begin
    m_list.Add( list.Items[i].clone);
  end;
end;

procedure TPersonenListeImpl.clear;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
    m_list[i].release;
  m_list.Clear;

end;

function TPersonenListeImpl.clone: IPersonenListe;
var
  i : integer;
begin
  Result := TPersonenListeimpl.create;
  for i := 0 to pred(m_list.Count) do
  begin
    Result.add( m_list[i].clone);
  end;
end;

constructor TPersonenListeImpl.create;
begin
  m_list := TList<IPerson>.create;
end;

destructor TPersonenListeImpl.Destroy;
begin
  m_list.Free;
  inherited;
end;

function TPersonenListeImpl.getCount: integer;
begin
  Result := m_list.Count;
end;

function TPersonenListeImpl.getItems(inx: integer): IPerson;
begin
  Result := m_list[inx];
end;

function TPersonenListeImpl.getName: string;
begin
  Result := m_name;
end;

function TPersonenListeImpl.hasSamePerson(p: IPerson): boolean;
var
  i : integer;
begin
  Result := false;
  for I := 0 to pred(m_list.Count) do begin
    Result := m_list[i].compare(p);
    if Result then
      break;
  end;
end;

function TPersonenListeImpl.newPerson: IPerson;
begin
  Result := TPersonImpl.create;
  self.add(Result);
end;

procedure TPersonenListeImpl.release;
begin
  clear;
end;

function TPersonenListeImpl.remove(value: IPerson): boolean;
begin
  value.Owner := NIL;
  Result := m_list.Contains(value);
  m_list.Remove(value);
end;

procedure TPersonenListeImpl.removeSamePerson(p: IPerson);
var
  i     : integer;
  pers  : IPerson;
begin
  for i := 0 to pred(m_list.Count) do begin
    pers := m_list[i];
    if pers.compare(p) then begin
      m_list.Remove(pers);
      pers.release;
      break;
    end;
  end;
end;

function TPersonenListeImpl.removeSamePersonByID(id: integer): IPerson;
var
  p : IPerson;
begin
  Result := NIL;

  for p in m_list do begin
    if p.ID = id then begin
      Result := p;
      m_list.Remove(Result);
      break;
    end;
  end;
end;

procedure TPersonenListeImpl.setItems(inx: integer; const value: IPerson);
begin
  m_list[inx] := value;
end;

procedure TPersonenListeImpl.setName(value: string);
begin
  m_name := value;
end;

end.
