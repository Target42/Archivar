unit i_datafields;

interface

uses
  System.Generics.Collections, System.Classes, Data.DB;

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
    function  getChilds : IDataFieldList;
    procedure setChilds( value : IDataFieldList);
    procedure config( const arr : array of TPropertyEntry);
    procedure setOwner( value : IDataFieldList );
    function  getOwner : IDataFieldList;
    procedure setGlobalName( value : string );
    function  getGlobalName : string;
  //public

    property Owner : IDataFieldList   read getOwner     write setOwner;
    property Name  : string           read GetName      write SetName;
    property CLID  : string           read GetCLID      write SetCLID;
    property Typ   : string           read GetTyp       write SetTyp;
    property Rem   : string           read getRem       write setRem;
    property isGlobal : boolean       read getIsGlobal  write setIsGlobal;
    property GlobalName : string      read getGlobalName write setGlobalName;

    property Properties : TList<IProperty> read GetItems;
    property Childs     : IDataFieldList read getChilds write setChilds;

    function getPropertyByName( name : string ) : IProperty;
    function propertyValue( name : string ) : string;

    procedure release;
    function clone : IDataField;
  end;

  TDataListChangeType = (dlcNew, dlcChange, dlcDelete );
  TDataListChange = procedure(event : TDataListChangeType; value : IDataField) of object;

  IDataFieldList = interface
    ['{6D8526CD-E42E-44C2-A2C1-FB879673DB1E}']
  // private
    procedure SetItems( inx : integer ; const value : IDataField );
    function  GetItems( inx : integer ) :IDataField;
    function  getCount : integer;
    procedure setOwner( value : IDataField );
    function  getOwner :IDataField;

  // public
    property Owner : IDataField read getOwner write setOwner;
    property Items[ inx : integer ] : IDataField read GetItems write SetItems;
    property Count : integer read getCount;

    function getByName( name : string ) : IDataField;
    function getByCLID( clid : string ) : IDataField;
    procedure add( value : IDataField );
    function newField( name, typ : string ) : IDataField;
    procedure delete( value : IDataField );

    procedure release;
    function clone : IDataFieldList;

    procedure RegisterListener( evt : TDataListChange );
    procedure UnregisterListener( evt : TDataListChange );
    procedure inform( event : TDataListChangeType; value : IDataField );
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
    function getOwner : IDataField;

    procedure setPtr( value : pointer );
    function  getPtr : Pointer;
  //public
    property Owner : IDataField   read getOwner;
    property Name  : string       read GetName    write SetName;
    property Typ   : string       read GetTyp     write SetTyp;
    property Value : string       read GetValue   write SetValue;
    property Ptr   : Pointer      read getPtr     write setPtr;

    function hasEditor : boolean;
    Function ShowEditor : boolean;

    function isList : Boolean;
    procedure fillList( list : TStrings );

    procedure release;
  end;

procedure DataTypeFillList( items : TStrings );
function DataTypeToDBType( name : string ) : string;

implementation

uses
  System.SysUtils;

const DataTypes : array[0..10] of string =
(
  'bool',   'date',   'datetime',   'enum',       'float',  'integer',
  'string', 'text',   'time',       'linktable',  'table'
);

const DBTypes : array[0..10] of string =
(
  'string', 'float',  'float',      'string',     'float',  'integer',
  'string', 'blob',   'float',      '',           ''
);

procedure DataTypeFillList( items : TStrings );
var
  i : integer;
begin
  for i := low(DataTypes) to high(DataTypes) do
    items.Add(DataTypes[i]);
end;

function DataTypeToDBType( name : string ) : string;
var
  i : integer;
begin
  Result := '';
  for i := low(DataTypes) to high(DataTypes) do begin
    if SameText( name, DataTypes[i]) then begin
      Result := DBTypes[i];
      break;
    end;
  end;

end;

end.
