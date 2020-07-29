unit i_beschluss;

interface

uses
  i_personen;

type
  IBeschluss    = interface;
  IAbstimmungen = interface;
  IAbstimmung   = interface;


  IBeschluss  = interface
    ['{F88CA754-CE8F-41B4-A880-61E4538BD72F}']
    // private
    procedure setText( value : string );
    function  getText : string;
    function  getAbstimmungen : IAbstimmungen;
    // public
    property Text         : string        read getText          write setText;
    property Abstimmungen : IAbstimmungen read getAbstimmungen ;

    procedure Release;
  end;

  IAbstimmungen = interface
    ['{DB6E3B28-7DDA-4D8C-AEDF-791616036298}']
    //private
    function getCount : integer;
    procedure setItems( inx : integer ; const value : IAbstimmung );
    function  getItems( inx : integer ) : IAbStimmung;
    //public

    property Count : integer    read getCount;
    property Items[ inx : integer ] : IAbstimmung  read getItems write setItems;

    function newAbstimmung : IAbStimmung;

    procedure Release;
  end;

  IAbstimmung = interface
    ['{796B1966-81BD-4119-B85D-BAF8C755ED7F}']
    // private
    procedure setGremium( value : IPersonenListe );
    function  getGremium : IPersonenListe;
    procedure setAbwesend( value : IPersonenListe);
    function  getAbwesend : IPersonenListe;
    procedure setNichtabgetimmt( value : IPersonenListe);
    function  getNichtabgetimmt : IPersonenListe;
    procedure setZustimmung( value : integer );
    function  getZustimmung : integer;
    procedure setAbgelehnt( value : integer );
    function  getAbgelehnt : integer;
    procedure setEnthalten( value : integer );
    function  getEnthalten : integer;
    procedure setZeitpunkt( value : TDateTime);
    function  getZeitpunkt : TDateTime;
    // public
    property Gremium        : IPersonenListe  read getGremium         write setGremium;
    property Abwesend       : IPersonenListe  read getAbwesend        write setAbwesend;
    property NichtAbgestimmt: IPersonenListe  read getNichtabgetimmt  write setNichtabgetimmt;

    property Zustimmung     : integer         read getZustimmung      write setZustimmung;
    property Abgelehnt      : integer         read getAbgelehnt       write setAbgelehnt;
    property Enthalten      : integer         read getEnthalten       write setEnthalten;

    property Zeitpunkt      : TDateTime       read getZeitpunkt       write setZeitpunkt;

    procedure Release;
  end;

implementation

end.
