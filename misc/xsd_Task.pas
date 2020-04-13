
{*****************************************************}
{                                                     }
{                  XML-Datenbindung                   }
{                                                     }
{         Generiert am: 13.04.2020 09:05:04           }
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
  IXMLProperty_ = interface;
  IXMLProperty_List = interface;
  IXMLForms = interface;
  IXMLForm = interface;
  IXMLControl = interface;

{ IXMLTask }

  IXMLTask = interface(IXMLNode)
    ['{1718E41A-862E-4BAB-9302-7F8BECE66838}']
    { Eigenschaftszugriff }
    function Get_Rem: UnicodeString;
    function Get_Datafields: IXMLDatafields;
    function Get_Forms: IXMLForms;
    procedure Set_Rem(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Rem: UnicodeString read Get_Rem write Set_Rem;
    property Datafields: IXMLDatafields read Get_Datafields;
    property Forms: IXMLForms read Get_Forms;
  end;

{ IXMLDatafields }

  IXMLDatafields = interface(IXMLNodeCollection)
    ['{6740EA68-FA3A-46FC-AD9C-DBBB866A3B08}']
    { Eigenschaftszugriff }
    function Get_DataField(Index: Integer): IXMLDataField;
    { Methoden & Eigenschaften }
    function Add: IXMLDataField;
    function Insert(const Index: Integer): IXMLDataField;
    property DataField[Index: Integer]: IXMLDataField read Get_DataField; default;
  end;

{ IXMLDataField }

  IXMLDataField = interface(IXMLNode)
    ['{639C0218-FDC6-450B-B8B3-72AEB831B2A0}']
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
    ['{E2A817EF-D70C-493B-BF2A-51504E6C220F}']
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
    ['{EC4EA0C6-4C7E-4D43-81EA-D966570EEF91}']
    { Methoden & Eigenschaften }
    function Add: IXMLProperty_;
    function Insert(const Index: Integer): IXMLProperty_;

    function Get_Item(Index: Integer): IXMLProperty_;
    property Items[Index: Integer]: IXMLProperty_ read Get_Item; default;
  end;

{ IXMLForms }

  IXMLForms = interface(IXMLNodeCollection)
    ['{67CB7931-0485-4C95-A087-38140CB2AD7B}']
    { Eigenschaftszugriff }
    function Get_Form(Index: Integer): IXMLForm;
    { Methoden & Eigenschaften }
    function Add: IXMLForm;
    function Insert(const Index: Integer): IXMLForm;
    property Form[Index: Integer]: IXMLForm read Get_Form; default;
  end;

{ IXMLForm }

  IXMLForm = interface(IXMLNodeCollection)
    ['{E6E5B36B-D261-4194-96D7-FC2772EC545F}']
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
    ['{F469BA43-ED14-4DAC-A3E1-14CDD3D14850}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Typ: UnicodeString;
    function Get_Parent: UnicodeString;
    function Get_Datafield: UnicodeString;
    function Get_Property_(Index: Integer): IXMLProperty_;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Typ(Value: UnicodeString);
    procedure Set_Parent(Value: UnicodeString);
    procedure Set_Datafield(Value: UnicodeString);
    { Methoden & Eigenschaften }
    function Add: IXMLProperty_;
    function Insert(const Index: Integer): IXMLProperty_;
    property Name: UnicodeString read Get_Name write Set_Name;
    property Typ: UnicodeString read Get_Typ write Set_Typ;
    property Parent: UnicodeString read Get_Parent write Set_Parent;
    property Datafield: UnicodeString read Get_Datafield write Set_Datafield;
    property Property_[Index: Integer]: IXMLProperty_ read Get_Property_; default;
  end;

{ Forward-Deklarationen }

  TXMLTask = class;
  TXMLDatafields = class;
  TXMLDataField = class;
  TXMLProperty_ = class;
  TXMLProperty_List = class;
  TXMLForms = class;
  TXMLForm = class;
  TXMLControl = class;

{ TXMLTask }

  TXMLTask = class(TXMLNode, IXMLTask)
  protected
    { IXMLTask }
    function Get_Rem: UnicodeString;
    function Get_Datafields: IXMLDatafields;
    function Get_Forms: IXMLForms;
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
    function Get_Datafield: UnicodeString;
    function Get_Property_(Index: Integer): IXMLProperty_;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Typ(Value: UnicodeString);
    procedure Set_Parent(Value: UnicodeString);
    procedure Set_Datafield(Value: UnicodeString);
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

function TXMLControl.Get_Datafield: UnicodeString;
begin
  Result := AttributeNodes['datafield'].Text;
end;

procedure TXMLControl.Set_Datafield(Value: UnicodeString);
begin
  SetAttribute('datafield', Value);
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