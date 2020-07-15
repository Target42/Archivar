//
// Erzeugt vom DataSnap-Proxy-Generator.
// 08.07.2020 21:08:35
//

unit u_stub;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TAdminModClient = class(TDSAdminClient)
  private
    FDSServerModuleCreateCommand: TDBXCommand;
    FgetUserInfoCommand: TDBXCommand;
    FgetGremiumListCommand: TDBXCommand;
    FgetDeleteTimesCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    function getUserInfo(data: TJSONObject): TJSONObject;
    function getGremiumList: TJSONObject;
    function getDeleteTimes: TJSONObject;
  end;

  TdsGremiumClient = class(TDSAdminClient)
  private
    FDSServerModuleCreateCommand: TDBXCommand;
    FGremiumTabBeforePostCommand: TDBXCommand;
    FImportGremiumCSVCommand: TDBXCommand;
    FExportGremiumCSVCommand: TDBXCommand;
    FAutoIncCommand: TDBXCommand;
    FAddMACommand: TDBXCommand;
    FRemoveMACommand: TDBXCommand;
    FchangeRollCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    procedure GremiumTabBeforePost(DataSet: TDataSet);
    function ImportGremiumCSV(st: TStream): TJSONObject;
    function ExportGremiumCSV: TStream;
    function AutoInc(gen: string): Integer;
    procedure AddMA(grid: Integer; id: Integer);
    procedure RemoveMA(grid: Integer; id: Integer);
    procedure changeRoll(grid: Integer; id: Integer; roll: string);
  end;

  TdsPersonClient = class(TDSAdminClient)
  private
    FAutoIncCommand: TDBXCommand;
    FImportPersonenCSVCommand: TDBXCommand;
    FExportPersonenCSVCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function AutoInc(gen: string): Integer;
    function ImportPersonenCSV(st: TStream): TJSONObject;
    function ExportPersonenCSV: TStream;
  end;

  TdsTaskClient = class(TDSAdminClient)
  private
    FnewTaskCommand: TDBXCommand;
    FdeleteTaskCommand: TDBXCommand;
    FTaskInfoCommand: TDBXCommand;
    FAutoIncCommand: TDBXCommand;
    FAssignGremiumCommand: TDBXCommand;
    FmoveTaskCommand: TDBXCommand;
    FcloseTaskCommand: TDBXCommand;
    FsetFlagsCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function newTask(data: TJSONObject): TJSONObject;
    function deleteTask(ta_id: Integer): TJSONObject;
    function TaskInfo(data: TJSONObject): TJSONObject;
    function AutoInc(gen: string): Integer;
    function AssignGremium(grid: Integer; taid: Integer; status: string): TJSONObject;
    function moveTask(grid: Integer; taid: Integer): TJSONObject;
    function closeTask(ta_id: Integer): TJSONObject;
    procedure setFlags(taid: Integer; flags: Integer);
  end;

  TdsFileClient = class(TDSAdminClient)
  private
    FAutoIncCommand: TDBXCommand;
    FuploadCommand: TDBXCommand;
    FdeleteFileCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function AutoInc(gen: string): Integer;
    function upload(data: TJSONObject; st: TStream): TJSONObject;
    function deleteFile(ta_id: Integer; fi_id: Integer): TJSONObject;
  end;

  TdsEinstellungClient = class(TDSAdminClient)
  private
    FDSServerModuleDestroyCommand: TDBXCommand;
    FAutoIncCommand: TDBXCommand;
    FgetDataIDCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleDestroy(Sender: TObject);
    function AutoInc(gen: string): Integer;
    function getDataID(ta_id: Integer): Integer;
  end;

  TdsMiscClient = class(TDSAdminClient)
  private
    FDSServerModuleCreateCommand: TDBXCommand;
    FLockDocumentCommand: TDBXCommand;
    FUnLockDocumentCommand: TDBXCommand;
    FisLockedCommand: TDBXCommand;
    FvalidTaskCommand: TDBXCommand;
    FAutoIncCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    function LockDocument(id: Integer; typ: Integer): TJSONObject;
    function UnLockDocument(id: Integer; typ: Integer): TJSONObject;
    function isLocked(id: Integer; typ: Integer): TJSONObject;
    function validTask(id: Integer; dt: Integer): Boolean;
    function AutoInc(gen: string): Integer;
  end;

  TdsProtocolClient = class(TDSAdminClient)
  private
    FAutoIncCommand: TDBXCommand;
    FnewProtocolCommand: TDBXCommand;
    FdeleteProtocolCommand: TDBXCommand;
    FdeleteCPCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function AutoInc(gen: string): Integer;
    function newProtocol(data: TJSONObject): TJSONObject;
    function deleteProtocol(data: TJSONObject): TJSONObject;
    function deleteCP(id: Integer): TJSONObject;
  end;

  TdsImageClient = class(TDSAdminClient)
  private
    FgetimageListCommand: TDBXCommand;
    FgetImageCommand: TDBXCommand;
    FAutoIncCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function getimageList: TJSONObject;
    function getImage(data: TJSONObject): TStream;
    function AutoInc(gen: string): Integer;
  end;

  TdsChapterClient = class(TDSAdminClient)
  private
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
  end;

  TdsTaskEditClient = class(TDSAdminClient)
  private
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
  end;

  TdsTemplateClient = class(TDSAdminClient)
  private
    FAutoIncCommand: TDBXCommand;
    FhasNameCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function AutoInc(gen: string): Integer;
    function hasName(name: string): Boolean;
  end;

implementation

procedure TAdminModClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FDBXConnection.CreateCommand;
    FDSServerModuleCreateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDSServerModuleCreateCommand.Text := 'TAdminMod.DSServerModuleCreate';
    FDSServerModuleCreateCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FDSServerModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDSServerModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FDSServerModuleCreateCommand.ExecuteUpdate;
end;

function TAdminModClient.getUserInfo(data: TJSONObject): TJSONObject;
begin
  if FgetUserInfoCommand = nil then
  begin
    FgetUserInfoCommand := FDBXConnection.CreateCommand;
    FgetUserInfoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetUserInfoCommand.Text := 'TAdminMod.getUserInfo';
    FgetUserInfoCommand.Prepare;
  end;
  FgetUserInfoCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FgetUserInfoCommand.ExecuteUpdate;
  Result := TJSONObject(FgetUserInfoCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TAdminModClient.getGremiumList: TJSONObject;
begin
  if FgetGremiumListCommand = nil then
  begin
    FgetGremiumListCommand := FDBXConnection.CreateCommand;
    FgetGremiumListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetGremiumListCommand.Text := 'TAdminMod.getGremiumList';
    FgetGremiumListCommand.Prepare;
  end;
  FgetGremiumListCommand.ExecuteUpdate;
  Result := TJSONObject(FgetGremiumListCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TAdminModClient.getDeleteTimes: TJSONObject;
begin
  if FgetDeleteTimesCommand = nil then
  begin
    FgetDeleteTimesCommand := FDBXConnection.CreateCommand;
    FgetDeleteTimesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetDeleteTimesCommand.Text := 'TAdminMod.getDeleteTimes';
    FgetDeleteTimesCommand.Prepare;
  end;
  FgetDeleteTimesCommand.ExecuteUpdate;
  Result := TJSONObject(FgetDeleteTimesCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

constructor TAdminModClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TAdminModClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TAdminModClient.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FgetUserInfoCommand.DisposeOf;
  FgetGremiumListCommand.DisposeOf;
  FgetDeleteTimesCommand.DisposeOf;
  inherited;
end;

procedure TdsGremiumClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FDBXConnection.CreateCommand;
    FDSServerModuleCreateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDSServerModuleCreateCommand.Text := 'TdsGremium.DSServerModuleCreate';
    FDSServerModuleCreateCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FDSServerModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDSServerModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FDSServerModuleCreateCommand.ExecuteUpdate;
end;

procedure TdsGremiumClient.GremiumTabBeforePost(DataSet: TDataSet);
begin
  if FGremiumTabBeforePostCommand = nil then
  begin
    FGremiumTabBeforePostCommand := FDBXConnection.CreateCommand;
    FGremiumTabBeforePostCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGremiumTabBeforePostCommand.Text := 'TdsGremium.GremiumTabBeforePost';
    FGremiumTabBeforePostCommand.Prepare;
  end;
  FGremiumTabBeforePostCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FGremiumTabBeforePostCommand.ExecuteUpdate;
end;

function TdsGremiumClient.ImportGremiumCSV(st: TStream): TJSONObject;
begin
  if FImportGremiumCSVCommand = nil then
  begin
    FImportGremiumCSVCommand := FDBXConnection.CreateCommand;
    FImportGremiumCSVCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FImportGremiumCSVCommand.Text := 'TdsGremium.ImportGremiumCSV';
    FImportGremiumCSVCommand.Prepare;
  end;
  FImportGremiumCSVCommand.Parameters[0].Value.SetStream(st, FInstanceOwner);
  FImportGremiumCSVCommand.ExecuteUpdate;
  Result := TJSONObject(FImportGremiumCSVCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsGremiumClient.ExportGremiumCSV: TStream;
begin
  if FExportGremiumCSVCommand = nil then
  begin
    FExportGremiumCSVCommand := FDBXConnection.CreateCommand;
    FExportGremiumCSVCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FExportGremiumCSVCommand.Text := 'TdsGremium.ExportGremiumCSV';
    FExportGremiumCSVCommand.Prepare;
  end;
  FExportGremiumCSVCommand.ExecuteUpdate;
  Result := FExportGremiumCSVCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TdsGremiumClient.AutoInc(gen: string): Integer;
begin
  if FAutoIncCommand = nil then
  begin
    FAutoIncCommand := FDBXConnection.CreateCommand;
    FAutoIncCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoIncCommand.Text := 'TdsGremium.AutoInc';
    FAutoIncCommand.Prepare;
  end;
  FAutoIncCommand.Parameters[0].Value.SetWideString(gen);
  FAutoIncCommand.ExecuteUpdate;
  Result := FAutoIncCommand.Parameters[1].Value.GetInt32;
end;

procedure TdsGremiumClient.AddMA(grid: Integer; id: Integer);
begin
  if FAddMACommand = nil then
  begin
    FAddMACommand := FDBXConnection.CreateCommand;
    FAddMACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAddMACommand.Text := 'TdsGremium.AddMA';
    FAddMACommand.Prepare;
  end;
  FAddMACommand.Parameters[0].Value.SetInt32(grid);
  FAddMACommand.Parameters[1].Value.SetInt32(id);
  FAddMACommand.ExecuteUpdate;
end;

procedure TdsGremiumClient.RemoveMA(grid: Integer; id: Integer);
begin
  if FRemoveMACommand = nil then
  begin
    FRemoveMACommand := FDBXConnection.CreateCommand;
    FRemoveMACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FRemoveMACommand.Text := 'TdsGremium.RemoveMA';
    FRemoveMACommand.Prepare;
  end;
  FRemoveMACommand.Parameters[0].Value.SetInt32(grid);
  FRemoveMACommand.Parameters[1].Value.SetInt32(id);
  FRemoveMACommand.ExecuteUpdate;
end;

procedure TdsGremiumClient.changeRoll(grid: Integer; id: Integer; roll: string);
begin
  if FchangeRollCommand = nil then
  begin
    FchangeRollCommand := FDBXConnection.CreateCommand;
    FchangeRollCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FchangeRollCommand.Text := 'TdsGremium.changeRoll';
    FchangeRollCommand.Prepare;
  end;
  FchangeRollCommand.Parameters[0].Value.SetInt32(grid);
  FchangeRollCommand.Parameters[1].Value.SetInt32(id);
  FchangeRollCommand.Parameters[2].Value.SetWideString(roll);
  FchangeRollCommand.ExecuteUpdate;
end;

constructor TdsGremiumClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsGremiumClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsGremiumClient.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FGremiumTabBeforePostCommand.DisposeOf;
  FImportGremiumCSVCommand.DisposeOf;
  FExportGremiumCSVCommand.DisposeOf;
  FAutoIncCommand.DisposeOf;
  FAddMACommand.DisposeOf;
  FRemoveMACommand.DisposeOf;
  FchangeRollCommand.DisposeOf;
  inherited;
end;

function TdsPersonClient.AutoInc(gen: string): Integer;
begin
  if FAutoIncCommand = nil then
  begin
    FAutoIncCommand := FDBXConnection.CreateCommand;
    FAutoIncCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoIncCommand.Text := 'TdsPerson.AutoInc';
    FAutoIncCommand.Prepare;
  end;
  FAutoIncCommand.Parameters[0].Value.SetWideString(gen);
  FAutoIncCommand.ExecuteUpdate;
  Result := FAutoIncCommand.Parameters[1].Value.GetInt32;
end;

function TdsPersonClient.ImportPersonenCSV(st: TStream): TJSONObject;
begin
  if FImportPersonenCSVCommand = nil then
  begin
    FImportPersonenCSVCommand := FDBXConnection.CreateCommand;
    FImportPersonenCSVCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FImportPersonenCSVCommand.Text := 'TdsPerson.ImportPersonenCSV';
    FImportPersonenCSVCommand.Prepare;
  end;
  FImportPersonenCSVCommand.Parameters[0].Value.SetStream(st, FInstanceOwner);
  FImportPersonenCSVCommand.ExecuteUpdate;
  Result := TJSONObject(FImportPersonenCSVCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsPersonClient.ExportPersonenCSV: TStream;
begin
  if FExportPersonenCSVCommand = nil then
  begin
    FExportPersonenCSVCommand := FDBXConnection.CreateCommand;
    FExportPersonenCSVCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FExportPersonenCSVCommand.Text := 'TdsPerson.ExportPersonenCSV';
    FExportPersonenCSVCommand.Prepare;
  end;
  FExportPersonenCSVCommand.ExecuteUpdate;
  Result := FExportPersonenCSVCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

constructor TdsPersonClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsPersonClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsPersonClient.Destroy;
begin
  FAutoIncCommand.DisposeOf;
  FImportPersonenCSVCommand.DisposeOf;
  FExportPersonenCSVCommand.DisposeOf;
  inherited;
end;

function TdsTaskClient.newTask(data: TJSONObject): TJSONObject;
begin
  if FnewTaskCommand = nil then
  begin
    FnewTaskCommand := FDBXConnection.CreateCommand;
    FnewTaskCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FnewTaskCommand.Text := 'TdsTask.newTask';
    FnewTaskCommand.Prepare;
  end;
  FnewTaskCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FnewTaskCommand.ExecuteUpdate;
  Result := TJSONObject(FnewTaskCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsTaskClient.deleteTask(ta_id: Integer): TJSONObject;
begin
  if FdeleteTaskCommand = nil then
  begin
    FdeleteTaskCommand := FDBXConnection.CreateCommand;
    FdeleteTaskCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteTaskCommand.Text := 'TdsTask.deleteTask';
    FdeleteTaskCommand.Prepare;
  end;
  FdeleteTaskCommand.Parameters[0].Value.SetInt32(ta_id);
  FdeleteTaskCommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteTaskCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsTaskClient.TaskInfo(data: TJSONObject): TJSONObject;
begin
  if FTaskInfoCommand = nil then
  begin
    FTaskInfoCommand := FDBXConnection.CreateCommand;
    FTaskInfoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FTaskInfoCommand.Text := 'TdsTask.TaskInfo';
    FTaskInfoCommand.Prepare;
  end;
  FTaskInfoCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FTaskInfoCommand.ExecuteUpdate;
  Result := TJSONObject(FTaskInfoCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsTaskClient.AutoInc(gen: string): Integer;
begin
  if FAutoIncCommand = nil then
  begin
    FAutoIncCommand := FDBXConnection.CreateCommand;
    FAutoIncCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoIncCommand.Text := 'TdsTask.AutoInc';
    FAutoIncCommand.Prepare;
  end;
  FAutoIncCommand.Parameters[0].Value.SetWideString(gen);
  FAutoIncCommand.ExecuteUpdate;
  Result := FAutoIncCommand.Parameters[1].Value.GetInt32;
end;

function TdsTaskClient.AssignGremium(grid: Integer; taid: Integer; status: string): TJSONObject;
begin
  if FAssignGremiumCommand = nil then
  begin
    FAssignGremiumCommand := FDBXConnection.CreateCommand;
    FAssignGremiumCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAssignGremiumCommand.Text := 'TdsTask.AssignGremium';
    FAssignGremiumCommand.Prepare;
  end;
  FAssignGremiumCommand.Parameters[0].Value.SetInt32(grid);
  FAssignGremiumCommand.Parameters[1].Value.SetInt32(taid);
  FAssignGremiumCommand.Parameters[2].Value.SetWideString(status);
  FAssignGremiumCommand.ExecuteUpdate;
  Result := TJSONObject(FAssignGremiumCommand.Parameters[3].Value.GetJSONValue(FInstanceOwner));
end;

function TdsTaskClient.moveTask(grid: Integer; taid: Integer): TJSONObject;
begin
  if FmoveTaskCommand = nil then
  begin
    FmoveTaskCommand := FDBXConnection.CreateCommand;
    FmoveTaskCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FmoveTaskCommand.Text := 'TdsTask.moveTask';
    FmoveTaskCommand.Prepare;
  end;
  FmoveTaskCommand.Parameters[0].Value.SetInt32(grid);
  FmoveTaskCommand.Parameters[1].Value.SetInt32(taid);
  FmoveTaskCommand.ExecuteUpdate;
  Result := TJSONObject(FmoveTaskCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TdsTaskClient.closeTask(ta_id: Integer): TJSONObject;
begin
  if FcloseTaskCommand = nil then
  begin
    FcloseTaskCommand := FDBXConnection.CreateCommand;
    FcloseTaskCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FcloseTaskCommand.Text := 'TdsTask.closeTask';
    FcloseTaskCommand.Prepare;
  end;
  FcloseTaskCommand.Parameters[0].Value.SetInt32(ta_id);
  FcloseTaskCommand.ExecuteUpdate;
  Result := TJSONObject(FcloseTaskCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

procedure TdsTaskClient.setFlags(taid: Integer; flags: Integer);
begin
  if FsetFlagsCommand = nil then
  begin
    FsetFlagsCommand := FDBXConnection.CreateCommand;
    FsetFlagsCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FsetFlagsCommand.Text := 'TdsTask.setFlags';
    FsetFlagsCommand.Prepare;
  end;
  FsetFlagsCommand.Parameters[0].Value.SetInt32(taid);
  FsetFlagsCommand.Parameters[1].Value.SetInt32(flags);
  FsetFlagsCommand.ExecuteUpdate;
end;

constructor TdsTaskClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsTaskClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsTaskClient.Destroy;
begin
  FnewTaskCommand.DisposeOf;
  FdeleteTaskCommand.DisposeOf;
  FTaskInfoCommand.DisposeOf;
  FAutoIncCommand.DisposeOf;
  FAssignGremiumCommand.DisposeOf;
  FmoveTaskCommand.DisposeOf;
  FcloseTaskCommand.DisposeOf;
  FsetFlagsCommand.DisposeOf;
  inherited;
end;

function TdsFileClient.AutoInc(gen: string): Integer;
begin
  if FAutoIncCommand = nil then
  begin
    FAutoIncCommand := FDBXConnection.CreateCommand;
    FAutoIncCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoIncCommand.Text := 'TdsFile.AutoInc';
    FAutoIncCommand.Prepare;
  end;
  FAutoIncCommand.Parameters[0].Value.SetWideString(gen);
  FAutoIncCommand.ExecuteUpdate;
  Result := FAutoIncCommand.Parameters[1].Value.GetInt32;
end;

function TdsFileClient.upload(data: TJSONObject; st: TStream): TJSONObject;
begin
  if FuploadCommand = nil then
  begin
    FuploadCommand := FDBXConnection.CreateCommand;
    FuploadCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FuploadCommand.Text := 'TdsFile.upload';
    FuploadCommand.Prepare;
  end;
  FuploadCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FuploadCommand.Parameters[1].Value.SetStream(st, FInstanceOwner);
  FuploadCommand.ExecuteUpdate;
  Result := TJSONObject(FuploadCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileClient.deleteFile(ta_id: Integer; fi_id: Integer): TJSONObject;
begin
  if FdeleteFileCommand = nil then
  begin
    FdeleteFileCommand := FDBXConnection.CreateCommand;
    FdeleteFileCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteFileCommand.Text := 'TdsFile.deleteFile';
    FdeleteFileCommand.Prepare;
  end;
  FdeleteFileCommand.Parameters[0].Value.SetInt32(ta_id);
  FdeleteFileCommand.Parameters[1].Value.SetInt32(fi_id);
  FdeleteFileCommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteFileCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

constructor TdsFileClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsFileClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsFileClient.Destroy;
begin
  FAutoIncCommand.DisposeOf;
  FuploadCommand.DisposeOf;
  FdeleteFileCommand.DisposeOf;
  inherited;
end;

procedure TdsEinstellungClient.DSServerModuleDestroy(Sender: TObject);
begin
  if FDSServerModuleDestroyCommand = nil then
  begin
    FDSServerModuleDestroyCommand := FDBXConnection.CreateCommand;
    FDSServerModuleDestroyCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDSServerModuleDestroyCommand.Text := 'TdsEinstellung.DSServerModuleDestroy';
    FDSServerModuleDestroyCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FDSServerModuleDestroyCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDSServerModuleDestroyCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleDestroyCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FDSServerModuleDestroyCommand.ExecuteUpdate;
end;

function TdsEinstellungClient.AutoInc(gen: string): Integer;
begin
  if FAutoIncCommand = nil then
  begin
    FAutoIncCommand := FDBXConnection.CreateCommand;
    FAutoIncCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoIncCommand.Text := 'TdsEinstellung.AutoInc';
    FAutoIncCommand.Prepare;
  end;
  FAutoIncCommand.Parameters[0].Value.SetWideString(gen);
  FAutoIncCommand.ExecuteUpdate;
  Result := FAutoIncCommand.Parameters[1].Value.GetInt32;
end;

function TdsEinstellungClient.getDataID(ta_id: Integer): Integer;
begin
  if FgetDataIDCommand = nil then
  begin
    FgetDataIDCommand := FDBXConnection.CreateCommand;
    FgetDataIDCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetDataIDCommand.Text := 'TdsEinstellung.getDataID';
    FgetDataIDCommand.Prepare;
  end;
  FgetDataIDCommand.Parameters[0].Value.SetInt32(ta_id);
  FgetDataIDCommand.ExecuteUpdate;
  Result := FgetDataIDCommand.Parameters[1].Value.GetInt32;
end;

constructor TdsEinstellungClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsEinstellungClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsEinstellungClient.Destroy;
begin
  FDSServerModuleDestroyCommand.DisposeOf;
  FAutoIncCommand.DisposeOf;
  FgetDataIDCommand.DisposeOf;
  inherited;
end;

procedure TdsMiscClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FDBXConnection.CreateCommand;
    FDSServerModuleCreateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDSServerModuleCreateCommand.Text := 'TdsMisc.DSServerModuleCreate';
    FDSServerModuleCreateCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FDSServerModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDSServerModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FDSServerModuleCreateCommand.ExecuteUpdate;
end;

function TdsMiscClient.LockDocument(id: Integer; typ: Integer): TJSONObject;
begin
  if FLockDocumentCommand = nil then
  begin
    FLockDocumentCommand := FDBXConnection.CreateCommand;
    FLockDocumentCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FLockDocumentCommand.Text := 'TdsMisc.LockDocument';
    FLockDocumentCommand.Prepare;
  end;
  FLockDocumentCommand.Parameters[0].Value.SetInt32(id);
  FLockDocumentCommand.Parameters[1].Value.SetInt32(typ);
  FLockDocumentCommand.ExecuteUpdate;
  Result := TJSONObject(FLockDocumentCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMiscClient.UnLockDocument(id: Integer; typ: Integer): TJSONObject;
begin
  if FUnLockDocumentCommand = nil then
  begin
    FUnLockDocumentCommand := FDBXConnection.CreateCommand;
    FUnLockDocumentCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FUnLockDocumentCommand.Text := 'TdsMisc.UnLockDocument';
    FUnLockDocumentCommand.Prepare;
  end;
  FUnLockDocumentCommand.Parameters[0].Value.SetInt32(id);
  FUnLockDocumentCommand.Parameters[1].Value.SetInt32(typ);
  FUnLockDocumentCommand.ExecuteUpdate;
  Result := TJSONObject(FUnLockDocumentCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMiscClient.isLocked(id: Integer; typ: Integer): TJSONObject;
begin
  if FisLockedCommand = nil then
  begin
    FisLockedCommand := FDBXConnection.CreateCommand;
    FisLockedCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FisLockedCommand.Text := 'TdsMisc.isLocked';
    FisLockedCommand.Prepare;
  end;
  FisLockedCommand.Parameters[0].Value.SetInt32(id);
  FisLockedCommand.Parameters[1].Value.SetInt32(typ);
  FisLockedCommand.ExecuteUpdate;
  Result := TJSONObject(FisLockedCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMiscClient.validTask(id: Integer; dt: Integer): Boolean;
begin
  if FvalidTaskCommand = nil then
  begin
    FvalidTaskCommand := FDBXConnection.CreateCommand;
    FvalidTaskCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FvalidTaskCommand.Text := 'TdsMisc.validTask';
    FvalidTaskCommand.Prepare;
  end;
  FvalidTaskCommand.Parameters[0].Value.SetInt32(id);
  FvalidTaskCommand.Parameters[1].Value.SetInt32(dt);
  FvalidTaskCommand.ExecuteUpdate;
  Result := FvalidTaskCommand.Parameters[2].Value.GetBoolean;
end;

function TdsMiscClient.AutoInc(gen: string): Integer;
begin
  if FAutoIncCommand = nil then
  begin
    FAutoIncCommand := FDBXConnection.CreateCommand;
    FAutoIncCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoIncCommand.Text := 'TdsMisc.AutoInc';
    FAutoIncCommand.Prepare;
  end;
  FAutoIncCommand.Parameters[0].Value.SetWideString(gen);
  FAutoIncCommand.ExecuteUpdate;
  Result := FAutoIncCommand.Parameters[1].Value.GetInt32;
end;

constructor TdsMiscClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsMiscClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsMiscClient.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FLockDocumentCommand.DisposeOf;
  FUnLockDocumentCommand.DisposeOf;
  FisLockedCommand.DisposeOf;
  FvalidTaskCommand.DisposeOf;
  FAutoIncCommand.DisposeOf;
  inherited;
end;

function TdsProtocolClient.AutoInc(gen: string): Integer;
begin
  if FAutoIncCommand = nil then
  begin
    FAutoIncCommand := FDBXConnection.CreateCommand;
    FAutoIncCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoIncCommand.Text := 'TdsProtocol.AutoInc';
    FAutoIncCommand.Prepare;
  end;
  FAutoIncCommand.Parameters[0].Value.SetWideString(gen);
  FAutoIncCommand.ExecuteUpdate;
  Result := FAutoIncCommand.Parameters[1].Value.GetInt32;
end;

function TdsProtocolClient.newProtocol(data: TJSONObject): TJSONObject;
begin
  if FnewProtocolCommand = nil then
  begin
    FnewProtocolCommand := FDBXConnection.CreateCommand;
    FnewProtocolCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FnewProtocolCommand.Text := 'TdsProtocol.newProtocol';
    FnewProtocolCommand.Prepare;
  end;
  FnewProtocolCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FnewProtocolCommand.ExecuteUpdate;
  Result := TJSONObject(FnewProtocolCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsProtocolClient.deleteProtocol(data: TJSONObject): TJSONObject;
begin
  if FdeleteProtocolCommand = nil then
  begin
    FdeleteProtocolCommand := FDBXConnection.CreateCommand;
    FdeleteProtocolCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteProtocolCommand.Text := 'TdsProtocol.deleteProtocol';
    FdeleteProtocolCommand.Prepare;
  end;
  FdeleteProtocolCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FdeleteProtocolCommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteProtocolCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsProtocolClient.deleteCP(id: Integer): TJSONObject;
begin
  if FdeleteCPCommand = nil then
  begin
    FdeleteCPCommand := FDBXConnection.CreateCommand;
    FdeleteCPCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteCPCommand.Text := 'TdsProtocol.deleteCP';
    FdeleteCPCommand.Prepare;
  end;
  FdeleteCPCommand.Parameters[0].Value.SetInt32(id);
  FdeleteCPCommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteCPCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TdsProtocolClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsProtocolClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsProtocolClient.Destroy;
begin
  FAutoIncCommand.DisposeOf;
  FnewProtocolCommand.DisposeOf;
  FdeleteProtocolCommand.DisposeOf;
  FdeleteCPCommand.DisposeOf;
  inherited;
end;

function TdsImageClient.getimageList: TJSONObject;
begin
  if FgetimageListCommand = nil then
  begin
    FgetimageListCommand := FDBXConnection.CreateCommand;
    FgetimageListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetimageListCommand.Text := 'TdsImage.getimageList';
    FgetimageListCommand.Prepare;
  end;
  FgetimageListCommand.ExecuteUpdate;
  Result := TJSONObject(FgetimageListCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TdsImageClient.getImage(data: TJSONObject): TStream;
begin
  if FgetImageCommand = nil then
  begin
    FgetImageCommand := FDBXConnection.CreateCommand;
    FgetImageCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetImageCommand.Text := 'TdsImage.getImage';
    FgetImageCommand.Prepare;
  end;
  FgetImageCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FgetImageCommand.ExecuteUpdate;
  Result := FgetImageCommand.Parameters[1].Value.GetStream(FInstanceOwner);
end;

function TdsImageClient.AutoInc(gen: string): Integer;
begin
  if FAutoIncCommand = nil then
  begin
    FAutoIncCommand := FDBXConnection.CreateCommand;
    FAutoIncCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoIncCommand.Text := 'TdsImage.AutoInc';
    FAutoIncCommand.Prepare;
  end;
  FAutoIncCommand.Parameters[0].Value.SetWideString(gen);
  FAutoIncCommand.ExecuteUpdate;
  Result := FAutoIncCommand.Parameters[1].Value.GetInt32;
end;

constructor TdsImageClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsImageClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsImageClient.Destroy;
begin
  FgetimageListCommand.DisposeOf;
  FgetImageCommand.DisposeOf;
  FAutoIncCommand.DisposeOf;
  inherited;
end;

constructor TdsChapterClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsChapterClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsChapterClient.Destroy;
begin
  inherited;
end;

constructor TdsTaskEditClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsTaskEditClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsTaskEditClient.Destroy;
begin
  inherited;
end;

function TdsTemplateClient.AutoInc(gen: string): Integer;
begin
  if FAutoIncCommand = nil then
  begin
    FAutoIncCommand := FDBXConnection.CreateCommand;
    FAutoIncCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoIncCommand.Text := 'TdsTemplate.AutoInc';
    FAutoIncCommand.Prepare;
  end;
  FAutoIncCommand.Parameters[0].Value.SetWideString(gen);
  FAutoIncCommand.ExecuteUpdate;
  Result := FAutoIncCommand.Parameters[1].Value.GetInt32;
end;

function TdsTemplateClient.hasName(name: string): Boolean;
begin
  if FhasNameCommand = nil then
  begin
    FhasNameCommand := FDBXConnection.CreateCommand;
    FhasNameCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FhasNameCommand.Text := 'TdsTemplate.hasName';
    FhasNameCommand.Prepare;
  end;
  FhasNameCommand.Parameters[0].Value.SetWideString(name);
  FhasNameCommand.ExecuteUpdate;
  Result := FhasNameCommand.Parameters[1].Value.GetBoolean;
end;

constructor TdsTemplateClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsTemplateClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsTemplateClient.Destroy;
begin
  FAutoIncCommand.DisposeOf;
  FhasNameCommand.DisposeOf;
  inherited;
end;

end.

