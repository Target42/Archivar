unit ds_file;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB,
  System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  System.Generics.Collections;

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
    AddHistQry: TFDQuery;
    DelFileHist: TFDQuery;
    UpdateDirSum: TFDQuery;
    FileInfoQry: TFDQuery;
    FileHistInfo: TFDQuery;
    MoveFilesQry: TFDQuery;
    DelFileQry: TFDQuery;
    FolderList: TFDQuery;
    UpdateParentQry: TFDQuery;
    UpdateGrpQry: TFDQuery;
  private
    { Private declarations }
    function findFile( dr_id : integer; fname : string) : integer;
    function findFolder( id, grp : integer  ) : TList<integer>;
  public
    function AutoInc   ( gen  : string )                     : integer;
    function upload    ( data : TJSONObject ; st : TStream ) : TJSONObject;
    function deleteFile( data : TJSONobject )                : TJSONObject;

    function createRoot  ( data : TJSONobject ) : TJSONObject;
    function newFolder   ( data : TJSONobject ) : TJSONObject;
    function deleteFolder( data : TJSONObject ) : TJSONObject;
    function renameFolder( data : TJSONObject ) : TJSONObject;

    function move        ( data : TJSONObject ) : TJSONObject;

    function getFileInfo( data : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  m_db, Variants, u_json, m_glob_server, Datasnap.DBClient, u_Konst,
  ServerContainerUnit1, u_folder;

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

function TdsFile.deleteFile(data : TJSONobject): TJSONObject;
var
  ids   : TList<integer>;
  id    : integer;
begin
  Result := TJSONObject.Create;

  if FDTransaction1.Active then
    FDTransaction1.Rollback;

  try
    FDTransaction1.StartTransaction;

    ids := JArrayToInteger(JArray(data, 'items'));
    DelFileHist.Prepare;
    DelFileQry.Prepare;

    for id in ids do begin
      DelFileQry.ParamByName('ID').AsInteger  := id;
      DelFileQry.ExecSQL;

      DelFileHist.ParamByName('id').AsInteger := id;
      DelFileHist.ExecSQL;
    end;
    DelFileHist.Unprepare;
    DelFileQry.Unprepare;

    FDTransaction1.Commit;
    JResponse(Result, true, 'Datei gelöscht');
  except
    on e : exception do begin
      JResult( Result, false, e.ToString);
      if FDTransaction1.Active then
        FDTransaction1.Rollback;
    end;
  end;
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

function TdsFile.findFolder(id, grp: integer): TList<integer>;
var
  list  : TList<TFolder>;
  fld   : TFolder;
  root  : TFolder;
  procedure fillList;
  begin
    with FolderList do begin
      ParamByName('grp').AsInteger := grp;
      open;
      while not eof do begin
        fld    := TFolder.create;
        fld.ID := FieldByName('DR_ID').AsInteger;
        fld.PID:= FieldByName('DR_PARENT').AsInteger;
        list.Add(fld);
        if fld.ID = id then
          root := fld;
        next;
      end;
      Close;
    end;
  end;
  function find( id : integer ) : TFolder;
  var
    fld : TFolder;
  begin
    Result := NIL;
    for fld in list do begin
      if fld.ID = id then begin
        Result := fld;
        break;
      end;
    end;
  end;
  procedure findChilds;
  var
    fld : TFolder;
    pfld: TFolder;
  begin
    for fld in list do begin
      pfld := find(fld.PID);
      if Assigned(pfld) then
        pfld.add(fld);
    end;
  end;
  procedure listFolder( root : TFolder );
  var
    fld : TFolder;
  begin
    if not Assigned(root) then exit;
    Result.Add( root.ID );
    for fld in root.Childs do
      listFolder(fld);
  end;
begin
  Result  := TList<integer>.create;
  list    := TList<TFolder>.create;

  fillList;
  findChilds;
  listFolder(root);

  for fld in list do
    fld.free;
  list.free;
end;

function TdsFile.getFileInfo(data: TJSONObject): TJSONObject;
var
  arr : TJSONArray;
  row : TJSONObject;
begin
  Result  := TJSONObject.Create;
  arr     := TJSONArray.Create;
  FileInfoQry.ParamByName('id').AsInteger := JInt( data, 'id');
  FileInfoQry.Open;
  if not FileInfoQry.IsEmpty then begin
    JReplace( Result, 'drid',FileInfoQry.FieldByName('DR_ID').AsInteger);
    row := TJSONObject.Create;

    JReplace(       row, 'name',      FileInfoQry.FieldByName('FI_NAME').AsString);
    JReplaceDouble( row, 'created',   FileInfoQry.FieldByName('FI_CREATED').AsDateTime);
    JReplaceDouble( row, 'todelete',  FileInfoQry.FieldByName('FI_TODELETE').AsDateTime);
    JReplace(       row, 'user',      FileInfoQry.FieldByName('FI_CREATED_BY').AsString);
    JReplace(       row, 'size',      FileInfoQry.FieldByName('FI_SIZE').AsLargeInt);
    JReplace(       row, 'version',   FileInfoQry.FieldByName('FI_VERSION').AsInteger );

    arr.AddElement(row);
  end;
  FileInfoQry.Close;
  FileHistInfo.ParamByName('ID').AsInteger := JInt( data, 'id');
  FileHistInfo.Open;
  while not FileHistInfo.Eof do begin
    row := TJSONObject.Create;

    JReplace(       row, 'name',      FileHistInfo.FieldByName('FI_NAME').AsString);
    JReplaceDouble( row, 'created',   FileHistInfo.FieldByName('FI_CREATED').AsDateTime);
    JReplaceDouble( row, 'todelete',  FileHistInfo.FieldByName('FI_TODELETE').AsDateTime);
    JReplace(       row, 'user',      FileHistInfo.FieldByName('FI_CREATED_BY').AsString);
    JReplace(       row, 'size',      FileHistInfo.FieldByName('FI_SIZE').AsLargeInt);
    JReplace(       row, 'version',   FileHistInfo.FieldByName('FI_VERSION').AsInteger );

    arr.AddElement(row);
    FileHistInfo.Next;
  end;

  FileHistInfo.Close;
  JReplace( Result, 'items', arr);
end;

function TdsFile.move(data: TJSONObject): TJSONObject;

  procedure sendUpdate( id : integer; typ : string );
  var
    msg : TJSONObject;
  begin
    msg := TJSONObject.Create;
    JAction(  msg, BRD_FOLDER_UPDATE);
    JReplace( msg, 'grid', id);
    JReplace( msg, 'type', typ);
    ServerContainer1.BroadcastMessage(BRD_CHANNEL, msg);
  end;

  procedure moveFiles;
  var
    ids : TList<integer>;
    id  : integer;
  begin
    try
      ids  := JArrayToInteger( JArray(data, 'items'));
      MoveFilesQry.ParamByName('src').AsInteger := JInt(data, 'src' );
      MoveFilesQry.ParamByName('dest').AsInteger:= JInt(data, 'dest');
      MoveFilesQry.Prepare;
      for id in ids do begin
        MoveFilesQry.ParamByName('id').AsInteger := id;
        MoveFilesQry.ExecSQL;
      end;
      MoveFilesQry.Unprepare;
      ids.free;

      if FDTransaction1.Active then
        FDTransaction1.Commit;

      sendUpdate(JInt(data, 'src' ),  'files');
      sendUpdate(JInt(data, 'dest' ), 'files');
      JResult( Result, true, '');
    except
      on e : exception do begin
        JResult( Result, false, e.ToString);
        if FDTransaction1.Active then
          FDTransaction1.Rollback;
      end;
    end;
  end;

  procedure moveFolder;
  var
    list  : TList<integer>;
    id    : integer;
    grp   : integer;
  begin
      list := findFolder( JInt( data, 'src'), JInt( data, 'srcgrp'));
      try
      grp  := JInt( data, 'destgrp');
      UpdateGrpQry.Prepare;
      for id in list do begin
        UpdateGrpQry.ParamByName('grp').AsInteger := grp;
        UpdateGrpQry.ParamByName('id').AsInteger  := id;
        UpdateGrpQry.ExecSQL;
      end;
      UpdateGrpQry.Unprepare;

      UpdateParentQry.ParamByName('pid').AsInteger := JInt( data, 'dest');
      UpdateParentQry.ParamByName('id').AsInteger  := JInt( data, 'src');
      UpdateParentQry.ExecSQL;

      if FDTransaction1.Active then
        FDTransaction1.Commit;

      sendUpdate(JInt(data, 'srcgrp' ),  'folder');
      sendUpdate(JInt(data, 'destgrp' ), 'folder');

      JResult( Result, true, '');
    except
      on e : exception do begin
        JResult( Result, false, e.ToString);
      end;
    end;
    list.Free;
  end;
begin
  Result := TJSONObject.Create;
  if FDTransaction1.Active then  FDTransaction1.Rollback;

  FDTransaction1.StartTransaction;

  if SameText(JString( data, 'type'), 'files') then
    moveFiles
  else if SameText( JString( data, 'type'), 'folder') then
    moveFolder;

  if FDTransaction1.Active then   FDTransaction1.Rollback;

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
  opts    := [loCaseInsensitive];
  Result  := TJSONObject.Create;

  if FDTransaction1.Active then
    FDTransaction1.Rollback;

  FDTransaction1.StartTransaction;
  try
    drid  := JInt(    data,    'drid' );
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
      FileData.FieldByName('FI_CREATED_BY').AsString := GM.getNameFromSession;
      FileData.FieldByName('FI_SIZE').AsLargeInt     := JInt64( data, 'size');

      bst := FileData.CreateBlobStream( FileData.FieldByName('FI_DATA'), bmWrite);
      GM.CopyStream( st, bst);
      bst.Free;
      FileData.Post;
    end
    else
    begin // Update File ..
      if FileData.Locate('FI_ID', VarArrayOf([fiid]), opts) then
      begin
        // add to history
        AddHistQry.ParamByName('ID').AsInteger := fiid;
        AddHistQry.ExecSQL;

        FileData.Edit;
        FileData.FieldByName('FI_VERSION').AsInteger   :=  FileData.FieldByName('FI_VERSION').AsInteger +1;
        bst := FileData.CreateBlobStream( FileData.FieldByName('FI_DATA'), bmWrite);
        GM.CopyStream( st, bst);
        bst.Free;
        FileData.FieldByName('FI_CREATED').AsDateTime  := now;
        FileData.FieldByName('FI_CREATED_BY').AsString := GM.getNameFromSession;
        FileData.FieldByName('FI_SIZE').AsLargeInt     := JInt64( data, 'size');
        FileData.Post;
      end;
    end;
    UpdateDirSum.ParamByName('ID').AsInteger := drid;
    UpdateDirSum.ExecSQL;

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

