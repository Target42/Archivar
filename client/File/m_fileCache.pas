unit m_fileCache;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, System.JSON, System.Generics.Collections;

type
  TCacheChange = procedure (Sender : TObject ) of object;
  TFileCacheMod = class(TDataModule)
    DSProviderConnection1: TDSProviderConnection;
    FCTab: TClientDataSet;
    FLTab: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    type
      TPEntry = ^TEntry;
      TEntry  = record
        id    : integer;
        cache : string;
        name  : string;
        md5   : string;
        ts    : string;

        // lock
        locked: boolean;  // flag, if locked
        user  : string;   // lock user
        tl    : string;   //lock time
        userid: integer;

      end;
  private
    m_files : TList<TPEntry>;
    m_listner : TCacheChange;

    procedure CheckFile( en : TEntry );
    procedure download(  en : TEntry );

    procedure clear;

    procedure setListner( value : TCacheChange );
  public
    property Files    : Tlist<TPEntry> read m_files;
    property Listner  : TCacheChange read m_listner write setListner;

    procedure SyncCache;

    function upload( cache, name, fname : string ) : boolean;
    function deleteFile( cache, name : string ) : boolean;

    function handle_update  (const arg : TJSONObject) : boolean;
    function handle_delete  (const arg : TJSONObject) : boolean;
    function handle_lock    (const arg : TJSONObject) : boolean;

    function getID( cache, name : string ) : integer;

    procedure fillList( cache : string; list : TStrings );
    function getFiles( cache : string ) : TList<TPEntry>;
    function getFile( ptr : TPEntry ) : string; overload;
    function getFile( cache, name : string ) : string; overload;

  end;

var
  FileCacheMod: TFileCacheMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  m_glob_client, u_stub, u_json, system.IOUtils, u_eventHandler, u_Konst,
  System.Variants;


{$R *.dfm}

procedure TFileCacheMod.CheckFile(en: TEntry);
var
  fname : string;
  dir   : string;
  st    : TStream;
begin
  dir   := TPath.Combine(GM.Cache, en.cache );
  ForceDirectories(dir);

  fname := TPath.Combine(dir, en.name);

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
  m_files   := TList<TPEntry>.create;
  m_listner := NIL;

  EventHandler.Register( self, handle_update, BRD_FILE_CACHE_UPT );
  EventHandler.Register( self, handle_delete, BRD_FILE_CACHE_DEL );
  EventHandler.Register( self, handle_lock,   BRD_FILE_CACHE_LOCK);
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

procedure TFileCacheMod.download(en: TEntry);
var
  client  : TdsFileCacheClient;
  fname   : string;
  md5     : string;
  st      : TStream;
  req     : TJSONObject;
begin
  fname := TPath.Combine(GM.Cache, format('', [en.cache, en.Name]));

  md5 := GM.md5(fname);

  if md5 <> en.md5 then begin
    client := TdsFileCacheClient.Create(GM.SQLConnection1.DBXConnection);

    req := TJSONObject.Create;
    JReplace( req, 'id', en.id);
    try
      st := client.download( req );
      if Assigned(st) then begin
        GM.download( fname, st );
      end;
    finally
      client.Free;
    end;
  end;
end;

procedure TFileCacheMod.fillList(cache: string; list: TStrings);
var
  ptr : TPEntry;
begin
  for ptr in m_files do begin
    if SameText(cache, ptr^.cache) then
      list.Add(ptr^.name);
  end;
end;

function TFileCacheMod.getFile(ptr: TPEntry): string;

begin
  Result := '';
  if not Assigned(ptr) then  exit;

  Result := TPath.Combine( GM.Cache, Format('%s\%s', [ptr^.cache, ptr^.name]));
//  if not FileExists(Result) then  Result := '';
end;

function TFileCacheMod.getFile(cache, name: string): string;
begin
  Result := TPath.Combine( GM.Cache, Format('%s\%s', [cache, name]));
//  if not FileExists(Result) then  Result := '';
end;

function TFileCacheMod.getFiles(cache: string): TList<TPEntry>;
var
  ptr : TPEntry;
begin
  Result := TList<TPEntry>.create;
  for ptr in m_files do begin
    if SameText(cache, ptr^.cache) then
      Result.Add(ptr);
  end;
end;

function TFileCacheMod.getID(cache, name: string): integer;
var
  ptr : TPEntry;
begin
  Result := -1;
  for ptr in m_files do begin
    if SameText(cache, ptr^.cache) and SameText(name, ptr^.name) then begin
      Result := ptr^.id;
      break;
    end;
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
  if Assigned(m_listner) then
    m_listner(Self);
end;

function TFileCacheMod.handle_lock(const arg: TJSONObject): boolean;
var
  id    : integer;
  ptr   : TPEntry;
begin
  id    := JInt   ( arg, 'id');

  for ptr in m_files do begin
    if ptr^.id = id then begin
      ptr^.locked := JBool  ( arg, 'lock');
      ptr^.user   := JString( arg, 'user');
      ptr^.tl     := JString( arg, 'tl');
      ptr^.userid := JInt(    arg, 'userid');
      break;
    end;
  end;

  if Assigned(m_listner) then
    m_listner(self);
  Result := true;
end;

function TFileCacheMod.handle_update(const arg: TJSONObject): boolean;
var
  i           : integer;
  ptr         : TPEntry;
  id          : integer;
  fname       : string;
  client      : TdsFileCacheClient;
  req         : TJSONObject;
  st          : TStream;
  path        : string;
begin
  Result  := false;

  id      := JInt( arg, 'id');
  ptr := NIL;
  for i := 0 to pred(m_files.Count) do begin
    if m_files[i]^.id = id then begin
      ptr := m_files[i];
      break;
    end;
  end;

  if not Assigned(ptr) then begin
    new(ptr);
    ptr^.id := id;
    m_files.Add(ptr);
  end;
  ptr^.cache  := JString( arg, 'cache');
  ptr^.name   := JString( arg, 'name');
  ptr^.md5    := JString( arg, 'md5');
  ptr^.ts     := JString( arg, 'ts');

  fname       := getFile(ptr);

  if not FileExists(fname) or (ptr^.md5 <> GM.md5(fname)) then begin
    client      := TdsFileCacheClient.Create(GM.SQLConnection1.DBXConnection);
    try
      req := TJSONObject.Create;
      JReplace( req, 'id', ptr^.id);

      st := client.download(req);

      path := ExtractFilePath(fname);
      ForceDirectories(path);
      GM.download(fname, st);
    finally
      client.Free;
    end;
  end;

  if Assigned(m_listner) then
    m_listner(Self);
end;

procedure TFileCacheMod.setListner(value: TCacheChange);
begin
  m_listner := value;
  if Assigned(m_listner) then
    m_listner(Self);

end;

procedure TFileCacheMod.SyncCache;
var
  ptr : TPEntry;
begin
  clear;
  FLTab.Open;
  with FCTAb do begin
    open;
    while not eof  do begin
      new(ptr);
      m_files.Add(ptr);

      ptr^.ID     := FieldByName('FC_ID').AsInteger;
      ptr^.cache  := FieldByName('FC_CACHE').AsString;
      ptr^.name   := FieldByName('FC_NAME').AsString;
      ptr^.md5    := FieldByName('FC_MD5').AsString;
      ptr^.ts     := FieldByName('FC_STAMP').AsString;
      ptr^.locked := FLTab.Locate('FC_ID', VarArrayOf([ptr^.id]), []);

      if  ptr^.locked then begin
        ptr^.user   := FLTab.FieldByName('FL_USER').AsString;
        ptr^.tl     := FLTab.FieldByName('FL_STAMP').AsString;
        ptr^.userid := FLTab.FieldByName('PE_ID').Asinteger;
      end;

      if (not ptr^.locked) or ((ptr^.locked) and (ptr^.userid <> GM.UserID)) then
        CheckFile( ptr^ );

      next;
    end;
    close;
  end;
  FLTab.Close;
end;

function TFileCacheMod.upload(cache, name, fname: string): boolean;
var
  client    : TdsFileCacheClient;
  req, res  : TJSONObject;
  st        : TStream;
begin
  Result  := false;

  if not FileExists(fname) then  exit;

  client  := TdsFileCacheClient.Create(GM.SQLConnection1.DBXConnection);
  req     := TJSONObject.Create;
  JReplace( req, 'cache', cache);
  JReplace( req, 'name', name);
  JReplace( req, 'fcid', getID( cache, name));

  try
    st  := TFileStream.Create(fname, fmOpenRead + fmShareDenyNone);
    res := client.upload( req, st);
    Result := JBool( res, 'result');
    ShowResult( res, true);
  finally

  end;
  client.Free;
end;


end.
