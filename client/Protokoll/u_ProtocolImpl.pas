unit u_ProtocolImpl;

interface

uses
  i_chapter, xsd_protocol, System.Classes, m_protocol, Data.DB,
  Datasnap.DBClient;

type
  TProtocolImpl = class( TInterfacedObject, IProtocol )
  private
    m_proto     : IXMLProtocol;
    m_title     : string;
    m_id        : integer;
    m_clid      : string;
    m_list      : IChapterTitleList;
    m_loader    : TProtocolMod;
    m_grid      : integer;
    m_nr        : integer;
    m_date      : TDateTime;
    m_start     : TDateTime;
    m_ende      : TDateTime;
    m_modified  : boolean;

    m_readOnly  : boolean;
    m_teilnehmer: ITeilnehmerListe;
    m_besucher  : IBesucherListe;

    procedure setXProto( value : IXMLProtocol );
    function  getXProto : IXMLProtocol;

    procedure setID( value : integer );
    function  getID : integer;

    function  getList : IChapterTitleList;
    function  GetTitle: string;
    procedure SetTitle(const Value: string);

    procedure loadFromStream( st : TStream );
    procedure saveToclientBlob( tab : TClientDataSet; FieldName : string );

    function  GetCLID: string;
    procedure SetCLID(const Value: string);

    function  getTeilnehmer : ITeilnehmerListe;
    function  GetGRID: integer;
    procedure SetGRID(const Value: integer);
    function  getRO : boolean;
    procedure setRO( value : boolean );

    procedure saveToStream( st : TStream );
    function  GetNr: integer;
    procedure SetNr(const Value: integer);
    function  GetDate: TDateTime;
    procedure SetDate(const Value: TDateTime);
    procedure setModified( value : boolean );
    function  getModified : boolean;
    function  getBesucher : IBesucherListe;
    procedure setStart( value : TDateTime );
    function  getStart : TDateTime;
    procedure setEnde( value : TDateTime );
    function  getEnde : TDateTime;

    procedure loadBE( ct : IChapterTitle );

  public
    constructor create;
    Destructor Destroy; override;

    function load( id : integer ) : boolean;

    function edit : boolean;
    function cancel : boolean;
    function save : boolean;
    function saveTree : boolean;

    procedure release;
  end;

implementation

uses
  u_ChapterTitleListImpl, Xml.XMLIntf, Xml.XMLDoc, System.SysUtils, m_glob_client,
  u_TTeilnehmerListeImpl, u_BesucherlisteImpl, i_beschluss;

{ TProtocolImpl }


function TProtocolImpl.cancel: boolean;
begin
  with m_loader do
  begin
    if PRTab.State = dsEdit then
      PRTab.Cancel;

    if CPTab.UpdatesPending     then  CPTab.CancelUpdates;
    if CPTextTab.UpdatesPending then  CPTextTab.CancelUpdates;
    if TNTab.UpdatesPending     then  TNTab.CancelUpdates;
    if TGTab.UpdatesPending     then  TGTab.CancelUpdates;
    if PRTab.UpdatesPending     then  PRTab.CancelUpdates;
    if BETab.UpdatesPending     then  BETab.CancelUpdates;

  end;
  Result := true;
end;

constructor TProtocolImpl.create;
begin
  m_proto := NewProtocol;
  m_id    := 0;
  m_grid  := 0;

  m_loader      := TProtocolMod.Create(NIL);
  m_list        := TChapterTitleListImpl.create(m_loader, self);
  m_teilnehmer  := TTeilnehmerListeImpl.create( m_loader, self);
  m_besucher    := TBesucherListeImpl.create(   m_loader, self);
  m_modified    := false;
end;

destructor TProtocolImpl.Destroy;
begin
  m_loader.Free;
  inherited;
end;

function TProtocolImpl.edit: boolean;
begin
  with m_loader do
  begin
    if PRTab.State <> dsEdit then
      PRTab.Edit;
    Result :=PRTab.State = dsEdit;
  end;
end;

function TProtocolImpl.getBesucher: IBesucherListe;
begin
  Result := m_besucher;
end;

function TProtocolImpl.GetCLID: string;
begin
  Result := m_clid;
end;

function TProtocolImpl.GetDate: TDateTime;
begin
  Result := m_date;
end;

function TProtocolImpl.getEnde: TDateTime;
begin
  Result := m_ende;
end;

function TProtocolImpl.GetGRID: integer;
begin
  Result := m_grid;
end;

function TProtocolImpl.getID: integer;
begin
  Result := m_id;
end;

function TProtocolImpl.getList: IChapterTitleList;
begin
  Result := m_list;
end;

function TProtocolImpl.getModified: boolean;
begin
  Result := m_modified;
  with m_loader do
  begin
    Result := Result or PRTab.UpdatesPending;
    Result := Result or CPTab.UpdatesPending;
    Result := Result or TNTab.UpdatesPending;
    Result := Result or TGTab.UpdatesPending;
    Result := Result or CPTextTab.UpdatesPending;
    Result := Result or BETab.UpdatesPending;
  end;
end;

function TProtocolImpl.GetNr: integer;
begin
 Result := m_nr;
end;

function TProtocolImpl.getRO: boolean;
begin
  Result := m_readOnly;
end;

function TProtocolImpl.getStart: TDateTime;
begin
  Result := m_start;
end;

function TProtocolImpl.getTeilnehmer: ITeilnehmerListe;
begin
  Result := m_teilnehmer;
end;

function TProtocolImpl.GetTitle: string;
begin
  Result := m_title;
end;

function TProtocolImpl.getXProto: IXMLProtocol;
begin
  Result := m_proto;
end;

function TProtocolImpl.load(id: integer): boolean;
var
  st  : TStream;
  cp  : IChapterTitle;
begin
  Result := false;
  m_loader.PR_ID := id;
  if m_loader.PRTab.Active then
  begin
    with m_loader do
    begin
      m_title := PRTab.FieldByName('PR_NAME').AsString;
      m_clid  := PRTab.FieldByName('PR_CLID').AsString;
      m_grid  := PRTab.FieldByName('GR_ID').AsInteger;
      m_nr    := PRTab.FieldByName('PR_NR').AsInteger;
      m_date  := PRTab.FieldByName('PR_DATUM').AsDateTime;

      st := getProtocolStream;
      loadFromStream( st );
      st.Free;

      m_teilnehmer.load;
      m_besucher.load;

      while not CPTab.Eof do
      begin
        cp          := m_list.NewEntry;
        cp.ID       := CPTab.FieldByName('CP_ID').AsInteger;
        cp.Text     := CPTab.FieldByName('CP_TITLE').AsString;
        cp.Nr       := CPTab.FieldByName('CP_NR').AsInteger;

        CPTextTab.Filter := 'CP_ID='+intToStr(cp.ID);
        CPTextTab.Filtered := true;

        cp.loadFromDataSet(CPTextTab);

        loadBE( cp );


        CPTab.Next;
      end;
    end;
    Result := true;
  end;
end;

procedure TProtocolImpl.loadBE(ct: IChapterTitle);
var
  i : integer;
  cp : IChapter;
  be : IBeschluss;
begin
  with m_loader do
  begin
    for i := 0 to pred(ct.Count) do
    begin
      cp := ct.Item[i];
      BETab.Filter := 'CT_ID = '+IntToStr( cp.ID);
      BETab.Filtered := true;
      BETab.First;
      while not BETab.Eof do
      begin
        be := cp.Votes.newBeschluss;
        be.loadFromDataSet(BETab);
        BETab.Next;
      end;
    end;
  end;
end;

procedure TProtocolImpl.loadFromStream(st: TStream);
var
  xml: IXMLDocument;
begin
  if not Assigned(st) or ( st.Size = 0) then
  begin
    setXProto(NewProtocol);
  end
  else
  begin
    xml := NewXMLDocument;
    xml.LoadFromStream(st);
    setXProto(  xml.GetDocBinding('Protocol', TXMLProtocol, TargetNamespace) as TXMLProtocol );
  end;
end;

procedure TProtocolImpl.release;
begin
  m_list.release;
  m_teilnehmer.release;
  m_besucher.release;
end;

function TProtocolImpl.save: boolean;
begin
  Result := false;
  with m_loader do
  begin
    try
      if m_modified then
      begin
        if (PRTab.State = dsEdit) or ( PRTab.State = dsInsert) then
        begin
          saveToclientBlob(prTab, 'PR_DATA');
          PRTab.FieldByName('PR_NAME').AsString     := m_title;
          PRTab.FieldByName('PR_NR').AsInteger      := m_nr;
          PRTab.FieldByName('PR_DATUM').AsDateTime  := m_date;

          PRTab.Post;
        end;
      end;

      if PRTab.UpdatesPending     then PRTab.ApplyUpdates(-1);
      if TNTab.UpdatesPending     then TNTab.ApplyUpdates(-1);
      if TGTab.UpdatesPending     then TGTab.ApplyUpdates(-1);
      if CPTab.UpdatesPending     then CPTab.ApplyUpdates(-1);
      if CPTextTab.UpdatesPending then CPTextTab.ApplyUpdates(-1);
      if BETab.UpdatesPending     then
        BETab.ApplyUpdates(-1);

      m_modified := false;
    except
      Result := false;
    end;
  end;
end;

procedure TProtocolImpl.saveToclientBlob(tab: TClientDataSet;
  FieldName: string);
var
  st : TStream;
begin
  st := tab.CreateBlobStream( tab.FieldByName(fieldname), bmWrite );
  SaveToStream(st);
  st.Free;
end;

procedure TProtocolImpl.saveToStream(st: TStream);
begin
  m_proto.OwnerDocument.SaveToStream(st);
end;

function TProtocolImpl.saveTree: boolean;
begin
  saveToclientBlob(m_loader.prTab, 'PR_DATA');
  m_modified := true;
  Result := true;
end;

procedure TProtocolImpl.SetCLID(const Value: string);
begin
  m_clid := value;
  m_modified := true;
end;

procedure TProtocolImpl.SetDate(const Value: TDateTime);
begin
  m_date := value;
  m_modified := true;
end;

procedure TProtocolImpl.setEnde(value: TDateTime);
begin
  m_ende := value;
  m_modified := true;
end;

procedure TProtocolImpl.SetGRID(const Value: integer);
begin
  m_grid := value;
end;

procedure TProtocolImpl.setID(value: integer);
begin
  m_id := value;
  m_modified := true;
end;

procedure TProtocolImpl.setModified(value: boolean);
begin
  m_modified := value;
end;

procedure TProtocolImpl.SetNr(const Value: integer);
begin
  m_nr := value;
  m_modified := true;
end;

procedure TProtocolImpl.setRO(value: boolean);
begin
  m_readOnly := value;
  m_loader.ReadOnly := m_readOnly;
end;

procedure TProtocolImpl.setStart(value: TDateTime);
begin
  m_start := value;
  m_modified := true;
end;

procedure TProtocolImpl.SetTitle(const Value: string);
begin
  m_title := value;
  m_modified := true;
end;

procedure TProtocolImpl.setXProto(value: IXMLProtocol);
begin
  m_proto := value;
  m_modified := true;
end;

end.
