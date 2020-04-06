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
begin
  try
    IBDatabase1.Open;
    Result := IBDatabase1.Connected;
  except
    Result := false;
  end;
end;

procedure TDBMod.stopDB;
begin
  if IBDatabase1.Connected then
    IBDatabase1.Close;
end;

end.
