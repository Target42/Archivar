unit ds_file;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB, IBX.IBDatabase, IBX.IBCustomDataSet, IBX.IBTable, IBX.IBQuery,
  System.JSON;

type
  [TRoleAuth('user,admin')]
  TdsFile = class(TDSServerModule)
    FITA: TIBTable;
    IBTransaction1: TIBTransaction;
    FileData: TIBTable;
    AutoIncQry: TIBQuery;
    ListFiles: TIBQuery;
    ListFilesQry: TDataSetProvider;
    FindFileQry: TIBQuery;
  private
    { Private declarations }
    function findFile( ta_id : integer; fname : string) : integer;
  public
    function AutoInc( gen : string ) : integer;
    function upload( data : TJSONObject ; st : TStream ) : TJSONObject;
    function deleteFile( ta_id, fi_id : integer ) : TJSONObject;
  end;

implementation

uses
  m_db, Variants, u_json, m_glob_server, Datasnap.DBClient;

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

function TdsFile.deleteFile(ta_id, fi_id: integer): TJSONObject;
var
  opts : TLocateOptions;
  found : boolean;
begin
  Result := TJSONObject.Create;
  found := false;

  if IBTransaction1.InTransaction then
    IBTransaction1.Rollback;

  IBTransaction1.StartTransaction;
  FITA.Open;

  if FITA.Locate('TA_ID;FI_ID', VarArrayOf([ta_id, fi_id]), opts) then
  begin
    FITA.Delete;
    found := true;
  end;
  FITA.Close;

  if found then
  begin
    FileData.Open;
    if FileData.Locate('FI_ID', VarArrayOf([FI_ID]), opts) then
      FileData.Delete;
    FileData.Close;
  end;
  IBTransaction1.Commit;
  JResponse(Result, true, 'Datei gelöscht');
end;

function TdsFile.findFile(ta_id : integer; fname: string): integer;
begin
  Result := 0;

  FindFileQry.ParamByName('TA_ID').AsInteger := ta_id;
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

function TdsFile.upload(data: TJSONObject; st: TStream): TJSONObject;
var
  bst : TStream;
  fiid : integer;
  taid : Integer;
  opts : Tlocateoptions;
  fname : string;
begin
  opts := [loCaseInsensitive];
  Result := TJSONObject.Create;

  if IBTransaction1.InTransaction then
    IBTransaction1.Rollback;

  IBTransaction1.StartTransaction;
  try
    taid  := JInt( data, 'taid' );
    fname := JString( data, 'fname');

    FileData.Open;
    fiid := findFile( taid, fname );

    if fiid = 0 then
    begin
      fiid  := AutoInc('gen_fi_id');
      FileData.Append;
      FileData.FieldByName('FI_ID').AsInteger        := fiid;
      FileData.FieldByName('FI_NAME').AsString       := fname;
      FileData.FieldByName('FI_TYPE').AsString       := JString( data, 'type');
      FileData.FieldByName('FI_CREATED').AsDateTime  := now;
      FileData.FieldByName('FI_TODELETE').AsDateTime := IncMonth(now, JInt( data, 'todelete', 6));
      FileData.FieldByName('FI_VERSION').AsInteger   := 1;

      bst := FileData.CreateBlobStream( FileData.FieldByName('FI_DATA'), bmWrite);
      GM.CopyStream( st, bst);
      bst.Free;
      FileData.Post;

      FITA.Open;
      FITA.Append;
      FITA.FieldByName('TA_ID').AsInteger := taid;
      FITA.FieldByName('FI_ID').AsInteger := fiid;
      FITA.Post;
    end
    else
    begin
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

    IBTransaction1.Commit;

    FileData.Close;
    FITA.close;

    JResponse( Result, true, 'Der Upload war erfolgreich');
  except
    begin
      IBTransaction1.Rollback;
      JResponse( Result, false, 'Der Upload ist fehlgeschlagen');
    end;
  end;
end;

end.

