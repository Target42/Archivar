unit u_TTeilnehmerListeImpl;

interface

uses
  i_chapter, i_personen, System.Generics.Collections, m_protocol, Data.DB;

type
  TTeilnehmerListeImpl = class(TInterfacedObject, ITeilnehmerListe )
    private
      m_proto   : IProtocol;
      m_loader  : TProtocolMod;
      m_list    : TList<ITeilnehmer>;

      function GetCount: integer;

      function GetItem(inx : integer ): ITeilnehmer;
      procedure SetItem(inx : integer; const Value: ITeilnehmer);


      function getByID( id : integer ) : ITeilnehmer;


      procedure clear;
    public
      constructor create(loader : TProtocolMod; proto : IProtocol );
      Destructor Destroy; override;

      procedure init( list : IPersonenListe );
      procedure loadFromSrc( data : TDataSet );
      procedure load;
      procedure saveChanged;

      function newTeilnehmer : ITeilnehmer;
      function getByPEID( id : integer ) : ITeilnehmer;

      procedure release;

  end;

implementation

uses
  u_teilnehmerImpl, System.Variants, u_teilnehmer;

{ TTeilnehmerListeImpl }

procedure TTeilnehmerListeImpl.clear;
var
  t : ITeilnehmer;
begin
  for t in m_list do
    t.release;
  m_list.Clear;
end;

constructor TTeilnehmerListeImpl.create(loader : TProtocolMod; proto : IProtocol );
begin
  m_proto   := proto;
  m_loader  := loader;
  m_list    := TList<ITeilnehmer>.create;
end;

destructor TTeilnehmerListeImpl.Destroy;
begin
  m_list.Free;
  inherited;
end;

function TTeilnehmerListeImpl.getByID(id: integer): ITeilnehmer;
var
  t : ITeilnehmer;
begin
  Result := NIL;
  for t in m_list do
  begin
    if t.ID = id then
    begin
      Result := t;
      break;
    end;
  end;
end;

function TTeilnehmerListeImpl.getByPEID(id: integer): ITeilnehmer;
var
  t : ITeilnehmer;
begin
  Result := NIL;
  for t in m_list do
  begin
    if t.PEID = id then
    begin
      Result := t;
      break;
    end;
  end;
end;

function TTeilnehmerListeImpl.GetCount: integer;
begin
  Result := m_list.Count;
end;

function TTeilnehmerListeImpl.GetItem(inx : integer): ITeilnehmer;
begin
  Result := m_list[inx];
end;

procedure TTeilnehmerListeImpl.init(list: IPersonenListe);
var
  i : integer;
  t : ITeilnehmer;

begin
  for i := 0 to pred(list.count) do
  begin
    t := self.getByPEID(list.Items[i].ID);
    if not Assigned(t) then
    begin
      t := TTeilnehmerImpl.create;
      m_list.Add(t);
      t.Assign(list.Items[i]);
    end;
  end;
end;

procedure TTeilnehmerListeImpl.load;
var
  t : ITeilnehmer;
begin
  clear;
  with m_loader do
  begin
    TNTab.First;
    while not TNTab.Eof do
    begin
      t           := newTeilnehmer;
      t.ID        := TNTabTN_ID.Value;
      t.Name      := TNTabTN_NAME.AsString;
      t.Vorname   := TNTabTN_VORNAME.AsString;
      t.Abteilung := TNTabTN_DEPARTMENT.AsString;
      t.Rolle     := TNTabTN_ROLLE.AsString;
      t.Status    := TTeilnehmerStatus(TNTabTN_STATUS.value);
      t.PEID      := TNTabPE_ID.Value;
      t.Grund     := TNTabTN_GRUND.AsString;
      t.Modified  := false;

      TNTab.Next;
    end;
  end;
end;

procedure TTeilnehmerListeImpl.loadFromSrc(data: TDataSet);
var
  t : ITeilnehmer;
begin
  clear;
  data.First;
  while not data.Eof do
  begin
    t           := newTeilnehmer;
    t.ID        := data.FieldByName('TN_ID').AsInteger;
    t.Name      := data.FieldByName('TN_NAME').AsString;
    t.Vorname   := data.FieldByName('TN_VORNAME').AsString;
    t.Abteilung := data.FieldByName('TN_DEPARTMENT').AsString;
    t.Rolle     := data.FieldByName('TN_ROLLE').AsString;
    t.Status    := TTeilnehmerStatus(data.FieldByName('TN_STATUS').AsInteger);
    t.PEID      := data.FieldByName('PE_ID').Asinteger;
    t.Grund     := data.FieldByName('TN_GRUND').AsString;
    t.Modified  := false;

    data.Next;
  end;
end;

function TTeilnehmerListeImpl.newTeilnehmer: ITeilnehmer;
begin
  Result := TTeilnehmerImpl.create;
  m_list.Add(Result);
end;

procedure TTeilnehmerListeImpl.release;
begin
  clear;
  m_proto := NIL;
end;

procedure TTeilnehmerListeImpl.saveChanged;
var
  t : ITeilnehmer;
begin
  if m_proto.ReadOnly then
    exit;

  for t in m_list do
  begin
    if t.Modified then
    begin
      with m_loader do
      begin
        if t.ID = 0 then
          TNTab.Append
        else
        if TNTab.Locate('TN_ID', VarArrayOf([t.id]), []) then
          TNTab.Edit;

        if (TNTab.State = dsEdit) or  (TNTab.State = dsInsert) then
        begin
          TNTabPR_ID.Value            := m_proto.ID;
          TNTabTN_NAME.AsString       := t.Name;
          TNTabTN_VORNAME.AsString    := t.Vorname;
          TNTabTN_DEPARTMENT.AsString := t.Abteilung;
          TNTabTN_ROLLE.AsString      := t.Rolle;
          TNTabTN_STATUS.Value        := integer(t.Status);
          TNTabPE_ID.Value            := t.PEID;
          TNTabTN_GRUND.AsString      := t.Grund;
          TNTab.Post;
          t.ID := TNTabTN_ID.Value;
        end;

        t.Modified  := false;
      end;
    end;
  end;
end;

procedure TTeilnehmerListeImpl.SetItem(inx : integer; const Value: ITeilnehmer);
begin
  m_list[inx] := value;
end;

end.
