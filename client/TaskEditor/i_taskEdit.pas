unit i_taskEdit;

interface

uses
  i_datafields, System.Generics.Collections, Vcl.Controls, System.Classes,
  Winapi.Windows;

type
  TControlType = (ctNone,
    ctEdit, ctLabeledEdit, ctComboBox,
    ctLabel,
    ctGroupBox, ctPanel,
    ctMemo, ctRichEdit,
    ctRadio, ctRadioGrp, ctCheckBox,
    ctTable, ctTableField,
    ctSpliter
    );
type
  TControlMouseDown = procedure ( Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : integer) of object;
  TControlMouseMove = procedure ( Sender : TObject; Shift  : TShiftState; X, Y : integer ) of object;
  TControlMouseUp   = procedure ( Sender : TObject; Button : TMouseButton ; Shift : TShiftState; X, Y : integer ) of object;

type
  ITask           = interface;
  ITaskForm       = interface;
  ITaskCtrl       = interface;
  ITaskCtrlProp   = interface;
  ITaskCtrlTable  = interface;
  ITaskContainer  = interface;
  ITaskFiles      = interface;
  ITaskFile       = interface;
  ITaskStyle      = interface;
  ITaskStyles     = interface;

  ITask = interface
    ['{5056AAD9-1DCC-4A50-B316-A9DDBE1CFD1D}']
  //private
    procedure setName( value : string );
    function  getName : string;
    procedure setCLID( value : string );
    function  getCLID : string;
    function  getFields :IDataFieldList;
    function  getForms : TList<ITaskForm>;
    procedure setWorkDir( value : string );
    function  getWorkDir : string;
    procedure setOwner( value : ITaskContainer);
    function  getOwner : ITaskContainer;

  //public
    property Owner  : ITaskContainer read getOwner write setOwner;
    property Name   : string read getName write setName;
    property CLID   : string read getCLID write setCLID;
    property Fields : IDataFieldList read getFields;
    property Forms  : TList<ITaskForm> read getForms;
    property WorkDir: string read getWorkDir write setWorkDir;

    function NewForm : ITaskForm;
    function getFormByCLID( clid : string ) : ITaskForm;

    procedure release;
  end;

  ITaskForm       = interface
    ['{380DBFF3-25D1-4B2F-AF38-2554FA948F22}']
  //private
    procedure setName( value : string );
    function  getName : string;
    procedure setCLID( value : string );
    function  getCLID : string;

    procedure setMainForm( value : boolean );
    function  getMainForm : Boolean;

    function  getBase : ITaskCtrl;
    function  getOwner :ITask;
  //public
    property Name  : string read getName write setName;

    property Owner  : ITask read getOwner;
    property CLID   : string read getCLID write setCLID;
    property MainForm : boolean read getMainForm write setMainForm;
    property Base     : ITaskCtrl read getBase;

    procedure release;
    function newControl : ITaskCtrl;

    function createControl( parent : TControl; newType : TControlType; x, y : integer ) : ITaskCtrl;
  end;

  ITaskCtrl = interface
  ['{7F80E65B-6A8A-4B4E-B6D9-52566A9BC95F}']
  // protected
  //private
    procedure setDataField( value : IDataField );
    function  getDataField : IDataField;

    function  getChilds : TList<ITaskCtrl>;

    procedure setControl( value : TControl );
    function  getControl : TControl;
    function  getProps : TList<ITaskCtrlProp>;
    procedure setParent( value : ITaskCtrl );
    function  getParent : ITaskCtrl;
    procedure setCLID( value : string );
    function  getCLID : string;
    procedure setRequired( value : boolean );
    function  getRequired : boolean;

    procedure setControlClass( value : string );
    function  getControlClass : string;
    function  getOwner : ITaskForm;

    function getTableCtrlIF : ITaskCtrlTable;
    function getTyp : TControlType;
  // public

    property Typ            : TControlType          read getTyp;
    property Control        : TControl              read getControl       write setControl;
    property ControlClass   : string                read getControlClass  write setControlClass;
    property CLID           : string                read getCLID          write setCLID;
    property DataField      : IDataField            read getDataField     write setDataField;
    property Childs         : TList<ITaskCtrl>      read getChilds;
    property Props          : TList<ITaskCtrlProp>  read getProps;
    property Parent         : ITaskCtrl             read getParent        write setParent;
    property Owner          : ITaskForm             read getOwner;
    property TableCtrlIF    : ITaskCtrlTable        read getTableCtrlIF;

    property Required       : boolean               read getRequired      write setRequired;

    procedure release;

    function containData : boolean;
    function isContainer : boolean;

    function findCtrlByCLID( clid : string ) : ITaskCtrl;
    function findCtrl( name : string ) : ITaskCtrl; overload;
    function findCtrl( ctrl : TControl): ITaskCtrl; overload;
    function newControl(parent : TWinControl; x, y : Integer) :  TControl;

    function NewChild( newType : TControlType; x, y : integer ) : ITaskCtrl;   overload;
    function NewChild( clName : string ) : ITaskCtrl;   overload;
    procedure up;
    procedure down;


    procedure setMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp );
    function find( pkt : TPoint ) : ITaskCtrl;
    procedure check( list : TStringList );

    procedure setData( value : string );
    function getData( var name, value :string ) : boolean;

    function getPropertyByName( name : string ) : ITaskCtrlProp;
    function propertyValue( name : string ) : string;

    procedure build;
    procedure dropControls;
    procedure drop;
    procedure updateControl;
  end;

  ITaskCtrlProp   = interface
    ['{715ABBB7-24B3-4277-AEFC-D20F93AFF8E5}']
  //private
    procedure setName( value : string );
    function  getName : string;
    procedure setValue( value : string );
    function  getValue : string;
    procedure setTyp( value : string );
    function  getTyp : string;
    procedure setControl( value : TControl );
    function  getControl : TControl;

  //public
    property Name     : string    read getName    write setName;
    property Value    : string    read getValue   write setValue;
    property Typ      : string    read getTyp     write setTyp;

    property Control  : TControl  read getControl write setControl;

    procedure release;
    procedure config;

    function  isList : boolean;
    function  hasEditor : boolean;
    procedure fillPickList( list : TStrings );
    procedure ShowEditor;
  end;

  ITaskCtrlTable = interface
    ['{D9DFBE26-F5EB-4D8E-B660-F09A7F0FAFA2}']
  // private
    function getCell( row, col : integer) : string;
    procedure setCell( row, col : integer; value : string );

    function getRowCount : integer;
    procedure setRowCount( value : integer );
  // public
    property RowCount : integer read getRowCount write setRowCount;

    function ColCount : integer;
    procedure deleteRow( row : integer );

    function addRow : integer;
    function ColDatafield( col : integer ) : string;

    property Cell[ row, col : integer] : string read getCell write setCell;
  end;

  ITaskContainer  = interface
    ['{3C349E82-3969-4A61-8776-0B1F20D11D51}']
    //private
      procedure setTask( value : ITask );
      function  getTask : ITask;
      function  getTestdata : ITaskFiles;
      function  getInfoFiles: ITaskFiles;
      function  getStyles : ITaskStyles;
    //public
      property Task : ITask read getTask write setTask;
      property TestData : ITaskFiles read getTestdata;
      property Styles   : ITaskStyles read getStyles;
      property Info     : ITaskFiles read getInfoFiles;

      function loadFromPath( path : string ) : boolean;
      function saveToPath( path : string ) : boolean;

      procedure release;
  end;

  ITaskFiles      = interface
    ['{960DEEAB-D40C-4EAD-BA4F-70A55A141A1A}']
    //private
      procedure setItems( inx : integer; const value : ITaskFile );
      function  getItems( inx : integer ) : ITaskFile;
      function  getCount : integer;
    //public
      property Items[ inx : integer ]: ITaskFile read getItems write setItems;
      property Count : integer read getCount;

      function getFile( name : string ): ITaskFile;

      function loadFromPath( path, mask : string ) : boolean;
      function saveToPath( path : string ) : boolean;
      function newFile( name : string ) : ITaskFile;

      procedure fillList( list : TStrings; ext : boolean = true );

      procedure release;
  end;

  ITaskFile       = interface
    ['{BD70B176-D1F4-4FBF-BA63-C68B820B1854}']
    //private
      procedure setName( value : string );
      function  getName : string;
      function  getStream : TStream;
      function  getStrings: TStrings;
    //public
      property Name : string read getName write setName;
      property Lines : TStrings read getStrings;
      property Data : TStream read getStream;

      function isName( name : string ) : Boolean;

      function load( fname : string ) : boolean;
      function save( path : string ) : boolean;

      procedure release;
  end;

  ITaskStyle      = interface
    ['{F4511A5F-3698-4CFF-A546-315E7145E8D5}']
    //private
      procedure setName( value : string );
      function  getName : string;
      function  getFiles : ITaskFiles;
      procedure setCLID( value : string );
      function  getCLID : string;
    //public
      property CLID   : string read getCLID write setCLID;
      property Name : string read getName write setName;
      property Files: ITaskFiles read getFiles;

      function loadFromPath( path : string ) : boolean;
      function saveToPath( path : string ) : boolean;

      function isName( name : string ) : Boolean;

      procedure release;
  end;

  ITaskStyles     = interface
    ['{C059AA77-5A6F-476F-96EC-50DF3E3BFD2F}']
    // private
      procedure setTaskStyle( inx : integer; const value : ITaskStyle );
      function  getTaskStyle(inx : integer ) : ITaskStyle;
      function getCount : integer;
    // public
      property Items[ inx : integer ]: ITaskStyle read getTaskStyle write setTaskStyle;
      property Count : integer read getCount;

      function newStyle(name : String ) : ITaskStyle;
      function loadFromPath( path : string ) : boolean;
      function saveToPath( path : string ) : boolean;

      function getStyle( name : string ) : ITaskStyle;
      function rename( style : ITaskStyle; name :string ) : boolean;

      procedure FillList( list : TStrings );

      procedure release;
  end;


implementation

end.


