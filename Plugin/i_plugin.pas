unit i_plugin;

interface

uses
  Vcl.Forms, Data.SqlExpr, u_ICrypt, u_IWindowHandler, System.JSON;

type
  IPluginData = interface;
  IPlugin     = interface;

  IPlugin = interface
    ['{606A69C2-5137-467E-87C1-15612FD507A4}']
    function getPluginName : string;
    function getData : IPluginData;

    procedure config( data : IPluginData );
    property Data : IPluginData read getData;
  
    property PluginName : string read getPluginName;

    procedure Execute;
    procedure restoreOldApplication;
    procedure PosWindow( owner, form : TForm );
  end;

  IPluginData = interface
    ['{1E5CF260-2E9D-4A35-9EA1-6E156044C172}']

    function getUserName : string;
    function getUserID : integer;
    function getSqlConnection : TSQLConnection;
    function getApplication : TApplication;
    function getCrypt : ICrypt;
    function getWndHandler : IWindowHandler;

    property SqlConnection  : TSQLConnection    read getSqlConnection;
    property App            : TApplication      read getApplication;
    property UserID         : integer           read getUserID;
    property UserName       : string            read getUserName;
    property WndHandler     : IWindowHandler    read getWndHandler;

    property Crypt          : ICrypt            read getCrypt;

    function AutoInc(name : string ) : integer;

    function getConfigData( req : TJSONObject ) : TJSONObject;
  end;

implementation

end.
