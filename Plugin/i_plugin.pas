unit i_plugin;

interface

uses
  Vcl.Forms, Data.SqlExpr;

type
  IPluginData = interface;
  IPlugin     = interface;

  IPlugin = interface
    ['{606A69C2-5137-467E-87C1-15612FD507A4}']
    function getPluginName : string;

    procedure prepare( App : TApplication; sql : TSQLConnection );
    procedure config( data : IPluginData );
    procedure release;

    property PluginName : string read getPluginName;

    procedure Execute;
  end;

  IPluginData = interface
    ['{1E5CF260-2E9D-4A35-9EA1-6E156044C172}']

    function getUserName : string;
    function getUserID : integer;
    function getSqlConnection : TSQLConnection;
    function getApplication : TApplication;

    property SqlConnection  : TSQLConnection    read getSqlConnection;
    property Application    : TApplication      read getApplication;
    property UserID         : integer           read getUserID;
    property UserName       : string            read getUserName;

    function AutoInc(name : string ) : integer;
  end;

implementation

end.
