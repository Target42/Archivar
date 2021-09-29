unit m_fileCache;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, System.JSON, System.Generics.Collections;

type
  TFileCacheMod = class(TDataModule)
    DSProviderConnection1: TDSProviderConnection;
    FCTab: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    type
      TPEntry = ^TEntry;
      TEntry  = record
        cache : string;
        name  : string;
        md5   : string;
      end;
  private
    m_files : TList<TPEntry>;

    procedure CheckFile( en : TEntry );
    procedure clear;
  public
    property Files : Tlist<TPEntry> read m_files;

    procedure SyncCache;

    function upload( cache, name : string ) : boolean;
    function deleteFile( cache, name : string ) : boolean;

    function handle_update (const arg : TJSONObject) : boolean;
    function handle_delete (const arg : TJSONObject) : boolean;
  end;

var
  FileCacheMod: TFileCacheMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  m_glob_client, u_stub, u_json, system.IOUtils, u_eventHandler, u_Konst;


{$R *.dfm}

procedure TFileCacheMod.CheckFile(en: TEntry);
var
  fname : string;
  st    : TStream;
begin
  fname := TPath.Combine(GM.Cache, format('%s\%s', [en.cache, en.name]));

  if en.md5 <> GM.md5(fname) then begin
    st := FCTab.CreateBlobStream(FCTab.FieldByName('FC_DATA'), bmRead);
    GM.download(fname, st);
    st.Free;
  end;
end;

procedure TFileCacheMod.clear;
var
  ptr : TPEntry;
begin
  for ptr in m_files do
    Dispose(ptr);
  m_files.Clear;
end;

procedure TFileCacheMod.DataModuleCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_files := TList<TPEntry>.create;

  EventHandler.Register( self, handle_update, BRD_FILE_CACHE_UPT );
  EventHandler.Register( self, handle_delete, BRD_FILE_CACHE_DEL );
end;

procedure TFileCacheMod.DataModuleDestroy(Sender: TObject);
begin
  clear;
  m_files.Free;

  EventHandler.Unregister(self);
end;

function TFileCacheMod.deleteFile(cache, name: string): boolean;
var
  req, res  : TJSONObject;
  client    : TdsFileCacheClient;
begin
  client := TdsFileCacheClient.Create(GM.SQLConnection1.DBXConnection);
  try
    req := TJSONObject.Create;
    JReplace( req, 'cache', cache);
    JReplace( req, 'name', name);

    res := client.deleteFile(req);
    Result := JBool(res, 'result');
  finally
    client.Free;
  end;
end;

function TFileCacheMod.handle_delete(const arg: TJSONObject): boolean;
var
  name, cache : string;
  fname       : string;
  i           : integer;
begin
  Result := false;

  name := JString( arg, 'name');
  cache:= JString( arg, 'cache');
  fname:= TPath.Combine(GM.Cache, format('%s\%s', [cache, name]));

  if FileExists(fname) then
      System.SysUtils.DeleteFile(fname);

  for i := 0 to pred(m_files.Count) do begin
    if SameText(m_files[i]^.cache, cache) and SameText(m_files[i]^.name, name) then begin
      Dispose(m_files[i]);
      m_files.Delete(i);
    end;
  end;
end;

function TFileCacheMod.handle_update(const arg: TJSONObject): boolean;
var
  name, cache : string;
  md5         : string;
  fname       : string;
  i           : integer;
  found       : boolean;
  ptr         : TPEntry;
begin
  Result  := false;
  found   := false;

  name    := JString( arg, 'name');
  cache   := JString( arg, 'cache');
  md5     := JString( arg, 'md5');
  fname   := TPath.Combine(GM.Cache, format('%s\%s', [cache, name]));

  for i := 0 to pred(m_files.Count) do begin
    found := SameText(m_files[i]^.cache, cache) and SameText(m_files[i]^.name, name);
    if found then
      break;
  end;
  if not found then begin
    new(ptr);
    ptr^.cache  := cache;
    ptr^.name   := name;
    ptr^.md5    := md5;
    m_files.Add(ptr);
  end;
end;

procedure TFileCacheMod.SyncCache;
var
  ptr : TPEntry;
begin
  clear;
  with FCTAb do begin
    open;
    while not eof  do begin
      new(ptr);

      ptr^.cache  := FieldByName('FC_CACHE').AsString;
      ptr^.name   := FieldByName('FC_NAME').AsString;
      ptr^.md5    := FieldByName('FC_MD5').AsString;

      CheckFile( ptr^ );

      next;
    end;
    close;
  end;
end;

function TFileCacheMod.upload(cache, name: string): boolean;
var
  fname     : string;
  client    : TdsFileCacheClient;
  req, res  : TJSONObject;
  st        : TStream;
begin
  Result  := false;
  fname   := TPath.combine( GM.Cache, format('%s\%s', [cache, name]));

  if not FileExists(fname) then  exit;

  client  := TdsFileCacheClient.Create(GM.SQLConnection1.DBXConnection);
  req     := TJSONObject.Create;
  JReplace( req, 'cache', cache);
  JReplace( req, 'name', name);

  try
    st  := TFileStream.Create(fname, fmOpenRead + fmShareDenyNone);
    res := client.upload( req, st);
    Result := JBool( res, 'result');
    st.Free;
  finally

  end;
  client.Free;
end;

end.
