
{*********************************************************}
{                                                         }
{                    XML-Datenbindung                     }
{                                                         }
{         Generiert am: 03.10.2020 14:59:42               }
{       Generiert von: D:\git\ber.git\misc\TaskData.xsd   }
{                                                         }
{*********************************************************}

unit xsd_TaskData;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLList = interface;
  IXMLValues = interface;
  IXMLField = interface;
  IXMLTables = interface;
  IXMLTable = interface;
  IXMLHeader = interface;
  IXMLRows = interface;
  IXMLRow = interface;
  IXMLData = interface;

{ IXMLList }

  IXMLList = interface(IXMLNode)
    ['{A5C8BC8D-6388-4F38-88AB-9495629890CA}']
    { Eigenschaftszugriff }
    function Get_Clid: UnicodeString;
    function Get_Taskclid: UnicodeString;
    function Get_Stylename: UnicodeString;
    function Get_Styleclid: UnicodeString;
    function Get_Values: IXMLValues;
    function Get_Tables: IXMLTables;
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_Taskclid(Value: UnicodeString);
    procedure Set_Stylename(Value: UnicodeString);
    procedure Set_Styleclid(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Clid: UnicodeString read Get_Clid write Set_Clid;
    property Taskclid: UnicodeString read Get_Taskclid write Set_Taskclid;
    property Stylename: UnicodeString read Get_Stylename write Set_Stylename;
    property Styleclid: UnicodeString read Get_Styleclid write Set_Styleclid;
    property Values: IXMLValues read Get_Values;
    property Tables: IXMLTables read Get_Tables;
  end;

{ IXMLValues }

  IXMLValues = interface(IXMLNodeCollection)
    ['{0120AC72-4F86-42A0-B0C5-1D5B3E21C6B8}']
    { Eigenschaftszugriff }
    function Get_Field(Index: Integer): IXMLField;
    { Methoden & Eigenschaften }
    function Add: IXMLField;
    function Insert(const Index: Integer): IXMLField;
    property Field[Index: Integer]: IXMLField read Get_Field; default;
  end;

{ IXMLField }

  IXMLField = interface(IXMLNode)
    ['{B784E470-61FF-44A8-BA55-6F978FD21CA3}']
    { Eigenschaftszugriff }
    function Get_Field: UnicodeString;
    function Get_Fieldclid: UnicodeString;
    function Get_Ctrlclid: UnicodeString;
    function Get_Header: UnicodeString;
    function Get_Width: Integer;
    function Get_Value: UnicodeString;
    procedure Set_Field(Value: UnicodeString);
    procedure Set_Fieldclid(Value: UnicodeString);
    procedure Set_Ctrlclid(Value: UnicodeString);
    procedure Set_Header(Value: UnicodeString);
    procedure Set_Width(Value: Integer);
    procedure Set_Value(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Field: UnicodeString read Get_Field write Set_Field;
    property Fieldclid: UnicodeString read Get_Fieldclid write Set_Fieldclid;
    property Ctrlclid: UnicodeString read Get_Ctrlclid write Set_Ctrlclid;
    property Header: UnicodeString read Get_Header write Set_Header;
    property Width: Integer read Get_Width write Set_Width;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLTables }

  IXMLTables = interface(IXMLNodeCollection)
    ['{48E50852-68BB-4A39-AC48-05D916778F39}']
    { Eigenschaftszugriff }
    function Get_Table(Index: Integer): IXMLTable;
    { Methoden & Eigenschaften }
    function Add: IXMLTable;
    function Insert(const Index: Integer): IXMLTable;
    property Table[Index: Integer]: IXMLTable read Get_Table; default;
  end;

{ IXMLTable }

  IXMLTable = interface(IXMLNode)
    ['{B70E1B7B-A915-48FE-A6B7-E1A0C24337D5}']
    { Eigenschaftszugriff }
    function Get_Ctrlclid: UnicodeString;
    function Get_Field: UnicodeString;
    function Get_Fieldclid: UnicodeString;
    function Get_Header: IXMLHeader;
    function Get_Rows: IXMLRows;
    procedure Set_Ctrlclid(Value: UnicodeString);
    procedure Set_Field(Value: UnicodeString);
    procedure Set_Fieldclid(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Ctrlclid: UnicodeString read Get_Ctrlclid write Set_Ctrlclid;
    property Field: UnicodeString read Get_Field write Set_Field;
    property Fieldclid: UnicodeString read Get_Fieldclid write Set_Fieldclid;
    property Header: IXMLHeader read Get_Header;
    property Rows: IXMLRows read Get_Rows;
  end;

{ IXMLHeader }

  IXMLHeader = interface(IXMLNodeCollection)
    ['{2F702ED8-8FAC-4D9A-ADDE-6868B639F08E}']
    { Eigenschaftszugriff }
    function Get_Field(Index: Integer): IXMLField;
    { Methoden & Eigenschaften }
    function Add: IXMLField;
    function Insert(const Index: Integer): IXMLField;
    property Field[Index: Integer]: IXMLField read Get_Field; default;
  end;

{ IXMLRows }

  IXMLRows = interface(IXMLNodeCollection)
    ['{1656C121-7955-468E-AEB8-B614FC7E0F14}']
    { Eigenschaftszugriff }
    function Get_Row(Index: Integer): IXMLRow;
    { Methoden & Eigenschaften }
    function Add: IXMLRow;
    function Insert(const Index: Integer): IXMLRow;
    property Row[Index: Integer]: IXMLRow read Get_Row; default;
  end;

{ IXMLRow }

  IXMLRow = interface(IXMLNodeCollection)
    ['{A7889EDA-9587-44F5-88FD-BD3FB740A004}']
    { Eigenschaftszugriff }
    function Get_Value(Index: Integer): UnicodeString;
    { Methoden & Eigenschaften }
    function Add(const Value: UnicodeString): IXMLNode;
    function Insert(const Index: Integer; const Value: UnicodeString): IXMLNode;
    property Value[Index: Integer]: UnicodeString read Get_Value; default;
  end;

{ IXMLData }

  IXMLData = interface(IXMLNode)
    ['{2115D906-EF72-4F6A-AD3C-646C2DA1CF71}']
    { Eigenschaftszugriff }
    function Get_Field: UnicodeString;
    function Get_Fieldclid: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_Field(Value: UnicodeString);
    procedure Set_Fieldclid(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Field: UnicodeString read Get_Field write Set_Field;
    property Fieldclid: UnicodeString read Get_Fieldclid write Set_Fieldclid;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ Forward-Deklarationen }

  TXMLList = class;
  TXMLValues = class;
  TXMLField = class;
  TXMLTables = class;
  TXMLTable = class;
  TXMLHeader = class;
  TXMLRows = class;
  TXMLRow = class;
  TXMLData = class;

{ TXMLList }

  TXMLList = class(TXMLNode, IXMLList)
  protected
    { IXMLList }
    function Get_Clid: UnicodeString;
    function Get_Taskclid: UnicodeString;
    function Get_Stylename: UnicodeString;
    function Get_Styleclid: UnicodeString;
    function Get_Values: IXMLValues;
    function Get_Tables: IXMLTables;
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_Taskclid(Value: UnicodeString);
    procedure Set_Stylename(Value: UnicodeString);
    procedure Set_Styleclid(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLValues }

  TXMLValues = class(TXMLNodeCollection, IXMLValues)
  protected
    { IXMLValues }
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
    function Get_Field: UnicodeString;
    function Get_Fieldclid: UnicodeString;
    function Get_Ctrlclid: UnicodeString;
    function Get_Header: UnicodeString;
    function Get_Width: Integer;
    function Get_Value: UnicodeString;
    procedure Set_Field(Value: UnicodeString);
    procedure Set_Fieldclid(Value: UnicodeString);
    procedure Set_Ctrlclid(Value: UnicodeString);
    procedure Set_Header(Value: UnicodeString);
    procedure Set_Width(Value: Integer);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLTables }

  TXMLTables = class(TXMLNodeCollection, IXMLTables)
  protected
    { IXMLTables }
    function Get_Table(Index: Integer): IXMLTable;
    function Add: IXMLTable;
    function Insert(const Index: Integer): IXMLTable;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTable }

  TXMLTable = class(TXMLNode, IXMLTable)
  protected
    { IXMLTable }
    function Get_Ctrlclid: UnicodeString;
    function Get_Field: UnicodeString;
    function Get_Fieldclid: UnicodeString;
    function Get_Header: IXMLHeader;
    function Get_Rows: IXMLRows;
    procedure Set_Ctrlclid(Value: UnicodeString);
    procedure Set_Field(Value: UnicodeString);
    procedure Set_Fieldclid(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLHeader }

  TXMLHeader = class(TXMLNodeCollection, IXMLHeader)
  protected
    { IXMLHeader }
    function Get_Field(Index: Integer): IXMLField;
    function Add: IXMLField;
    function Insert(const Index: Integer): IXMLField;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRows }

  TXMLRows = class(TXMLNodeCollection, IXMLRows)
  protected
    { IXMLRows }
    function Get_Row(Index: Integer): IXMLRow;
    function Add: IXMLRow;
    function Insert(const Index: Integer): IXMLRow;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRow }

  TXMLRow = class(TXMLNodeCollection, IXMLRow)
  protected
    { IXMLRow }
    function Get_Value(Index: Integer): UnicodeString;
    function Add(const Value: UnicodeString): IXMLNode;
    function Insert(const Index: Integer; const Value: UnicodeString): IXMLNode;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLData }

  TXMLData = class(TXMLNode, IXMLData)
  protected
    { IXMLData }
    function Get_Field: UnicodeString;
    function Get_Fieldclid: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_Field(Value: UnicodeString);
    procedure Set_Fieldclid(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ Globale Funktionen }

function GetList(Doc: IXMLDocument): IXMLList;
function LoadList(const FileName: string): IXMLList;
function NewList: IXMLList;

const
  TargetNamespace = '';

implementation

uses Xml.xmlutil;

{ Globale Funktionen }

function GetList(Doc: IXMLDocument): IXMLList;
begin
  Result := Doc.GetDocBinding('List', TXMLList, TargetNamespace) as IXMLList;
end;

function LoadList(const FileName: string): IXMLList;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('List', TXMLList, TargetNamespace) as IXMLList;
end;

function NewList: IXMLList;
begin
  Result := NewXMLDocument.GetDocBinding('List', TXMLList, TargetNamespace) as IXMLList;
end;

{ TXMLList }

procedure TXMLList.AfterConstruction;
begin
  RegisterChildNode('Values', TXMLValues);
  RegisterChildNode('Tables', TXMLTables);
  inherited;
end;

function TXMLList.Get_Clid: UnicodeString;
begin
  Result := AttributeNodes['clid'].Text;
end;

procedure TXMLList.Set_Clid(Value: UnicodeString);
begin
  SetAttribute('clid', Value);
end;

function TXMLList.Get_Taskclid: UnicodeString;
begin
  Result := AttributeNodes['taskclid'].Text;
end;

procedure TXMLList.Set_Taskclid(Value: UnicodeString);
begin
  SetAttribute('taskclid', Value);
end;

function TXMLList.Get_Stylename: UnicodeString;
begin
  Result := AttributeNodes['stylename'].Text;
end;

procedure TXMLList.Set_Stylename(Value: UnicodeString);
begin
  SetAttribute('stylename', Value);
end;

function TXMLList.Get_Styleclid: UnicodeString;
begin
  Result := AttributeNodes['styleclid'].Text;
end;

procedure TXMLList.Set_Styleclid(Value: UnicodeString);
begin
  SetAttribute('styleclid', Value);
end;

function TXMLList.Get_Values: IXMLValues;
begin
  Result := ChildNodes['Values'] as IXMLValues;
end;

function TXMLList.Get_Tables: IXMLTables;
begin
  Result := ChildNodes['Tables'] as IXMLTables;
end;

{ TXMLValues }

procedure TXMLValues.AfterConstruction;
begin
  RegisterChildNode('Field', TXMLField);
  ItemTag := 'Field';
  ItemInterface := IXMLField;
  inherited;
end;

function TXMLValues.Get_Field(Index: Integer): IXMLField;
begin
  Result := List[Index] as IXMLField;
end;

function TXMLValues.Add: IXMLField;
begin
  Result := AddItem(-1) as IXMLField;
end;

function TXMLValues.Insert(const Index: Integer): IXMLField;
begin
  Result := AddItem(Index) as IXMLField;
end;

{ TXMLField }

function TXMLField.Get_Field: UnicodeString;
begin
  Result := AttributeNodes['field'].Text;
end;

procedure TXMLField.Set_Field(Value: UnicodeString);
begin
  SetAttribute('field', Value);
end;

function TXMLField.Get_Fieldclid: UnicodeString;
begin
  Result := AttributeNodes['fieldclid'].Text;
end;

procedure TXMLField.Set_Fieldclid(Value: UnicodeString);
begin
  SetAttribute('fieldclid', Value);
end;

function TXMLField.Get_Ctrlclid: UnicodeString;
begin
  Result := AttributeNodes['ctrlclid'].Text;
end;

procedure TXMLField.Set_Ctrlclid(Value: UnicodeString);
begin
  SetAttribute('ctrlclid', Value);
end;

function TXMLField.Get_Header: UnicodeString;
begin
  Result := AttributeNodes['header'].Text;
end;

procedure TXMLField.Set_Header(Value: UnicodeString);
begin
  SetAttribute('header', Value);
end;

function TXMLField.Get_Width: Integer;
begin
  Result := AttributeNodes['width'].NodeValue;
end;

procedure TXMLField.Set_Width(Value: Integer);
begin
  SetAttribute('width', Value);
end;

function TXMLField.Get_Value: UnicodeString;
begin
  Result := ChildNodes['Value'].Text;
end;

procedure TXMLField.Set_Value(Value: UnicodeString);
begin
  ChildNodes['Value'].NodeValue := Value;
end;

{ TXMLTables }

procedure TXMLTables.AfterConstruction;
begin
  RegisterChildNode('Table', TXMLTable);
  ItemTag := 'Table';
  ItemInterface := IXMLTable;
  inherited;
end;

function TXMLTables.Get_Table(Index: Integer): IXMLTable;
begin
  Result := List[Index] as IXMLTable;
end;

function TXMLTables.Add: IXMLTable;
begin
  Result := AddItem(-1) as IXMLTable;
end;

function TXMLTables.Insert(const Index: Integer): IXMLTable;
begin
  Result := AddItem(Index) as IXMLTable;
end;

{ TXMLTable }

procedure TXMLTable.AfterConstruction;
begin
  RegisterChildNode('Header', TXMLHeader);
  RegisterChildNode('Rows', TXMLRows);
  inherited;
end;

function TXMLTable.Get_Ctrlclid: UnicodeString;
begin
  Result := AttributeNodes['ctrlclid'].Text;
end;

procedure TXMLTable.Set_Ctrlclid(Value: UnicodeString);
begin
  SetAttribute('ctrlclid', Value);
end;

function TXMLTable.Get_Field: UnicodeString;
begin
  Result := AttributeNodes['field'].Text;
end;

procedure TXMLTable.Set_Field(Value: UnicodeString);
begin
  SetAttribute('field', Value);
end;

function TXMLTable.Get_Fieldclid: UnicodeString;
begin
  Result := AttributeNodes['fieldclid'].Text;
end;

procedure TXMLTable.Set_Fieldclid(Value: UnicodeString);
begin
  SetAttribute('fieldclid', Value);
end;

function TXMLTable.Get_Header: IXMLHeader;
begin
  Result := ChildNodes['Header'] as IXMLHeader;
end;

function TXMLTable.Get_Rows: IXMLRows;
begin
  Result := ChildNodes['Rows'] as IXMLRows;
end;

{ TXMLHeader }

procedure TXMLHeader.AfterConstruction;
begin
  RegisterChildNode('Field', TXMLField);
  ItemTag := 'Field';
  ItemInterface := IXMLField;
  inherited;
end;

function TXMLHeader.Get_Field(Index: Integer): IXMLField;
begin
  Result := List[Index] as IXMLField;
end;

function TXMLHeader.Add: IXMLField;
begin
  Result := AddItem(-1) as IXMLField;
end;

function TXMLHeader.Insert(const Index: Integer): IXMLField;
begin
  Result := AddItem(Index) as IXMLField;
end;

{ TXMLRows }

procedure TXMLRows.AfterConstruction;
begin
  RegisterChildNode('Row', TXMLRow);
  ItemTag := 'Row';
  ItemInterface := IXMLRow;
  inherited;
end;

function TXMLRows.Get_Row(Index: Integer): IXMLRow;
begin
  Result := List[Index] as IXMLRow;
end;

function TXMLRows.Add: IXMLRow;
begin
  Result := AddItem(-1) as IXMLRow;
end;

function TXMLRows.Insert(const Index: Integer): IXMLRow;
begin
  Result := AddItem(Index) as IXMLRow;
end;

{ TXMLRow }

procedure TXMLRow.AfterConstruction;
begin
  ItemTag := 'Value';
  ItemInterface := IXMLNode;
  inherited;
end;

function TXMLRow.Get_Value(Index: Integer): UnicodeString;
begin
  Result := List[Index].Text;
end;

function TXMLRow.Add(const Value: UnicodeString): IXMLNode;
begin
  Result := AddItem(-1);
  Result.NodeValue := Value;
end;

function TXMLRow.Insert(const Index: Integer; const Value: UnicodeString): IXMLNode;
begin
  Result := AddItem(Index);
  Result.NodeValue := Value;
end;

{ TXMLData }

function TXMLData.Get_Field: UnicodeString;
begin
  Result := AttributeNodes['field'].Text;
end;

procedure TXMLData.Set_Field(Value: UnicodeString);
begin
  SetAttribute('field', Value);
end;

function TXMLData.Get_Fieldclid: UnicodeString;
begin
  Result := AttributeNodes['fieldclid'].Text;
end;

procedure TXMLData.Set_Fieldclid(Value: UnicodeString);
begin
  SetAttribute('fieldclid', Value);
end;

function TXMLData.Get_Value: UnicodeString;
begin
  Result := ChildNodes['Value'].Text;
end;

procedure TXMLData.Set_Value(Value: UnicodeString);
begin
  ChildNodes['Value'].NodeValue := Value;
end;

end.