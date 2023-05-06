
{************************************************************}
{                                                            }
{                      XML-Datenbindung                      }
{                                                            }
{         Generiert am: 02.05.2023 21:00:54                  }
{       Generiert von: D:\git\ber.git\misc\Betriebsrat.xsd   }
{                                                            }
{************************************************************}

unit xsd_Betriebsrat;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLBER = interface;
  IXMLGremium = interface;

{ IXMLBER }

  IXMLBER = interface(IXMLNodeCollection)
    ['{A1683D1B-C4E1-4829-BA57-2515F4C835BA}']
    { Eigenschaftszugriff }
    function Get_Gremium(Index: Integer): IXMLGremium;
    { Methoden & Eigenschaften }
    function Add: IXMLGremium;
    function Insert(const Index: Integer): IXMLGremium;
    property Gremium[Index: Integer]: IXMLGremium read Get_Gremium; default;
  end;

{ IXMLGremium }

  IXMLGremium = interface(IXMLNode)
    ['{4648F61F-D247-4598-8F17-F806C3723AE8}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Kurz: UnicodeString;
    function Get_Pkurz: UnicodeString;
    function Get_Pic: UnicodeString;
    function Get_Color: Integer;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Kurz(Value: UnicodeString);
    procedure Set_Pkurz(Value: UnicodeString);
    procedure Set_Pic(Value: UnicodeString);
    procedure Set_Color(Value: Integer);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Kurz: UnicodeString read Get_Kurz write Set_Kurz;
    property Pkurz: UnicodeString read Get_Pkurz write Set_Pkurz;
    property Pic: UnicodeString read Get_Pic write Set_Pic;
    property Color: Integer read Get_Color write Set_Color;
  end;

{ Forward-Deklarationen }

  TXMLBER = class;
  TXMLGremium = class;

{ TXMLBER }

  TXMLBER = class(TXMLNodeCollection, IXMLBER)
  protected
    { IXMLBER }
    function Get_Gremium(Index: Integer): IXMLGremium;
    function Add: IXMLGremium;
    function Insert(const Index: Integer): IXMLGremium;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGremium }

  TXMLGremium = class(TXMLNode, IXMLGremium)
  protected
    { IXMLGremium }
    function Get_Name: UnicodeString;
    function Get_Kurz: UnicodeString;
    function Get_Pkurz: UnicodeString;
    function Get_Pic: UnicodeString;
    function Get_Color: Integer;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Kurz(Value: UnicodeString);
    procedure Set_Pkurz(Value: UnicodeString);
    procedure Set_Pic(Value: UnicodeString);
    procedure Set_Color(Value: Integer);
  end;

{ Globale Funktionen }

function GetBER(Doc: IXMLDocument): IXMLBER;
function LoadBER(const FileName: string): IXMLBER;
function NewBER: IXMLBER;

const
  TargetNamespace = '';

implementation

uses Xml.xmlutil;

{ Globale Funktionen }

function GetBER(Doc: IXMLDocument): IXMLBER;
begin
  Result := Doc.GetDocBinding('BER', TXMLBER, TargetNamespace) as IXMLBER;
end;

function LoadBER(const FileName: string): IXMLBER;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('BER', TXMLBER, TargetNamespace) as IXMLBER;
end;

function NewBER: IXMLBER;
begin
  Result := NewXMLDocument.GetDocBinding('BER', TXMLBER, TargetNamespace) as IXMLBER;
end;

{ TXMLBER }

procedure TXMLBER.AfterConstruction;
begin
  RegisterChildNode('Gremium', TXMLGremium);
  ItemTag := 'Gremium';
  ItemInterface := IXMLGremium;
  inherited;
end;

function TXMLBER.Get_Gremium(Index: Integer): IXMLGremium;
begin
  Result := List[Index] as IXMLGremium;
end;

function TXMLBER.Add: IXMLGremium;
begin
  Result := AddItem(-1) as IXMLGremium;
end;

function TXMLBER.Insert(const Index: Integer): IXMLGremium;
begin
  Result := AddItem(Index) as IXMLGremium;
end;

{ TXMLGremium }

function TXMLGremium.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLGremium.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLGremium.Get_Kurz: UnicodeString;
begin
  Result := AttributeNodes['kurz'].Text;
end;

procedure TXMLGremium.Set_Kurz(Value: UnicodeString);
begin
  SetAttribute('kurz', Value);
end;

function TXMLGremium.Get_Pkurz: UnicodeString;
begin
  Result := AttributeNodes['pkurz'].Text;
end;

procedure TXMLGremium.Set_Pkurz(Value: UnicodeString);
begin
  SetAttribute('pkurz', Value);
end;

function TXMLGremium.Get_Pic: UnicodeString;
begin
  Result := AttributeNodes['pic'].Text;
end;

procedure TXMLGremium.Set_Pic(Value: UnicodeString);
begin
  SetAttribute('pic', Value);
end;

function TXMLGremium.Get_Color: Integer;
begin
  Result := AttributeNodes['color'].NodeValue;
end;

procedure TXMLGremium.Set_Color(Value: Integer);
begin
  SetAttribute('color', Value);
end;

end.