
{*********************************************************}
{                                                         }
{                    XML-Datenbindung                     }
{                                                         }
{         Generiert am: 30.04.2020 20:08:53               }
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
    ['{D5D48D2F-7189-420E-9682-0E47FBABF8C6}']
    { Eigenschaftszugriff }
    function Get_Clid: UnicodeString;
    function Get_Taskclid: UnicodeString;
    function Get_Values: IXMLValues;
    function Get_Tables: IXMLTables;
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_Taskclid(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Clid: UnicodeString read Get_Clid write Set_Clid;
    property Taskclid: UnicodeString read Get_Taskclid write Set_Taskclid;
    property Values: IXMLValues read Get_Values;
    property Tables: IXMLTables read Get_Tables;
  end;

{ IXMLValues }

  IXMLValues = interface(IXMLNodeCollection)
    ['{9E212422-DCD2-4BE5-ADD6-F0BB1BB96B3C}']
    { Eigenschaftszugriff }
    function Get_Field(Index: Integer): IXMLField;
    { Methoden & Eigenschaften }
    function Add: IXMLField;
    function Insert(const Index: Integer): IXMLField;
    property Field[Index: Integer]: IXMLField read Get_Field; default;
  end;

{ IXMLField }

  IXMLField = interface(IXMLNode)
    ['{AFEFF36E-7A8A-4825-A6EA-F7A058F9DB90}']
    { Eigenschaftszugriff }
    function Get_Field: UnicodeString;
    function Get_Fieldclid: UnicodeString;
    function Get_Ctrlclid: UnicodeString;
    function Get_Header: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_Field(Value: UnicodeString);
    procedure Set_Fieldclid(Value: UnicodeString);
    procedure Set_Ctrlclid(Value: UnicodeString);
    procedure Set_Header(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Field: UnicodeString read Get_Field write Set_Field;
    property Fieldclid: UnicodeString read Get_Fieldclid write Set_Fieldclid;
    property Ctrlclid: UnicodeString read Get_Ctrlclid write Set_Ctrlclid;
    property Header: UnicodeString read Get_Header write Set_Header;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLTables }

  IXMLTables = interface(IXMLNodeCollection)
    ['{CCCFFED2-CCF3-4E95-B4FF-849E0CF41FA7}']
    { Eigenschaftszugriff }
    function Get_Table(Index: Integer): IXMLTable;
    { Methoden & Eigenschaften }
    function Add: IXMLTable;
    function Insert(const Index: Integer): IXMLTable;
    property Table[Index: Integer]: IXMLTable read Get_Table; default;
  end;

{ IXMLTable }

  IXMLTable = interface(IXMLNode)
    ['{3BA085B4-EC8C-4800-9E26-7D0A67E97530}']
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
    ['{EC703F29-4863-4273-8B3C-E1C6121C94F4}']
    { Eigenschaftszugriff }
    function Get_Field(Index: Integer): IXMLField;
    { Methoden & Eigenschaften }
    function Add: IXMLField;
    function Insert(const Index: Integer): IXMLField;
    property Field[Index: Integer]: IXMLField read Get_Field; default;
  end;

{ IXMLRows }

  IXMLRows = interface(IXMLNodeCollection)
    ['{C52C0F00-453D-471D-B8F6-ADD6FA73EDD5}']
    { Eigenschaftszugriff }
    function Get_Row(Index: Integer): IXMLRow;
    { Methoden & Eigenschaften }
    function Add: IXMLRow;
    function Insert(const Index: Integer): IXMLRow;
    property Row[Index: Integer]: IXMLRow read Get_Row; default;
  end;

{ IXMLRow }

  IXMLRow = interface(IXMLNodeCollection)
    ['{EFBFD359-7E56-4257-95EA-45AF74DD5466}']
    { Eigenschaftszugriff }
    function Get_Value(Index: Integer): UnicodeString;
    { Methoden & Eigenschaften }
    function Add(const Value: UnicodeString): IXMLNode;
    function Insert(const Index: Integer; const Value: UnicodeString): IXMLNode;
    property Value[Index: Integer]: UnicodeString read Get_Value; default;
  end;

{ IXMLData }

  IXMLData = interface(IXMLNode)
    ['{FEEDA16E-7D9E-45D1-9673-18B2748759BF}']
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
    function Get_Values: IXMLValues;
    function Get_Tables: IXMLTables;
    procedure Set_Clid(Value: UnicodeString);
    procedure Set_Taskclid(Value: UnicodeString);
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
    function Get_Value: UnicodeString;
    procedure Set_Field(Value: UnicodeString);
    procedure Set_Fieldclid(Value: UnicodeString);
    procedure Set_Ctrlclid(Value: UnicodeString);
    procedure Set_Header(Value: UnicodeString);
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