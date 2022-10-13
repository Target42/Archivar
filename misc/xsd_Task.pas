
{*****************************************************}
{                                                     }
{                  XML-Datenbindung                   }
{                                                     }
{         Generiert am: 12.10.2022 16:40:22           }
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
  IXMLProperty_List = interface;
  IXMLChilds = interface;
  IXMLForms = interface;
  IXMLForm = interface;
  IXMLControl = interface;
  IXMLControlList = interface;

{ IXMLTask }

  IXMLTask = interface(IXMLNode)
    ['{D8BAB42F-AC86-41D0-8EFA-74A1F5F86D37}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Clid: UnicodeString;
    function Get_System: UnicodeString;
    function Get_Rem: UnicodeString;
    function Get_Datafields: IXMLDatafields;
    function Get_Forms: IXMLForms;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_System(Value: UnicodeString);
    procedure Set_Rem(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Clid: UnicodeString read Get_Clid write Set_Clid;
    property System: UnicodeString read Get_System write Set_System;
    property Rem: UnicodeString read Get_Rem write Set_Rem;
    property Datafields: IXMLDatafields read Get_Datafields;
    property Forms: IXMLForms read Get_Forms;
  end;

{ IXMLDatafields }

  IXMLDatafields = interface(IXMLNodeCollection)
    ['{A43508C9-AD03-4615-A43A-2FDB96496625}']
    { Eigenschaftszugriff }
    function Get_DataField(Index: Integer): IXMLDataField;
    { Methoden & Eigenschaften }
    function Add: IXMLDataField;
    function Insert(const Index: Integer): IXMLDataField;
    property DataField[Index: Integer]: IXMLDataField read Get_DataField; default;
  end;

{ IXMLDataField }

  IXMLDataField = interface(IXMLNode)
    ['{01042466-B2C0-45EB-A416-7C8F8936527F}']
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
    ['{C22E4CE0-CCAA-4B3C-B5F5-9B7CD9838EBB}']
    { Eigenschaftszugriff }
    function Get_Property_(Index: Integer): IXMLProperty_;
    { Methoden & Eigenschaften }
    function Add: IXMLProperty_;
    function Insert(const Index: Integer): IXMLProperty_;
    property Property_[Index: Integer]: IXMLProperty_ read Get_Property_; default;
  end;

{ IXMLProperty_ }

  IXMLProperty_ = interface(IXMLNode)
    ['{BF6299C5-5D07-4097-85A7-6CC99DA50A89}']
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
    ['{FE4FDCF3-2130-4407-AEAD-58B506F4A8FC}']
    { Methoden & Eigenschaften }
    function Add: IXMLProperty_;
    function Insert(const Index: Integer): IXMLProperty_;

    function Get_Item(Index: Integer): IXMLProperty_;
    property Items[Index: Integer]: IXMLProperty_ read Get_Item; default;
  end;

{ IXMLChilds }

  IXMLChilds = interface(IXMLNodeCollection)
    ['{622BD4D4-9CCF-4F70-A634-99AD021E6F02}']
    { Eigenschaftszugriff }
    function Get_DataField(Index: Integer): IXMLDataField;
    { Methoden & Eigenschaften }
    function Add: IXMLDataField;
    function Insert(const Index: Integer): IXMLDataField;
    property DataField[Index: Integer]: IXMLDataField read Get_DataField; default;
  end;

{ IXMLForms }

  IXMLForms = interface(IXMLNodeCollection)
    ['{D6B1E6AB-A860-4BD8-97E9-21B755DC6CC5}']
    { Eigenschaftszugriff }
    function Get_Form(Index: Integer): IXMLForm;
    { Methoden & Eigenschaften }
    function Add: IXMLForm;
    function Insert(const Index: Integer): IXMLForm;
    property Form[Index: Integer]: IXMLForm read Get_Form; default;
  end;

{ IXMLForm }

  IXMLForm = interface(IXMLNodeCollection)
    ['{F7D4F059-540B-47E6-B137-A2F3856BDBFA}']
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

  IXMLControl = interface(IXMLNode)
    ['{06E94D87-41F9-4A15-BFFF-0CE25C47E564}']
    { Eigenschaftszugriff }
    function Get_Clid: UnicodeString;
    function Get_CtrlType: UnicodeString;
    function Get_Field: UnicodeString;
    function Get_Fieldclid: UnicodeString;
    function Get_Property_: IXMLProperty_List;
    function Get_Control: IXMLControlList;
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_CtrlType(Value: UnicodeString);
    procedure Set_Field(Value: UnicodeString);
    procedure Set_Fieldclid(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Clid: UnicodeString read Get_Clid write Set_Clid;
    property CtrlType: UnicodeString read Get_CtrlType write Set_CtrlType;
    property Field: UnicodeString read Get_Field write Set_Field;
    property Fieldclid: UnicodeString read Get_Fieldclid write Set_Fieldclid;
    property Property_: IXMLProperty_List read Get_Property_;
    property Control: IXMLControlList read Get_Control;
  end;

{ IXMLControlList }

  IXMLControlList = interface(IXMLNodeCollection)
    ['{8B893E07-D963-4AD1-BC19-9FC18FF6D16B}']
    { Methoden & Eigenschaften }
    function Add: IXMLControl;
    function Insert(const Index: Integer): IXMLControl;

    function Get_Item(Index: Integer): IXMLControl;
    property Items[Index: Integer]: IXMLControl read Get_Item; default;
  end;

{ Forward-Deklarationen }

  TXMLTask = class;
  TXMLDatafields = class;
  TXMLDataField = class;
  TXMLProperties = class;
  TXMLProperty_ = class;
  TXMLProperty_List = class;
  TXMLChilds = class;
  TXMLForms = class;
  TXMLForm = class;
  TXMLControl = class;
  TXMLControlList = class;

{ TXMLTask }

  TXMLTask = class(TXMLNode, IXMLTask)
  protected
    { IXMLTask }
    function Get_Name: UnicodeString;
    function Get_Clid: UnicodeString;
    function Get_System: UnicodeString;
    function Get_Rem: UnicodeString;
    function Get_Datafields: IXMLDatafields;
    function Get_Forms: IXMLForms;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_System(Value: UnicodeString);
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

{ TXMLProperty_List }

  TXMLProperty_List = class(TXMLNodeCollection, IXMLProperty_List)
  protected
    { IXMLProperty_List }
    function Add: IXMLProperty_;
    function Insert(const Index: Integer): IXMLProperty_;

    function Get_Item(Index: Integer): IXMLProperty_;
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

  TXMLControl = class(TXMLNode, IXMLControl)
  private
    FProperty_: IXMLProperty_List;
    FControl: IXMLControlList;
  protected
    { IXMLControl }
    function Get_Clid: UnicodeString;
    function Get_CtrlType: UnicodeString;
    function Get_Field: UnicodeString;
    function Get_Fieldclid: UnicodeString;
    function Get_Property_: IXMLProperty_List;
    function Get_Control: IXMLControlList;
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_CtrlType(Value: UnicodeString);
    procedure Set_Field(Value: UnicodeString);
    procedure Set_Fieldclid(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLControlList }

  TXMLControlList = class(TXMLNodeCollection, IXMLControlList)
  protected
    { IXMLControlList }
    function Add: IXMLControl;
    function Insert(const Index: Integer): IXMLControl;

    function Get_Item(Index: Integer): IXMLControl;
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

function TXMLTask.Get_System: UnicodeString;
begin
  Result := AttributeNodes['system'].Text;
end;

procedure TXMLTask.Set_System(Value: UnicodeString);
begin
  SetAttribute('system', Value);
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
  RegisterChildNode('Control', TXMLControl);
  FProperty_ := CreateCollection(TXMLProperty_List, IXMLProperty_, 'Property') as IXMLProperty_List;
  FControl := CreateCollection(TXMLControlList, IXMLControl, 'Control') as IXMLControlList;
  inherited;
end;

function TXMLControl.Get_Clid: UnicodeString;
begin
  Result := AttributeNodes['clid'].Text;
end;

procedure TXMLControl.Set_Clid(Value: UnicodeString);
begin
  SetAttribute('clid', Value);
end;

function TXMLControl.Get_CtrlType: UnicodeString;
begin
  Result := AttributeNodes['ctrlType'].Text;
end;

procedure TXMLControl.Set_CtrlType(Value: UnicodeString);
begin
  SetAttribute('ctrlType', Value);
end;

function TXMLControl.Get_Field: UnicodeString;
begin
  Result := AttributeNodes['field'].Text;
end;

procedure TXMLControl.Set_Field(Value: UnicodeString);
begin
  SetAttribute('field', Value);
end;

function TXMLControl.Get_Fieldclid: UnicodeString;
begin
  Result := AttributeNodes['fieldclid'].Text;
end;

procedure TXMLControl.Set_Fieldclid(Value: UnicodeString);
begin
  SetAttribute('fieldclid', Value);
end;

function TXMLControl.Get_Property_: IXMLProperty_List;
begin
  Result := FProperty_;
end;

function TXMLControl.Get_Control: IXMLControlList;
begin
  Result := FControl;
end;

{ TXMLControlList }

function TXMLControlList.Add: IXMLControl;
begin
  Result := AddItem(-1) as IXMLControl;
end;

function TXMLControlList.Insert(const Index: Integer): IXMLControl;
begin
  Result := AddItem(Index) as IXMLControl;
end;

function TXMLControlList.Get_Item(Index: Integer): IXMLControl;
begin
  Result := List[Index] as IXMLControl;
end;

end.