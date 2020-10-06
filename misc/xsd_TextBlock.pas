
{**********************************************************}
{                                                          }
{                     XML-Datenbindung                     }
{                                                          }
{         Generiert am: 13.09.2020 17:17:05                }
{       Generiert von: D:\git\ber.git\misc\TextBlock.xsd   }
{                                                          }
{**********************************************************}

unit xsd_TextBlock;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLBlock = interface;
  IXMLFields = interface;
  IXMLField = interface;

{ IXMLBlock }

  IXMLBlock = interface(IXMLNode)
    ['{915691DF-2FAD-4029-8264-73FF971EC411}']
    { Eigenschaftszugriff }
    function Get_Id: UnicodeString;
    function Get_Name: UnicodeString;
    function Get_Content: UnicodeString;
    function Get_Rem: UnicodeString;
    function Get_Tags: UnicodeString;
    function Get_Fields: IXMLFields;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Content(Value: UnicodeString);
    procedure Set_Rem(Value: UnicodeString);
    procedure Set_Tags(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Id: UnicodeString read Get_Id write Set_Id;
    property Name: UnicodeString read Get_Name write Set_Name;
    property Content: UnicodeString read Get_Content write Set_Content;
    property Rem: UnicodeString read Get_Rem write Set_Rem;
    property Tags: UnicodeString read Get_Tags write Set_Tags;
    property Fields: IXMLFields read Get_Fields;
  end;

{ IXMLFields }

  IXMLFields = interface(IXMLNodeCollection)
    ['{36971FAD-D480-4327-99DE-CAF7CBD410B1}']
    { Eigenschaftszugriff }
    function Get_Field(Index: Integer): IXMLField;
    { Methoden & Eigenschaften }
    function Add: IXMLField;
    function Insert(const Index: Integer): IXMLField;
    property Field[Index: Integer]: IXMLField read Get_Field; default;
  end;

{ IXMLField }

  IXMLField = interface(IXMLNode)
    ['{71A80642-C08B-4A37-9DF6-BF330216F6E8}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Caption: UnicodeString;
    function Get_Fieldtype: UnicodeString;
    function Get_Rem: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Caption(Value: UnicodeString);
    procedure Set_Fieldtype(Value: UnicodeString);
    procedure Set_Rem(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Caption: UnicodeString read Get_Caption write Set_Caption;
    property Fieldtype: UnicodeString read Get_Fieldtype write Set_Fieldtype;
    property Rem: UnicodeString read Get_Rem write Set_Rem;
  end;

{ Forward-Deklarationen }

  TXMLBlock = class;
  TXMLFields = class;
  TXMLField = class;

{ TXMLBlock }

  TXMLBlock = class(TXMLNode, IXMLBlock)
  protected
    { IXMLBlock }
    function Get_Id: UnicodeString;
    function Get_Name: UnicodeString;
    function Get_Content: UnicodeString;
    function Get_Rem: UnicodeString;
    function Get_Tags: UnicodeString;
    function Get_Fields: IXMLFields;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Content(Value: UnicodeString);
    procedure Set_Rem(Value: UnicodeString);
    procedure Set_Tags(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFields }

  TXMLFields = class(TXMLNodeCollection, IXMLFields)
  protected
    { IXMLFields }
    function Get_Field(Index: Integer): IXMLField;
    function Add: IXMLField;
    function Insert(const Index: Integer): IXMLField;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLField }

  TXMLField = class(TXMLNode, IXMLField)
  protected
    { IXMLField }
    function Get_Name: UnicodeString;
    function Get_Caption: UnicodeString;
    function Get_Fieldtype: UnicodeString;
    function Get_Rem: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Caption(Value: UnicodeString);
    procedure Set_Fieldtype(Value: UnicodeString);
    procedure Set_Rem(Value: UnicodeString);
  end;

{ Globale Funktionen }

function GetBlock(Doc: IXMLDocument): IXMLBlock;
function LoadBlock(const FileName: string): IXMLBlock;
function NewBlock: IXMLBlock;

const
  TargetNamespace = '';

implementation

uses Xml.xmlutil;

{ Globale Funktionen }

function GetBlock(Doc: IXMLDocument): IXMLBlock;
begin
  Result := Doc.GetDocBinding('Block', TXMLBlock, TargetNamespace) as IXMLBlock;
end;

function LoadBlock(const FileName: string): IXMLBlock;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Block', TXMLBlock, TargetNamespace) as IXMLBlock;
end;

function NewBlock: IXMLBlock;
begin
  Result := NewXMLDocument.GetDocBinding('Block', TXMLBlock, TargetNamespace) as IXMLBlock;
end;

{ TXMLBlock }

procedure TXMLBlock.AfterConstruction;
begin
  RegisterChildNode('Fields', TXMLFields);
  inherited;
end;

function TXMLBlock.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLBlock.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLBlock.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLBlock.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLBlock.Get_Content: UnicodeString;
begin
  Result := ChildNodes['Content'].Text;
end;

procedure TXMLBlock.Set_Content(Value: UnicodeString);
begin
  ChildNodes['Content'].NodeValue := Value;
end;

function TXMLBlock.Get_Rem: UnicodeString;
begin
  Result := ChildNodes['Rem'].Text;
end;

procedure TXMLBlock.Set_Rem(Value: UnicodeString);
begin
  ChildNodes['Rem'].NodeValue := Value;
end;

function TXMLBlock.Get_Tags: UnicodeString;
begin
  Result := ChildNodes['Tags'].Text;
end;

procedure TXMLBlock.Set_Tags(Value: UnicodeString);
begin
  ChildNodes['Tags'].NodeValue := Value;
end;

function TXMLBlock.Get_Fields: IXMLFields;
begin
  Result := ChildNodes['Fields'] as IXMLFields;
end;

{ TXMLFields }

procedure TXMLFields.AfterConstruction;
begin
  RegisterChildNode('Field', TXMLField);
  ItemTag := 'Field';
  ItemInterface := IXMLField;
  inherited;
end;

function TXMLFields.Get_Field(Index: Integer): IXMLField;
begin
  Result := List[Index] as IXMLField;
end;

function TXMLFields.Add: IXMLField;
begin
  Result := AddItem(-1) as IXMLField;
end;

function TXMLFields.Insert(const Index: Integer): IXMLField;
begin
  Result := AddItem(Index) as IXMLField;
end;

{ TXMLField }

function TXMLField.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLField.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLField.Get_Caption: UnicodeString;
begin
  Result := AttributeNodes['caption'].Text;
end;

procedure TXMLField.Set_Caption(Value: UnicodeString);
begin
  SetAttribute('caption', Value);
end;

function TXMLField.Get_Fieldtype: UnicodeString;
begin
  Result := AttributeNodes['fieldtype'].Text;
end;

procedure TXMLField.Set_Fieldtype(Value: UnicodeString);
begin
  SetAttribute('fieldtype', Value);
end;

function TXMLField.Get_Rem: UnicodeString;
begin
  Result := ChildNodes['Rem'].Text;
end;

procedure TXMLField.Set_Rem(Value: UnicodeString);
begin
  ChildNodes['Rem'].NodeValue := Value;
end;

end.