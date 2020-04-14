unit i_taskEdit;

interface

uses
  i_datafields, System.Generics.Collections;

type
  ITask           = interface;
  ITaskForm       = interface;

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
  //public
    procedure release;
  end;

implementation

end.
