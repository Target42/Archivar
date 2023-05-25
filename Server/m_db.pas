unit m_db;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  Data.DB, FireDAC.Phys.Intf, FireDAC.Phys.IBWrapper, FireDAC.Phys.IBBase,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Moni.Base, FireDAC.Moni.RemoteClient,
  FireDAC.Moni.FlatFile;

type
  TDBMod = class(TDataModule)
    ArchivarConnection: TFDConnection;
    FDTransaction1: TFDTransaction;
    FDManager1: TFDManager;
    FDFBNBackup1: TFDFBNBackup;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDMoniRemoteClientLink1: TFDMoniRemoteClientLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_clientDLL : string;

    procedure findClientDLL;
  public
    function startDB: boolean;
    procedure stopDB;

    function Started : boolean;
  end;

var
  DBMod: TDBMod;

implementation

uses
  Grijjy.CloudLogging, u_ini, system.IOUtils;

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

procedure TDBMod.findClientDLL;
var
  list  : TStringList;
  i     : integer;
  fname : string;
begin
  m_clientDLL := '';
  List := TStringList.Create;
  list.StrictDelimiter := true;
  list.Delimiter := ';';
  list.DelimitedText := GetEnvironmentVariable('PATH');
  list.Sort;

  for i := 0 to pred(list.Count) do begin
    fname := TPath.combine( list[i], 'fbclient.dll');
    if FileExists(fname) then begin
      m_clientDLL := fname;
      break;
    end;
  end;
  list.Free;
end;

function TDBMod.startDB: boolean;
var
  db : string;
begin
  GrijjyLog.EnterMethod(self, 'startDB');
  findClientDLL;

  db := IniOptions.DBhost+':'+IniOptions.DBdb;
  GrijjyLog.Send('db name', db);
  GrijjyLog.Send('dll', m_clientDLL);
{$ifdef DEBUG}
  Writeln( 'DB:'+db);
{$endif}


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
    Pooled    := true;
    MonitorBy := mbRemote;
  end;
  FDManager.AddConnectionDef('FirebirdPooled', 'FB', ArchivarConnection.Params );

  FDPhysFBDriverLink1.VendorLib := m_clientDLL;

  with FDFBNBackup1 do begin
    Protocol  := ipTCPIP;
    host      := IniOptions.DBhost;
    Database  := IniOptions.DBdb;
    UserName  := IniOptions.DBuser;
    Password  := IniOptions.DBpwd;
    level     := 0;
  end;

  try
    ArchivarConnection.ConnectionDefName := 'FirebirdPooled';

    FDMoniRemoteClientLink1.Tracing := true;
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

function TDBMod.Started: boolean;
begin
  result := ArchivarConnection.Connected;
end;

procedure TDBMod.stopDB;
begin
  if ArchivarConnection.Connected then
    ArchivarConnection.Close;
end;

end.
