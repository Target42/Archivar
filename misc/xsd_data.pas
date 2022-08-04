
{*************************************************************************************************}
{                                                                                                 }
{                                        XML-Datenbindung                                         }
{                                                                                                 }
{         Generiert am: 07.03.2020 12:14:29                                                       }
{       Generiert von: d:\Users\steph\Documents\Embarcadero\Studio\Projekte\BER\client\data.xsd   }
{                                                                                                 }
{*************************************************************************************************}

unit xsd_data;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLAddInfo = interface;
  IXMLHistory = interface;
  IXMLHistroyEelemnt = interface;
  IXMLDatafields = interface;
  IXMLDatafield = interface;

{ IXMLAddInfo }

  IXMLAddInfo = interface(IXMLNode)
    ['{3F5746F7-FCB6-4AF8-B1E3-6A6A4359B252}']
    { Eigenschaftszugriff }
    function Get_Rem: UnicodeString;
    function Get_History: IXMLHistory;
    function Get_Datafields: IXMLDatafields;
    procedure Set_Rem(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Rem: UnicodeString read Get_Rem write Set_Rem;
    property History: IXMLHistory read Get_History;
    property Datafields: IXMLDatafields read Get_Datafields;
  end;

{ IXMLHistory }

  IXMLHistory = interface(IXMLNodeCollection)
    ['{B0549942-3AEF-4542-97A3-DE2A1914F716}']
    { Eigenschaftszugriff }
    function Get_HistroyEelemnt(Index: Integer): IXMLHistroyEelemnt;
    { Methoden & Eigenschaften }
    function Add: IXMLHistroyEelemnt;
    function Insert(const Index: Integer): IXMLHistroyEelemnt;
    property HistroyEelemnt[Index: Integer]: IXMLHistroyEelemnt read Get_HistroyEelemnt; default;
  end;

{ IXMLHistroyEelemnt }

  IXMLHistroyEelemnt = interface(IXMLNode)
    ['{501E4688-1BA1-442C-A1B3-C025E2C20014}']
    { Eigenschaftszugriff }
    function Get_TimeStamp: UnicodeString;
    function Get_User: UnicodeString;
    function Get_Rem: UnicodeString;
    procedure Set_TimeStamp(Value: UnicodeString);
    procedure Set_User(Value: UnicodeString);
    procedure Set_Rem(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property TimeStamp: UnicodeString read Get_TimeStamp write Set_TimeStamp;
    property User: UnicodeString read Get_User write Set_User;
    property Rem: UnicodeString read Get_Rem write Set_Rem;
  end;

{ IXMLDatafields }

  IXMLDatafields = interface(IXMLNodeCollection)
    ['{52159CA8-3931-4108-9065-FDF59A1A3ED9}']
    { Eigenschaftszugriff }
    function Get_Datafield(Index: Integer): IXMLDatafield;
    { Methoden & Eigenschaften }
    function Add: IXMLDatafield;
    function Insert(const Index: Integer): IXMLDatafield;
    property Datafield[Index: Integer]: IXMLDatafield read Get_Datafield; default;
  end;

{ IXMLDatafield }

  IXMLDatafield = interface(IXMLNode)
    ['{B8BED055-0E80-47D0-B935-9223C8148181}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Datatype: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Datatype(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Datatype: UnicodeString read Get_Datatype write Set_Datatype;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ Forward-Deklarationen }

  TXMLAddInfo = class;
  TXMLHistory = class;
  TXMLHistroyEelemnt = class;
  TXMLDatafields = class;
  TXMLDatafield = class;

{ TXMLAddInfo }

  TXMLAddInfo = class(TXMLNode, IXMLAddInfo)
  protected
    { IXMLAddInfo }
    function Get_Rem: UnicodeString;
    function Get_History: IXMLHistory;
    function Get_Datafields: IXMLDatafields;
    procedure Set_Rem(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLHistory }

  TXMLHistory = class(TXMLNodeCollection, IXMLHistory)
  protected
    { IXMLHistory }
    function Get_HistroyEelemnt(Index: Integer): IXMLHistroyEelemnt;
    function Add: IXMLHistroyEelemnt;
    function Insert(const Index: Integer): IXMLHistroyEelemnt;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLHistroyEelemnt }

  TXMLHistroyEelemnt = class(TXMLNode, IXMLHistroyEelemnt)
  protected
    { IXMLHistroyEelemnt }
    function Get_TimeStamp: UnicodeString;
    function Get_User: UnicodeString;
    function Get_Rem: UnicodeString;
    procedure Set_TimeStamp(Value: UnicodeString);
    procedure Set_User(Value: UnicodeString);
    procedure Set_Rem(Value: UnicodeString);
  end;

{ TXMLDatafields }

  TXMLDatafields = class(TXMLNodeCollection, IXMLDatafields)
  protected
    { IXMLDatafields }
    function Get_Datafield(Index: Integer): IXMLDatafield;
    function Add: IXMLDatafield;
    function Insert(const Index: Integer): IXMLDatafield;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDatafield }

  TXMLDatafield = class(TXMLNode, IXMLDatafield)
  protected
    { IXMLDatafield }
    function Get_Name: UnicodeString;
    function Get_Datatype: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Datatype(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ Globale Funktionen }

function GetAddInfo(Doc: IXMLDocument): IXMLAddInfo;
function LoadAddInfo(const FileName: string): IXMLAddInfo;
function NewAddInfo: IXMLAddInfo;

const
  TargetNamespace = '';

implementation



{ Globale Funktionen }

function GetAddInfo(Doc: IXMLDocument): IXMLAddInfo;
begin
  Result := Doc.GetDocBinding('AddInfo', TXMLAddInfo, TargetNamespace) as IXMLAddInfo;
end;

function LoadAddInfo(const FileName: string): IXMLAddInfo;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('AddInfo', TXMLAddInfo, TargetNamespace) as IXMLAddInfo;
end;

function NewAddInfo: IXMLAddInfo;
begin
  Result := NewXMLDocument.GetDocBinding('AddInfo', TXMLAddInfo, TargetNamespace) as IXMLAddInfo;
end;

{ TXMLAddInfo }

procedure TXMLAddInfo.AfterConstruction;
begin
  RegisterChildNode('History', TXMLHistory);
  RegisterChildNode('Datafields', TXMLDatafields);
  inherited;
end;

function TXMLAddInfo.Get_Rem: UnicodeString;
begin
  Result := ChildNodes['Rem'].Text;
end;

procedure TXMLAddInfo.Set_Rem(Value: UnicodeString);
begin
  ChildNodes['Rem'].NodeValue := Value;
end;

function TXMLAddInfo.Get_History: IXMLHistory;
begin
  Result := ChildNodes['History'] as IXMLHistory;
end;

function TXMLAddInfo.Get_Datafields: IXMLDatafields;
begin
  Result := ChildNodes['Datafields'] as IXMLDatafields;
end;

{ TXMLHistory }

procedure TXMLHistory.AfterConstruction;
begin
  RegisterChildNode('HistroyEelemnt', TXMLHistroyEelemnt);
  ItemTag := 'HistroyEelemnt';
  ItemInterface := IXMLHistroyEelemnt;
  inherited;
end;

function TXMLHistory.Get_HistroyEelemnt(Index: Integer): IXMLHistroyEelemnt;
begin
  Result := List[Index] as IXMLHistroyEelemnt;
end;

function TXMLHistory.Add: IXMLHistroyEelemnt;
begin
  Result := AddItem(-1) as IXMLHistroyEelemnt;
end;

function TXMLHistory.Insert(const Index: Integer): IXMLHistroyEelemnt;
begin
  Result := AddItem(Index) as IXMLHistroyEelemnt;
end;

{ TXMLHistroyEelemnt }

function TXMLHistroyEelemnt.Get_TimeStamp: UnicodeString;
begin
  Result := AttributeNodes['TimeStamp'].Text;
end;

procedure TXMLHistroyEelemnt.Set_TimeStamp(Value: UnicodeString);
begin
  SetAttribute('TimeStamp', Value);
end;

function TXMLHistroyEelemnt.Get_User: UnicodeString;
begin
  Result := AttributeNodes['User'].Text;
end;

procedure TXMLHistroyEelemnt.Set_User(Value: UnicodeString);
begin
  SetAttribute('User', Value);
end;

function TXMLHistroyEelemnt.Get_Rem: UnicodeString;
begin
  Result := ChildNodes['Rem'].Text;
end;

procedure TXMLHistroyEelemnt.Set_Rem(Value: UnicodeString);
begin
  ChildNodes['Rem'].NodeValue := Value;
end;

{ TXMLDatafields }

procedure TXMLDatafields.AfterConstruction;
begin
  RegisterChildNode('Datafield', TXMLDatafield);
  ItemTag := 'Datafield';
  ItemInterface := IXMLDatafield;
  inherited;
end;

function TXMLDatafields.Get_Datafield(Index: Integer): IXMLDatafield;
begin
  Result := List[Index] as IXMLDatafield;
end;

function TXMLDatafields.Add: IXMLDatafield;
begin
  Result := AddItem(-1) as IXMLDatafield;
end;

function TXMLDatafields.Insert(const Index: Integer): IXMLDatafield;
begin
  Result := AddItem(Index) as IXMLDatafield;
end;

{ TXMLDatafield }

function TXMLDatafield.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLDatafield.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLDatafield.Get_Datatype: UnicodeString;
begin
  Result := AttributeNodes['datatype'].Text;
end;

procedure TXMLDatafield.Set_Datatype(Value: UnicodeString);
begin
  SetAttribute('datatype', Value);
end;

function TXMLDatafield.Get_Value: UnicodeString;
begin
  Result := ChildNodes['value'].Text;
end;

procedure TXMLDatafield.Set_Value(Value: UnicodeString);
begin
  ChildNodes['value'].NodeValue := Value;
end;

end.