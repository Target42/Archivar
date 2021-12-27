unit ds_storage;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.Provider,
  System.JSON;

type
  TdsStorage = class(TDSServerModule)
    FDTransaction1: TFDTransaction;
    AutoIncQry: TFDQuery;
    Storages: TFDTable;
    StorageTab: TDataSetProvider;
    DRTab: TFDTable;
    STTab: TFDTable;
    FDTransaction2: TFDTransaction;
    CountFolder: TFDQuery;
    CountFolderQry: TDataSetProvider;
    CountFiles: TFDQuery;
    CountFilesQry: TDataSetProvider;
    Memory: TFDQuery;
    MemoryQry: TDataSetProvider;
  private
    procedure sendUpdate( cmd, name : string; id, drid : integer );
    function find( fldname : string ) : boolean;
  public
    function AutoInc   ( gen  : string )                     : integer;

    function newStorage( data : TJSONobject ) : TJSONObject;
    function renameStorage(data : TJSONobject ) : TJSONObject;
  end;

implementation

uses
  m_db, u_json, u_Konst, ServerContainerUnit1, System.Variants;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdsStorage }

function TdsStorage.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;
end;

function TdsStorage.find(fldname: string): boolean;
begin
  Result := false;
  with sttab do begin
    first;
    while not eof and not Result do begin
      Result := SameText(fldname, FieldByName('ST_NAME').AsString);
      next;
    end;
  end;
end;

function TdsStorage.newStorage(data: TJSONobject): TJSONObject;
var
  drid  : integer;
  stid  : integer;
  fldname  : string;
begin
  Result := TJSONObject.Create;
  if FDTransaction2.Active then
    FDTransaction2.Rollback;

  fldname := JString( data, 'name');
  FDTransaction2.StartTransaction;

  STTab.Open;
  if find(fldname) then begin
    JResult( Result, false, 'Der Name ist schon vergeben!');
    FDTransaction2.Rollback;
    STTab.Close;
    exit;
  end;

  try
    with drtab do begin
      drid := AutoInc('gen_dr_id');
      open;
      Append;
      FieldByName('dr_id').AsInteger    := drid;
      FieldByName('dr_group').AsInteger := drid;
      Post;
    end;

    with sttab do begin
      stid := AutoInc('gen_st_id');
      append;
      FieldByName('st_id').AsInteger  := stid;
      FieldByName('dr_id').AsInteger  := drid;
      FieldByName('st_name').AsString := fldname;
      post;
    end;

    FDTransaction2.Commit;

    JResult( Result, true, '');
    JReplace( Result, 'id', stid);
    JReplace( Result, 'drid',drid);
    JReplace( Result, 'name', fldname);

    sendUpdate('new', fldname, stid, drid);

  except
    on e : exception do begin
      if FDTransaction2.Active then
        FDTransaction2.Rollback;
      JResult( Result, false, e.ToString);
    end;
  end;

end;

function TdsStorage.renameStorage(data: TJSONobject): TJSONObject;
var
  fldname  : string;
  id    : integer;
  drid  : integer;
begin
  Result := TJSONObject.Create;
  fldname:= JString( data, 'name');
  id     := JInt( data, 'id');
  drid   := -1;

  if FDTransaction2.Active then
    FDTransaction2.Rollback;

  FDTransaction2.StartTransaction;
  STTab.Open;
  if not find(fldname) then begin
    try
      if STTab.Locate('st_id', VarArrayOf([id]), []) then begin
        STTab.Edit;
        STTab.FieldByName('ST_NAME').AsString := fldname;
        drid  := STTab.FieldByName('DR_ID').AsInteger;
        STTab.Post;
        FDTransaction2.Commit;

        JResult( Result, true,    '' );
        JReplace( Result, 'name', fldname);
        JReplace( Result, 'id',   id );
      end else begin
        JResult( Result, false, 'Name nicht gefunden!');
      end;

      sendUpdate('update', fldname, id, drid);
    except
      on e :exception do begin
        JResult( Result, false, e.ToString);
      end;
    end;
  end else
    JResult( Result, false, 'Der Name ist schon vergeben');

  if FDTransaction2.Active then
    FDTransaction2.Rollback;

  STTab.Close;

end;

procedure TdsStorage.sendUpdate(cmd, name: string; id, drid: integer);
var
  msg : TJSONObject;
begin
  msg := TJSONObject.Create;
  JAction(  msg, BRD_STORE_UPDATE);
  JReplace( msg, 'cmd',   cmd );
  JReplace( msg, 'name',  name);
  JReplace( msg, 'id',    id );
  JReplace( msg, 'drid',  drid );

  ServerContainer1.BroadcastMessage(BRD_CHANNEL, msg);
end;

end.

