
{*******************************************************}
{                                                       }
{                   XML-Datenbindung                    }
{                                                       }
{         Generiert am: 30.09.2020 19:30:36             }
{       Generiert von: D:\git\ber.git\misc\Styles.xsd   }
{                                                       }
{*******************************************************}

unit xsd_Styles;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLStyles = interface;
  IXMLStyle = interface;

{ IXMLStyles }

  IXMLStyles = interface(IXMLNodeCollection)
    ['{6C48BCDC-1C2D-476A-BC88-05CE832CA64F}']
    { Eigenschaftszugriff }
    function Get_Def: UnicodeString;
    function Get_Style(Index: Integer): IXMLStyle;
    procedure Set_Def(Value: UnicodeString);
    { Methoden & Eigenschaften }
    function Add: IXMLStyle;
    function Insert(const Index: Integer): IXMLStyle;
    property Def: UnicodeString read Get_Def write Set_Def;
    property Style[Index: Integer]: IXMLStyle read Get_Style; default;
  end;

{ IXMLStyle }

  IXMLStyle = interface(IXMLNode)
    ['{AC23D712-4539-41D3-9FE3-870DA92710F7}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Clid: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Clid(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Clid: UnicodeString read Get_Clid write Set_Clid;
  end;

{ Forward-Deklarationen }

  TXMLStyles = class;
  TXMLStyle = class;

{ TXMLStyles }

  TXMLStyles = class(TXMLNodeCollection, IXMLStyles)
  protected
    { IXMLStyles }
    function Get_Def: UnicodeString;
    function Get_Style(Index: Integer): IXMLStyle;
    procedure Set_Def(Value: UnicodeString);
    function Add: IXMLStyle;
    function Insert(const Index: Integer): IXMLStyle;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLStyle }

  TXMLStyle = class(TXMLNode, IXMLStyle)
  protected
    { IXMLStyle }
    function Get_Name: UnicodeString;
    function Get_Clid: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Clid(Value: UnicodeString);
  end;

{ Globale Funktionen }

function GetStyles(Doc: IXMLDocument): IXMLStyles;
function LoadStyles(const FileName: string): IXMLStyles;
function NewStyles: IXMLStyles;

const
  TargetNamespace = '';

implementation



{ Globale Funktionen }

function GetStyles(Doc: IXMLDocument): IXMLStyles;
begin
  Result := Doc.GetDocBinding('Styles', TXMLStyles, TargetNamespace) as IXMLStyles;
end;

function LoadStyles(const FileName: string): IXMLStyles;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Styles', TXMLStyles, TargetNamespace) as IXMLStyles;
end;

function NewStyles: IXMLStyles;
begin
  Result := NewXMLDocument.GetDocBinding('Styles', TXMLStyles, TargetNamespace) as IXMLStyles;
end;

{ TXMLStyles }

procedure TXMLStyles.AfterConstruction;
begin
  RegisterChildNode('Style', TXMLStyle);
  ItemTag := 'Style';
  ItemInterface := IXMLStyle;
  inherited;
end;

function TXMLStyles.Get_Def: UnicodeString;
begin
  Result := AttributeNodes['def'].Text;
end;

procedure TXMLStyles.Set_Def(Value: UnicodeString);
begin
  SetAttribute('def', Value);
end;

function TXMLStyles.Get_Style(Index: Integer): IXMLStyle;
begin
  Result := List[Index] as IXMLStyle;
end;

function TXMLStyles.Add: IXMLStyle;
begin
  Result := AddItem(-1) as IXMLStyle;
end;

function TXMLStyles.Insert(const Index: Integer): IXMLStyle;
begin
  Result := AddItem(Index) as IXMLStyle;
end;

{ TXMLStyle }

function TXMLStyle.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLStyle.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLStyle.Get_Clid: UnicodeString;
begin
  Result := AttributeNodes['clid'].Text;
end;

procedure TXMLStyle.Set_Clid(Value: UnicodeString);
begin
  SetAttribute('clid', Value);
end;

end.