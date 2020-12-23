unit i_beschluss;

interface

uses
  i_personen;

type
  IBeschluss      = interface;
  IBeschlussListe = interface;
  IAbstimmung     = interface;

  IBeschlussListe = interface
    ['{C23CDA08-059A-4E90-86B4-917B3DE58AAF}']
    //private
    function  getItem( inx : integer ) : IBeschluss;
    procedure setItem( inx : integer; const value : IBeschluss);
    function  getCount : integer;

    //public
    property Item[ inx : integer ]  : IBeschluss  read getItem    write setItem;
    property Count                  : integer     read getCount;

    function  newBeschluss : IBeschluss;
    procedure delete( inx : integer ) ; overload;
    procedure delete( be : IBeschluss); overload;

    procedure Release;
  end;


  IBeschluss  = interface
    ['{F88CA754-CE8F-41B4-A880-61E4538BD72F}']
    // private
    procedure setText( value : string );
    function  getText : string;
    function  getAbstimmung : IAbstimmung;
    // public
    property Text         : string        read getText          write setText;
    property Abstimmung   : IAbstimmung   read getAbstimmung ;

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
