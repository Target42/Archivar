unit ds_file;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB,
  System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  [TRoleAuth('user,admin', 'download')]
  TdsFile = class(TDSServerModule)
    ListFilesQry: TDataSetProvider;
    FDTransaction1: TFDTransaction;
    ListFiles: TFDQuery;
    FindFileQry: TFDQuery;
    AutoIncQry: TFDQuery;
    FileData: TFDTable;
    ListFolder: TFDQuery;
    ListFolderQry: TDataSetProvider;
    DirTab: TFDTable;
    ListChilds: TFDQuery;
  private
    { Private declarations }
    function findFile( dr_id : integer; fname : string) : integer;
  public
    function AutoInc   ( gen  : string )                     : integer;
    function upload    ( data : TJSONObject ; st : TStream ) : TJSONObject;
    function deleteFile( fi_id : integer )                   : TJSONObject;

    function createRoot  ( data : TJSONobject ) : TJSONObject;
    function newFolder   ( data : TJSONobject ) : TJSONObject;
    function deleteFolder( data : TJSONObject ) : TJSONObject;
    function renameFolder( data : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  m_db, Variants, u_json, m_glob_server, Datasnap.DBClient, u_Konst,
  ServerContainerUnit1;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsFile }


function TdsFile.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;
end;

function TdsFile.createRoot(data: TJSONobject): TJSONObject;
var
  id : integer;
begin
  Result := TJSONObject.Create;
  if FDTransaction1.Active then
    FDTransaction1.StartTransaction;

  DirTab.Open;
  try
    id := AutoInc('gen_dr_id');

    DirTab.Append;
    DirTab.FieldByName('DR_ID').AsInteger     := id;
    DirTab.FieldByName('DR_GROUP').AsInteger  := id;
    DirTab.Post;
    JReplace( Result, 'id', id);
    JResult(  Result, true, '');
  except
    on e : exception do begin
      JResult( Result, false, e.ToString);
      if FDTransaction1.Active then
        FDTransaction1.Rollback;
    end;
  end;
  if FDTransaction1.Active then
    FDTransaction1.Commit;

  DirTab.close;
end;

function TdsFile.deleteFile(fi_id: integer): TJSONObject;
var
  opts : TLocateOptions;
begin
  Result := TJSONObject.Create;


  if FDTransaction1.Active then
    FDTransaction1.Rollback;

  FDTransaction1.StartTransaction;
  FileData.Open;

  if FileData.Locate('FI_ID', VarArrayOf([FI_ID]), opts) then
    FileData.Delete;
  FileData.Close;

  FDTransaction1.Commit;
  JResponse(Result, true, 'Datei gelöscht');
end;

function TdsFile.deleteFolder(data: TJSONObject): TJSONObject;
begin
  Result := NIL;
end;

function TdsFile.findFile(dr_id : integer; fname: string): integer;
begin
  Result := 0;

  FindFileQry.ParamByName('dr_ID').AsInteger := dr_id;
  FindFileQry.Open;
  while not FindFileQry.Eof do
  begin
    if SameText(fname, FindFileQry.FieldByName('FI_NAME').AsString) then
    begin
      Result := FindFileQry.FieldByName('FI_ID').AsInteger;
      break;
    end;
    FindFileQry.Next;
  end;
  FindFileQry.Close;
end;

function TdsFile.newFolder(data: TJSONobject): TJSONObject;
var
  pid   : integer;
  id    : integer;
  grid  : integer;
  msg   : TJSONObject;
  name  : string;
begin
  Result := TJSONObject.Create;

  pid := JInt( data, 'pid');
  id  := 0;
  grid:= 0;
  name:= JString( data, 'name', 'Neuer Ordner');
  if pid = 0 then begin
    JResult( Result, false, 'Root-Verzeichnis nicht gefunden.');
    exit;
  end;

  if FDTransaction1.Active then
    FDTransaction1.StartTransaction;
  DirTab.Open;
  try
    if (pid <> 0 ) and not DirTab.Locate('DR_ID', VarArrayOf([pid]), [] ) then begin
      JResult( Result, false, 'Root-Verzeichnis nicht gefunden.');
    end else begin
      grid := DirTab.FieldByName('DR_GROUP').AsInteger;
      id := AutoInc('gen_dr_id');

      DirTab.Append;
      DirTab.FieldByName('DR_ID').AsInteger     := id;
      DirTab.FieldByName('DR_GROUP').AsInteger  := grid;
      DirTab.FieldByName('DR_PARENT').AsInteger := pid;
      DirTab.FieldByName('DR_NAME').AsString    := name;
      DirTab.Post;

      JReplace( Result, 'id',   id);
      JReplace( Result, 'grid', grid);
      JResult( Result, true,    '');
    end;
  except
    on e : exception do begin
      JResult( Result, false, e.ToString);
      if FDTransaction1.Active then
        FDTransaction1.Rollback;
    end;
  end;
  if FDTransaction1.Active then
    FDTransaction1.Commit;
  DirTab.Close;

  if JBool( Result, 'result') then begin
      msg := TJSONObject.Create;
      JAction(  msg, BRD_FOLDER_NEW);
      JReplace( msg, 'id',   id);
      JReplace( msg, 'grid', grid);
      JReplace( msg, 'name', name );
      JReplace( msg, 'pid',  pid );
      JReplaceDouble( msg, 'stamp', now);

      ServerContainer1.BroadcastMessage(BRD_CHANNEL, msg);
  end;

end;

function TdsFile.renameFolder(data: TJSONObject): TJSONObject;
var
  id    : integer;
  grid  : integer;
  pid   : integer;
  name  : string;
  msg   : TJSONObject;
  found : boolean;
begin
  Result := TJSONObject.Create;

  id    := JInt( data,   'id');
  grid  := JInt( data,   'grid');
  pid   := JInt( data,   'pid');
  name  := JString(data, 'newname', 'John Doe');

  if FDTransaction1.Active then
    FDTransaction1.Rollback;
  FDTransaction1.StartTransaction;

  found := false;
  ListChilds.ParamByName('grp').AsInteger := grid;
  ListChilds.ParamByName('pid').AsInteger := pid;
  ListChilds.Open;
  while not ListChilds.Eof and not found do begin
    found := SameText(ListChilds.FieldByName('dr_name').AsString, name) and not
             (ListChilds.FieldByName('dr_id').AsInteger = id);
    ListChilds.Next;
  end;
  ListChilds.Close;

  if not found then begin
    DirTab.Open;
    if DirTab.Locate('DR_ID;DR_GROUP', VarArrayOf([id, grid]), []) then begin
      DirTab.Edit;
      DirTab.FieldByName('DR_NAME').AsString := name;
      DirTab.Post;

      JResult(Result, true, '');
    end else
      JResult( Result, false, 'Ordnder nicht gefunden!');
  end else
    JResult( Result, false, 'Der Name ist schon vergeben');


  FDTransaction1.Commit;
  DirTab.Close;

  if not found  and JBool( Result, 'result') then begin
      msg := TJSONObject.Create;
      JAction(  msg, BRD_FOLDER_REN);
      JReplace( msg, 'id',   id);
      JReplace( msg, 'grid', grid);
      JReplace( msg, 'name', name );
      ServerContainer1.BroadcastMessage(BRD_CHANNEL, msg);
  end;
end;

function TdsFile.upload(data: TJSONObject; st: TStream): TJSONObject;
var
  bst : TStream;
  fiid : integer;
  drid : Integer;
  opts : Tlocateoptions;
  fname : string;
begin
  opts := [loCaseInsensitive];
  Result := TJSONObject.Create;

  if FDTransaction1.Active then
    FDTransaction1.Rollback;

  FDTransaction1.StartTransaction;
  try
    drid  := JInt( data,    'drid' );
    fname := JString( data, 'fname');

    FileData.Open;
    fiid := findFile( drid, fname );

    if fiid = 0 then
    begin // new file
      fiid  := AutoInc('gen_fi_id');
      FileData.Append;
      FileData.FieldByName('FI_ID').AsInteger        := fiid;
      FileData.FieldByName('DR_ID').AsInteger        := drid;
      FileData.FieldByName('FI_NAME').AsString       := fname;
      FileData.FieldByName('FI_TYPE').AsString       := JString( data, 'type');
      FileData.FieldByName('FI_CREATED').AsDateTime  := now;
      FileData.FieldByName('FI_TODELETE').AsDateTime := IncMonth(now, JInt( data, 'todelete', 6));
      FileData.FieldByName('FI_VERSION').AsInteger   := 1;

      bst := FileData.CreateBlobStream( FileData.FieldByName('FI_DATA'), bmWrite);
      GM.CopyStream( st, bst);
      bst.Free;
      FileData.Post;
    end
    else
    begin // Update File ..
      if FileData.Locate('FI_ID', VarArrayOf([fiid]), opts) then
      begin
        FileData.Edit;
        FileData.FieldByName('FI_VERSION').AsInteger   :=  FileData.FieldByName('FI_VERSION').AsInteger +1;
        bst := FileData.CreateBlobStream( FileData.FieldByName('FI_DATA'), bmWrite);
        GM.CopyStream( st, bst);
        bst.Free;
        FileData.Post;
      end;
    end;

    FDTransaction1.Commit;

    FileData.Close;

    JResponse( Result, true, 'Der Upload war erfolgreich');
  except
    on e : exception do
    begin
      FDTransaction1.Rollback;
      JResponse( Result, false, 'Der Upload ist fehlgeschlagen'+sLineBreak+e.ToString);
    end;
  end;
end;

end.

