unit ds_taks;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

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
    DeleteTaskLog: TFDQuery;
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
    Unused: TFDQuery;
    UnusedQry: TDataSetProvider;
    ListGrTaQry: TFDQuery;
    TOTab: TFDTable;
    LTTab: TFDTable;
    procedure TaskLogTabBeforePost(DataSet: TDataSet);
  private
    function getAssignments( taid : integer ) : TJSONArray;
    procedure addLog( ta_id : integer; text : string );
    procedure sendNotify( grid, taid : integer; assign : boolean );
  public
    function newTask( data : TJSONObject ) : TJSONObject;
    function deleteTask( ta_id : integer ) : TJSONObject;
    function TaskInfo( data : TJSONObject ) : TJSONObject;

    function AutoInc( gen : string ) : integer;

    function AssignGremium( grid, taid : integer; status : string) : TJSONObject;
    function moveTask( grid, taid : integer) : TJSONObject;

    function closeTask( ta_id : integer ) : TJSONObject;
    procedure setFlags( taid, flags : integer );

    function Assignments( taid : integer ) : TJSONObject;
    function AssignToGremium( data : TJSONObject ) : TJSONObject;
    function AssignmentRemove( data : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  Grijjy.CloudLogging, u_json, Variants, u_Konst, m_lockMod, ServerContainerUnit1,
  u_berTypes, Datasnap.DSSession, m_del_files;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsTask }

procedure TdsTask.addLog(ta_id : integer; text: string);
begin
  LTTab.Open;
  LTTab.Append;
  LTTab.FieldByName('LT_ID').AsInteger      := AutoInc('gen_lt_id');
  LTTab.FieldByName('TA_ID').AsInteger      := ta_id;
  LTTab.FieldByName('LT_STAMP').AsDateTime  := now;
  LTTab.FieldByName('LT_REM').AsString      := text;
  LTTab.Post;
  LTTab.Close;
end;

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

function TdsTask.AssignmentRemove(data : TJSONObject): TJSONObject;
var
  taid : integer;
  grid : integer;
  sendIt : boolean;
begin
  Result:= TJSONObject.Create;
  sendIt := false;

  taid := JInt( data, 'taid');
  grid := JInt( data, 'grid');

  TOTab.Filter := format('ta_id=%d', [taid]);
  TOTab.Filtered := true;
  TOTab.Open;
  TOTab.Last;

  if TOTab.RecordCount = 1 then begin
    JResponse(Result, false, 'Die letzte Zuordnung kann nicht aufgehoben werden!');
  end else if TOTab.RecordCount > 1 then begin
    if TOTab.Locate('GR_ID;TA_ID', VarArrayOf([grid, taid]), []) then begin
      TOTab.Delete;

      AddLog( taid, getText(data, 'rem') );

      JReplace( Result, 'items', getAssignments(taid));
      JResult( Result, true, 'Zuweisung gelöscht');
      sendIt := true;
    end else
      JResponse(Result, false, 'Keine Zuweisung für dieses Gremium gefunden!');
  end else
    JResponse(Result, false, 'Keine Zuweisung für diesen Vorgang gefunden!!');


  if IBTransaction1.Active then
    IBTransaction1.Commit;

   TOTab.Close;

   if sendIt then
    sendNotify(grid, taid, false);

end;

function TdsTask.Assignments(taid: integer): TJSONObject;
begin
  Result := TJSONObject.Create;

  JReplace( Result, 'items', getAssignments( taid ));

  if IBTransaction1.Active then
    IBTransaction1.Commit;

end;

function TdsTask.AssignToGremium(data : TJSONObject): TJSONObject;
var
  taid : integer;
  grid : integer;
  sendIT : boolean;
begin
  Result:= TJSONObject.Create;
  sendIT := false;

  taid := JInt( data, 'taid');
  grid := JInt( data, 'grid');

  TOTab.Open;

  if not TOTab.Locate('GR_ID;TA_ID', VarArrayOf([grid, taid]), []) then begin
    TOTab.Append;
    TOTab.FieldByName('GR_ID').AsInteger := grid;
    TOTab.FieldByName('TA_ID').AsInteger := taid;
    TOTab.Post;

    AddLog( taid, getText(data, 'rem') );

    JReplace( Result, 'items', getAssignments(taid));
    JResult( Result, true, 'Zuweisung erfolgt');

    sendIt := true;
  end else begin
    JResult( Result, true, 'Diesem Gremium ist der Vorgang schon zugewiesen.');
  end;

  if IBTransaction1.Active then
    IBTransaction1.Commit;

  TOTab.Close;
  if sendIT then
    sendNotify(grid, taid, true);

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
  dr_id : integer;
  delFiles : TDeleteFilesMod;
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
    dr_id := -1;
    TaskClidQry.ParamByName('TA_ID').AsInteger := ta_id;
    TaskClidQry.Open;
    if not TaskClidQry.Eof then
    begin
      clid := TaskClidQry.FieldByName('TA_CLID').AsString;
      dr_id:=  TaskClidQry.FieldByName('DR_ID').AsInteger;
    end;
    TaskClidQry.Close;

    if dr_id > -1 then begin
      DeleteOpenTA.ParamByName('TA_ID').AsInteger := ta_id;
      DeleteOpenTA.ExecSQL;

      delFiles := TDeleteFilesMod.Create(self);
      delFiles.DeleteFolderExecute(dr_id, dr_id, DeleteTrans);
      delFiles.Free;

      DeleteTaskLog.ParamByName('TA_ID').AsInteger := ta_id;
      DeleteTaskLog.ExecSQL;

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

function TdsTask.getAssignments(taid: integer): TJSONArray;
var
  row : TJSONObject;
begin
  Result := TJSONArray.Create;

  ListGrTaQry.ParamByName('TA_ID').AsInteger := taid;
  ListGrTaQry.Open;
  while not ListGrTaQry.Eof do begin
    row := TJSONObject.Create;
    JReplace(row, 'id',   ListGrTaQry.FieldByName('GR_ID').AsInteger );
    JReplace(row, 'name', ListGrTaQry.FieldByName('GR_NAME').AsString );
    Result.AddElement(row);
    ListGrTaQry.Next;
  end;
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

procedure TdsTask.sendNotify(grid, taid: integer; assign: boolean);
var
  msg : TJSONObject;
begin
  msg := TJSONObject.Create;
  JAction(  msg, BRD_TASK_ASSIGN);
  JReplace( msg, 'taid', taid);
  JReplace( msg, 'grid', grid);
  JReplace( msg, 'assign', assign );
  ServerContainer1.BroadcastMessage(BRD_CHANNEL, msg);

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


