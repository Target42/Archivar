unit i_beschluss;

interface

uses
  i_personen, Data.DB, System.Classes, xsd_TaskData;

type
  IBeschluss      = interface;
  IBeschlussListe = interface;
  IAbstimmung     = interface;

  TBeschlussStatus= (bsGeplant, bsZugestimmt, bsAbgelehnt, bsWarten);

  IBeschlussListe = interface
    ['{C23CDA08-059A-4E90-86B4-917B3DE58AAF}']
    //private
    function  getItem( inx : integer ) : IBeschluss;
    procedure setItem( inx : integer; const value : IBeschluss);
    function  getCount : integer;

    procedure setOwner( value : pointer);
    function  getOwner : pointer;

    //public
    property Item[ inx : integer ]  : IBeschluss  read getItem    write setItem;
    property Count                  : integer     read getCount;
    property Owner                  : pointer     read getOwner   write setOwner;

    function  newBeschluss : IBeschluss;
    procedure delete( inx : integer ) ; overload;
    procedure delete( be : IBeschluss); overload;

    procedure saveModified;

    procedure Release;
  end;


  IBeschluss  = interface
    ['{F88CA754-CE8F-41B4-A880-61E4538BD72F}']
    // private
    procedure setText( value : string );
    function  getText : string;
    function  getAbstimmung : IAbstimmung;
    function  getTitel : string;
    function  GetStatus: TBeschlussStatus;
    procedure SetStatus(const Value: TBeschlussStatus);
    function  GetModified: boolean;
    procedure SetModified(const Value: boolean);
    function  GetID: integer;
    procedure SetID(const Value: integer);
    function  GetCTID: integer;
    procedure SetCTID(const Value: integer);
    procedure setData( value : IXMLList );
    function  getData : IXMLList;
    procedure setOwner( value : IBeschlussListe );
    function  getOwner : IBeschlussListe;

    // public
    property ID           : integer           read GetID            write SetID;
    property CTID         : integer           read GetCTID          write SetCTID;
    property Status       : TBeschlussStatus  read GetStatus        write SetStatus;
    property titel        : string            read getTitel;
    property Text         : string            read getText          write setText;
    property Abstimmung   : IAbstimmung       read getAbstimmung ;
    property Modified     : boolean           read GetModified      write SetModified;
    property Data         : IXMLList          read getData          write setData;

    property Owner        : IBeschlussListe   read getOwner         write setOwner;

    procedure loadFromDataSet( data : TDataSet );
    procedure save( data : TDataSet );

    procedure setGremium( gremium : IPersonenListe );


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
    function  GetModified: boolean;
    procedure SetModified(const Value: boolean);

    // public
    property Gremium        : IPersonenListe  read getGremium         write setGremium;
    property Abwesend       : IPersonenListe  read getAbwesend        write setAbwesend;
    property NichtAbgestimmt: IPersonenListe  read getNichtabgetimmt  write setNichtabgetimmt;

    property Zustimmung     : integer         read getZustimmung      write setZustimmung;
    property Abgelehnt      : integer         read getAbgelehnt       write setAbgelehnt;
    property Enthalten      : integer         read getEnthalten       write setEnthalten;

    property Zeitpunkt      : TDateTime       read getZeitpunkt       write setZeitpunkt;

    property Modified     : boolean           read GetModified        write SetModified;

    procedure Release;
  end;

function BeschlussStatusToStr( bs :TBeschlussStatus ) : string;
function StrToBeschlussStatus( val : string ) : TBeschlussStatus;

procedure fillBelschlussStatus( list : TStrings );

implementation

uses
  System.SysUtils;

function BeschlussStatusToStr( bs :TBeschlussStatus ) : string;
begin
  case bs of
    bsGeplant:      Result := 'Geplant';
    bsZugestimmt:   Result := 'Zugestimmt';
    bsAbgelehnt:    Result := 'Abgelehnt';
    bsWarten:       Result := 'Klärungsbedarf';
  end;
end;

function StrToBeschlussStatus( val : string ) : TBeschlussStatus;
begin
  Result := bsGeplant;
  if SameText( val, 'Geplant') then
    Result := bsGeplant
  else if SameText( val, 'Zugestimmt') then
    Result := bsZugestimmt
  else if SameText( val, 'Abgelehnt') then
    Result := bsAbgelehnt
  else if SameText( val, 'Klärungsbedarf') then
    Result := bsWarten;
end;

procedure fillBelschlussStatus( list : TStrings );
var
  i : TBeschlussStatus;
begin
  for i := bsGeplant to bsWarten do
    list.AddObject(BeschlussStatusToStr(i), TObject(i));

end;

end.
