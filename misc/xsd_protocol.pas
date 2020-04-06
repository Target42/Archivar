
{*****************************************************************************************************}
{                                                                                                     }
{                                          XML-Datenbindung                                           }
{                                                                                                     }
{         Generiert am: 31.03.2020 16:14:01                                                           }
{       Generiert von: d:\Users\steph\Documents\Embarcadero\Studio\Projekte\BER\client\protocol.xsd   }
{                                                                                                     }
{*****************************************************************************************************}

unit xsd_protocol;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLProtocol = interface;
  IXMLChapter = interface;

{ IXMLProtocol }

  IXMLProtocol = interface(IXMLNodeCollection)
    ['{23ADACC8-79B4-493D-A29E-E40B59BFE776}']
    { Eigenschaftszugriff }
    function Get_Chapter(Index: Integer): IXMLChapter;
    { Methoden & Eigenschaften }
    function Add: IXMLChapter;
    function Insert(const Index: Integer): IXMLChapter;
    property Chapter[Index: Integer]: IXMLChapter read Get_Chapter; default;
  end;

{ IXMLChapter }

  IXMLChapter = interface(IXMLNode)
    ['{DC95AB74-9DF3-49BB-B8B9-145996547194}']
    { Eigenschaftszugriff }
    function Get_Id: Integer;
    function Get_Titel: UnicodeString;
    function Get_Nr: Integer;
    function Get_Gr_id: Integer;
    function Get_Gr_short: UnicodeString;
    procedure Set_Id(Value: Integer);
    procedure Set_Titel(Value: UnicodeString);
    procedure Set_Nr(Value: Integer);
    procedure Set_Gr_id(Value: Integer);
    procedure Set_Gr_short(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Id: Integer read Get_Id write Set_Id;
    property Titel: UnicodeString read Get_Titel write Set_Titel;
    property Nr: Integer read Get_Nr write Set_Nr;
    property Gr_id: Integer read Get_Gr_id write Set_Gr_id;
    property Gr_short: UnicodeString read Get_Gr_short write Set_Gr_short;
  end;

{ Forward-Deklarationen }

  TXMLProtocol = class;
  TXMLChapter = class;

{ TXMLProtocol }

  TXMLProtocol = class(TXMLNodeCollection, IXMLProtocol)
  protected
    { IXMLProtocol }
    function Get_Chapter(Index: Integer): IXMLChapter;
    function Add: IXMLChapter;
    function Insert(const Index: Integer): IXMLChapter;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLChapter }

  TXMLChapter = class(TXMLNode, IXMLChapter)
  protected
    { IXMLChapter }
    function Get_Id: Integer;
    function Get_Titel: UnicodeString;
    function Get_Nr: Integer;
    function Get_Gr_id: Integer;
    function Get_Gr_short: UnicodeString;
    procedure Set_Id(Value: Integer);
    procedure Set_Titel(Value: UnicodeString);
    procedure Set_Nr(Value: Integer);
    procedure Set_Gr_id(Value: Integer);
    procedure Set_Gr_short(Value: UnicodeString);
  end;

{ Globale Funktionen }

function GetProtocol(Doc: IXMLDocument): IXMLProtocol;
function LoadProtocol(const FileName: string): IXMLProtocol;
function NewProtocol: IXMLProtocol;

const
  TargetNamespace = '';

implementation

uses Xml.xmlutil;

{ Globale Funktionen }

function GetProtocol(Doc: IXMLDocument): IXMLProtocol;
begin
  Result := Doc.GetDocBinding('Protocol', TXMLProtocol, TargetNamespace) as TXMLProtocol;
end;

function LoadProtocol(const FileName: string): IXMLProtocol;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Protocol', TXMLProtocol, TargetNamespace) as IXMLProtocol;
end;

function NewProtocol: IXMLProtocol;
begin
  Result := NewXMLDocument.GetDocBinding('Protocol', TXMLProtocol, TargetNamespace) as IXMLProtocol;
end;

{ TXMLProtocol }

procedure TXMLProtocol.AfterConstruction;
begin
  RegisterChildNode('Chapter', TXMLChapter);
  ItemTag := 'Chapter';
  ItemInterface := IXMLChapter;
  inherited;
end;

function TXMLProtocol.Get_Chapter(Index: Integer): IXMLChapter;
begin
  Result := List[Index] as IXMLChapter;
end;

function TXMLProtocol.Add: IXMLChapter;
begin
  Result := AddItem(-1) as IXMLChapter;
end;

function TXMLProtocol.Insert(const Index: Integer): IXMLChapter;
begin
  Result := AddItem(Index) as IXMLChapter;
end;

{ TXMLChapter }

function TXMLChapter.Get_Id: Integer;
begin
  Result := AttributeNodes['id'].NodeValue;
end;

procedure TXMLChapter.Set_Id(Value: Integer);
begin
  SetAttribute('id', Value);
end;

function TXMLChapter.Get_Titel: UnicodeString;
begin
  Result := AttributeNodes['titel'].Text;
end;

procedure TXMLChapter.Set_Titel(Value: UnicodeString);
begin
  SetAttribute('titel', Value);
end;

function TXMLChapter.Get_Nr: Integer;
begin
  Result := AttributeNodes['nr'].NodeValue;
end;

procedure TXMLChapter.Set_Nr(Value: Integer);
begin
  SetAttribute('nr', Value);
end;

function TXMLChapter.Get_Gr_id: Integer;
begin
  Result := AttributeNodes['gr_id'].NodeValue;
end;

procedure TXMLChapter.Set_Gr_id(Value: Integer);
begin
  SetAttribute('gr_id', Value);
end;

function TXMLChapter.Get_Gr_short: UnicodeString;
begin
  Result := AttributeNodes['gr_short'].Text;
end;

procedure TXMLChapter.Set_Gr_short(Value: UnicodeString);
begin
  SetAttribute('gr_short', Value);
end;

end.