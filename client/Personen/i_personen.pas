unit i_personen;

interface

type

  IPerson         = interface;
  IPersonenListe  = interface;


  IPersonenListe  = interface
    ['{4B270570-7FE2-492A-AA07-D98F1B1EF3A0}']
    // private
    procedure setName( value : string );
    function  getName : string;
    function  getCount : integer;
    procedure setItems( inx : integer; const value : IPerson );
    function  getItems( inx : integer ) :  IPerson;
    //püublic
    property  Name       : string  read getName      write setName;
    property  count      : integer read getCount;

    property  Items[inx : integer ] : IPerson read getItems write setItems;

    procedure add( value : IPerson );
    function  remove( value : IPerson ) : boolean;
    function  newPerson : IPerson;

    function  clone : IPersonenListe;
    procedure Assign( list : IPersonenListe );

    procedure release;
  end;

  IPerson         = interface
    ['{A7BF20E7-9927-40D3-B09F-026AAE7084C9}']
    //private
    procedure setID( value : integer );
    function  getID : integer;
    procedure setName( value : string );
    function  getName : string;
    procedure setVorname( value : string );
    function  getVorname : string;
    procedure setAbteilung( value : string );
    function  getAbteilung : string;
    procedure setOwner( value : IPersonenListe );
    function getOwner : IPersonenListe;
    procedure setRolle( value : string );
    function  getRolle : string;

    //public
    property Owner      : IPersonenListe  read getOwner     write setOwner;
    property ID         : integer         read getID        write setID;
    property Name       : string          read getName      write setName;
    property Vorname    : string          read getVorname   write setVorname;
    property Abteilung  : string          read getAbteilung write setAbteilung;
    property Rolle      : string          read getRolle     write setRolle;

    function clone : IPerson;

    procedure release;
  end;

implementation

end.
