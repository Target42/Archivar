unit u_AbstimmungenImpl;

interface

uses
  i_beschluss, System.Generics.Collections;

type
  TAbstimmungenImpl = class( TInterfacedObject, IAbstimmungen )
    private
      m_list : Tlist<IAbStimmung>;

      function getCount : integer;
      procedure setItems( inx : integer ; const value : IAbstimmung );
      function  getItems( inx : integer ) : IAbStimmung;
    public
      constructor create;
      Destructor Destroy; override;

      function newAbstimmung : IAbStimmung;

      procedure Release;
  end;

implementation

uses
  u_AbstimmungImpl;

{ TAbstimmungenImpl }

constructor TAbstimmungenImpl.create;
begin
  m_list := Tlist<IAbStimmung>.create;
end;

destructor TAbstimmungenImpl.Destroy;
begin
  m_list.Free;
  inherited;
end;

function TAbstimmungenImpl.getCount: integer;
begin
  Result := m_list.Count;
end;

function TAbstimmungenImpl.getItems(inx: integer): IAbStimmung;
begin
  Result := m_list[inx];
end;

function TAbstimmungenImpl.newAbstimmung: IAbStimmung;
begin
  Result := TAbstimmungImpl.create;
  m_list.Add(Result);
end;

procedure TAbstimmungenImpl.Release;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
    m_list[i].Release;
  m_list.Clear;

end;

procedure TAbstimmungenImpl.setItems(inx: integer; const value: IAbstimmung);
begin
  m_list[inx] := value;
end;

end.
