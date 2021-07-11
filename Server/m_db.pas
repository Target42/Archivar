unit m_db;

interface

uses
  System.SysUtils, System.Classes, IBX.IBDatabase, Data.DB;

type
  TDBMod = class(TDataModule)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
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
  Grijjy.CloudLogging, m_glob_server, u_ini;

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
  try
    IBDatabase1.DatabaseName := db;
    IBDatabase1.Params.Clear;
    IBDatabase1.Params.Values['user_name'] := IniOptions.DBuser;
    IBDatabase1.Params.Values['password']  := IniOptions.DBpwd;

    IBDatabase1.Open;
    Result := IBDatabase1.Connected;
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
  if IBDatabase1.Connected then
    IBDatabase1.Close;
end;

end.
