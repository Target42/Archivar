unit u_addInfo;

interface

uses
  xsd_data, Data.DB, Datasnap.DBClient;

type
  TAddinfo = class
  private
    m_info : IXMLAddInfo;
  public

    constructor Create;
    Destructor Destroy; override;

    property Addinfo : IXMLAddInfo read m_info;

    procedure loadFromClientBlob( tab : TClientDataSet; FieldName : string );
    procedure saveToclientBlob( tab : TClientDataSet; FieldName : string );

  end;
implementation

uses
  System.Classes, Xml.XMLDoc, Xml.XMLIntf;


{ TAddinfo }

constructor TAddinfo.Create;
begin
  m_info := NewAddInfo;
end;

destructor TAddinfo.Destroy;
begin

  inherited;
end;

procedure TAddinfo.loadFromClientBlob(tab : TClientDataSet; FieldName : string );
var
  st : TStream;
  xml: IXMLDocument;
begin
  tab.FetchBlobs;
  st := tab.CreateBlobStream( tab.FieldByName(FieldName), bmRead );
  if not Assigned(st) or ( st.Size = 0) then
    m_info := NewAddInfo
  else
  begin
    xml := NewXMLDocument;
    xml.LoadFromStream(st);
    m_info := xml.GetDocBinding('AddInfo', TXMLAddInfo, TargetNamespace) as IXMLAddInfo;
  end;
  if Assigned(st) then
    st.Free;
end;

procedure TAddinfo.saveToclientBlob(tab : TClientDataSet; FieldName : string );
var
  st : TStream;
begin
  st := tab.CreateBlobStream( tab.FieldByName(fieldname), bmWrite );
  m_info.OwnerDocument.SaveToStream(st);
  st.Free;
end;

end.
