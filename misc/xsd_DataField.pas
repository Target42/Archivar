
{**********************************************************}
{                                                          }
{                     XML-Datenbindung                     }
{                                                          }
{         Generiert am: 13.04.2020 09:04:34                }
{       Generiert von: D:\git\ber.git\misc\DataField.xsd   }
{                                                          }
{**********************************************************}

unit xsd_DataField;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLDataField = interface;
  IXMLProperty_ = interface;
  IXMLProperty_List = interface;

{ IXMLDataField }

  IXMLDataField = interface(IXMLNode)
    ['{0B2C9A32-7A89-4BBF-9C5E-3820FAD5A603}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Datatype: UnicodeString;
    function Get_Clid: UnicodeString;
    function Get_IsGlobal: Boolean;
    function Get_Property_: IXMLProperty_List;
    function Get_Text: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Datatype(Value: UnicodeString);
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_IsGlobal(Value: Boolean);
    procedure Set_Text(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Datatype: UnicodeString read Get_Datatype write Set_Datatype;
    property Clid: UnicodeString read Get_Clid write Set_Clid;
    property IsGlobal: Boolean read Get_IsGlobal write Set_IsGlobal;
    property Property_: IXMLProperty_List read Get_Property_;
    property Text: UnicodeString read Get_Text write Set_Text;
  end;

{ IXMLProperty_ }

  IXMLProperty_ = interface(IXMLNode)
    ['{C07C20BF-3A3E-41A8-8D74-3514452B2039}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Typ: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Typ(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Typ: UnicodeString read Get_Typ write Set_Typ;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLProperty_List }

  IXMLProperty_List = interface(IXMLNodeCollection)
    ['{AE852D81-339E-4B94-A828-3EE6FA9C997C}']
    { Methoden & Eigenschaften }
    function Add: IXMLProperty_;
    function Insert(const Index: Integer): IXMLProperty_;

    function Get_Item(Index: Integer): IXMLProperty_;
    property Items[Index: Integer]: IXMLProperty_ read Get_Item; default;
  end;

{ Forward-Deklarationen }

  TXMLDataField = class;
  TXMLProperty_ = class;
  TXMLProperty_List = class;

{ TXMLDataField }

  TXMLDataField = class(TXMLNode, IXMLDataField)
  private
    FProperty_: IXMLProperty_List;
  protected
    { IXMLDataField }
    function Get_Name: UnicodeString;
    function Get_Datatype: UnicodeString;
    function Get_Clid: UnicodeString;
    function Get_IsGlobal: Boolean;
    function Get_Property_: IXMLProperty_List;
    function Get_Text: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Datatype(Value: UnicodeString);
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_IsGlobal(Value: Boolean);
    procedure Set_Text(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLProperty_ }

  TXMLProperty_ = class(TXMLNode, IXMLProperty_)
  protected
    { IXMLProperty_ }
    function Get_Name: UnicodeString;
    function Get_Typ: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Typ(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLProperty_List }

  TXMLProperty_List = class(TXMLNodeCollection, IXMLProperty_List)
  protected
    { IXMLProperty_List }
    function Add: IXMLProperty_;
    function Insert(const Index: Integer): IXMLProperty_;

    function Get_Item(Index: Integer): IXMLProperty_;
  end;

{ Globale Funktionen }

function GetDataField(Doc: IXMLDocument): IXMLDataField;
function LoadDataField(const FileName: string): IXMLDataField;
function NewDataField: IXMLDataField;

const
  TargetNamespace = '';

implementation

uses Xml.xmlutil;

{ Globale Funktionen }

function GetDataField(Doc: IXMLDocument): IXMLDataField;
begin
  Result := Doc.GetDocBinding('DataField', TXMLDataField, TargetNamespace) as IXMLDataField;
end;

function LoadDataField(const FileName: string): IXMLDataField;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('DataField', TXMLDataField, TargetNamespace) as IXMLDataField;
end;

function NewDataField: IXMLDataField;
begin
  Result := NewXMLDocument.GetDocBinding('DataField', TXMLDataField, TargetNamespace) as IXMLDataField;
end;

{ TXMLDataField }

procedure TXMLDataField.AfterConstruction;
begin
  RegisterChildNode('Property', TXMLProperty_);
  FProperty_ := CreateCollection(TXMLProperty_List, IXMLProperty_, 'Property') as IXMLProperty_List;
  inherited;
end;

function TXMLDataField.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLDataField.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLDataField.Get_Datatype: UnicodeString;
begin
  Result := AttributeNodes['datatype'].Text;
end;

procedure TXMLDataField.Set_Datatype(Value: UnicodeString);
begin
  SetAttribute('datatype', Value);
end;

function TXMLDataField.Get_Clid: UnicodeString;
begin
  Result := AttributeNodes['clid'].Text;
end;

procedure TXMLDataField.Set_Clid(Value: UnicodeString);
begin
  SetAttribute('clid', Value);
end;

function TXMLDataField.Get_IsGlobal: Boolean;
begin
  Result := AttributeNodes['isGlobal'].NodeValue;
end;

procedure TXMLDataField.Set_IsGlobal(Value: Boolean);
begin
  SetAttribute('isGlobal', Value);
end;

function TXMLDataField.Get_Property_: IXMLProperty_List;
begin
  Result := FProperty_;
end;

function TXMLDataField.Get_Text: UnicodeString;
begin
  Result := ChildNodes['Text'].Text;
end;

procedure TXMLDataField.Set_Text(Value: UnicodeString);
begin
  ChildNodes['Text'].NodeValue := Value;
end;

{ TXMLProperty_ }

function TXMLProperty_.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLProperty_.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLProperty_.Get_Typ: UnicodeString;
begin
  Result := AttributeNodes['typ'].Text;
end;

procedure TXMLProperty_.Set_Typ(Value: UnicodeString);
begin
  SetAttribute('typ', Value);
end;

function TXMLProperty_.Get_Value: UnicodeString;
begin
  Result := ChildNodes['value'].Text;
end;

procedure TXMLProperty_.Set_Value(Value: UnicodeString);
begin
  ChildNodes['value'].NodeValue := Value;
end;

{ TXMLProperty_List }

function TXMLProperty_List.Add: IXMLProperty_;
begin
  Result := AddItem(-1) as IXMLProperty_;
end;

function TXMLProperty_List.Insert(const Index: Integer): IXMLProperty_;
begin
  Result := AddItem(Index) as IXMLProperty_;
end;

function TXMLProperty_List.Get_Item(Index: Integer): IXMLProperty_;
begin
  Result := List[Index] as IXMLProperty_;
end;

end.