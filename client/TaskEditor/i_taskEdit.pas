unit i_taskEdit;

interface

uses
  i_datafields, System.Generics.Collections, Vcl.Controls, System.Classes;

type
  TControlType = (ctNone,
    ctEdit, ctLabeledEdit,
    ctLabel,
    ctGroupBox, ctPanel,
    ctMemo, ctRichEdit,
    ctRadio, ctRadioGrp
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
    function  getControls : Tlist<ITaskCtrl>;

    procedure setRoot( value : TWinControl );
    function  getRoot : TWinControl;
  //public
    property Name  : string read getName write setName;

    property CLID   : string read getCLID write setCLID;
    property MainForm : boolean read getMainForm write setMainForm;
    property Controls : Tlist<ITaskCtrl> read getControls;
    property Root     : TWinControl read getRoot write setRoot;

    procedure release;

    function createControl( parent : TControl; newType : TControlType; x, y : integer ) : ITaskCtrl;
  end;

  ITaskCtrl = interface
  ['{7F80E65B-6A8A-4B4E-B6D9-52566A9BC95F}']
  //private
    procedure setDataField( value : IDataField );
    function  getDataField : IDataField;

    function  getChilds : TList<ITaskCtrl>;

    procedure setControl( value : TControl );
    function  getControl : TControl;
    function  getProps : TList<ITaskCtrlProp>;
    procedure setParent( value : ITaskCtrl );
    function  getParent : ITaskCtrl;
  // public
    property DataField : IDataField read getDataField write setDataField;
    property Control   : TControl read getControl write setControl;
    property Childs    : TList<ITaskCtrl> read getChilds;
    property Props     : TList<ITaskCtrlProp> read getProps;
    property Parent    : ITaskCtrl read getParent write setParent;

    procedure release;

    function findCtrl( name : string ) : ITaskCtrl; overload;
    function findCtrl( ctrl : TControl): ITaskCtrl; overload;

    function NewChild( newType : TControlType; x, y : integer ) : ITaskCtrl;
    procedure setMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp );
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
  //public
    property Name  : string read getName write setName;
    property Value : string read getValue write setValue;
    property Typ   : string read getTyp write setTyp;

    procedure release;

    function  isList : boolean;
    function  hasEditor : boolean;
    procedure fillPickList( list : TStrings );

  end;

implementation

end.
