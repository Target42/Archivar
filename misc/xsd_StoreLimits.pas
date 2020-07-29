
{************************************************************}
{                                                            }
{                      XML-Datenbindung                      }
{                                                            }
{         Generiert am: 29.07.2020 09:06:29                  }
{       Generiert von: D:\git\ber.git\misc\StoreLimits.xsd   }
{                                                            }
{************************************************************}

unit xsd_StoreLimits;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLStoreLimits = interface;
  IXMLLimit = interface;

{ IXMLStoreLimits }

  IXMLStoreLimits = interface(IXMLNodeCollection)
    ['{56CF5F1B-E9BB-47F6-9B9B-709A45CC41AD}']
    { Eigenschaftszugriff }
    function Get_Limit(Index: Integer): IXMLLimit;
    { Methoden & Eigenschaften }
    function Add: IXMLLimit;
    function Insert(const Index: Integer): IXMLLimit;
    property Limit[Index: Integer]: IXMLLimit read Get_Limit; default;
  end;

{ IXMLLimit }

  IXMLLimit = interface(IXMLNode)
    ['{91CD8F91-544E-4055-8018-423B53459CCF}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Monate: Integer;
    function Get_Rem: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Monate(Value: Integer);
    procedure Set_Rem(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Monate: Integer read Get_Monate write Set_Monate;
    property Rem: UnicodeString read Get_Rem write Set_Rem;
  end;

{ Forward-Deklarationen }

  TXMLStoreLimits = class;
  TXMLLimit = class;

{ TXMLStoreLimits }

  TXMLStoreLimits = class(TXMLNodeCollection, IXMLStoreLimits)
  protected
    { IXMLStoreLimits }
    function Get_Limit(Index: Integer): IXMLLimit;
    function Add: IXMLLimit;
    function Insert(const Index: Integer): IXMLLimit;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLimit }

  TXMLLimit = class(TXMLNode, IXMLLimit)
  protected
    { IXMLLimit }
    function Get_Name: UnicodeString;
    function Get_Monate: Integer;
    function Get_Rem: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Monate(Value: Integer);
    procedure Set_Rem(Value: UnicodeString);
  end;

{ Globale Funktionen }

function GetStoreLimits(Doc: IXMLDocument): IXMLStoreLimits;
function LoadStoreLimits(const FileName: string): IXMLStoreLimits;
function NewStoreLimits: IXMLStoreLimits;

const
  TargetNamespace = '';

implementation

uses Xml.xmlutil;

{ Globale Funktionen }

function GetStoreLimits(Doc: IXMLDocument): IXMLStoreLimits;
begin
  Result := Doc.GetDocBinding('StoreLimits', TXMLStoreLimits, TargetNamespace) as IXMLStoreLimits;
end;

function LoadStoreLimits(const FileName: string): IXMLStoreLimits;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('StoreLimits', TXMLStoreLimits, TargetNamespace) as IXMLStoreLimits;
end;

function NewStoreLimits: IXMLStoreLimits;
begin
  Result := NewXMLDocument.GetDocBinding('StoreLimits', TXMLStoreLimits, TargetNamespace) as IXMLStoreLimits;
end;

{ TXMLStoreLimits }

procedure TXMLStoreLimits.AfterConstruction;
begin
  RegisterChildNode('Limit', TXMLLimit);
  ItemTag := 'Limit';
  ItemInterface := IXMLLimit;
  inherited;
end;

function TXMLStoreLimits.Get_Limit(Index: Integer): IXMLLimit;
begin
  Result := List[Index] as IXMLLimit;
end;

function TXMLStoreLimits.Add: IXMLLimit;
begin
  Result := AddItem(-1) as IXMLLimit;
end;

function TXMLStoreLimits.Insert(const Index: Integer): IXMLLimit;
begin
  Result := AddItem(Index) as IXMLLimit;
end;

{ TXMLLimit }

function TXMLLimit.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLLimit.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLLimit.Get_Monate: Integer;
begin
  Result := AttributeNodes['monate'].NodeValue;
end;

procedure TXMLLimit.Set_Monate(Value: Integer);
begin
  SetAttribute('monate', Value);
end;

function TXMLLimit.Get_Rem: UnicodeString;
begin
  Result := AttributeNodes['rem'].Text;
end;

procedure TXMLLimit.Set_Rem(Value: UnicodeString);
begin
  SetAttribute('rem', Value);
end;

end.