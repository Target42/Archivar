unit m_glob_server;

interface

uses
  System.SysUtils, System.Classes, JvScheduledEvents;

type
  TGM = class(TDataModule)
    JvScheduledEvents1: TJvScheduledEvents;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure JvScheduledEvents1Events0Execute(Sender: TJvEventCollectionItem;
      const IsSnoozeEvent: Boolean);
  private
    { Private declarations }
  public
    procedure LoadIni;
    procedure SaveIni;

    function download( fname : string ; st : TStream ) : boolean;
    function downloadMem( st : TStream ) : TMemoryStream;
    function downloadInto( src, dest : TStream ) : boolean;
    function CopyStream( fromSt, toSt : TStream ) : integer;
    function saveToTempFile(st : TStream ) : string;

    function md5( fname : string  ) : string; overload;
    function md5( st    : TStream ) : string; overload;

    function getNameFromSession : string;

  end;

var
  GM: TGM;


implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  IOUtils, u_ini, IdHashMessageDigest, Datasnap.DSSession, m_del_files;

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
  LoadIni;
  JvScheduledEvents1.Events[0].Start;
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

function TGM.downloadInto(src, dest: TStream): boolean;
const
  BSize = 1024 * 1024;
var bytes : integer;
   buffer : array  of byte;
begin
  try
    SetLength(Buffer, BSize);
    repeat
      bytes := src.Read( buffer[0], BSize);
      dest.Write(buffer[0], bytes)
    until bytes <> BSize;
    Result := true;
  except
    Result := false
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

function TGM.getNameFromSession: string;
var
  Session : TDSSession;
  user, name, vorname, dept : string;
begin
  Session := TDSSessionManager.GetThreadSession;

  user    := Session.GetData('user');
  name    := Session.GetData('name');
  vorname := Session.GetData('vorname');
  dept    := Session.GetData('dept');


  if name = '' then
    Result := user
  else
    Result := Format('%s %s (%s)', [vorname, name, dept]);
end;

procedure TGM.JvScheduledEvents1Events0Execute(Sender: TJvEventCollectionItem;
  const IsSnoozeEvent: Boolean);
begin
  try
    DeleteFilesMod := TDeleteFilesMod.Create(self);
    DeleteFilesMod.TimeToDie;
  finally
    DeleteFilesMod.Free;
  end;
end;

procedure TGM.LoadIni;
var
  FName : string;
begin
  fname := ParamStr(0)+'.ini';
  IniOptions.LoadFromFile(fname);
end;

function TGM.md5(st: TStream): string;
var
  IdMD5: TIdHashMessageDigest5;
begin
  st.Position := 0;
  IdMD5 := TIdHashMessageDigest5.Create;
  try
    Result := LowerCase( IdMD5.HashStreamAsHex(st));
  finally
    IdMD5.Free;
  end;
  st.Position := 0;
end;

function TGM.md5(fname: string): string;
var
  fs   : TFileStream;
begin
  Result := '';

  fs := NIL;
  if not FileExists(fname) then
    exit;

  try
    fs    := TFileStream.Create(fname, fmOpenRead + fmShareDenyWrite);
    Result := md5(fs);
  finally
    fs.Free;
  end;
end;

procedure TGM.SaveIni;
var
  FName : string;
begin
  fname := ParamStr(0) +'.ini';
  IniOptions.SaveToFile(fname);
end;

function TGM.saveToTempFile(st: TStream): string;
begin
  Result := TPath.GetTempFileName;
  download(Result, st);
end;

end.
