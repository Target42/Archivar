unit u_BeschlussImpl;

interface

uses
  i_beschluss, u_AbstimmungImpl, Data.DB;

type
  TBeschlussImpl = class(TInterfacedObject, IBeschluss )
    private
      m_id    : integer;
      m_ctid  : integer;
      m_text  : string;
      m_vote  : IAbstimmung;
      m_status: TBeschlussStatus;
      m_modified : boolean;

      procedure setText( value : string );
      function  getText : string;
      function  getAbstimmung : IAbstimmung;
      function  getTitel : string;
      function  GetStatus: TBeschlussStatus;
      procedure SetStatus(const Value: TBeschlussStatus);
      function  GetModified: boolean;
      procedure SetModified(const Value: boolean);
      function  GetID: integer;
      procedure SetID(const Value: integer);
      function  GetCTID: integer;
      procedure SetCTID(const Value: integer);
    public
      constructor create;
      destructor Destroy; override;

      procedure loadFromDataSet( data : TDataSet );
      procedure save( data : TDataSet );

      procedure Release;
  end;

implementation

uses
  System.Variants;

{ TBeschlussImpl }

constructor TBeschlussImpl.create;
begin
  m_vote    := TAbstimmungImpl.create;
  m_status  := bsGeplant;
  m_ID      := 0;
  m_ctid    := 0;
end;

destructor TBeschlussImpl.Destroy;
begin
  m_vote := NIL;
  inherited;
end;

function TBeschlussImpl.getAbstimmung: IAbstimmung;
begin
  Result := m_vote;
end;

function TBeschlussImpl.GetCTID: integer;
begin
  Result := m_ctid;
end;

function TBeschlussImpl.GetID: integer;
begin
  Result := m_id;
end;

function TBeschlussImpl.GetModified: boolean;
begin
  Result := m_modified or m_vote.Modified;
end;

function TBeschlussImpl.GetStatus: TBeschlussStatus;
begin
  Result := m_status;
end;

function TBeschlussImpl.getText: string;
begin
  Result := m_text;
end;

function TBeschlussImpl.getTitel: string;
begin
  Result := BeschlussStatusToStr(m_status);
end;

procedure TBeschlussImpl.loadFromDataSet(data: TDataSet);
begin
  m_id              := data.FieldByName('BE_ID').AsInteger;
  m_id              := data.FieldByName('CT_ID').AsInteger;
  m_status          := StrToBeschlussStatus(data.FieldByName('BE_TITEL').AsString);
  m_vote.Zustimmung := data.FieldByName('BE_JA').AsInteger;
  m_vote.Abgelehnt  := data.FieldByName('BE_NEIN').AsInteger;
  m_vote.Enthalten  := data.FieldByName('BE_UN').AsInteger;
  m_vote.Zeitpunkt  := data.FieldByName('BE_TIMESTAMP').AsDateTime;
  m_modified        := false;
end;

procedure TBeschlussImpl.Release;
begin
  m_vote.Release;
end;

procedure TBeschlussImpl.save(data: TDataSet);
begin
  if m_ID = 0 then
    data.Append
  else
    if data.Locate('BE_ID', VarArrayOf([m_id]), []) then
      data.Edit;

  if (data.State = dsEdit) or ( data.State = dsInsert) then
  begin
    data.FieldByName('CT_ID').AsInteger         := m_ctid;
    data.FieldByName('BE_TITEL').AsString       := BeschlussStatusToStr(m_status);
    data.FieldByName('BE_JA').AsInteger         := m_vote.Zustimmung;
    data.FieldByName('BE_NEIN').AsInteger       := m_vote.Abgelehnt;
    data.FieldByName('BE_UN').AsInteger         := m_vote.Enthalten;
    data.FieldByName('BE_TIMESTAMP').AsDateTime := m_vote.Zeitpunkt;
    data.Post;
  end;
  m_id := data.FieldByName('BE_ID').AsInteger;

  SetModified(false);
end;

procedure TBeschlussImpl.SetCTID(const Value: integer);
begin
  m_ctid := value;
  m_modified := true;
end;

procedure TBeschlussImpl.SetID(const Value: integer);
begin
  m_id := value;
  m_modified := true;
end;

procedure TBeschlussImpl.SetModified(const Value: boolean);
begin
  m_modified      := value;
  m_vote.Modified := value;
end;

procedure TBeschlussImpl.SetStatus(const Value: TBeschlussStatus);
begin
  m_status := value;
  m_modified := true;
end;

procedure TBeschlussImpl.setText(value: string);
begin
  m_text := value;
  m_modified := true;
end;

end.
