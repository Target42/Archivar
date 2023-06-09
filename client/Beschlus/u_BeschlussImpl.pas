unit u_BeschlussImpl;

interface

uses
  i_beschluss, u_AbstimmungImpl, Data.DB, xsd_TaskData, i_personen;

type
  TBeschlussImpl = class(TInterfacedObject, IBeschluss )
    private
      m_owner     : IBeschlussListe;
      m_id        : integer;
      m_ctid      : integer;
      m_text      : string;
      m_vote      : IAbstimmung;
      m_status    : TBeschlussStatus;
      m_modified  : boolean;
      m_xList     : IXMLList;

      m_readOnly  : boolean;
      m_timeStamp : TDateTime;

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
      procedure setOwner( value : IBeschlussListe );
      function  getOwner : IBeschlussListe;
      function GetReadOnly: boolean;
      procedure SetReadOnly(const Value: boolean);


      procedure addHeader( tab :IXMLTable );
      procedure addTable( name : string ;  list : IPersonenListe );
      function findTable( name : string ) :IXMLTable;
      procedure ReadTable( name : string ;  list : IPersonenListe );

    public
      constructor create(owner : IBeschlussListe);
      destructor Destroy; override;


      procedure loadFromDataSet( data : TDataSet );
      procedure save( data : TDataSet );

      procedure setGremium( gremium : IPersonenListe );

      procedure Release;

      function clone : IBeschluss;
      procedure Assign( org : IBeschluss );

      procedure calcStatus;
  end;

implementation

uses
  System.Variants, System.SysUtils, System.Classes, Xml.XMLIntf, Xml.XMLDoc;

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

procedure TBeschlussImpl.Assign(org: IBeschluss);
var
  src : TBeschlussImpl;
begin
  if not Assigned(org) or not (org is TBeschlussImpl) then
    exit;

  src := org as TBeschlussImpl;

  m_status    := src.m_status;
  m_id        := src.m_id;
  m_ctid      := src.m_ctid;
  m_xList     := src.m_xList;

  if Assigned(m_vote) then
    m_vote.Release;

  m_vote      := src.m_vote.clone;
  m_text      := src.m_text;
  m_readOnly  := src.m_readOnly;
  m_timeStamp := src.m_timeStamp;
end;

procedure TBeschlussImpl.calcStatus;
begin

end;

function TBeschlussImpl.clone: IBeschluss;
var
  dest : TBeschlussImpl;
begin
  dest              := TBeschlussImpl.create( NIL );
  dest.m_status     := m_status;
  dest.m_id         := m_id;
  dest.m_ctid       := m_ctid;
  if Assigned(m_xList) then
    dest.m_xList    := m_xList.CloneNode(true) as IXMLList;
  dest.m_vote.Release;
  dest.m_vote       := m_vote.clone;
  dest.m_text       := m_text;
  dest. m_readOnly  := m_readOnly;
  dest.m_timeStamp  := m_timeStamp;


  Result            := dest;
end;

constructor TBeschlussImpl.create(owner : IBeschlussListe);
begin
  m_owner   := owner;
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
    xdf       : IXMLField;
  begin
    xdf       := m_xList.Values.Add;
    xdf.Field := name;
    xdf.Value := IntToStr(data);
  end;
begin
  m_xList     := NewList;

  AddTable( 'BE_TAB_TEILNEHMER',       m_vote.Gremium );
  AddTable( 'BE_TAB_NICHT_ABGESTIMMT', m_vote.NichtAbgestimmt);
  AddTable( 'BE_TAB_ABWESENDE',        m_vote.Abwesend );

  addVal('BE_ZUSTIMMUNG',     m_vote.Zustimmung);
  addVal('BE_ABLEHNUNG',      m_vote.Abgelehnt);
  addVal('BE_ENTHALTUNGEN',   m_vote.Enthalten);
  addVal('BE_ERGEBNIS',       BeschlussStatusToStr(m_status));
  addVal('BE_DATUM',          DateToStr(m_vote.Zeitpunkt));
  addVal('BE_ZEIT',           FormatDateTime('hh:mm',  m_vote.Zeitpunkt));
  addVal('BE_SUMME',          m_vote.Zustimmung + m_vote.Abgelehnt + m_vote.Enthalten );
  addVal('BE_TEXT',           m_text );


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

function TBeschlussImpl.getOwner: IBeschlussListe;
begin
  Result := m_owner;
end;

function TBeschlussImpl.GetReadOnly: boolean;
begin
  Result := m_readOnly;
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
var
  xList : IXMLList;
  st    : TStream;
  procedure loadXML;

  var
    xml: IXMLDocument;
  begin
    xList := NewList;
    try
      if st.Size <> 0 then
      begin
        xml := NewXMLDocument;
        xml.LoadFromStream(st);
        xList := xml.GetDocBinding('List', TXMLList, TargetNamespace) as IXMLList;
      end;
    except

    end;
  end;

begin
  st := data.CreateBlobStream(data.FieldByName('BE_DATA'), bmRead);
  loadXML;
  st.Free;
  self.setData(xList);

  m_id              := data.FieldByName('BE_ID').AsInteger;
  m_ctid            := data.FieldByName('CT_ID').AsInteger;
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

  if (list.count > 0) and ( xTab.Rows.Count > 0 ) then
    list.release;

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
  m_owner := NIL;
  m_vote.Release;
  m_vote := NIL;
end;

procedure TBeschlussImpl.save(data: TDataSet);
var
  xml : IXMLList;
  st  : TStream;
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

    xml := getData;

    st := data.CreateBlobStream( data.FieldByName('BE_DATA'), bmWrite );
    xml.OwnerDocument.SaveToStream(st);
    st.free;

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

  m_vote.Zustimmung   := getInt('BE_ZUSTIMMUNG');
  m_vote.Abgelehnt    := getInt('BE_ABLEHNUNG');
  m_vote.Enthalten    := getInt('BE_ENTHALTUNGEN');

  m_text              := getStr('BE_TEXT');
  m_status            := StrToBeschlussStatus(getStr('BE_ERGEBNIS'));

  da := 0.0;
  TryStrToDate(getStr('BE_DATUM'), da);
  m_vote.Zeitpunkt := da;
  TryStrToDate(getStr('BE_ZEIT'), da);
  m_vote.Zeitpunkt := m_vote.Zeitpunkt + da;

  ReadTable('BE_TAB_TEILNEHMER',       m_vote.Gremium );
  ReadTable('BE_TAB_ABWESENDE',        m_vote.Abwesend );
  ReadTable('BE_TAB_NICHT_ABGESTIMMT', m_vote.NichtAbgestimmt );

end;

procedure TBeschlussImpl.setGremium(gremium: IPersonenListe);
begin
  if Assigned(m_vote.Gremium) then
    m_vote.Gremium.release;
  m_vote.Gremium := gremium;
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

procedure TBeschlussImpl.setOwner(value: IBeschlussListe);
begin
  m_owner := value;
end;

procedure TBeschlussImpl.SetReadOnly(const Value: boolean);
begin
  m_readOnly := value;
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
