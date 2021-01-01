unit ds_protocol;

interface

uses
  System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, System.JSON,
  IBX.IBQuery, IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet, IBX.IBTable,
  Datasnap.Provider, IBX.IBUpdateSQL;

type
  TdsProtocol = class(TDSServerModule)
    PRTab: TIBTable;
    IBTransaction1: TIBTransaction;
    AutoIncQry: TIBQuery;
    PRTable: TDataSetProvider;
    TNTab: TIBTable;
    TGTab: TIBTable;
    TGTable: TDataSetProvider;
    PEQry: TIBQuery;
    DeleteTrans: TIBTransaction;
    deleteTNQry: TIBQuery;
    deleteTGQry: TIBQuery;
    deletePrTaQry: TIBQuery;
    deletePR: TIBQuery;
    ListPr: TIBQuery;
    ListPrQry: TDataSetProvider;
    incQry: TIBQuery;
    AutoIncValue: TDataSetProvider;
    CPTab: TIBTable;
    ChapterTab: TDataSetProvider;
    DeleteChapter: TIBQuery;
    UpdateCP: TIBQuery;
    UpdateCPQry: TDataSetProvider;
    DeleteCPQry: TIBQuery;
    TNTabPR_ID: TIntegerField;
    TNTabTN_ID: TIntegerField;
    TNTabTN_NAME: TIBStringField;
    TNTabTN_VORNAME: TIBStringField;
    TNTabTN_DEPARTMENT: TIBStringField;
    TNTabTN_ROLLE: TIBStringField;
    TNTabTN_STATUS: TIntegerField;
    TNTabPE_ID: TIntegerField;
    ListTasksQry: TIBQuery;
    ListTasks: TDataSetProvider;
    CPText: TIBTable;
    CPTextTab: TDataSetProvider;
    TNTabTN_GRUND: TIBStringField;
    BE: TIBTable;
    BETab: TDataSetProvider;
  private
    { Private-Deklarationen }
  public
    function AutoInc( gen : string ) : integer;
    function newProtocol( data : TJSONObject) : TJSONObject;
    function deleteProtocol( data : TJSONObject) : TJSONObject;
    function deleteCP( id : integer ) : TJSONObject;
  end;

implementation

uses
  m_db, u_json, System.SysUtils, m_glob_server, System.Win.ComObj;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdsProtocol }

function TdsProtocol.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;

end;

function TdsProtocol.deleteCP(id: integer): TJSONObject;
begin
  Result := TJSONObject.create;
  if DeleteTrans.InTransaction then
    DeleteTrans.Rollback;
  DeleteTrans.StartTransaction;
  try
    DeleteCPQry.ParamByName('CP_ID').Asinteger := id;
    DeleteCPQry.ExecSQL;
    DeleteTrans.commit;
    JResult(Result, true, 'Das Kapitel wurde gelöscht');
  except
    on e : exception do
    begin
      DebugMsg('deleteCP : ' + e.toString);
      DeleteTrans.Rollback;
      JResult(Result, false, e.toString);
    end;
  end;
end;

function TdsProtocol.deleteProtocol(data: TJSONObject): TJSONObject;
var
  id : integer;
begin
  Result := TJSONObject.create;
  id := JInt( data, 'id', -1);
  if id = -1 then
  begin
    JResult( Result, false, 'Es ist kein gültiges Protokoll');
    exit;
  end;
  DeleteTrans.StartTransaction;
  try
    deleteTNQry.ParamByName('PR_ID').AsInteger := id;
    deleteTNQry.ExecSQL;

    deleteTGQry.ParamByName('PR_ID').AsInteger := id;
    deleteTGQry.ExecSQL;

    deletePrTaQry.ParamByName('PR_ID').AsInteger := id;
    deletePrTaQry.ExecSQL;

    DeleteChapter.ParamByName('PR_ID').AsInteger := id;
    DeleteChapter.ExecSQL;

    deletePR.ParamByName('PR_ID').AsInteger := id;
    deletePR.ExecSQL;

    JResult( Result, false, 'Es wurde gelöscht.');
    DeleteTrans.commit;
  except
    begin
      JResult( Result, false, 'Es ist ein Fehler beim Löschen aufgetreten.');
      DeleteTrans.rollBack;
    end;
  end;

end;

function TdsProtocol.newProtocol(data: TJSONObject): TJSONObject;
var
  id : integer;
begin
  Result := TJSONObject.create;

  if IBTransaction1.InTransAction then
    IBTransaction1.Rollback;

  IBTransaction1.StartTransaction;
  try
    id := AutoInc('gen_pr_id');
    JReplace( Result, 'id', id);

    PRTab.Open;
    PRTab.Append;
    PRTab.FieldByName('PR_ID').AsInteger     := id;
    PRTab.FieldByName('GR_ID').AsInteger     := JInt( data, 'grid' );
    PRTab.FieldByName('PR_DATUM').AsDateTime := now + 7;
    PRTab.FieldByName('PR_NAME').AsString    := JString( data, 'short')+'_'+FormatDateTime('yyyyMMdd', now);
    PRTab.FieldByName('PR_CLID').AsString    := createClassID;
    PRTab.post;

    PRTab.close;

    PEQry.ParamByName('GR_ID').AsInteger := JInt( data, 'grid' );
    PEQry.Open;
    TNTab.Open;
    while not PEQry.eof do
    begin
      TNTab.Append;
      TNTab.FieldByName('PR_ID').AsInteger        := id;
      TNTab.FieldByName('TN_ID').AsInteger        := AutoInc('gen_TN_ID');
      TNTab.FieldByName('PE_ID').AsInteger        := PEQry.FieldByName('PE_ID').AsInteger;
      TNTab.FieldByName('TN_NAME').AsString       := PEQry.FieldByName('PE_NAME').AsString;
      TNTab.FieldByName('TN_VORNAME').AsString    := PEQry.FieldByName('PE_VORNAME').AsString;
      TNTab.FieldByName('TN_DEPARTMENT').AsString := PEQry.FieldByName('PE_DEPARTMENT').AsString;
      TNTab.FieldByName('TN_ROLLE').AsString      := PEQry.FieldByName('GP_ROLLE').AsString;
      TNTab.FieldByName('TN_STATUS').AsString     := '0';
      TNTab.Post;
      PEQry.next;
    end;
    PEQry.close;
    TNTab.Close;
    IBTransaction1.commit;
    JResult( Result, true, 'Das Protokoll wurde erfolgreich angelegt.');
    DebugMsg('newProtocol :'+IntToStr(id));
  except
    on e : exception do
    begin
      DebugMsg('newProtocol :' + e.toString);
      IBTransaction1.RollBack;
      JResult( Result, false, 'Fehler bei dem Anlegen des Protokolls');
    end;
  end;
end;

end.

