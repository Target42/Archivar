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
  m_glob_server;

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
  db := GM.DBHost+':'+GM.DBName;
  DebugMsg('Database : '+db);
  try
    IBDatabase1.DatabaseName := db;
    IBDatabase1.Params.Clear;
    IBDatabase1.Params.Values['user_name'] := GM.DBUser;
    IBDatabase1.Params.Values['password']  := GM.DBKey;

    IBDatabase1.Open;
    Result := IBDatabase1.Connected;
    DebugMsg('database connected');
  except
    on e : Exception do
    begin
      DebugMsg(e.ToString);
      Result := false;
    end;
  end;
end;

procedure TDBMod.stopDB;
begin
  if IBDatabase1.Connected then
    IBDatabase1.Close;
end;

end.
