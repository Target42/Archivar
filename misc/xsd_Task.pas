
{*****************************************************}
{                                                     }
{                  XML-Datenbindung                   }
{                                                     }
{         Generiert am: 15.04.2020 13:02:41           }
{       Generiert von: D:\git\ber.git\misc\Task.xsd   }
{                                                     }
{*****************************************************}

unit xsd_Task;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLTask = interface;
  IXMLDatafields = interface;
  IXMLDataField = interface;
  IXMLProperties = interface;
  IXMLProperty_ = interface;
  IXMLChilds = interface;
  IXMLForms = interface;
  IXMLForm = interface;
  IXMLControl = interface;

{ IXMLTask }

  IXMLTask = interface(IXMLNode)
    ['{D7E6C569-56F4-4315-83DA-E27D3372FAB8}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Clid: UnicodeString;
    function Get_Rem: UnicodeString;
    function Get_Datafields: IXMLDatafields;
    function Get_Forms: IXMLForms;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_Rem(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Clid: UnicodeString read Get_Clid write Set_Clid;
    property Rem: UnicodeString read Get_Rem write Set_Rem;
    property Datafields: IXMLDatafields read Get_Datafields;
    property Forms: IXMLForms read Get_Forms;
  end;

{ IXMLDatafields }

  IXMLDatafields = interface(IXMLNodeCollection)
    ['{71F2EEDA-D54B-4A71-BE08-CBBB80FF5B65}']
    { Eigenschaftszugriff }
    function Get_DataField(Index: Integer): IXMLDataField;
    { Methoden & Eigenschaften }
    function Add: IXMLDataField;
    function Insert(const Index: Integer): IXMLDataField;
    property DataField[Index: Integer]: IXMLDataField read Get_DataField; default;
  end;

{ IXMLDataField }

  IXMLDataField = interface(IXMLNode)
    ['{FDE257C5-59B4-40EA-B1C1-F914AA79F370}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Datatype: UnicodeString;
    function Get_Clid: UnicodeString;
    function Get_IsGlobal: Boolean;
    function Get_Required: Boolean;
    function Get_Properties: IXMLProperties;
    function Get_Childs: IXMLChilds;
    function Get_Text: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Datatype(Value: UnicodeString);
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_IsGlobal(Value: Boolean);
    procedure Set_Required(Value: Boolean);
    procedure Set_Text(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Datatype: UnicodeString read Get_Datatype write Set_Datatype;
    property Clid: UnicodeString read Get_Clid write Set_Clid;
    property IsGlobal: Boolean read Get_IsGlobal write Set_IsGlobal;
    property Required: Boolean read Get_Required write Set_Required;
    property Properties: IXMLProperties read Get_Properties;
    property Childs: IXMLChilds read Get_Childs;
    property Text: UnicodeString read Get_Text write Set_Text;
  end;

{ IXMLProperties }

  IXMLProperties = interface(IXMLNodeCollection)
    ['{3D8616A9-8971-4D1A-B16A-FF70B1B7EECD}']
    { Eigenschaftszugriff }
    function Get_Property_(Index: Integer): IXMLProperty_;
    { Methoden & Eigenschaften }
    function Add: IXMLProperty_;
    function Insert(const Index: Integer): IXMLProperty_;
    property Property_[Index: Integer]: IXMLProperty_ read Get_Property_; default;
  end;

{ IXMLProperty_ }

  IXMLProperty_ = interface(IXMLNode)
    ['{997858CC-C67C-48F3-985E-A9CFC6EDFF01}']
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
    ['{5A45AB79-C75A-4C39-AB6C-0B4F708C65EE}']
    { Eigenschaftszugriff }
    function Get_DataField(Index: Integer): IXMLDataField;
    { Methoden & Eigenschaften }
    function Add: IXMLDataField;
    function Insert(const Index: Integer): IXMLDataField;
    property DataField[Index: Integer]: IXMLDataField read Get_DataField; default;
  end;

{ IXMLForms }

  IXMLForms = interface(IXMLNodeCollection)
    ['{08D3F671-2AFE-42EA-AA2D-EE957E8497E4}']
    { Eigenschaftszugriff }
    function Get_Form(Index: Integer): IXMLForm;
    { Methoden & Eigenschaften }
    function Add: IXMLForm;
    function Insert(const Index: Integer): IXMLForm;
    property Form[Index: Integer]: IXMLForm read Get_Form; default;
  end;

{ IXMLForm }

  IXMLForm = interface(IXMLNodeCollection)
    ['{AB47AE10-96FB-4EF4-9065-00878E631511}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Mainform: Boolean;
    function Get_Clid: UnicodeString;
    function Get_Control(Index: Integer): IXMLControl;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Mainform(Value: Boolean);
    procedure Set_Clid(Value: UnicodeString);
    { Methoden & Eigenschaften }
    function Add: IXMLControl;
    function Insert(const Index: Integer): IXMLControl;
    property Name: UnicodeString read Get_Name write Set_Name;
    property Mainform: Boolean read Get_Mainform write Set_Mainform;
    property Clid: UnicodeString read Get_Clid write Set_Clid;
    property Control[Index: Integer]: IXMLControl read Get_Control; default;
  end;

{ IXMLControl }

  IXMLControl = interface(IXMLNodeCollection)
    ['{CB8385CA-0567-4BE3-A53C-0B4CDF3CB6FA}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Typ: UnicodeString;
    function Get_Parent: UnicodeString;
    function Get_Field: UnicodeString;
    function Get_Property_(Index: Integer): IXMLProperty_;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Typ(Value: UnicodeString);
    procedure Set_Parent(Value: UnicodeString);
    procedure Set_Field(Value: UnicodeString);
    { Methoden & Eigenschaften }
    function Add: IXMLProperty_;
    function Insert(const Index: Integer): IXMLProperty_;
    property Name: UnicodeString read Get_Name write Set_Name;
    property Typ: UnicodeString read Get_Typ write Set_Typ;
    property Parent: UnicodeString read Get_Parent write Set_Parent;
    property Field: UnicodeString read Get_Field write Set_Field;
    property Property_[Index: Integer]: IXMLProperty_ read Get_Property_; default;
  end;

{ Forward-Deklarationen }

  TXMLTask = class;
  TXMLDatafields = class;
  TXMLDataField = class;
  TXMLProperties = class;
  TXMLProperty_ = class;
  TXMLChilds = class;
  TXMLForms = class;
  TXMLForm = class;
  TXMLControl = class;

{ TXMLTask }

  TXMLTask = class(TXMLNode, IXMLTask)
  protected
    { IXMLTask }
    function Get_Name: UnicodeString;
    function Get_Clid: UnicodeString;
    function Get_Rem: UnicodeString;
    function Get_Datafields: IXMLDatafields;
    function Get_Forms: IXMLForms;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_Rem(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDatafields }

  TXMLDatafields = class(TXMLNodeCollection, IXMLDatafields)
  protected
    { IXMLDatafields }
    function Get_DataField(Index: Integer): IXMLDataField;
    function Add: IXMLDataField;
    function Insert(const Index: Integer): IXMLDataField;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDataField }

  TXMLDataField = class(TXMLNode, IXMLDataField)
  protected
    { IXMLDataField }
    function Get_Name: UnicodeString;
    function Get_Datatype: UnicodeString;
    function Get_Clid: UnicodeString;
    function Get_IsGlobal: Boolean;
    function Get_Required: Boolean;
    function Get_Properties: IXMLProperties;
    function Get_Childs: IXMLChilds;
    function Get_Text: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Datatype(Value: UnicodeString);
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_IsGlobal(Value: Boolean);
    procedure Set_Required(Value: Boolean);
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

{ TXMLForms }

  TXMLForms = class(TXMLNodeCollection, IXMLForms)
  protected
    { IXMLForms }
    function Get_Form(Index: Integer): IXMLForm;
    function Add: IXMLForm;
    function Insert(const Index: Integer): IXMLForm;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLForm }

  TXMLForm = class(TXMLNodeCollection, IXMLForm)
  protected
    { IXMLForm }
    function Get_Name: UnicodeString;
    function Get_Mainform: Boolean;
    function Get_Clid: UnicodeString;
    function Get_Control(Index: Integer): IXMLControl;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Mainform(Value: Boolean);
    procedure Set_Clid(Value: UnicodeString);
    function Add: IXMLControl;
    function Insert(const Index: Integer): IXMLControl;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLControl }

  TXMLControl = class(TXMLNodeCollection, IXMLControl)
  protected
    { IXMLControl }
    function Get_Name: UnicodeString;
    function Get_Typ: UnicodeString;
    function Get_Parent: UnicodeString;
    function Get_Field: UnicodeString;
    function Get_Property_(Index: Integer): IXMLProperty_;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Typ(Value: UnicodeString);
    procedure Set_Parent(Value: UnicodeString);
    procedure Set_Field(Value: UnicodeString);
    function Add: IXMLProperty_;
    function Insert(const Index: Integer): IXMLProperty_;
  public
    procedure AfterConstruction; override;
  end;

{ Globale Funktionen }

function GetTask(Doc: IXMLDocument): IXMLTask;
function LoadTask(const FileName: string): IXMLTask;
function NewTask: IXMLTask;

const
  TargetNamespace = '';

implementation

uses Xml.xmlutil;

{ Globale Funktionen }

function GetTask(Doc: IXMLDocument): IXMLTask;
begin
  Result := Doc.GetDocBinding('Task', TXMLTask, TargetNamespace) as IXMLTask;
end;

function LoadTask(const FileName: string): IXMLTask;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Task', TXMLTask, TargetNamespace) as IXMLTask;
end;

function NewTask: IXMLTask;
begin
  Result := NewXMLDocument.GetDocBinding('Task', TXMLTask, TargetNamespace) as IXMLTask;
end;

{ TXMLTask }

procedure TXMLTask.AfterConstruction;
begin
  RegisterChildNode('Datafields', TXMLDatafields);
  RegisterChildNode('Forms', TXMLForms);
  inherited;
end;

function TXMLTask.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLTask.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLTask.Get_Clid: UnicodeString;
begin
  Result := AttributeNodes['clid'].Text;
end;

procedure TXMLTask.Set_Clid(Value: UnicodeString);
begin
  SetAttribute('clid', Value);
end;

function TXMLTask.Get_Rem: UnicodeString;
begin
  Result := ChildNodes['Rem'].Text;
end;

procedure TXMLTask.Set_Rem(Value: UnicodeString);
begin
  ChildNodes['Rem'].NodeValue := Value;
end;

function TXMLTask.Get_Datafields: IXMLDatafields;
begin
  Result := ChildNodes['Datafields'] as IXMLDatafields;
end;

function TXMLTask.Get_Forms: IXMLForms;
begin
  Result := ChildNodes['Forms'] as IXMLForms;
end;

{ TXMLDatafields }

procedure TXMLDatafields.AfterConstruction;
begin
  RegisterChildNode('DataField', TXMLDataField);
  ItemTag := 'DataField';
  ItemInterface := IXMLDataField;
  inherited;
end;

function TXMLDatafields.Get_DataField(Index: Integer): IXMLDataField;
begin
  Result := List[Index] as IXMLDataField;
end;

function TXMLDatafields.Add: IXMLDataField;
begin
  Result := AddItem(-1) as IXMLDataField;
end;

function TXMLDatafields.Insert(const Index: Integer): IXMLDataField;
begin
  Result := AddItem(Index) as IXMLDataField;
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

{ TXMLForms }

procedure TXMLForms.AfterConstruction;
begin
  RegisterChildNode('Form', TXMLForm);
  ItemTag := 'Form';
  ItemInterface := IXMLForm;
  inherited;
end;

function TXMLForms.Get_Form(Index: Integer): IXMLForm;
begin
  Result := List[Index] as IXMLForm;
end;

function TXMLForms.Add: IXMLForm;
begin
  Result := AddItem(-1) as IXMLForm;
end;

function TXMLForms.Insert(const Index: Integer): IXMLForm;
begin
  Result := AddItem(Index) as IXMLForm;
end;

{ TXMLForm }

procedure TXMLForm.AfterConstruction;
begin
  RegisterChildNode('Control', TXMLControl);
  ItemTag := 'Control';
  ItemInterface := IXMLControl;
  inherited;
end;

function TXMLForm.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLForm.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLForm.Get_Mainform: Boolean;
begin
  Result := AttributeNodes['mainform'].NodeValue;
end;

procedure TXMLForm.Set_Mainform(Value: Boolean);
begin
  SetAttribute('mainform', Value);
end;

function TXMLForm.Get_Clid: UnicodeString;
begin
  Result := AttributeNodes['clid'].Text;
end;

procedure TXMLForm.Set_Clid(Value: UnicodeString);
begin
  SetAttribute('clid', Value);
end;

function TXMLForm.Get_Control(Index: Integer): IXMLControl;
begin
  Result := List[Index] as IXMLControl;
end;

function TXMLForm.Add: IXMLControl;
begin
  Result := AddItem(-1) as IXMLControl;
end;

function TXMLForm.Insert(const Index: Integer): IXMLControl;
begin
  Result := AddItem(Index) as IXMLControl;
end;

{ TXMLControl }

procedure TXMLControl.AfterConstruction;
begin
  RegisterChildNode('Property', TXMLProperty_);
  ItemTag := 'Property';
  ItemInterface := IXMLProperty_;
  inherited;
end;

function TXMLControl.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLControl.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLControl.Get_Typ: UnicodeString;
begin
  Result := AttributeNodes['typ'].Text;
end;

procedure TXMLControl.Set_Typ(Value: UnicodeString);
begin
  SetAttribute('typ', Value);
end;

function TXMLControl.Get_Parent: UnicodeString;
begin
  Result := AttributeNodes['parent'].Text;
end;

procedure TXMLControl.Set_Parent(Value: UnicodeString);
begin
  SetAttribute('parent', Value);
end;

function TXMLControl.Get_Field: UnicodeString;
begin
  Result := AttributeNodes['field'].Text;
end;

procedure TXMLControl.Set_Field(Value: UnicodeString);
begin
  SetAttribute('field', Value);
end;

function TXMLControl.Get_Property_(Index: Integer): IXMLProperty_;
begin
  Result := List[Index] as IXMLProperty_;
end;

function TXMLControl.Add: IXMLProperty_;
begin
  Result := AddItem(-1) as IXMLProperty_;
end;

function TXMLControl.Insert(const Index: Integer): IXMLProperty_;
begin
  Result := AddItem(Index) as IXMLProperty_;
end;

end.