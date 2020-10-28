unit u_ProtocolImpl;

interface

uses
  i_chapter, xsd_protocol, System.Classes;

type
  TProtocolImpl = class( TInterfacedObject, IProtocol )
  private
    m_proto : IXMLProtocol;
    m_id    : integer;
    m_list  : IChapterTitleList;

    procedure setXProto( value : IXMLProtocol );
    function  getXProto : IXMLProtocol;

    procedure setID( value : integer );
    function  getID : integer;

    function  getList : IChapterTitleList;
  public
    constructor create;
    Destructor Destroy; override;

    property XProto : IXMLProtocol      read getXProto  write setXProto;
    property ID     : integer           read getID      write setID;
    property Chapter: IChapterTitleList read getList;

    procedure loadFromStream( st : TStream );
    procedure saveToStream( st : TStream );

    procedure release;
  end;

implementation

uses
  u_ChapterTitleListImpl, Xml.XMLIntf, Xml.XMLDoc;

{ TProtocolImpl }

constructor TProtocolImpl.create;
begin
  m_proto := NewProtocol;
  m_id    := 0;
  m_list  := TChapterTitleListImpl.create;
end;

destructor TProtocolImpl.Destroy;
begin

  inherited;
end;

function TProtocolImpl.getID: integer;
begin
  Result := m_id;
end;

function TProtocolImpl.getList: IChapterTitleList;
begin
  Result := m_list;
end;

function TProtocolImpl.getXProto: IXMLProtocol;
begin
  Result := m_proto;
end;

procedure TProtocolImpl.loadFromStream(st: TStream);
var
  xml: IXMLDocument;
begin
  if not Assigned(st) or ( st.Size = 0) then
  begin
    m_proto := NewProtocol;
  end
  else
  begin
    xml := NewXMLDocument;
    xml.LoadFromStream(st);
    m_proto := xml.GetDocBinding('Protocol', TXMLProtocol, TargetNamespace) as TXMLProtocol;
  end;
end;

procedure TProtocolImpl.release;
begin
  m_list.release;
end;

procedure TProtocolImpl.saveToStream(st: TStream);
begin
  m_proto.OwnerDocument.SaveToStream(st);
end;

procedure TProtocolImpl.setID(value: integer);
begin
  m_id := value;
end;

procedure TProtocolImpl.setXProto(value: IXMLProtocol);
begin
  m_proto := value;
end;

end.
