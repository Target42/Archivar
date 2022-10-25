
{*********************************************************}
{                                                         }
{                    XML-Datenbindung                     }
{                                                         }
{         Generiert am: 22.10.2022 19:29:24               }
{       Generiert von: D:\git\ber.git\misc\TaskType.xsd   }
{                                                         }
{*********************************************************}

unit xsd_TaskType;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLTaskTypes = interface;
  IXMLTaskType = interface;

{ IXMLTaskTypes }

  IXMLTaskTypes = interface(IXMLNodeCollection)
    ['{BDE16BFC-36E4-456D-9007-F7DD8D18F8A8}']
    { Eigenschaftszugriff }
    function Get_TaskType(Index: Integer): IXMLTaskType;
    { Methoden & Eigenschaften }
    function Add: IXMLTaskType;
    function Insert(const Index: Integer): IXMLTaskType;
    property TaskType[Index: Integer]: IXMLTaskType read Get_TaskType; default;
  end;

{ IXMLTaskType }

  IXMLTaskType = interface(IXMLNode)
    ['{2E91C88F-C462-4621-A88D-CD84CE1604B1}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Tage: Integer;
    function Get_Id: Integer;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Tage(Value: Integer);
    procedure Set_Id(Value: Integer);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Tage: Integer read Get_Tage write Set_Tage;
    property Id: Integer read Get_Id write Set_Id;
  end;

{ Forward-Deklarationen }

  TXMLTaskTypes = class;
  TXMLTaskType = class;

{ TXMLTaskTypes }

  TXMLTaskTypes = class(TXMLNodeCollection, IXMLTaskTypes)
  protected
    { IXMLTaskTypes }
    function Get_TaskType(Index: Integer): IXMLTaskType;
    function Add: IXMLTaskType;
    function Insert(const Index: Integer): IXMLTaskType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTaskType }

  TXMLTaskType = class(TXMLNode, IXMLTaskType)
  protected
    { IXMLTaskType }
    function Get_Name: UnicodeString;
    function Get_Tage: Integer;
    function Get_Id: Integer;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Tage(Value: Integer);
    procedure Set_Id(Value: Integer);
  end;

{ Globale Funktionen }

function GetTaskTypes(Doc: IXMLDocument): IXMLTaskTypes;
function LoadTaskTypes(const FileName: string): IXMLTaskTypes;
function NewTaskTypes: IXMLTaskTypes;

const
  TargetNamespace = '';

implementation

uses Xml.xmlutil;

{ Globale Funktionen }

function GetTaskTypes(Doc: IXMLDocument): IXMLTaskTypes;
begin
  Result := Doc.GetDocBinding('TaskTypes', TXMLTaskTypes, TargetNamespace) as IXMLTaskTypes;
end;

function LoadTaskTypes(const FileName: string): IXMLTaskTypes;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('TaskTypes', TXMLTaskTypes, TargetNamespace) as IXMLTaskTypes;
end;

function NewTaskTypes: IXMLTaskTypes;
begin
  Result := NewXMLDocument.GetDocBinding('TaskTypes', TXMLTaskTypes, TargetNamespace) as IXMLTaskTypes;
end;

{ TXMLTaskTypes }

procedure TXMLTaskTypes.AfterConstruction;
begin
  RegisterChildNode('TaskType', TXMLTaskType);
  ItemTag := 'TaskType';
  ItemInterface := IXMLTaskType;
  inherited;
end;

function TXMLTaskTypes.Get_TaskType(Index: Integer): IXMLTaskType;
begin
  Result := List[Index] as IXMLTaskType;
end;

function TXMLTaskTypes.Add: IXMLTaskType;
begin
  Result := AddItem(-1) as IXMLTaskType;
end;

function TXMLTaskTypes.Insert(const Index: Integer): IXMLTaskType;
begin
  Result := AddItem(Index) as IXMLTaskType;
end;

{ TXMLTaskType }

function TXMLTaskType.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLTaskType.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLTaskType.Get_Tage: Integer;
begin
  Result := AttributeNodes['tage'].NodeValue;
end;

procedure TXMLTaskType.Set_Tage(Value: Integer);
begin
  SetAttribute('tage', Value);
end;

function TXMLTaskType.Get_Id: Integer;
begin
  Result := AttributeNodes['id'].NodeValue;
end;

procedure TXMLTaskType.Set_Id(Value: Integer);
begin
  SetAttribute('id', Value);
end;

end.