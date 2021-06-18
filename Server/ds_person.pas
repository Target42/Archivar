unit ds_person;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, m_db, IBX.IBQuery,
  Datasnap.Provider, IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet, IBX.IBTable,
  System.JSON, JvCsvData;

type
  [TRoleAuth('user,admin')]
  TdsPerson = class(TDSServerModule)
    PETable: TIBTable;
    IBTransaction1: TIBTransaction;
    PETab: TDataSetProvider;
    AutoIncQry: TIBQuery;
    JvCsvDataSet1: TJvCsvDataSet;
  private
    { Private declarations }
  public
    function AutoInc( gen : string ) : integer;
    function ImportPersonenCSV( st : TStream ) : TJSONObject;
    function ExportPersonenCSV : TStream;
  end;

implementation

uses
  m_glob_server, u_json;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsPerson }

function TdsPerson.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;
end;

function TdsPerson.ExportPersonenCSV: TStream;
begin
  Result := NIL;
end;

function TdsPerson.ImportPersonenCSV(st: TStream): TJSONObject;
var
  fname : string;
begin
  fname := GM.saveToTempFile(st);
  Result := TJSONObject.Create;
  JvCsvDataSet1.LoadFromFile(fname);
  PETable.Open;
  try
    JvCsvDataSet1.Open;
    while not JvCsvDataSet1.Eof do
    begin
      PETable.Append;
      PETable.FieldByName('PE_ID').AsInteger        := AutoInc('gen_PE_ID');
      PETable.FieldByName('PE_NET').AsString        := JvCsvDataSet1.FieldByName('id').AsString;
      PETable.FieldByName('PE_NAME').AsString       := JvCsvDataSet1.FieldByName('name').AsString;
      PETable.FieldByName('PE_VORNAME').AsString    := JvCsvDataSet1.FieldByName('vorname').AsString;
      PETable.FieldByName('PE_DEPARTMENT').AsString := JvCsvDataSet1.FieldByName('abteilung').AsString;
      PETable.FieldByName('PE_MAIL').AsString       := JvCsvDataSet1.FieldByName('mail').AsString;
      PETable.Post;

      JvCsvDataSet1.Next;
    end;
    JResult(Result, true, 'Import abgeschlossen');
  except
    begin
      JResult(Result, false, 'Import fehlgeschlagen');
      if PETable.Transaction.InTransaction then
        PETable.Transaction.Rollback;
    end;
  end;
  if PETable.Transaction.InTransaction then
    PETable.Transaction.Commit;
  PETable.Close;

  JvCsvDataSet1.Close;
  try
    DeleteFile(fname);
  finally

  end;

end;

end.

