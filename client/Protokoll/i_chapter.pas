unit i_chapter;

interface

uses
  xsd_chapter;

type
  IChapter          = interface;
  IChapterList      = interface;
  IChapterTitleList = interface;
  IChapterTitle     = interface;

  IChapter = interface
    ['{573E438F-18D6-4AA4-93CB-B16C342C7EDE}']

      procedure setModified(  value : boolean );
      procedure setOwner(     value : IChapter);
      procedure setName(      value : string );
      procedure SetID(        value : integer);
      procedure setPID(       value : integer );
      procedure SetNr(        value : integer );
      procedure SetNumbering( value : boolean );
      procedure setTAID(      value : integer );
      procedure setData(      value : pointer );
      procedure setRem(       value : string );

      function getModified  : boolean;
      function getOwner     : IChapter;
      function getName      : string;
      function getID        : integer;
      function getPID       : integer;
      function getNr        : integer;
      function getNumbering : boolean ;
      function getTAID      : integer;
      function getData      : pointer;
      function getRem       : string;
      function getChilds    : IChapterList;

      property Owner      : IChapter      read getOwner     write setOwner;
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
      procedure setChapter( value : IXMLChapter );
      function  getChapter : IXMLChapter;

      // public
      property ID       : integer       read getID        write setID;
      property Nr       : integer       read getNr        write setNr;
      property Text     : string        read getText      write setText;
      property Modified : boolean       read getModified  write setModified;
      property xChapter : IXMLChapter   read getChapter   write setChapter;

      procedure up;
      procedure down;

      function FullTitle : string;

      procedure release;

  end;


implementation

end.
