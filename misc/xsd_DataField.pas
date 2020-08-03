
{**********************************************************}
{                                                          }
{                     XML-Datenbindung                     }
{                                                          }
{         Generiert am: 31.07.2020 17:21:26                }
{       Generiert von: D:\git\ber.git\misc\DataField.xsd   }
{                                                          }
{**********************************************************}

unit xsd_DataField;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLDataField = interface;
  IXMLProperties = interface;
  IXMLProperty_ = interface;
  IXMLChilds = interface;

{ IXMLDataField }

  IXMLDataField = interface(IXMLNode)
    ['{87E964BE-017D-4F6F-9F1E-642CD50D393E}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Datatype: UnicodeString;
    function Get_Clid: UnicodeString;
    function Get_IsGlobal: Boolean;
    function Get_Required: Boolean;
    function Get_Globalname: UnicodeString;
    function Get_Properties: IXMLProperties;
    function Get_Childs: IXMLChilds;
    function Get_Text: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Datatype(Value: UnicodeString);
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_IsGlobal(Value: Boolean);
    procedure Set_Required(Value: Boolean);
    procedure Set_Globalname(Value: UnicodeString);
    procedure Set_Text(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Datatype: UnicodeString read Get_Datatype write Set_Datatype;
    property Clid: UnicodeString read Get_Clid write Set_Clid;
    property IsGlobal: Boolean read Get_IsGlobal write Set_IsGlobal;
    property Required: Boolean read Get_Required write Set_Required;
    property Globalname: UnicodeString read Get_Globalname write Set_Globalname;
    property Properties: IXMLProperties read Get_Properties;
    property Childs: IXMLChilds read Get_Childs;
    property Text: UnicodeString read Get_Text write Set_Text;
  end;

{ IXMLProperties }

  IXMLProperties = interface(IXMLNodeCollection)
    ['{574861EA-DD5B-481B-9243-4DAAA1895C19}']
    { Eigenschaftszugriff }
    function Get_Property_(Index: Integer): IXMLProperty_;
    { Methoden & Eigenschaften }
    function Add: IXMLProperty_;
    function Insert(const Index: Integer): IXMLProperty_;
    property Property_[Index: Integer]: IXMLProperty_ read Get_Property_; default;
  end;

{ IXMLProperty_ }

  IXMLProperty_ = interface(IXMLNode)
    ['{1D3B47E6-EA59-42B2-BCF0-8413DBBB4995}']
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

{ IXMLChilds }

  IXMLChilds = interface(IXMLNodeCollection)
    ['{7A36BC0C-DF8D-42C4-AEA0-3F4B9149013D}']
    { Eigenschaftszugriff }
    function Get_DataField(Index: Integer): IXMLDataField;
    { Methoden & Eigenschaften }
    function Add: IXMLDataField;
    function Insert(const Index: Integer): IXMLDataField;
    property DataField[Index: Integer]: IXMLDataField read Get_DataField; default;
  end;

{ Forward-Deklarationen }

  TXMLDataField = class;
  TXMLProperties = class;
  TXMLProperty_ = class;
  TXMLChilds = class;

{ TXMLDataField }

  TXMLDataField = class(TXMLNode, IXMLDataField)
  protected
    { IXMLDataField }
    function Get_Name: UnicodeString;
    function Get_Datatype: UnicodeString;
    function Get_Clid: UnicodeString;
    function Get_IsGlobal: Boolean;
    function Get_Required: Boolean;
    function Get_Globalname: UnicodeString;
    function Get_Properties: IXMLProperties;
    function Get_Childs: IXMLChilds;
    function Get_Text: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Datatype(Value: UnicodeString);
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_IsGlobal(Value: Boolean);
    procedure Set_Required(Value: Boolean);
    procedure Set_Globalname(Value: UnicodeString);
    procedure Set_Text(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLProperties }

  TXMLProperties = class(TXMLNodeCollection, IXMLProperties)
  protected
    { IXMLProperties }
    function Get_Property_(Index: Integer): IXMLProperty_;
    function Add: IXMLProperty_;
    function Insert(const Index: Integer): IXMLProperty_;
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

{ TXMLChilds }

  TXMLChilds = class(TXMLNodeCollection, IXMLChilds)
  protected
    { IXMLChilds }
    function Get_DataField(Index: Integer): IXMLDataField;
    function Add: IXMLDataField;
    function Insert(const Index: Integer): IXMLDataField;
  public
    procedure AfterConstruction; override;
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
  RegisterChildNode('Properties', TXMLProperties);
  RegisterChildNode('Childs', TXMLChilds);
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

function TXMLDataField.Get_Required: Boolean;
begin
  Result := AttributeNodes['required'].NodeValue;
end;

procedure TXMLDataField.Set_Required(Value: Boolean);
begin
  SetAttribute('required', Value);
end;

function TXMLDataField.Get_Globalname: UnicodeString;
begin
  Result := AttributeNodes['globalname'].Text;
end;

procedure TXMLDataField.Set_Globalname(Value: UnicodeString);
begin
  SetAttribute('globalname', Value);
end;

function TXMLDataField.Get_Properties: IXMLProperties;
begin
  Result := ChildNodes['Properties'] as IXMLProperties;
end;

function TXMLDataField.Get_Childs: IXMLChilds;
begin
  Result := ChildNodes['Childs'] as IXMLChilds;
end;

function TXMLDataField.Get_Text: UnicodeString;
begin
  Result := ChildNodes['Text'].Text;
end;

procedure TXMLDataField.Set_Text(Value: UnicodeString);
begin
  ChildNodes['Text'].NodeValue := Value;
end;

{ TXMLProperties }

procedure TXMLProperties.AfterConstruction;
begin
  RegisterChildNode('Property', TXMLProperty_);
  ItemTag := 'Property';
  ItemInterface := IXMLProperty_;
  inherited;
end;

function TXMLProperties.Get_Property_(Index: Integer): IXMLProperty_;
begin
  Result := List[Index] as IXMLProperty_;
end;

function TXMLProperties.Add: IXMLProperty_;
begin
  Result := AddItem(-1) as IXMLProperty_;
end;

function TXMLProperties.Insert(const Index: Integer): IXMLProperty_;
begin
  Result := AddItem(Index) as IXMLProperty_;
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

{ TXMLChilds }

procedure TXMLChilds.AfterConstruction;
begin
  RegisterChildNode('DataField', TXMLDataField);
  ItemTag := 'DataField';
  ItemInterface := IXMLDataField;
  inherited;
end;

function TXMLChilds.Get_DataField(Index: Integer): IXMLDataField;
begin
  Result := List[Index] as IXMLDataField;
end;

function TXMLChilds.Add: IXMLDataField;
begin
  Result := AddItem(-1) as IXMLDataField;
end;

function TXMLChilds.Insert(const Index: Integer): IXMLDataField;
begin
  Result := AddItem(Index) as IXMLDataField;
end;

end.