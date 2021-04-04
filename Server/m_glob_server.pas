unit m_glob_server;

interface

uses
  System.SysUtils, System.Classes;

type
  TGM = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FDBHost: string;
    FDBName: string;
    FDBUser: string;
    FDBKey: string;
    FDSPort: integer;
    { Private declarations }
  public
    procedure LoadIni;
    procedure SaveIni;

    property DBHost: string read FDBHost write FDBHost;
    property DBName: string read FDBName write FDBName;
    property DBUser: string read FDBUser write FDBUser;
    property DBKey: string read FDBKey write FDBKey;

    property DSPort: integer read FDSPort write FDSPort;

    function download( fname : string ; st : TStream ) : boolean;
    function downloadMem( st : TStream ) : TMemoryStream;
    function CopyStream( fromSt, toSt : TStream ) : integer;
    function saveToTempFile(st : TStream ) : string;
  end;

var
  GM: TGM;

procedure DebugMsg( text : string );

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  IOUtils, m_db, IniFiles;

procedure DebugMsg( text : string );
begin
{$ifdef DEBUG}
  WriteLn( text );
{$endif}
end;

function TGM.CopyStream(fromSt, toSt: TStream): integer;
const
  BSize = 1024 * 1024;
var bytes : integer;
   buffer : array  of byte;
begin
  try
    SetLength(Buffer, BSize);
    repeat
      bytes := FromSt.Read( buffer[0], BSize);
      toSt.Write(buffer[0], bytes)
    until bytes <> BSize;
    Result := toSt.Size;
  except
    Result := -1
  end;
  SetLength(Buffer, 0);
end;

procedure TGM.DataModuleCreate(Sender: TObject);
begin
  FDBHost := 'localhost';
  FDBName := 'd:\db\archivar.gdb';
  FDBUser := 'sysdba';
  FDBKey  := 'masterkey';
  FDSPort := 211;

  LoadIni;
end;

procedure TGM.DataModuleDestroy(Sender: TObject);
begin
//
end;

function TGM.download(fname: string; st: TStream): boolean;
const
  BSize = 1024 * 1024;
var bytes : integer;
   buffer : array  of byte;
   fout : TFileStream;
begin
  Result := true;
  try
    SetLength(Buffer, BSize);
    fout := TFileStream.Create( fname, fmCreate);
    repeat
      bytes := st.Read( buffer[0], BSize);
      fout.Write(buffer[0], bytes)
    until bytes <> BSize;
    FreeAndNil(fout);
  except
    Result := false;
  end;
  SetLength(Buffer, 0);
end;

function TGM.downloadMem(st: TStream): TMemoryStream;
const
  BSize = 1024 * 1024;
var bytes : integer;
   buffer : array  of byte;
begin
  Result := TMemoryStream.Create;
  try
    SetLength(Buffer, BSize);
    repeat
      bytes := st.Read( buffer[0], BSize);
      Result.Write(buffer[0], bytes)
    until bytes <> BSize;
  except
    Result := NIL;
  end;
  SetLength(Buffer, 0);
  Result.Position := 0;
  if Result.Size = 0 then
  begin
    Result.Free;
    Result := NIL;
  end;
end;

procedure TGM.LoadIni;
var
  FName : string;
  ini   : TIniFile;
begin
  fname := ParamStr(0)+'.ini';

  ini := TIniFile.Create(fname);

  FDBHost := ini.ReadString('DB', 'host', FDBHost);
  FDBName := ini.ReadString('DB', 'db', FDBName);
  FDBUser := ini.ReadString('DB', 'user', FDBUser);
  FDBKey  := ini.ReadString('DB', 'pwd', FDBKey);

  FDSPort := ini.ReadInteger('DS', 'port', FDSPort);

  ini.Free;
end;

procedure TGM.SaveIni;
var
  FName : string;
  ini   : TIniFile;
begin
  fname := TPath.Combine(ExtractFilePath(ParamStr(0)), 'server.dat');

  ini := TIniFile.Create(fname);

  ini.WriteString('DB', 'host', FDBHost);
  ini.WriteString('DB', 'db', FDBName);
  ini.WriteString('DB', 'user', FDBUser);
  ini.WriteString('DB', 'pwd', FDBKey);

  ini.WriteInteger('DS', 'port', FDSPort);

  ini.Free;
end;

function TGM.saveToTempFile(st: TStream): string;
begin
  Result := TPath.GetTempFileName;
  download(Result, st);
end;

end.
