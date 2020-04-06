unit ds_einstellung;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, IBX.IBDatabase,
  Data.DB, IBX.IBCustomDataSet, IBX.IBTable, IBX.IBQuery, Datasnap.Provider,
  IBX.IBUpdateSQL, Datasnap.DBClient;

type
  [TRoleAuth('user,admin')]
  TdsEinstellung = class(TDSServerModule)
    Task: TIBTable;
    Einstellung: TIBTable;
    IBTransaction1: TIBTransaction;
    AutoIncQry: TIBQuery;
    TaskTab: TDataSetProvider;
    DataTab: TDataSetProvider;
    TaskInfo: TIBQuery;
    GremiumQry: TDataSetProvider;
    EinstellungTab: TDataSetProvider;
    FindTaskQry: TIBQuery;
    AddDataQry: TIBQuery;
    UpdateTask: TIBQuery;
    IBUpdateSQL1: TIBUpdateSQL;
    IBUpdateSQL2: TIBUpdateSQL;
    UdateTrans: TIBTransaction;
    procedure DSServerModuleDestroy(Sender: TObject);
    procedure EinstellungTabUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
  private
    { Private declarations }
  public
    function AutoInc( gen : string ) : integer;
    function getDataID( ta_id : integer ) : integer;
  end;

implementation

uses
  m_db, m_glob_server;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsEinstellung }

function TdsEinstellung.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;

end;

procedure TdsEinstellung.DSServerModuleDestroy(Sender: TObject);
begin
  if IBTransaction1.InTransaction then
    IBTransaction1.Commit;
end;

procedure TdsEinstellung.EinstellungTabUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
  DebugMsg(e.ToString);
end;

function TdsEinstellung.getDataID(ta_id: integer): integer;
begin
  Result := -1;

  if UdateTrans.InTransaction then
    UdateTrans.Rollback;

  UdateTrans.StartTransaction;

  FindTaskQry.ParamByName('TA_ID').AsInteger := ta_id;
  FindTaskQry.Open;
  if not FindTaskQry.Eof then
    Result := FindTaskQry.FieldByName('TA_SUB_ID').AsInteger;
  FindTaskQry.Close;

  if Result = -1 then
   begin
     UdateTrans.Rollback;
     exit;
   end;

   if Result = 0 then
   begin
     Result := AutoInc('gen_ES_ID');
     AddDataQry.ParamByName('ES_ID').AsInteger := Result;
     AddDataQry.ExecSQL;

     UpdateTask.ParamByName('TA_ID').AsInteger := ta_id;
     UpdateTask.ParamByName('ID').AsInteger := Result;
     UpdateTask.ExecSQL;
   end;
   UdateTrans.Commit;
end;

end.

