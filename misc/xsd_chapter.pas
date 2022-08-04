
{****************************************************************************************************}
{                                                                                                    }
{                                          XML-Datenbindung                                          }
{                                                                                                    }
{         Generiert am: 04.04.2020 17:46:06                                                          }
{       Generiert von: d:\Users\steph\Documents\Embarcadero\Studio\Projekte\BER\client\chapter.xsd   }
{                                                                                                    }
{****************************************************************************************************}

unit xsd_chapter;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLChapter = interface;
  IXMLTop = interface;
  IXMLTopList = interface;

{ IXMLChapter }

  IXMLChapter = interface(IXMLNode)
    ['{A557F8CC-8F05-4F47-9639-428DFB5A2BD8}']
    { Eigenschaftszugriff }
    function Get_Id: Integer;
    function Get_Gr_id: Integer;
    function Get_Top: IXMLTopList;
    function Get_Rem: UnicodeString;
    procedure Set_Id(Value: Integer);
    procedure Set_Gr_id(Value: Integer);
    procedure Set_Rem(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Id: Integer read Get_Id write Set_Id;
    property Gr_id: Integer read Get_Gr_id write Set_Gr_id;
    property Top: IXMLTopList read Get_Top;
    property Rem: UnicodeString read Get_Rem write Set_Rem;
  end;

{ IXMLTop }

  IXMLTop = interface(IXMLNode)
    ['{48DE77D2-E22B-48F0-9868-58D80EBCE034}']
    { Eigenschaftszugriff }
    function Get_Id: Integer;
    function Get_Pid: Integer;
    function Get_Titel: UnicodeString;
    function Get_Numbering: Boolean;
    function Get_Nr: Integer;
    function Get_Taid: Integer;
    function Get_Rem: UnicodeString;
    procedure Set_Id(Value: Integer);
    procedure Set_Pid(Value: Integer);
    procedure Set_Titel(Value: UnicodeString);
    procedure Set_Numbering(Value: Boolean);
    procedure Set_Nr(Value: Integer);
    procedure Set_Taid(Value: Integer);
    procedure Set_Rem(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Id: Integer read Get_Id write Set_Id;
    property Pid: Integer read Get_Pid write Set_Pid;
    property Titel: UnicodeString read Get_Titel write Set_Titel;
    property Numbering: Boolean read Get_Numbering write Set_Numbering;
    property Nr: Integer read Get_Nr write Set_Nr;
    property Taid: Integer read Get_Taid write Set_Taid;
    property Rem: UnicodeString read Get_Rem write Set_Rem;
  end;

{ IXMLTopList }

  IXMLTopList = interface(IXMLNodeCollection)
    ['{7A738CC2-4745-43F4-8D9C-CB265EDD242A}']
    { Methoden & Eigenschaften }
    function Add: IXMLTop;
    function Insert(const Index: Integer): IXMLTop;

    function Get_Item(Index: Integer): IXMLTop;
    property Items[Index: Integer]: IXMLTop read Get_Item; default;
  end;

{ Forward-Deklarationen }

  TXMLChapter = class;
  TXMLTop = class;
  TXMLTopList = class;

{ TXMLChapter }

  TXMLChapter = class(TXMLNode, IXMLChapter)
  private
    FTop: IXMLTopList;
  protected
    { IXMLChapter }
    function Get_Id: Integer;
    function Get_Gr_id: Integer;
    function Get_Top: IXMLTopList;
    function Get_Rem: UnicodeString;
    procedure Set_Id(Value: Integer);
    procedure Set_Gr_id(Value: Integer);
    procedure Set_Rem(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTop }

  TXMLTop = class(TXMLNode, IXMLTop)
  protected
    { IXMLTop }
    function Get_Id: Integer;
    function Get_Pid: Integer;
    function Get_Titel: UnicodeString;
    function Get_Numbering: Boolean;
    function Get_Nr: Integer;
    function Get_Taid: Integer;
    function Get_Rem: UnicodeString;
    procedure Set_Id(Value: Integer);
    procedure Set_Pid(Value: Integer);
    procedure Set_Titel(Value: UnicodeString);
    procedure Set_Numbering(Value: Boolean);
    procedure Set_Nr(Value: Integer);
    procedure Set_Taid(Value: Integer);
    procedure Set_Rem(Value: UnicodeString);
  end;

{ TXMLTopList }

  TXMLTopList = class(TXMLNodeCollection, IXMLTopList)
  protected
    { IXMLTopList }
    function Add: IXMLTop;
    function Insert(const Index: Integer): IXMLTop;

    function Get_Item(Index: Integer): IXMLTop;
  end;

{ Globale Funktionen }

function GetChapter(Doc: IXMLDocument): IXMLChapter;
function LoadChapter(const FileName: string): IXMLChapter;
function NewChapter: IXMLChapter;

const
  TargetNamespace = '';

implementation



{ Globale Funktionen }

function GetChapter(Doc: IXMLDocument): IXMLChapter;
begin
  Result := Doc.GetDocBinding('Chapter', TXMLChapter, TargetNamespace) as IXMLChapter;
end;

function LoadChapter(const FileName: string): IXMLChapter;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Chapter', TXMLChapter, TargetNamespace) as IXMLChapter;
end;

function NewChapter: IXMLChapter;
begin
  Result := NewXMLDocument.GetDocBinding('Chapter', TXMLChapter, TargetNamespace) as IXMLChapter;
end;

{ TXMLChapter }

procedure TXMLChapter.AfterConstruction;
begin
  RegisterChildNode('top', TXMLTop);
  FTop := CreateCollection(TXMLTopList, IXMLTop, 'top') as IXMLTopList;
  inherited;
end;

function TXMLChapter.Get_Id: Integer;
begin
  Result := AttributeNodes['id'].NodeValue;
end;

procedure TXMLChapter.Set_Id(Value: Integer);
begin
  SetAttribute('id', Value);
end;

function TXMLChapter.Get_Gr_id: Integer;
begin
  Result := AttributeNodes['gr_id'].NodeValue;
end;

procedure TXMLChapter.Set_Gr_id(Value: Integer);
begin
  SetAttribute('gr_id', Value);
end;

function TXMLChapter.Get_Top: IXMLTopList;
begin
  Result := FTop;
end;

function TXMLChapter.Get_Rem: UnicodeString;
begin
  Result := ChildNodes['Rem'].Text;
end;

procedure TXMLChapter.Set_Rem(Value: UnicodeString);
begin
  ChildNodes['Rem'].NodeValue := Value;
end;

{ TXMLTop }

function TXMLTop.Get_Id: Integer;
begin
  Result := AttributeNodes['id'].NodeValue;
end;

procedure TXMLTop.Set_Id(Value: Integer);
begin
  SetAttribute('id', Value);
end;

function TXMLTop.Get_Pid: Integer;
begin
  Result := AttributeNodes['pid'].NodeValue;
end;

procedure TXMLTop.Set_Pid(Value: Integer);
begin
  SetAttribute('pid', Value);
end;

function TXMLTop.Get_Titel: UnicodeString;
begin
  Result := AttributeNodes['titel'].Text;
end;

procedure TXMLTop.Set_Titel(Value: UnicodeString);
begin
  SetAttribute('titel', Value);
end;

function TXMLTop.Get_Numbering: Boolean;
begin
  Result := AttributeNodes['numbering'].NodeValue;
end;

procedure TXMLTop.Set_Numbering(Value: Boolean);
begin
  SetAttribute('numbering', Value);
end;

function TXMLTop.Get_Nr: Integer;
begin
  Result := AttributeNodes['nr'].NodeValue;
end;

procedure TXMLTop.Set_Nr(Value: Integer);
begin
  SetAttribute('nr', Value);
end;

function TXMLTop.Get_Taid: Integer;
begin
  Result := AttributeNodes['taid'].NodeValue;
end;

procedure TXMLTop.Set_Taid(Value: Integer);
begin
  SetAttribute('taid', Value);
end;

function TXMLTop.Get_Rem: UnicodeString;
begin
  Result := ChildNodes['Rem'].Text;
end;

procedure TXMLTop.Set_Rem(Value: UnicodeString);
begin
  ChildNodes['Rem'].NodeValue := Value;
end;

{ TXMLTopList }

function TXMLTopList.Add: IXMLTop;
begin
  Result := AddItem(-1) as IXMLTop;
end;

function TXMLTopList.Insert(const Index: Integer): IXMLTop;
begin
  Result := AddItem(Index) as IXMLTop;
end;

function TXMLTopList.Get_Item(Index: Integer): IXMLTop;
begin
  Result := List[Index] as IXMLTop;
end;

end.