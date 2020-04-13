unit i_datafields;

interface

uses
  System.Generics.Collections, System.Classes;

type
  IDataField = interface;
  IDataFieldList = interface;
  IProperty = interface;

  TPropertyEntry = record
    name  : string;
    typ   : string;
    value : string;
  end;

  IDataField = interface
    ['{AD022376-1FDB-410B-893E-24F4CA6B59AF}']
  //private
    procedure SetName( value : string );
    function  GetName : string;
    procedure SetCLID( value : string );
    function  GetCLID : string;
    procedure SetTyp( value : string );
    function  GetTyp : string;
    procedure setRem( value : string );
    function  getRem : string;
    procedure setIsGlobal( value : boolean );
    function  getIsGlobal : boolean;

    function  GetItems : TList<IProperty>;
    procedure config( const arr : array of TPropertyEntry);
  //public

    property Name  : string read GetName write SetName;
    property CLID  : string read GetCLID write SetCLID;
    property Typ   : string read GetTyp  write SetTyp;
    property Rem   : string read getRem write setRem;
    property isGlobal : boolean read getIsGlobal write setIsGlobal;

    property Items : TList<IProperty> read GetItems;
    function getPropertyByName( name : string ) : IProperty;

    procedure loadFromStream( st : TStream );
    procedure saveToStream(st  : TStream );

    procedure release;
  end;

  IDataFieldList = interface
    ['{6D8526CD-E42E-44C2-A2C1-FB879673DB1E}']
  // private
    procedure SetItems( inx : integer ; const value : IDataField );
    function  GetItems( inx : integer ) :IDataField;
  // public
    property Items[ inx : integer ] : IDataField read GetItems write SetItems;
    function getByName( name : string ) : IDataField;

    procedure release;
  end;

  IProperty = interface
    ['{37D4CDC4-61EE-4C7D-A480-3B636D2878EF}']
  //private
    procedure SetName( value : string );
    function  GetName : string;
    procedure SetTyp( value : string );
    function  GetTyp : string;
    procedure SetValue( value : string );
    function  GetValue : string;
  //public
    property Name  : string read GetName write SetName;
    property Typ   : string read GetTyp  write SetTyp;
    property Value : string read GetValue write SetValue;


    function isList : Boolean;
    procedure fillList( list : TStrings );

    procedure release;
  end;

procedure DataTypeFillList( items : TStrings );

implementation

procedure DataTypeFillList( items : TStrings );
begin
  items.Add('string');
  items.Add('integer');
  items.Add('date');
  items.Add('time');
  items.Add('datetime');
  items.Add('bool');
  items.Add('enum');
  items.Add('float');
  items.Add('text');

end;

end.
