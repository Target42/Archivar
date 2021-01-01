unit u_BeschlussListeImpl;

interface

uses
  i_beschluss, System.Generics.Collections, m_protocol;

type
  TBeschlussListeImpl = class( TInterfacedObject, IBeschlussListe )
  private
    m_list : TList<IBeschluss>;
    m_loader: TProtocolMod;

    function  getItem( inx : integer ) : IBeschluss;
    procedure setItem( inx : integer; const value : IBeschluss);
    function  getCount : integer;

  public
    constructor Create(loader: TProtocolMod);
    Destructor Destroy; override;

    property Item[ inx : integer ]  : IBeschluss  read getItem    write setItem;
    property Count                  : integer     read getCount;

    function  newBeschluss : IBeschluss;
    procedure delete( inx : integer ) ; overload;
    procedure delete( be : IBeschluss); overload;

    procedure saveModified;

    procedure Release;

  end;

implementation

uses
  u_BeschlussImpl, System.Variants;

{ TBeschlussListeImpl }

constructor TBeschlussListeImpl.Create(loader: TProtocolMod);
begin
  m_loader := loader;
  m_list  := TList<IBeschluss>.create;
end;

procedure TBeschlussListeImpl.delete(be: IBeschluss);
var
  id : integer;
begin
  id := be.ID;
  if (id <> 0 ) and m_loader.BETab.Locate('BE_ID', VarArrayOF([id]), []) then
  begin
    m_loader.BETab.Delete;
  end;
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

procedure TBeschlussListeImpl.saveModified;
var
  b : IBeschluss;
begin
  for b in m_list do
  begin
    if b.Modified then
      b.save( m_loader.BETab );
    b.Modified := false;
  end;
end;

procedure TBeschlussListeImpl.setItem(inx: integer; const value: IBeschluss);
begin
  m_list[inx] := value;
end;

end.
