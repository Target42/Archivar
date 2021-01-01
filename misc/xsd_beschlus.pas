
{*********************************************************}
{                                                         }
{                    XML-Datenbindung                     }
{                                                         }
{         Generiert am: 28.12.2020 20:12:56               }
{       Generiert von: D:\git\ber.git\misc\beschlus.xsd   }
{                                                         }
{*********************************************************}

unit xsd_beschlus;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLBeschlus = interface;
  IXMLGremium = interface;
  IXMLTeilnehmer = interface;
  IXMLNichtAbgestimmt = interface;
  IXMLAbstimmung = interface;

{ IXMLBeschlus }

  IXMLBeschlus = interface(IXMLNode)
    ['{53C29FC1-DDB2-43D0-9CDF-C52984723D11}']
    { Eigenschaftszugriff }
    function Get_Datum: UnicodeString;
    function Get_Zeit: UnicodeString;
    function Get_Titel: UnicodeString;
    function Get_Gremium: IXMLGremium;
    function Get_NichtAbgestimmt: IXMLNichtAbgestimmt;
    function Get_Abstimmung: IXMLAbstimmung;
    function Get_Rem: UnicodeString;
    procedure Set_Datum(Value: UnicodeString);
    procedure Set_Zeit(Value: UnicodeString);
    procedure Set_Titel(Value: UnicodeString);
    procedure Set_Rem(Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Datum: UnicodeString read Get_Datum write Set_Datum;
    property Zeit: UnicodeString read Get_Zeit write Set_Zeit;
    property Titel: UnicodeString read Get_Titel write Set_Titel;
    property Gremium: IXMLGremium read Get_Gremium;
    property NichtAbgestimmt: IXMLNichtAbgestimmt read Get_NichtAbgestimmt;
    property Abstimmung: IXMLAbstimmung read Get_Abstimmung;
    property Rem: UnicodeString read Get_Rem write Set_Rem;
  end;

{ IXMLGremium }

  IXMLGremium = interface(IXMLNodeCollection)
    ['{BB910610-351C-472F-B696-E06AEB76D148}']
    { Eigenschaftszugriff }
    function Get_Teilnehmer(Index: Integer): IXMLTeilnehmer;
    { Methoden & Eigenschaften }
    function Add: IXMLTeilnehmer;
    function Insert(const Index: Integer): IXMLTeilnehmer;
    property Teilnehmer[Index: Integer]: IXMLTeilnehmer read Get_Teilnehmer; default;
  end;

{ IXMLTeilnehmer }

  IXMLTeilnehmer = interface(IXMLNode)
    ['{9DED6A7E-DAEC-43F1-B0BC-8D95066753AE}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Vorname: UnicodeString;
    function Get_Dept: UnicodeString;
    function Get_Anwesend: Boolean;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Vorname(Value: UnicodeString);
    procedure Set_Dept(Value: UnicodeString);
    procedure Set_Anwesend(Value: Boolean);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Vorname: UnicodeString read Get_Vorname write Set_Vorname;
    property Dept: UnicodeString read Get_Dept write Set_Dept;
    property Anwesend: Boolean read Get_Anwesend write Set_Anwesend;
  end;

{ IXMLNichtAbgestimmt }

  IXMLNichtAbgestimmt = interface(IXMLNodeCollection)
    ['{9F9CE5E6-7B87-4D38-BE8E-4EF9B1C19ED5}']
    { Eigenschaftszugriff }
    function Get_Teilnehmer(Index: Integer): IXMLTeilnehmer;
    { Methoden & Eigenschaften }
    function Add: IXMLTeilnehmer;
    function Insert(const Index: Integer): IXMLTeilnehmer;
    property Teilnehmer[Index: Integer]: IXMLTeilnehmer read Get_Teilnehmer; default;
  end;

{ IXMLAbstimmung }

  IXMLAbstimmung = interface(IXMLNode)
    ['{25A6D91E-99EB-4F76-BAFD-4B43D7E5CBED}']
    { Eigenschaftszugriff }
    function Get_Ja: Integer;
    function Get_Nein: Integer;
    function Get_Un: Integer;
    function Get_Nicht: Integer;
    procedure Set_Ja(Value: Integer);
    procedure Set_Nein(Value: Integer);
    procedure Set_Un(Value: Integer);
    procedure Set_Nicht(Value: Integer);
    { Methoden & Eigenschaften }
    property Ja: Integer read Get_Ja write Set_Ja;
    property Nein: Integer read Get_Nein write Set_Nein;
    property Un: Integer read Get_Un write Set_Un;
    property Nicht: Integer read Get_Nicht write Set_Nicht;
  end;

{ Forward-Deklarationen }

  TXMLBeschlus = class;
  TXMLGremium = class;
  TXMLTeilnehmer = class;
  TXMLNichtAbgestimmt = class;
  TXMLAbstimmung = class;

{ TXMLBeschlus }

  TXMLBeschlus = class(TXMLNode, IXMLBeschlus)
  protected
    { IXMLBeschlus }
    function Get_Datum: UnicodeString;
    function Get_Zeit: UnicodeString;
    function Get_Titel: UnicodeString;
    function Get_Gremium: IXMLGremium;
    function Get_NichtAbgestimmt: IXMLNichtAbgestimmt;
    function Get_Abstimmung: IXMLAbstimmung;
    function Get_Rem: UnicodeString;
    procedure Set_Datum(Value: UnicodeString);
    procedure Set_Zeit(Value: UnicodeString);
    procedure Set_Titel(Value: UnicodeString);
    procedure Set_Rem(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGremium }

  TXMLGremium = class(TXMLNodeCollection, IXMLGremium)
  protected
    { IXMLGremium }
    function Get_Teilnehmer(Index: Integer): IXMLTeilnehmer;
    function Add: IXMLTeilnehmer;
    function Insert(const Index: Integer): IXMLTeilnehmer;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTeilnehmer }

  TXMLTeilnehmer = class(TXMLNode, IXMLTeilnehmer)
  protected
    { IXMLTeilnehmer }
    function Get_Name: UnicodeString;
    function Get_Vorname: UnicodeString;
    function Get_Dept: UnicodeString;
    function Get_Anwesend: Boolean;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Vorname(Value: UnicodeString);
    procedure Set_Dept(Value: UnicodeString);
    procedure Set_Anwesend(Value: Boolean);
  end;

{ TXMLNichtAbgestimmt }

  TXMLNichtAbgestimmt = class(TXMLNodeCollection, IXMLNichtAbgestimmt)
  protected
    { IXMLNichtAbgestimmt }
    function Get_Teilnehmer(Index: Integer): IXMLTeilnehmer;
    function Add: IXMLTeilnehmer;
    function Insert(const Index: Integer): IXMLTeilnehmer;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLAbstimmung }

  TXMLAbstimmung = class(TXMLNode, IXMLAbstimmung)
  protected
    { IXMLAbstimmung }
    function Get_Ja: Integer;
    function Get_Nein: Integer;
    function Get_Un: Integer;
    function Get_Nicht: Integer;
    procedure Set_Ja(Value: Integer);
    procedure Set_Nein(Value: Integer);
    procedure Set_Un(Value: Integer);
    procedure Set_Nicht(Value: Integer);
  end;

{ Globale Funktionen }

function GetBeschlus(Doc: IXMLDocument): IXMLBeschlus;
function LoadBeschlus(const FileName: string): IXMLBeschlus;
function NewBeschlus: IXMLBeschlus;

const
  TargetNamespace = '';

implementation

uses Xml.xmlutil;

{ Globale Funktionen }

function GetBeschlus(Doc: IXMLDocument): IXMLBeschlus;
begin
  Result := Doc.GetDocBinding('Beschlus', TXMLBeschlus, TargetNamespace) as IXMLBeschlus;
end;

function LoadBeschlus(const FileName: string): IXMLBeschlus;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Beschlus', TXMLBeschlus, TargetNamespace) as IXMLBeschlus;
end;

function NewBeschlus: IXMLBeschlus;
begin
  Result := NewXMLDocument.GetDocBinding('Beschlus', TXMLBeschlus, TargetNamespace) as IXMLBeschlus;
end;

{ TXMLBeschlus }

procedure TXMLBeschlus.AfterConstruction;
begin
  RegisterChildNode('Gremium', TXMLGremium);
  RegisterChildNode('NichtAbgestimmt', TXMLNichtAbgestimmt);
  RegisterChildNode('Abstimmung', TXMLAbstimmung);
  inherited;
end;

function TXMLBeschlus.Get_Datum: UnicodeString;
begin
  Result := AttributeNodes['datum'].Text;
end;

procedure TXMLBeschlus.Set_Datum(Value: UnicodeString);
begin
  SetAttribute('datum', Value);
end;

function TXMLBeschlus.Get_Zeit: UnicodeString;
begin
  Result := AttributeNodes['zeit'].Text;
end;

procedure TXMLBeschlus.Set_Zeit(Value: UnicodeString);
begin
  SetAttribute('zeit', Value);
end;

function TXMLBeschlus.Get_Titel: UnicodeString;
begin
  Result := AttributeNodes['titel'].Text;
end;

procedure TXMLBeschlus.Set_Titel(Value: UnicodeString);
begin
  SetAttribute('titel', Value);
end;

function TXMLBeschlus.Get_Gremium: IXMLGremium;
begin
  Result := ChildNodes['Gremium'] as IXMLGremium;
end;

function TXMLBeschlus.Get_NichtAbgestimmt: IXMLNichtAbgestimmt;
begin
  Result := ChildNodes['NichtAbgestimmt'] as IXMLNichtAbgestimmt;
end;

function TXMLBeschlus.Get_Abstimmung: IXMLAbstimmung;
begin
  Result := ChildNodes['Abstimmung'] as IXMLAbstimmung;
end;

function TXMLBeschlus.Get_Rem: UnicodeString;
begin
  Result := ChildNodes['Rem'].Text;
end;

procedure TXMLBeschlus.Set_Rem(Value: UnicodeString);
begin
  ChildNodes['Rem'].NodeValue := Value;
end;

{ TXMLGremium }

procedure TXMLGremium.AfterConstruction;
begin
  RegisterChildNode('Teilnehmer', TXMLTeilnehmer);
  ItemTag := 'Teilnehmer';
  ItemInterface := IXMLTeilnehmer;
  inherited;
end;

function TXMLGremium.Get_Teilnehmer(Index: Integer): IXMLTeilnehmer;
begin
  Result := List[Index] as IXMLTeilnehmer;
end;

function TXMLGremium.Add: IXMLTeilnehmer;
begin
  Result := AddItem(-1) as IXMLTeilnehmer;
end;

function TXMLGremium.Insert(const Index: Integer): IXMLTeilnehmer;
begin
  Result := AddItem(Index) as IXMLTeilnehmer;
end;

{ TXMLTeilnehmer }

function TXMLTeilnehmer.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLTeilnehmer.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLTeilnehmer.Get_Vorname: UnicodeString;
begin
  Result := AttributeNodes['vorname'].Text;
end;

procedure TXMLTeilnehmer.Set_Vorname(Value: UnicodeString);
begin
  SetAttribute('vorname', Value);
end;

function TXMLTeilnehmer.Get_Dept: UnicodeString;
begin
  Result := AttributeNodes['dept'].Text;
end;

procedure TXMLTeilnehmer.Set_Dept(Value: UnicodeString);
begin
  SetAttribute('dept', Value);
end;

function TXMLTeilnehmer.Get_Anwesend: Boolean;
begin
  Result := AttributeNodes['anwesend'].NodeValue;
end;

procedure TXMLTeilnehmer.Set_Anwesend(Value: Boolean);
begin
  SetAttribute('anwesend', Value);
end;

{ TXMLNichtAbgestimmt }

procedure TXMLNichtAbgestimmt.AfterConstruction;
begin
  RegisterChildNode('Teilnehmer', TXMLTeilnehmer);
  ItemTag := 'Teilnehmer';
  ItemInterface := IXMLTeilnehmer;
  inherited;
end;

function TXMLNichtAbgestimmt.Get_Teilnehmer(Index: Integer): IXMLTeilnehmer;
begin
  Result := List[Index] as IXMLTeilnehmer;
end;

function TXMLNichtAbgestimmt.Add: IXMLTeilnehmer;
begin
  Result := AddItem(-1) as IXMLTeilnehmer;
end;

function TXMLNichtAbgestimmt.Insert(const Index: Integer): IXMLTeilnehmer;
begin
  Result := AddItem(Index) as IXMLTeilnehmer;
end;

{ TXMLAbstimmung }

function TXMLAbstimmung.Get_Ja: Integer;
begin
  Result := AttributeNodes['ja'].NodeValue;
end;

procedure TXMLAbstimmung.Set_Ja(Value: Integer);
begin
  SetAttribute('ja', Value);
end;

function TXMLAbstimmung.Get_Nein: Integer;
begin
  Result := AttributeNodes['nein'].NodeValue;
end;

procedure TXMLAbstimmung.Set_Nein(Value: Integer);
begin
  SetAttribute('nein', Value);
end;

function TXMLAbstimmung.Get_Un: Integer;
begin
  Result := AttributeNodes['un'].NodeValue;
end;

procedure TXMLAbstimmung.Set_Un(Value: Integer);
begin
  SetAttribute('un', Value);
end;

function TXMLAbstimmung.Get_Nicht: Integer;
begin
  Result := AttributeNodes['Nicht'].NodeValue;
end;

procedure TXMLAbstimmung.Set_Nicht(Value: Integer);
begin
  SetAttribute('Nicht', Value);
end;

end.