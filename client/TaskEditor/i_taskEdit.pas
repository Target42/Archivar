unit i_taskEdit;

interface

uses
  i_datafields, System.Generics.Collections;

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
    procedure setMainForm( value : boolean );
    function  getMainForm : Boolean;
    function  getControls : Tlist<ITaskCtrl>;
  //public
    property Name  : string read getName write setName;
    property MainForm : boolean read getMainForm write setMainForm;
    property Controls : Tlist<ITaskCtrl> read getControls;

    procedure release;
  end;

  ITaskCtrl = interface
  ['{7F80E65B-6A8A-4B4E-B6D9-52566A9BC95F}']
  //private
    procedure setDataField( value : IDataField );
    function  getDataField : IDataField;

    function  getChilds : TList<ITaskCtrl>;

    procedure setControl( value : TControl );
    function  getControl : TControl;
  // public
    property DataField : IDataField read getDataField write setDataField;
    property Control   : TControl read getControl write setControl;
    property Childs    : TList<ITaskCtrl> read getChilds;

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
  end;

implementation

end.
