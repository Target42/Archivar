unit ds_fileCache;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet, IBX.IBTable, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON, u_broadcastMsg;

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
    UnlockQry: TFDQuery;
    FL: TFDTable;
    FLTab: TDataSetProvider;
    LockQry: TFDQuery;
    AutoIncQry: TFDQuery;
    FDTransaction3: TFDTransaction;
    DnlQry: TFDQuery;
    GetLockQry: TFDQuery;
  private
    function sendInfo( cmd, cache, name : string; sendDirect : boolean = true) : TBroadcastMsg;
  public
    function AutoInc( gen : string ) : integer;

    [TRoleAuth('admin', 'user,download,broadcast')]
    function upload( req : TJSONObject; st : TStream ) : TJSONObject;

    [TRoleAuth('admin', 'user,download,broadcast')]
    function download( req : TJSONObject ) : TStream;

    [TRoleAuth('admin', 'user,download,broadcast')]
    function deleteFile( req : TJSONObject ) : TJSONObject;

    [TRoleAuth('admin', 'user,download,broadcast')]
    function Lock( req : TJSONObject ) : TJSONObject;

    [TRoleAuth('admin', 'user,download,broadcast')]
    function unlock( req : TJSONObject ) : TJSONObject;

  end;

implementation

uses
  m_db, u_json, u_Konst, ServerContainerUnit1, System.Variants, m_glob_server,
  Datasnap.DSSession;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsFileCache }

function TdsFileCache.AutoInc(gen: string): integer;
begin

  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;

  if AutoIncQry.Transaction.Active then
    AutoIncQry.Transaction.Commit;
end;

function TdsFileCache.deleteFile(req: TJSONObject): TJSONObject;
var
  ok    : boolean;
  cache : string;
  name  : string;
begin
  Result  := TJSONObject.Create;

  cache   := JString( req, 'cache');
  name    := JString( req, 'name');

  try
    if FileDelQry.Active then
      FileDelQry.Transaction.Rollback;

    FileDelQry.Transaction.StartTransaction;
    FileDelQry.ParamByName('cache').AsString  := UpperCase(cache);
    FileDelQry.ParamByName('name').AsString   := UpperCase(name);

    FileDelQry.ExecSQL;

    ok := FileDelQry.RowsAffected = 1;

    if FileDelQry.Active then
      FileDelQry.Transaction.Commit;

    if ok  then begin
      sendInfo(BRD_FILE_CACHE_DEL, cache, name);

      JResult( result, ok, '');
    end else
      JResult( Result, false, 'Datei nicht gefunden!');

  except
    on e : exception do
      JResult(Result, false, e.ToString);
  end;
end;

function TdsFileCache.download(req: TJSONObject): TStream;
var
  id  : integer;
  mem : TMemoryStream;
  st  : TStream;
begin
  Result := NIL;

  id := JInt( req, 'id');
  DnlQry.ParamByName('FC_ID').AsInteger := id;
  DnlQry.open;
  if not DnlQry.IsEmpty then begin
    mem := TMemoryStream.Create;
    st := DnlQry.CreateBlobStream(DnlQry.FieldByName('FC_DATA'), bmRead);
    mem.LoadFromStream(st);
    mem.Position := 0;
    Result := mem;
    st.Free;
  end;
  DnlQry.Close;
end;

function TdsFileCache.Lock(req: TJSONObject): TJSONObject;
var
  session : TDSSession;
  peid    : integer;
  uname   : string;
  msg     : TBroadcastMsg;
begin
  Result := TJSONObject.Create;

  Session := TDSSessionManager.GetThreadSession;

  peid := StrToIntDef(Session.GetData('id'), 1);
  if peid = 1 then
    uname := 'admin'
  else
    uname := format('%s %s (%s)',
      [session.GetData('vorname'),
       session.GetData('name'),
       session.GetData('dept')]);


  if FDTransaction2.Active then
    FDTransaction2.Commit;
  FDTransaction2.StartTransaction;

  with LockQry do begin
    ParamByName('FC_ID').AsInteger      := JInt( req, 'fcid');
    ParamByName('PE_ID').AsInteger      := peid;
    ParamByName('FL_USER').AsString     := uname;
    ParamByName('FL_STAMP').AsDateTime  := now;
    try
      ExecSQL;

      if FDTransaction2.Active then
        FDTransaction2.Commit;

      JResult(Result, true, '');

      msg := TBroadcastMsg.create(BRD_FILE_LOCK);
      msg.add('lock',   true);
      msg.add('id',     JInt( req, 'fcid'));
      msg.add('user',   uname);
      msg.add('tl',     DateTimeToStr(now));
      msg.add('userid', peid );;

      TBroadcastMsg.SendMsg(msg);

    except
      on e : exception do begin

        JResult( Result, false, 'Der Datensatz ist schon gesperrt oder nicht mehr vorhanden!');

        if FDTransaction2.Active then
          FDTransaction2.Rollback;
      end;
    end;
  end;
end;

function TdsFileCache.sendInfo( cmd, cache, name : string; sendDirect : boolean) : TBroadcastMsg;
begin
  Result := TBroadcastMsg.create(cmd);
  Result.add('cache', cache);
  Result.add('name', name);

  if sendDirect then begin
    TBroadcastMsg.SendMsg(Result);
  end;
end;

function TdsFileCache.unlock(req: TJSONObject): TJSONObject;
var
  fcid    : integer;
  usid    : integer;
  session : TDSSession;
  sid     : integer;
  ok      : boolean;
  msg     : TBroadcastMsg;
begin
  Result := TJSONObject.Create;

  fcid := JInt( req, 'fcid');
  usid := JInt( req, 'usid');

  Session := TDSSessionManager.GetThreadSession;
  sid     := StrToIntDef( Session.GetData('id'), 0);

  if (sid = 1) or ( sid = usid) then begin
    if FDTransaction2.Active then
      FDTransaction2.Rollback;
    FDTransaction2.StartTransaction;

    UnlockQry.ParamByName('FC_ID').AsInteger := fcid;
    UnlockQry.ExecSQL;
    ok := UnlockQry.RowsAffected > 0;

    if FDTransaction2.Active then
      FDTransaction2.Commit;

    if not ok then
      JResult( Result, ok, 'Kein Lock gefunden!')
    else begin
      msg := TBroadcastMsg.create(BRD_FILE_LOCK);
      msg.add('lock', false);
      msg.add('id', fcid);
      TBroadcastMsg.SendMsg(msg);

      JResult( Result, ok, '');
    end;
  end;

end;

function TdsFileCache.upload(req: TJSONObject; st: TStream): TJSONObject;
var
  cache : string;
  fname : string;
  mem   : TStream;
  msg   : TBroadcastMsg;
  md5   : string;
  id    : integer;


  function canUpload: boolean;
  var
    session : TDSSession;
    sid     : integer;
  begin
    Result  := ( JInt(req, 'fcid', -1) = -1 );
    Session := TDSSessionManager.GetThreadSession;
    sid     := StrToIntDef( Session.GetData('id'), 0);

    GetLockQry.ParamByName('FC_ID').AsInteger := JInt(req, 'fcid', -1);
    GetLockQry.Open;
    if not GetLockQry.IsEmpty then begin
      Result := (sid = 1) or ( sid = GetLockQry.FieldByName('PE_ID').AsInteger);
    end;
    GetLockQry.Close;
  end;

begin
  Result  := TJSONObject.Create;

  if not canUpload then begin
    JResult(Result, false, 'Die Datei ist nicht gesperrt oder von jemandem anderen gesperrt.');
    exit;
  end;

  cache   := JString( req, 'cache');
  fname   := JString( req, 'name');
  try
    with UploadTab do begin
      if  Transaction.Active then
        Transaction.Rollback;
      Transaction.StartTransaction;

      open;

      if Locate('FC_CACHE;FC_NAME', varArrayOf([cache, fname]), [loCaseInsensitive]) then
        edit
      else begin
        Append;
        FieldByName('FC_ID').AsInteger    := AutoInc('gen_fc_id');
        FieldByName('FC_NAME').AsString   := fname;
        FieldByName('FC_CACHE').AsString  := cache;
      end;

      id  := FieldByName('FC_ID').AsInteger;
      mem := GM.downloadMem(st);
      md5 := GM.md5(mem);

      FieldByName('FC_STAMP').AsDateTime  := now;
      FieldByName('FC_MD5').AsString      := md5;
      (FieldByName('FC_DATA') as TBlobField).LoadFromStream(mem);

      mem.Free;
      post;
      if Transaction.Active then
        Transaction.Commit;
      close;
    end;

    msg := sendInfo(BRD_FILE_CACHE_UPT, cache, fname, false);
    msg.add('id', id);
    msg.add('ts', DateTimeToStr(now));
    msg.add('md5', md5);
    TBroadcastMsg.SendMsg( msg );

    JResult(Result, true, 'Der Upload war erfolgreich.');
  except
    on e : exception do
      JResult( Result, false, e.ToString);
  end;
end;

end.



