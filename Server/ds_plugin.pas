unit ds_plugin;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet, Datasnap.Provider,
  System.JSON;

type
  [TRoleAuth('download, admin', 'user')]
  TTdsPlugin = class(TDSServerModule)
    TabPlugin: TFDTable;
    FDTransaction1: TFDTransaction;
    PluginTab: TDataSetProvider;
    AutoIncQry: TFDQuery;
    procedure TabPluginBeforePost(DataSet: TDataSet);
  private
    function AutoInc( gen : string ) : integer;
  public
    function getList : TJSonObject;
    function download( data : TJSONObject ) : TStream;

    [TRoleAuth('admin')]
    function upload( data : TJSONObject; st : TStream ) : TJSONObject;
    [TRoleAuth('admin')]
    function setStatus(data : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  m_db, u_json, System.Variants, m_glob_server;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TTdsPlugin }

function TTdsPlugin.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;
end;

function TTdsPlugin.download(data: TJSONObject): TStream;
var
  bs : TStream;
begin
  Result := TMemoryStream.Create;
  TabPlugin.Open;
  if TabPlugin.Locate('PL_ID', VarArrayOf([JInt(data, 'id')]), []) then begin
    bs := TabPlugin.CreateBlobStream(TabPlugin.FieldByName('PL_DATA'),bmRead );
    GM.CopyStream(bs, Result);
    Result.Position := 0;
    bs.Free;
  end;
  TabPlugin.Close;
  if TabPlugin.Transaction.Active then
    TabPlugin.Transaction.Commit;
end;

function TTdsPlugin.getList: TJSonObject;
var
  arr : TJSONArray;
  row : TJSONObject;
begin
  Result := TJSONObject.Create;
  TabPlugin.Open;
  arr := TJSONArray.Create;
  while not TabPlugin.Eof do begin
    row := TJSONObject.Create;
    JReplace( row, 'id',        TabPlugin.FieldByName('PL_ID').AsInteger);
    JReplace( row, 'name',      TabPlugin.FieldByName('PL_NAME').AsString);
    JReplace( row, 'md5',       TabPlugin.FieldByName('PL_MD5').AsString);
    JReplace( row, 'state',     TabPlugin.FieldByName('PL_STATE').AsString);
    JReplace( row, 'filename',  TabPlugin.FieldByName('PL_FILENAME').AsString);
    arr.AddElement(row);
    TabPlugin.Next;
  end;

  TabPlugin.Close;

  JReplace( Result, 'items', arr);
  if TabPlugin.Transaction.Active then
    TabPlugin.Transaction.Commit;
end;

function TTdsPlugin.setStatus(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  if FDTransaction1.Active then
    FDTransaction1.Rollback;

  FDTransaction1.StartTransaction;

  TabPlugin.Open;
  if TabPlugin.Locate('PL_ID', VarArrayOf([JInt(data, 'id')]), []) then begin
    TabPlugin.Edit;
    TabPlugin.FieldByName('PL_STATE').AsString := JString(data, 'state');
    TabPlugin.Post;
    JResult( Result, true, 'Status geändert');
    FDTransaction1.Commit;
  end else begin
    JResult( Result, false, 'Pluign nicht gefunden');
    FDTransaction1.Rollback;
  end;
  TabPlugin.Close;
end;

procedure TTdsPlugin.TabPluginBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('PL_ID').IsNull then
    DataSet.FieldByName('PL_ID').AsInteger := AutoInc('gen_pl_id');

end;

function TTdsPlugin.upload(data: TJSONObject; st: TStream): TJSONObject;
var
  mem : TMemoryStream;
  bs  : TStream;
begin
  Result := TJSONObject.Create;

  if FDTransaction1.Active then
    FDTransaction1.Rollback;

  FDTransaction1.StartTransaction;

  TabPlugin.Open;

  if TabPlugin.Locate('PL_FILENAME', VarArrayOf([JString(data, 'filename')]), [loCaseInsensitive]) then begin
    TabPlugin.Edit;
  end else begin
    TabPlugin.Append;
    TabPlugin.FieldByName('PL_ID').AsInteger := AutoInc('gen_pl_id');
    TabPlugin.FieldByName('PL_FILENAME').AsString  := JString( data, 'filename');
  end;

  if (TabPlugin.State = dsEdit) or (TabPlugin.State = dsInsert) then begin
    mem := GM.downloadMem(st);
    bs  := TabPlugin.CreateBlobStream(TabPlugin.FieldByName('PL_DATA'), bmWrite);
    TabPlugin.FieldByName('PL_MD5').AsString := GM.md5(mem);
    bs.CopyFrom(mem, mem.Size);
    mem.Free;
    bs.Free;

    TabPlugin.FieldByName('PL_NAME').AsString  := JString( data, 'name', 'Plugin');
    TabPlugin.FieldByName('PL_STATE').AsString := JString( data, 'state', 'A');
    TabPlugin.Post;

    JResult( Result, true, 'ok');
  end else
    JResult( Result, false, 'Das Plugin konnte nicht hochgeladen werden!');

  TabPlugin.Close;

  FDTransaction1.Commit;
end;

end.

