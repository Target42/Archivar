unit u_PluginData;

interface

uses
  i_plugin, Data.SqlExpr, Vcl.Forms, u_ICrypt, u_IWindowHandler, System.JSON;

type
  TPluginDataImpl = class(TInterfacedObject, IPluginData )
    private
      function getUserName : string;
      function getUserID : integer;
      function getSqlConnection : TSQLConnection;
      function getApplication : TApplication;
      function getCrypt : ICrypt;
      function getWndHandler : IWindowHandler;
    public
      constructor create;
      Destructor Destroy; override;

      function AutoInc(name : string ) : integer;
      function getConfigData( req : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  m_glob_client, m_crypt, m_WindowHandler, u_json, System.SysUtils;

{ TPluginDataImpl }

function TPluginDataImpl.AutoInc(name: string): integer;
begin
  Result := GM.autoInc(name);
end;

constructor TPluginDataImpl.create;
begin

end;

destructor TPluginDataImpl.Destroy;
begin

  inherited;
end;

function TPluginDataImpl.getApplication: TApplication;
begin
  Result := Application;
end;

function TPluginDataImpl.getConfigData(req: TJSONObject): TJSONObject;
var
  res : TJSONObject;
begin
  Result := NIL;
  res := GM.MiscIF.getConfigData(req);
  if Assigned(res) then
    Result := res.Clone as TJSONObject;
end;

function TPluginDataImpl.getCrypt: ICrypt;
begin
  Result := CryptMod;
end;

function TPluginDataImpl.getSqlConnection: TSQLConnection;
begin
  Result := GM.SQLConnection1;
end;

function TPluginDataImpl.getUserID: integer;
begin
  Result := GM.UserID;
end;

function TPluginDataImpl.getUserName: string;
begin
  Result := gm.UserName;
end;

function TPluginDataImpl.getWndHandler: IWindowHandler;
begin
  Result := WindowHandler;
end;

end.
