unit ds_fileCache;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet, IBX.IBTable, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON;

type
  [TRoleAuth('user,admin,broadcast', 'download')]
  TdsFileCache = class(TDSServerModule)
    HCTab: TDataSetProvider;
    FDTransaction1: TFDTransaction;
    HC: TFDTable;
    FileCache: TFDTable;
    FCTab: TDataSetProvider;
    FileDelQry: TFDQuery;
    FDTransaction2: TFDTransaction;
    UploadTab: TFDTable;
  private
    procedure sendInfo( cmd, cache, name : string; md5 : string = '' );
  public
    [TRoleAuth('admin', 'user,download,broadcast')]
    function upload( req : TJSONObject; st : TStream ) : TJSONObject;
    [TRoleAuth('admin', 'user,download,broadcast')]
    function deleteFile( req : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  m_db, u_json, u_Konst, ServerContainerUnit1, System.Variants, m_glob_server;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsFileCache }

function TdsFileCache.deleteFile(req: TJSONObject): TJSONObject;
var
  ok    : boolean;
  cache : string;
  name  : string;
begin
  Result  := TJSONObject.Create;

  cache   := JString( req, 'cache');
  name    := JString( req, 'name');

  FileDelQry.ParamByName('cache').AsString  := UpperCase(cache);
  FileDelQry.ParamByName('name').AsString   := UpperCase(name);

  FileDelQry.ExecSQL;

  ok := FileDelQry.RowsAffected = 1;

  FileDelQry.Transaction.Commit;

  if ok  then
    sendInfo(BRD_FILE_CACHE_DEL, cache, name);
end;

procedure TdsFileCache.sendInfo(cmd, cache, name: string; md5 : string);
var
  msg : TJSONObject;
begin
  msg := TJSONObject.Create;

  JAction(  msg, cmd);
  JReplace( msg, 'cache', cache);
  JReplace( msg, 'name', name);
  if md5 <> '' then
    JReplace( msg, 'md5', md5);

  ServerContainer1.BroadcastMessage(BRD_CHANNEL, msg);
end;

function TdsFileCache.upload(req: TJSONObject; st: TStream): TJSONObject;
var
  cache : string;
  name  : string;
  mem   : TStream;
begin
  Result  := TJSONObject.Create;

  cache   := JString( req, 'cache');
  name    := JString( req, 'name');

  with UploadTab do begin
    open;

    if Locate('FC_CACHE;FC_NAME', varArrayOf([cache, name]), [loCaseInsensitive]) then
      edit
    else begin
      Append;
      FieldByName('FC_ID').AsInteger    := 1;
      FieldByName('FC_NAME').AsString   := name;
      FieldByName('FC_CACHE').AsString  := cache;
    end;

    mem := GM.downloadMem(st);
    mem.Position := 0;

    FieldByName('FC_MD5').AsString  := GM.md5(mem);
    mem.Position := 0;

    (FieldByName('FC_DATA') as TBlobField).LoadFromStream(mem);
    mem.Free;
    post;
    Transaction.Commit;
    close;
  end;
  sendInfo(BRD_FILE_CACHE_UPT, cache, name);

end;

end.



