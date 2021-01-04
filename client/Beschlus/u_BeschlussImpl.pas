unit u_BeschlussImpl;

interface

uses
  i_beschluss, u_AbstimmungImpl, Data.DB, xsd_TaskData, i_personen;

type
  TBeschlussImpl = class(TInterfacedObject, IBeschluss )
    private
      m_id        : integer;
      m_ctid      : integer;
      m_text      : string;
      m_vote      : IAbstimmung;
      m_status    : TBeschlussStatus;
      m_modified  : boolean;
      m_xList     : IXMLList;

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
      procedure setData( value : IXMLList );
      function  getData : IXMLList;

      procedure addHeader( tab :IXMLTable );
      procedure addTable( name : string ;  list : IPersonenListe );
      function findTable( name : string ) :IXMLTable;
      procedure ReadTable( name : string ;  list : IPersonenListe );

    public
      constructor create;
      destructor Destroy; override;

      procedure loadFromDataSet( data : TDataSet );
      procedure save( data : TDataSet );

      procedure Release;
  end;

implementation

uses
  System.Variants, System.SysUtils;

{ TBeschlussImpl }

procedure TBeschlussImpl.addHeader(tab: IXMLTable);
  procedure add( header, field  : string );
  var
    xdf : IXMLField;
  begin
    xdf := tab.Header.Add;
    xdf.Field   := field;
    xdf.Header  := header;
    xdf.Width   := 100;
  end;
begin
  Add('NAME',       'NAME');
  Add('VORNAME',    'VORNAME');
  Add('ABTEILUNG',  'ABTEILUNG');
  Add('ROLLE',      'ROLLE');
end;

procedure TBeschlussImpl.addTable(name: string; list: IPersonenListe);
var
  xTab : IXMLTable;
  procedure addRow( row : IXMLRow; pe : IPerson );
  begin
    row.Add(pe.Name);
    row.Add(pe.Vorname);
    row.Add(pe.Abteilung);
    row.Add(pe.Rolle);
  end;
var
  i : integer;
begin
  if not Assigned(list) then
    exit;

  xTab := m_xList.Tables.Add;
  xTab.Field := name;
  addHeader(xTab);
  for i := 0 to pred(list.count) do
    addRow(xTab.Rows.Add, list.Items[i]);
end;

constructor TBeschlussImpl.create;
begin
  m_vote    := TAbstimmungImpl.create;
  m_status  := bsGeplant;
  m_ID      := 0;
  m_ctid    := 0;
  m_xList   := NIL;
end;

destructor TBeschlussImpl.Destroy;
begin
  m_vote := NIL;
  inherited;
end;

function TBeschlussImpl.findTable(name: string): IXMLTable;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(m_xList.Tables.Count) do
  begin
    if SameText(name, m_xList.Tables.Table[i].Field) then
    begin
      Result := m_xList.Tables.Table[i];
      break;
    end;
  end;
end;

function TBeschlussImpl.getAbstimmung: IAbstimmung;
begin
  Result := m_vote;
end;

function TBeschlussImpl.GetCTID: integer;
begin
  Result := m_ctid;
end;

function TBeschlussImpl.getData: IXMLList;
  procedure addVal( name, data : string ); overload;
  var
    xdf : IXMLField;
  begin
    xdf := m_xList.Values.Add;
    xdf.Field := name;
    xdf.Value := data;
  end;
  procedure addVal( name: string;  data : integer ); overload;
  var
    xdf : IXMLField;
  begin
    xdf := m_xList.Values.Add;
    xdf.Field := name;
    xdf.Value := IntToStr(data);
  end;
begin
  m_xList := NewList;

  AddTable( 'TAB_TEILNEHMER',   m_vote.Gremium );

  addVal('VOTE_ZUSTIMMUNG',     m_vote.Zustimmung);
  addVal('VOTE_ABLEHNUNG',      m_vote.Abgelehnt);
  addVal('VOTE_ENTHALTUNGEN',   m_vote.Enthalten);
  addVal('VOTE_ERGEBNIS',       BeschlussStatusToStr(m_status));
  addVal('VOTE_DATUM',          DateToStr(m_vote.Zeitpunkt));
  addVal('VOTE_ZEIT',           FormatDateTime('hh:mm',  m_vote.Zeitpunkt));
  addVal('VOTE_SUMME',          m_vote.Zustimmung + m_vote.Abgelehnt + m_vote.Enthalten );
  addVal('VOTE_TEXT',           m_text );


  Result := m_xList;
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

procedure TBeschlussImpl.ReadTable(name: string; list: IPersonenListe);
var
  i     : integer;
  xTab  : IXMLTable;
  xRow  : IXMLRow;
  pe    : IPerson;
begin
  if not Assigned(list) then
    exit;

  xTab := findTable(name);
  if not Assigned(xTab) then
    exit;

  for i := 0 to pred(xTab.Rows.Count) do
  begin
    xRow := xTab.Rows.Row[i];
    pe   := list.newPerson;
    pe.Name     := xRow.Value[0];
    pe.Vorname  := xRow.Value[1];
    pe.Abteilung:= xRow.Value[2];
    pe.Rolle    := xRow.Value[3];
  end;
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

procedure TBeschlussImpl.setData(value: IXMLList);
  function getField(name : string ) : IXMLField;
  var
    i : integer;
  begin
    Result := NIL;
    for i := 0 to pred(m_xList.Values.Count) do
    begin
      if SameText(name, m_xList.Values.Field[i].Field) then
      begin
        Result := m_xList.Values.Field[i];
        break;
      end;
    end;
  end;
  function getInt( name : string) : integer;
  var
    xValue  : IXMLField;
  begin
    Result := 0;
    xValue := getField(name);
    if Assigned(xValue) then
      Result := StrToIntDef( xValue.Value, 0);
  end;
  function getStr( name : string ) : string;
  var
    xValue  : IXMLField;
  begin
    Result := '';
    xValue := getField(name);
    if Assigned(xValue) then
      Result := xValue.Value;
  end;
var
  da : TDateTime;
begin
  m_xList := value;

  m_vote.Zustimmung   := getInt('VOTE_ZUSTIMMUNG');
  m_vote.Abgelehnt    := getInt('VOTE_ABLEHNUNG');
  m_vote.Enthalten    := getInt('VOTE_ENTHALTUNGEN');

  m_text              := getStr('VOTE_TEXT');
  m_status            := StrToBeschlussStatus(getStr('VOTE_ERGEBNIS'));

  da := 0.0;
  TryStrToDate(getStr('VOTE_DATUM'), da);
  m_vote.Zeitpunkt := da;
  TryStrToDate(getStr('VOTE_ZEIT'), da);
  m_vote.Zeitpunkt := m_vote.Zeitpunkt + da;

  ReadTable('TAB_TEILNEHMER',       m_vote.Gremium );
  ReadTable('TAB_ABWESENDE',        m_vote.Abwesend );
  ReadTable('TAB_NICHT_ABGESTIMMT', m_vote.NichtAbgestimmt );

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
