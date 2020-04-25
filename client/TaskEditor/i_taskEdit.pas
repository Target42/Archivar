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
    ctTable, ctTableField
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

  ITask = interface
    ['{5056AAD9-1DCC-4A50-B316-A9DDBE1CFD1D}']
  //private
    procedure setName( value : string );
    function  getName : string;
    procedure setCLID( value : string );
    function  getCLID : string;
    function  getFields :IDataFieldList;
    function  getForms : TList<ITaskForm>;
  //public
    property Name   : string read getName write setName;
    property CLID   : string read getCLID write setCLID;
    property Fields : IDataFieldList read getFields;
    property Forms  : TList<ITaskForm> read getForms;

    function NewForm : ITaskForm;

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

    procedure setControlClass( value : string );
    function  getControlClass : string;
    function  getOwner : ITaskForm;

  // public

    property Control        : TControl              read getControl       write setControl;
    property ControlClass   : string                read getControlClass  write setControlClass;
    property CLID           : string                read getCLID          write setCLID;
    property DataField      : IDataField            read getDataField     write setDataField;
    property Childs         : TList<ITaskCtrl>      read getChilds;
    property Props          : TList<ITaskCtrlProp>  read getProps;
    property Parent         : ITaskCtrl             read getParent        write setParent;
    property Owner          : ITaskForm             read getOwner;

    procedure release;

    function findCtrl( name : string ) : ITaskCtrl; overload;
    function findCtrl( ctrl : TControl): ITaskCtrl; overload;
    function newControl(parent : TWinControl; x, y : Integer) :  TControl;
    procedure updateControl;

    function NewChild( newType : TControlType; x, y : integer ) : ITaskCtrl;   overload;
    function NewChild( clName : string ) : ITaskCtrl;   overload;
    procedure setMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp );

    function getPropertyByName( name : string ) : ITaskCtrlProp;
    function propertyValue( name : string ) : string;
    procedure build;
    procedure dropControls;
    procedure clearProps;
    procedure drop;

    function find( pkt : TPoint ) : ITaskCtrl;

    procedure up;
    procedure down;
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

    function  isList : boolean;
    function  hasEditor : boolean;
    procedure fillPickList( list : TStrings );
    procedure ShowEditor;

    procedure config;
  end;

  ITaskControlFactory = interface
    ['{D9DFBE26-F5EB-4D8E-B660-F09A7F0FAFA2}']

  end;


implementation

end.
