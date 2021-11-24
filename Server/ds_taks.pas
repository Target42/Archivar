unit ds_taks;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  [TRoleAuth('user,admin', 'download')]
  TdsTask = class(TDSServerModule)
    TaskTypes: TDataSetProvider;
    Task: TDataSetProvider;
    GremiumList: TDataSetProvider;
    TemplatesQry: TDataSetProvider;
    TemplateTab: TDataSetProvider;
    TaskTableSrc: TDataSetProvider;
    IBTransaction2: TFDTransaction;
    TaskTable: TFDTable;
    DeleteTrans: TFDTransaction;
    ArchivQry: TFDQuery;
    RemoveOpenTask: TFDQuery;
    RemoveTask: TFDQuery;
    AddTask: TFDQuery;
    SetFlagQry: TFDQuery;
    DeleteOpenTA: TFDQuery;
    DeleteFITA: TFDQuery;
    DeleteFiles: TFDQuery;
    DeleteTaskQry: TFDQuery;
    FindTask: TFDQuery;
    TaskClidQry: TFDQuery;
    IBTransaction1: TFDTransaction;
    TaskTab: TFDTable;
    OpenTasks: TFDTable;
    TATab: TFDTable;
    Template: TFDTable;
    TaskTypesQry: TFDQuery;
    AutoIncQry: TFDQuery;
    GremiumQry: TFDQuery;
    SetStatusQry: TFDQuery;
    Templates: TFDQuery;
    TaskLogTab: TFDTable;
    TaskLogSrc: TDataSetProvider;
    procedure TaskLogTabBeforePost(DataSet: TDataSet);
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
  Grijjy.CloudLogging, m_db, u_json, Variants, u_Konst, m_lockMod, ServerContainerUnit1, m_glob_server,
  u_berTypes, Datasnap.DSSession;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsTask }

function TdsTask.AssignGremium(grid, taid: integer; status: string) : TJSONObject;
var
  opts : TLocateOptions;
begin
  GrijjyLog.EnterMethod(self, 'AssignGremium');
  Result := LockMod.isLockedByID( taid, integer(ltTask));
  if Jbool( Result, 'result') then
  begin
    JReplace( Result, 'result', false);
    GrijjyLog.Send('Document is locked', TgoLogLevel.Error);
    GrijjyLog.ExitMethod(self, 'AssignGremium');
    exit;
  end;

  if TATab.Transaction.Active then
    TATab.Transaction.Rollback;

  IBTransaction1.StartTransaction;
  TATab.Open;
  try
    if not TATab.Locate('TA_ID', VarArrayOf([taid]), opts) then
    begin
      TATab.Append;
      TATab.FieldByName('TA_ID').AsInteger := taid;
      GrijjyLog.Send('new task created!', taid);
    end
    else
    begin
      TATab.Edit;
      GrijjyLog.Send('task edit', taid);
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
  GrijjyLog.ExitMethod(self, 'AssignGremium');
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

  if DeleteTrans.Active then
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
  if DeleteTrans.Active then
    DeleteTrans.Rollback
end;

function TdsTask.deleteTask(ta_id : integer): TJSONObject;
var
  msg : TJSONObject;
  clid: string;
begin
  GrijjyLog.EnterMethod(self, 'deleteTask');
  Result := LockMod.isLockedByID( ta_id, integer(ltTask ));
  if Jbool( Result, 'result') then
  begin
    JReplace( Result, 'result', false);
    GrijjyLog.Send('task is locked');
    GrijjyLog.ExitMethod(self, 'deleteTask');
    exit;
  end;

  if DeleteTrans.Active then
    DeleteTrans.Rollback;

  DeleteTrans.StartTransaction;

  try
    TaskClidQry.ParamByName('TA_ID').AsInteger := ta_id;
    TaskClidQry.Open;
    if not TaskClidQry.Eof then
    begin
      clid := TaskClidQry.FieldByName('TA_CLID').AsString;
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

    JResult(Result, true, 'Die Aufgabe wurde gelöscht!');
    DeleteTrans.Commit;
    try
      msg := TJSONObject.Create;
      JAction(  msg, BRD_TASK_DELETE);
      JReplace( msg, 'taid', ta_id);
      JReplace( msg, 'clid', clid);
      ServerContainer1.BroadcastMessage(BRD_CHANNEL, msg);
    except
      on e : exception do
      begin
        GrijjyLog.Send('error', e.ToString, TgoLogLevel.Error);
      end;
    end;

  except
    on e : exception do
     begin
     GrijjyLog.Send('error', e.ToString, TgoLogLevel.Error);
      JResult(Result, false, 'Die Aufgabe konnte nicht gelöscht werde!');
      DeleteTrans.Rollback;
    end;
  end;
  GrijjyLog.ExitMethod(self, 'deleteTask');
end;

function TdsTask.moveTask(grid, taid: integer) : TJSONObject;
var
  s : string;
  flags : integer;
  msg : TJSONObject;
begin
  Result := LockMod.isLockedByID( taid, integer(ltTask));
  if Jbool( Result, 'result') then
  begin
    JReplace( Result, 'result', false);
    exit;
  end;

  if DeleteTrans.Active then
    DeleteTrans.Rollback;

  DeleteTrans.StartTransaction;

  s := 'O';

  flags := taskNew;
  try
    FindTask.ParamByName('TA_ID').AsInteger := taid;

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
      JAction(  msg, BRD_TASK_MOVE);
      JReplace( msg, 'taid', taid);
      JReplace( msg, 'grid', grid);
      ServerContainer1.BroadcastMessage(BRD_CHANNEL, msg);
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
  GrijjyLog.Send('not supported: newTask', TgoLogLevel.Error);

end;

procedure TdsTask.setFlags(taid, flags: integer);
begin
  if IBTransaction1.Active then
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
  GrijjyLog.Send('not supported: TaskInfo', TgoLogLevel.Error);
end;

procedure TdsTask.TaskLogTabBeforePost(DataSet: TDataSet);
var
  session : TDSSession;
begin
  Session := TDSSessionManager.GetThreadSession;

  if DataSet.FieldByName('LT_STAMP').IsNull then
    DataSet.FieldByName('LT_STAMP').AsDateTime := now;

  if DataSet.FieldByName('LT_NAME').IsNull then
    DataSet.FieldByName('LT_NAME').AsString := session.GetData('user');
end;

end.


