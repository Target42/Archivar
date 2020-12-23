unit u_BeschlussListeImpl;

interface

uses
  i_beschluss, System.Generics.Collections;

type
  TBeschlussListeImpl = class( TInterfacedObject, IBeschlussListe )
  private
    m_list : TList<IBeschluss>;

    function  getItem( inx : integer ) : IBeschluss;
    procedure setItem( inx : integer; const value : IBeschluss);
    function  getCount : integer;

  public
    constructor Create;
    Destructor Destroy; override;

    property Item[ inx : integer ]  : IBeschluss  read getItem    write setItem;
    property Count                  : integer     read getCount;

    function  newBeschluss : IBeschluss;
    procedure delete( inx : integer ) ; overload;
    procedure delete( be : IBeschluss); overload;

    procedure Release;

  end;

implementation

uses
  u_BeschlussImpl;

{ TBeschlussListeImpl }

constructor TBeschlussListeImpl.Create;
begin
  m_list := TList<IBeschluss>.create;
end;

procedure TBeschlussListeImpl.delete(be: IBeschluss);
begin
  m_list.Remove(be);
  be.Release;
end;

procedure TBeschlussListeImpl.delete(inx: integer);
begin
  m_list[inx].Release;
  m_list.Delete(inx);
end;

destructor TBeschlussListeImpl.Destroy;
begin
  m_list.Free;
  inherited;
end;

function TBeschlussListeImpl.getCount: integer;
begin
  Result := m_list.Count;
end;

function TBeschlussListeImpl.getItem(inx: integer): IBeschluss;
begin
  Result := m_list[inx];
end;

function TBeschlussListeImpl.newBeschluss: IBeschluss;
begin
  Result := TBeschlussImpl.create;
  m_list.Add(Result);
end;

procedure TBeschlussListeImpl.Release;
var
  b : IBeschluss;
begin
  for b in m_list do
    b.Release;
  m_list.Clear;

end;

procedure TBeschlussListeImpl.setItem(inx: integer; const value: IBeschluss);
begin
  m_list[inx] := value;
end;

end.
