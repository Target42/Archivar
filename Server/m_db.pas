unit m_db;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  Data.DB;

type
  TDBMod = class(TDataModule)
    ArchivarConnection: TFDConnection;
    FDTransaction1: TFDTransaction;
    FDManager1: TFDManager;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    function startDB: boolean;
    procedure stopDB;
  end;

var
  DBMod: TDBMod;

implementation

uses
  Grijjy.CloudLogging, m_glob_server, u_ini, FireDAC.Phys.IBWrapper;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TDBMod.DataModuleCreate(Sender: TObject);
begin
//
end;

procedure TDBMod.DataModuleDestroy(Sender: TObject);
begin
//
end;

function TDBMod.startDB: boolean;
var
  db : string;
begin
  GrijjyLog.EnterMethod(self, 'startDB');

  db := IniOptions.DBhost+':'+IniOptions.DBdb;
  GrijjyLog.Send('db name', db);

//  ArchivarConnection.ConnectionDefName := 'Archivar_pooled';
  ArchivarConnection.Params.Clear;
  ArchivarConnection.DriverName := 'FB';
  ArchivarConnection.LoginPrompt := false;
  with ArchivarConnection.Params as TFDPhysFBConnectionDefParams do
  begin
    Protocol  := ipTCPIP;
    Server    := IniOptions.DBhost;
    Database  := IniOptions.DBdb;
    UserName  := IniOptions.DBuser;
    Password  := IniOptions.DBpwd;
    SQLDialect:= 3;
    PageSize  := ps4096;
//    Pooled    := true;
  end;

  try

    ArchivarConnection.Open;
    Result := ArchivarConnection.Connected;
    GrijjyLog.Send('database connected');
  except
    on e : Exception do
    begin
      GrijjyLog.Send('error', e.ToString, TgoLogLevel.Error);
      Result := false;
    end;
  end;
  GrijjyLog.ExitMethod(self, 'startDB');
end;

procedure TDBMod.stopDB;
begin
  if ArchivarConnection.Connected then
    ArchivarConnection.Close;
end;

end.
