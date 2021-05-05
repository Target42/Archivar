unit i_chapter;

interface

uses
  xsd_chapter, xsd_protocol, System.Classes, Data.DB, i_beschluss, i_personen,
  u_teilnehmer;

type

  IChapter          = interface;
  IChapterList      = interface;
  IChapterTitleList = interface;
  IChapterTitle     = interface;
  IProtocol         = interface;
  ITeilnehmer       = interface;
  ITeilnehmerListe  = interface;
  IBesucher         = interface;
  IBesucherListe    = interface;

  IProtocol = interface
    ['{22F955F2-2B4F-44B4-9319-438413D20842}']

    procedure setXProto( value : IXMLProtocol );
    function  getXProto : IXMLProtocol;

    procedure setID( value : integer );
    function  getID : integer;

    function  getList : IChapterTitleList;
    function  GetTitle: string;
    procedure SetTitle(const Value: string);
    function  GetCLID: string;
    procedure SetCLID(const Value: string);
    function  getTeilnehmer : ITeilnehmerListe;
    function  GetGRID: integer;
    procedure SetGRID(const Value: integer);
    function  getRO : boolean;
    procedure setRO( value : boolean );
    function  GetNr: integer;
    procedure SetNr(const Value: integer);
    function  GetDate: TDateTime;
    procedure SetDate(const Value: TDateTime);
    procedure setModified( value : boolean );
    function  getModified : boolean;
    function  getBesucher : IBesucherListe;
    procedure setStart( value : TDateTime );
    function  getStart : TDateTime;
    procedure setEnde( value : TDateTime );
    function  getEnde : TDateTime;

    property GRID   : integer           read GetGRID      write SetGRID;
    property XProto : IXMLProtocol      read getXProto    write setXProto;
    property Title  : string            read GetTitle     write SetTitle;
    property ID     : integer           read getID        write setID;
    property CLID   : string            read GetCLID      write SetCLID;
    property Chapter: IChapterTitleList read getList;
    property ReadOnly : boolean         read getRo        write setRO;
    property Nr     : integer           read GetNr        write SetNr;
    property Date   : TDateTime         read GetDate      write SetDate;
    property Modified : boolean         read getModified  write setModified;
    property Start  : TDateTime         read getStart     write setStart;
    property Ende   : TDateTime         read getEnde      write setEnde;

    property Teilnehmer : ITeilnehmerListe read getTeilnehmer;
    property Besucher   : IBesucherListe   read getBesucher;

    procedure loadFromStream( st : TStream );
    procedure saveToStream( st : TStream );

    function load( id : integer ) : boolean;
    function save : boolean;
    function saveTree : boolean;
    function edit : boolean;
    function cancel : boolean;

    procedure SyncUser( be : IBeschluss );

    procedure release;
  end;

  IChapter = interface
    ['{573E438F-18D6-4AA4-93CB-B16C342C7EDE}']

      procedure setModified(  value : boolean );
      procedure setParent(    value : IChapter);
      procedure setName(      value : string );
      procedure SetID(        value : integer);
      procedure setPID(       value : integer );
      procedure SetNr(        value : integer );
      procedure SetNumbering( value : boolean );
      procedure setTAID(      value : integer );
      procedure setData(      value : pointer );
      procedure setRem(       value : string );
      procedure setxData(     value : xsd_chapter.IXMLChapter );
      procedure setPos(       value : integer );
      procedure SetTimeStamp(const Value: TDateTime);

      function getModified  : boolean;
      function getParent    : IChapter;
      function getName      : string;
      function getID        : integer;
      function getPID       : integer;
      function getNr        : integer;
      function getNumbering : boolean ;
      function getTAID      : integer;
      function getData      : pointer;
      function getRem       : string;
      function getChilds    : IChapterList;
      function getxData     : xsd_chapter.IXMLChapter;
      function getPos       : integer;
      function getVotes     : IBeschlussListe;
      function GetTimeStamp: TDateTime;


      // public
      property Parent     : IChapter      read getParent     write setParent;
      property Childs     : IChapterList  read getChilds;
      property Name       : string        read getName      write setName;
      property ID         : integer       read getID        write SetID;
      property PID        : integer       read getPID       write setPID;
      property Nr         : integer       read getNr        write SetNr;
      property Numbering  : boolean       read getNumbering write SetNumbering;
      property TAID       : integer       read getTAID      write setTAID;
      property Data       : Pointer       read getData      write setData;
      property Rem        : String        read getRem       write setRem;
      property Modified   : boolean       read getModified  write setModified;
      property Pos        : integer       read getPos       write setPos;
      property TimeStamp  : TDateTime     read GetTimeStamp write SetTimeStamp;

      property xData      : xsd_chapter.IXMLChapter         read getxData     write setxData;

      property Votes      : IBeschlussListe read getVotes;

      procedure clearModified;
      function isModified : boolean;

      procedure up;
      procedure down;

      procedure add( cp : IChapter );
      procedure remove( cp : IChapter );

      function newChapter : IChapter;

      function fullTitle: string;
      procedure reindex;

      function hasID( id : integer ) : Boolean;
      function level : integer;

      function save( data : TDataSet ) : boolean;
      function load( data : TDataSet ) : boolean;

      procedure release;
  end;

  IChapterList = interface
    ['{B7323787-B1A4-4E0A-B115-53A815A70252}']

      function  getCount : integer;
      procedure setItem( inx : integer ; const value : IChapter );
      function  getItem( inx : integer ) : IChapter;

      property Count : integer read getCount;
      property Items[inx : integer] : IChapter read getItem write setItem;

      procedure clear;

      procedure up(     cp : IChapter);
      procedure down(   cp : IChapter );
      procedure remove( cp : IChapter );
      procedure Delete( cp : IChapter );
      procedure add(    cp : IChapter );

      function findMax : integer;

      procedure renumber;
      procedure sortPos;

      procedure release;
  end;

  IChapterTitleList = interface
    ['{2DEBD8CB-0B6F-4911-8284-C84EB58AF0FC}']
      function getIndex( cp : IChapterTitle) : integer;
      function getCount : integer;
      function getItem( inx : integer ) : IChapterTitle;
      // public
      procedure renumber;
      function NewEntry : IChapterTitle;

      property Count : integer                       read getCount;
      property Items[ inx : integer] : IChapterTitle read getItem;

      procedure up( cp      : IChapterTitle );
      procedure down( cp    : IChapterTitle );
      procedure remove( cp  : IChapterTitle );

      procedure saveChangedChapter;
      procedure updateChapter( cp : IChapterTitle );
      procedure AddNewChaper( cp : IChapterTitle );

      procedure release;
  end;

  IChapterTitle = interface
    ['{E146A7DF-D5D7-454B-8D14-A9D22A4BA1DC}']
      procedure setID( value : integer );
      function  getID : integer;
      procedure setNr( value : integer );
      function  getNR : integer;
      procedure setText( value : string );
      function  getText : string;
      procedure setModified( value : boolean );
      function  getModified : boolean;
      procedure setxChapter( value : xsd_chapter.IXMLChapter );
      function  getxChapter : xsd_chapter.IXMLChapter;
      function  getRoot : IChapter;

      function getCount : integer;
      function getItem( inx : integer ) : IChapter;
      function getProto : IProtocol;
      function GetTimeStamp: TDateTime;
      procedure SetTimeStamp(const Value: TDateTime);


      // public
      property Protocol : IProtocol     read getProto;
      property ID       : integer       read getID        write setID;
      property Nr       : integer       read getNr        write setNr;
      property Text     : string        read getText      write setText;
      property Modified : boolean       read getModified  write setModified;
      property xChapter : xsd_chapter.IXMLChapter   read getxChapter   write setxChapter;
      property Root     : IChapter      read getRoot;
      property TimeStamp: TDateTime     read GetTimeStamp write SetTimeStamp;

      property Item[inx : integer] : IChapter read getItem;
      property Count    : integer   read getCount;

      procedure up;
      procedure down;

      function FullTitle : string;

      procedure loadFromDataSet( data, beData : TDataSet );

      procedure buildTree;

      procedure release;

  end;

  ITeilnehmer       = interface
    ['{84956349-5E4D-47E8-A121-878C6728D7A0}']
      function GetName: string;
      procedure SetName(const Value: string);
      function GetVorname: string;
      procedure SetVorname(const Value: string);
      function GetAbteilung: string;
      procedure SetAbteilung(const Value: string);
      function GetRolle: string;
      procedure SetRolle(const Value: string);
      function GetID: integer;
      procedure SetID(const Value: integer);
      function GetStatus: TTeilnehmerStatus;
      procedure SetStatus(const Value: TTeilnehmerStatus);
      procedure setPEID( value : integer );
      function  getPEID : integer;
      procedure setModified( value : boolean );
      function  getModified : boolean;
      function GetGrund: string;
      procedure SetGrund(const Value: string);

    //public

      property ID         : integer           read GetID          write SetID;
      property Name       : string            read GetName        write SetName;
      property Vorname    : string            read GetVorname     write SetVorname;
      property Abteilung  : string            read GetAbteilung   write SetAbteilung;
      property Rolle      : string            read GetRolle       write SetRolle;
      property Status     : TTeilnehmerStatus read GetStatus      write SetStatus;
      property PEID       : integer           read getPEID        write setPEID;
      property Modified   : boolean           read getModified    write setModified;
      property Grund      : string            read GetGrund       write SetGrund;

      procedure Assign( pe : IPerson );

      procedure release;
    end;

    ITeilnehmerListe  = interface
      ['{0552ECEF-BD70-4554-A09B-FE2ED8F06179}']
      //private
      function GetCount: integer;

      function GetItem(inx : integer ): ITeilnehmer;
      procedure SetItem(int : integer; const Value: ITeilnehmer);
      // public
      property Count: integer read GetCount;
      property Item[inx : integer ] : ITeilnehmer read GetItem write SetItem;

      function newTeilnehmer : ITeilnehmer;
      procedure load;
      procedure init( list : IPersonenListe );

      procedure saveChanged;
      procedure release;
    end;

  IBesucher         = interface
    ['{CF5F3624-7558-486F-B1EF-321B9D3E45FE}']
    function GetName: string;
    procedure SetName(const Value: string);
    function GetVorname: string;
    procedure SetVorname(const Value: string);
    function GetAbteilung: string;
    procedure SetAbteilung(const Value: string);
    function GetGrund: string;
    procedure SetGrund(const Value: string);
    function GetVon: TDateTime;
    procedure SetVon(const Value: TDateTime);
    function Getbis: TDateTime;
    procedure Setbis(const Value: TDateTime);
    function GetModified: boolean;
    procedure SetModified(const Value: boolean);
    function Getid: integer;
    procedure Setid(const Value: integer);

  //public
    property Name: string read GetName write SetName;
    property Vorname: string read GetVorname write SetVorname;
    property Abteilung: string read GetAbteilung write SetAbteilung;
    property Grund: string read GetGrund write SetGrund;
    property Von: TDateTime read GetVon write SetVon;
    property bis: TDateTime read Getbis write Setbis;
    property Modified: boolean read GetModified write SetModified;
    property id: integer read Getid write Setid;

    procedure release;
  end;

  IBesucherListe    = interface
    ['{A9E043F2-C921-46A5-AA64-CE24676A220E}']
      //private
      function GetCount: integer;

      function GetItem(inx : integer ): IBesucher;
      procedure SetItem(inx : integer; const Value: IBesucher);
      // public
      property Count: integer read GetCount;
      property Item[inx : integer ] : IBesucher read GetItem write SetItem;

      function newBesucher : IBesucher;

      procedure load;
      procedure saveChanged;

      procedure remove( b : IBesucher );

      procedure release;
  end;


implementation


end.
