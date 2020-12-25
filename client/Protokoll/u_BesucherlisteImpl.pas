unit u_BesucherlisteImpl;

interface

uses
  i_chapter, System.Generics.Collections, m_protocol, System.Variants;

type
  TBesucherListeImpl = class( TInterfacedObject, IBesucherListe )
    private
      m_proto : IProtocol;
      m_list  : TList<IBesucher>;
      m_loader: TProtocolMod;

      function GetCount: integer;

      function GetItem(inx : integer ): IBesucher;
      procedure SetItem(inx : integer; const Value: IBesucher);
    public

      constructor Create(loader : TProtocolMod; proto : IProtocol );
      Destructor Destroy; override;

      function newBesucher : IBesucher;

      procedure load;
      procedure saveChanged;

      procedure remove( b : IBesucher );

      procedure release;

  end;

implementation

uses
  Data.DB, u_BesucherImpl;

{ TBesucherListeImpl }

constructor TBesucherListeImpl.Create(loader: TProtocolMod; proto: IProtocol);
begin
  m_proto := proto;
  m_loader:= loader;
  m_list  := TList<IBesucher>.create;

end;

destructor TBesucherListeImpl.Destroy;
begin
  m_list.Free;
  inherited;
end;

function TBesucherListeImpl.GetCount: integer;
begin
  Result := m_list.Count;
end;

function TBesucherListeImpl.GetItem(inx: integer): IBesucher;
begin
  Result :=  m_list[inx];
end;

procedure TBesucherListeImpl.load;
var
  b : IBesucher;
begin
  with m_loader do
  begin
    TGTab.First;
    while not TGTab.Eof do
    begin
      b           := self.newBesucher;
      b.Name      := TGTab.FieldByName('TG_NAME').AsString;
      b.Vorname   := TGTab.FieldByName('TG_VORNAME').AsString;
      b.Abteilung := TGTab.FieldByName('TG_DEPARTMENT').AsString;
      b.Von       := TGTab.FieldByName('TG_VON').AsDateTime;
      b.bis       := TGTab.FieldByName('TG_BIS').AsDateTime;
      b.Grund     := TGTab.FieldByName('TG_GRUND').AsString;
      b.id        := TGTab.FieldByName('TG_ID').AsInteger;
      TGTab.Next;
    end;
  end;
end;

function TBesucherListeImpl.newBesucher: IBesucher;
begin
  Result := TBesucherImpl.create;
  m_list.Add(Result);
end;

procedure TBesucherListeImpl.release;
var
  b : IBesucher;
begin
  m_proto := NIL;
  for b in m_list do
    b.release;
  m_list.clear;
end;

procedure TBesucherListeImpl.remove(b: IBesucher);
begin
  if m_proto.ReadOnly then
    exit;

  if b.id <> 0  then
  begin
    if m_loader.TGTab.Locate('TG_ID', VarArrayOf([b.id]), [] ) then
      m_loader.TGTab.Delete;
  end;
  m_list.Remove(b);
  b.release;
end;

procedure TBesucherListeImpl.saveChanged;
var
  b : IBesucher;
begin
  if m_proto.ReadOnly then
    exit;
  for b in m_list do
  begin
    with m_loader do
    begin
      if b.id = 0 then
        TGTab.Append
      else
      begin
        if TGTab.Locate('TG_ID', VarArrayOf([b.id]), [] ) then
          TGTab.Edit;
      end;
      if (TGTab.State = dsEdit) or (TGTab.State = dsInsert) then
      begin
        TGTab.FieldByName('PR_ID').AsInteger        := m_proto.ID;
        TGTab.FieldByName('TG_NAME').AsString       := b.Name;
        TGTab.FieldByName('TG_VORNAME').AsString    := b.Vorname;
        TGTab.FieldByName('TG_DEPARTMENT').AsString := b.Abteilung;
        TGTab.FieldByName('TG_VON').AsDateTime      := b.Von;
        TGTab.FieldByName('TG_BIS').AsDateTime      := b.bis;
        TGTab.FieldByName('TG_GRUND').AsString      := b.Grund;
        TGTab.Post;

        b.id := TGTab.FieldByName('TG_ID').AsInteger;
      end;
      b.Modified := false;

    end;


  end;


end;

procedure TBesucherListeImpl.SetItem(inx: integer; const Value: IBesucher);
begin
  m_list[inx] := value;
end;

end.
