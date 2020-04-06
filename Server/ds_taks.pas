unit ds_taks;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery, System.JSON,
  IBX.IBTable;

type
  [TRoleAuth('user,admin')]
  TdsTask = class(TDSServerModule)
    TaskTypesQry: TIBQuery;
    IBTransaction1: TIBTransaction;
    TaskTypes: TDataSetProvider;
    TaskTab: TIBTable;
    Task: TDataSetProvider;
    AutoIncQry: TIBQuery;
    GremiumQry: TIBQuery;
    GremiumList: TDataSetProvider;
    OpenTasks: TIBTable;
    ArchivQry: TIBQuery;
    RemoveOpenTask: TIBQuery;
    DeleteTrans: TIBTransaction;
    RemoveTask: TIBQuery;
    AddTask: TIBQuery;
    SetFlagQry: TIBQuery;
    DeleteOpenTA: TIBQuery;
    DeleteFITA: TIBQuery;
    DeleteFiles: TIBQuery;
    DeleteTaskQry: TIBQuery;
    TATab: TIBTable;
    FindTask: TIBQuery;
    SetStatusQry: TIBQuery;
    TaskClidQry: TIBQuery;
    DelEinstellung: TIBQuery;
  private
    { Private declarations }

  public
    function newTask( data : TJSONObject ) : TJSONObject;
    function deleteTask( ta_id : integer ) : TJSONObject;
    function TaskInfo( data : TJSONObject ) : TJSONObject;

    function AutoInc( gen : string ) : integer;

    function AssignGremium( grid, taid : integer; status : string) : TJSONObject;
    function moveTask( grid, taid : integer) : TJSONObject;

    function closeTask( ta_id : integer ) : TJSONObject;
    procedure setFlags( taid, flags : integer );
  end;

implementation

uses
  m_db, u_json, Variants, u_Konst, m_lockMod, ServerContainerUnit1, m_glob_server,
  u_berTypes;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsTask }

function TdsTask.AssignGremium(grid, taid: integer; status: string) : TJSONObject;
var
  opts : TLocateOptions;
begin
  Result := LockMod.isLocked( taid, integer(ltTask));
  if Jbool( Result, 'result') then
  begin
    JReplace( Result, 'result', false);
    exit;
  end;

  if TATab.Transaction.InTransaction then
    TATab.Transaction.Rollback;

  IBTransaction1.StartTransaction;
  TATab.Open;
  try
    if not TATab.Locate('TA_ID', VarArrayOf([taid]), opts) then
    begin
      TATab.Append;
      TATab.FieldByName('TA_ID').AsInteger := taid;
    end
    else
    begin
      TATab.Edit;
    end;
    TATab.FieldByName('gr_id').AsInteger := grid;
    TATab.Post;

    SetStatusQry.ParamByName('TA_FLAGS').AsInteger := taskNew;
    SetStatusQry.ParamByName('TA_STATUS').AsString := status;
    SetStatusQry.ParamByName('TA_ID').AsInteger := taid;
    SetStatusQry.ExecSQL;
    IBTransaction1.Commit;
    JResult( Result, true, 'Die Aufgabe wurde verschoben');
  except
    begin
      JResult( Result, false, 'Es ist ein Fehler beim Verschieben aufgetreten.');
      IBTransaction1.Rollback;
    end;
  end;
  TATab.Close;
end;

function TdsTask.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;
end;

function TdsTask.closeTask(ta_id: integer): TJSONObject;
var
  gr_id : integer;
begin
  Result := TJSONObject.Create;

  if DeleteTrans.InTransaction then
    DeleteTrans.Rollback;

  DeleteTrans.StartTransaction;
  gr_id := -1;
  try

    FindTask.ParamByName('TA_ID').AsInteger := ta_id;
    FindTask.Open;
    if not FindTask.IsEmpty then
    begin
      gr_id := FindTask.FieldByName('GR_ID').AsInteger;
    end;
    FindTask.Close;

    if gr_id >-1 then
    begin
      ArchivQry.ParamByName('TA_ID').AsInteger := ta_id;
      ArchivQry.ParamByName('GR_ID').AsInteger := gr_id;
      ArchivQry.ExecSQL;

      RemoveOpenTask.ParamByName('TA_ID').AsInteger := ta_id;
      RemoveOpenTask.ExecSQL;

      DeleteTrans.Commit;
    end;
  except
  end;
  if DeleteTrans.InTransaction then
    DeleteTrans.Rollback
end;

function TdsTask.deleteTask(ta_id : integer): TJSONObject;
var
  msg : TJSONObject;
  clid: string;
  tyid, subid : integer;
begin
  Result := LockMod.isLocked( ta_id, integer(ltTask ));
  if Jbool( Result, 'result') then
  begin
    JReplace( Result, 'result', false);
    exit;
  end;

  if DeleteTrans.InTransaction then
    DeleteTrans.Rollback;

  DeleteTrans.StartTransaction;

  try
    TaskClidQry.ParamByName('TA_ID').AsInteger := ta_id;
    TaskClidQry.Open;
    if not TaskClidQry.Eof then
    begin
      clid := TaskClidQry.FieldByName('TA_CLID').AsString;
      tyid := TaskClidQry.FieldByName('TY_ID').AsInteger;
      subid:= TaskClidQry.FieldByName('TA_SUB_ID').AsInteger;
    end;
    TaskClidQry.Close;

    DeleteOpenTA.ParamByName('TA_ID').AsInteger := ta_id;
    DeleteOpenTA.ExecSQL;

    DeleteFiles.ParamByName('TA_ID').AsInteger := ta_id;
    DeleteFiles.ExecSQL;

    DeleteFITA.ParamByName('TA_ID').AsInteger := ta_id;
    DeleteFITA.ExecSQL;

    DeleteTaskQry.ParamByName('TA_ID').AsInteger := ta_id;
    DeleteTaskQry.ExecSQL;

    case tyid of
      1 :
      begin
        DelEinstellung.ParamByName('ES_ID').AsInteger := subid;
        DelEinstellung.ExecSQL;
      end;

    else
      DebugMsg('deleteTask :not supportet sub id:'+IntToStr(subid) );

    end;

    JResult(Result, true, 'Die Aufgabe wurde gelöscht!');
    DeleteTrans.Commit;
    try
      msg := TJSONObject.Create;
      JReplace(msg, 'action', 'taskdelete');
      JReplace( msg, 'taid', ta_id);
      JReplace( msg, 'clid', clid);
      ServerContainer1.DSServer1.BroadcastMessage('storage', msg);
    except
      on e : exception do
      begin
        DebugMsg('deleteTask: ' + e.ToString);
      end;
    end;

  except
    on e : exception do
     begin
       DebugMsg('deleteTask: ' + e.ToString);
      JResult(Result, false, 'Die Aufgabe konnte nicht gelöscht werde!');
      DeleteTrans.Rollback;
    end;
  end;

end;

function TdsTask.moveTask(grid, taid: integer) : TJSONObject;
var
  s : string;
  flags : integer;
  msg : TJSONObject;
begin
  Result := LockMod.isLocked( taid, integer(ltTask));
  if Jbool( Result, 'result') then
  begin
    JReplace( Result, 'result', false);
    exit;
  end;

  if DeleteTrans.InTransaction then
    DeleteTrans.Rollback;

  DeleteTrans.StartTransaction;

  s := 'O';
  flags := taskNew;

  try
    FindTask.ParamByName('TA_ID').AsInteger := taid;

    FindTask.open;
    if not FindTask.IsEmpty then
    begin
      flags := FindTask.FieldByName('TA_FLAGS').AsInteger;
    end;
    FindTask.Close;

    flags := taskNew;
    SetFlagQry.ParamByName('TA_ID').AsInteger     := taid;
    SetFlagQry.ParamByName('TA_FLAGS').AsInteger  := flags;
    SetFlagQry.ExecSQL;


    RemoveTask.ParamByName('TA_ID').AsInteger := taid;
    RemoveTask.ExecSQL;

    AddTask.ParamByName('GR_ID').AsInteger := grid;
    AddTask.ParamByName('TA_ID').AsInteger := taid;

    AddTask.ExecSQL;
    DeleteTrans.Commit;
    JResult( Result, true, 'Die Aufgabe wurde verschoben');
    try
      msg := TJSONObject.Create;
      JReplace(msg, 'action', 'taskmove');
      JReplace( msg, 'taid', taid);
      JReplace( msg, 'grid', grid);
      ServerContainer1.DSServer1.BroadcastMessage('storage', msg);
    except

    end;
  except
    begin
      JResult( Result, false, 'Es ist ein Fehler beim Verschieben aufgetreten');
      DeleteTrans.RollBack;
    end;
  end;
end;

function TdsTask.newTask(data: TJSONObject): TJSONObject;
begin
  Result := NIL;
end;

procedure TdsTask.setFlags(taid, flags: integer);
begin
  if IBTransaction1.InTransaction then
    IBTransaction1.Rollback;
  IBTransaction1.StartTransaction;

  SetFlagQry.ParamByName('TA_ID').AsInteger     := taid;
  SetFlagQry.ParamByName('TA_FLAGS').AsInteger  := flags;
  SetFlagQry.ExecSQL;

  IBTransaction1.Commit;
end;

function TdsTask.TaskInfo(data: TJSONObject): TJSONObject;
begin
  Result := NIL;
end;

end.


