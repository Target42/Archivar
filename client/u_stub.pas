//
// Erzeugt vom DataSnap-Proxy-Generator.
// 08.05.2023 21:09:02
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
    FServiceActionCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    function getUserInfo(data: TJSONObject): TJSONObject;
    function getGremiumList: TJSONObject;
    function getDeleteTimes: TJSONObject;
    function ServiceAction(data: TJSONObject): TJSONObject;
  end;

  TdsGremiumClient = class(TDSAdminClient)
  private
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
    FTaskLogTabBeforePostCommand: TDBXCommand;
    FnewTaskCommand: TDBXCommand;
    FdeleteTaskCommand: TDBXCommand;
    FTaskInfoCommand: TDBXCommand;
    FAutoIncCommand: TDBXCommand;
    FAssignGremiumCommand: TDBXCommand;
    FmoveTaskCommand: TDBXCommand;
    FcloseTaskCommand: TDBXCommand;
    FsetFlagsCommand: TDBXCommand;
    FAssignmentsCommand: TDBXCommand;
    FAssignToGremiumCommand: TDBXCommand;
    FAssignmentRemoveCommand: TDBXCommand;
    FcheckFileStorageCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure TaskLogTabBeforePost(DataSet: TDataSet);
    function newTask(data: TJSONObject): TJSONObject;
    function deleteTask(ta_id: Integer): TJSONObject;
    function TaskInfo(data: TJSONObject): TJSONObject;
    function AutoInc(gen: string): Integer;
    function AssignGremium(grid: Integer; taid: Integer; status: string): TJSONObject;
    function moveTask(grid: Integer; taid: Integer): TJSONObject;
    function closeTask(ta_id: Integer): TJSONObject;
    procedure setFlags(taid: Integer; flags: Integer);
    function Assignments(taid: Integer): TJSONObject;
    function AssignToGremium(data: TJSONObject): TJSONObject;
    function AssignmentRemove(data: TJSONObject): TJSONObject;
    procedure checkFileStorage(taid: Integer);
  end;

  TdsFileClient = class(TDSAdminClient)
  private
    FAutoIncCommand: TDBXCommand;
    FuploadCommand: TDBXCommand;
    FdeleteFileCommand: TDBXCommand;
    FcreateRootCommand: TDBXCommand;
    FnewFolderCommand: TDBXCommand;
    FdeleteFolderCommand: TDBXCommand;
    FrenameFolderCommand: TDBXCommand;
    FmoveCommand: TDBXCommand;
    FgetFileInfoCommand: TDBXCommand;
    FDeleteFileHistoryCommand: TDBXCommand;
    FlockCommand: TDBXCommand;
    FunlockCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function AutoInc(gen: string): Integer;
    function upload(data: TJSONObject; st: TStream): TJSONObject;
    function deleteFile(data: TJSONObject): TJSONObject;
    function createRoot(data: TJSONObject): TJSONObject;
    function newFolder(data: TJSONObject): TJSONObject;
    function deleteFolder(data: TJSONObject): TJSONObject;
    function renameFolder(data: TJSONObject): TJSONObject;
    function move(data: TJSONObject): TJSONObject;
    function getFileInfo(data: TJSONObject): TJSONObject;
    function DeleteFileHistory(data: TJSONObject): TJSONObject;
    function lock(data: TJSONObject): TJSONObject;
    function unlock(data: TJSONObject): TJSONObject;
  end;

  TdsMiscClient = class(TDSAdminClient)
  private
    FDSServerModuleCreateCommand: TDBXCommand;
    FLockDocumentCommand: TDBXCommand;
    FUnLockDocumentCommand: TDBXCommand;
    FisLockedCommand: TDBXCommand;
    FvalidTaskCommand: TDBXCommand;
    FAutoIncCommand: TDBXCommand;
    FgetUserListCommand: TDBXCommand;
    FchangeOnlineStatusCommand: TDBXCommand;
    FgetPublicKeyCommand: TDBXCommand;
    FgetStorageListCommand: TDBXCommand;
    FpingCommand: TDBXCommand;
    FcheckFolderCommand: TDBXCommand;
    FgetConfigDataCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    function LockDocument(req: TJSONObject): TJSONObject;
    function UnLockDocument(req: TJSONObject): TJSONObject;
    function isLocked(req: TJSONObject): TJSONObject;
    function validTask(id: Integer; dt: Integer): Boolean;
    function AutoInc(gen: string): Integer;
    function getUserList: TJSONObject;
    function changeOnlineStatus(req: TJSONObject): TJSONObject;
    function getPublicKey(net: string; stamp: TDateTime): TStream;
    function getStorageList: TJSONObject;
    function ping(value: Integer): Integer;
    function checkFolder(data: TJSONObject): TJSONObject;
    function getConfigData(req: TJSONObject): TJSONObject;
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
    FgetSysTemplatesCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function AutoInc(gen: string): Integer;
    function hasName(name: string): Boolean;
    function getSysTemplates: TJSONObject;
  end;

  TdsTaskViewClient = class(TDSAdminClient)
  private
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
  end;

  TdsTextBlockClient = class(TDSAdminClient)
  private
    FgetTagListCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function getTagList: TJSONObject;
  end;

  TdsFileCacheClient = class(TDSAdminClient)
  private
    FAutoIncCommand: TDBXCommand;
    FuploadCommand: TDBXCommand;
    FdownloadCommand: TDBXCommand;
    FdeleteFileCommand: TDBXCommand;
    FLockCommand: TDBXCommand;
    FunlockCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function AutoInc(gen: string): Integer;
    function upload(req: TJSONObject; st: TStream): TJSONObject;
    function download(req: TJSONObject): TStream;
    function deleteFile(req: TJSONObject): TJSONObject;
    function Lock(req: TJSONObject): TJSONObject;
    function unlock(req: TJSONObject): TJSONObject;
  end;

  TdsEpubClient = class(TDSAdminClient)
  private
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
  end;

  TdsMeeingClient = class(TDSAdminClient)
  private
    FAutoIncCommand: TDBXCommand;
    FnewMeetingCommand: TDBXCommand;
    FdeleteMeetingCommand: TDBXCommand;
    FSendmailCommand: TDBXCommand;
    FinviteCommand: TDBXCommand;
    FGetTreeCommand: TDBXCommand;
    FchangeStatusCommand: TDBXCommand;
    FchangeUserCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function AutoInc(gen: string): Integer;
    function newMeeting(req: TJSONObject): TJSONObject;
    function deleteMeeting(req: TJSONObject): TJSONObject;
    function Sendmail(req: TJSONObject): TJSONObject;
    function invite(req: TJSONObject): TJSONObject;
    function GetTree(req: TJSONObject): TJSONObject;
    function changeStatus(req: TJSONObject): TJSONObject;
    function changeUser(req: TJSONObject): TJSONObject;
  end;

  TdsSitzungClient = class(TDSAdminClient)
  private
    FenterCommand: TDBXCommand;
    FleaveCommand: TDBXCommand;
    FchangeStateCommand: TDBXCommand;
    FstartVoteCommand: TDBXCommand;
    FVoteCommand: TDBXCommand;
    FendVoteCommand: TDBXCommand;
    FrequestLeadCommand: TDBXCommand;
    FchangeLeadCommand: TDBXCommand;
    FupdateDocumentCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function enter(obj: TJSONObject): TJSONObject;
    function leave(obj: TJSONObject): TJSONObject;
    function changeState(obj: TJSONObject): TJSONObject;
    function startVote(obj: TJSONObject): TJSONObject;
    function Vote(obj: TJSONObject): TJSONObject;
    function endVote(obj: TJSONObject): TJSONObject;
    function requestLead(obj: TJSONObject): TJSONObject;
    function changeLead(obj: TJSONObject): TJSONObject;
    procedure updateDocument(obj: TJSONObject);
  end;

  TdsUpdaterClient = class(TDSAdminClient)
  private
    FdownloadCommand: TDBXCommand;
    FgetFileListCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function download(obj: TJSONObject): TStream;
    function getFileList: TJSONObject;
  end;

  TStammModClient = class(TDSAdminClient)
  private
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
  end;

  TdsPKIClient = class(TDSAdminClient)
  private
    FuploadKeysCommand: TDBXCommand;
    FgetPublicKeyCommand: TDBXCommand;
    FgetPrivateKeyCommand: TDBXCommand;
    FhasValidKeyCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function uploadKeys(net: string; pub: TStream; priv: TStream): TJSONObject;
    function getPublicKey(net: string; stamp: TDateTime): TStream;
    function getPrivateKey: TStream;
    function hasValidKey(net: string; stamp: TDateTime): Boolean;
  end;

  TdsDairyClient = class(TDSAdminClient)
  private
    FDSServerModuleCreateCommand: TDBXCommand;
    FDITabBeforePostCommand: TDBXCommand;
    FDataQryBeforeOpenCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    procedure DITabBeforePost(DataSet: TDataSet);
    procedure DataQryBeforeOpen(DataSet: TDataSet);
  end;

  TdsStorageClient = class(TDSAdminClient)
  private
    FAutoIncCommand: TDBXCommand;
    FnewStorageCommand: TDBXCommand;
    FrenameStorageCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function AutoInc(gen: string): Integer;
    function newStorage(data: TJSONObject): TJSONObject;
    function renameStorage(data: TJSONObject): TJSONObject;
  end;

  TTdsPluginClient = class(TDSAdminClient)
  private
    FTabPluginBeforePostCommand: TDBXCommand;
    FgetListCommand: TDBXCommand;
    FdownloadCommand: TDBXCommand;
    FuploadCommand: TDBXCommand;
    FsetStatusCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure TabPluginBeforePost(DataSet: TDataSet);
    function getList: TJSONObject;
    function download(data: TJSONObject): TStream;
    function upload(data: TJSONObject; st: TStream): TJSONObject;
    function setStatus(data: TJSONObject): TJSONObject;
  end;

  TDSImportClient = class(TDSAdminClient)
  private
    FDSServerModuleCreateCommand: TDBXCommand;
    FstartImportCommand: TDBXCommand;
    FimportTaskCommand: TDBXCommand;
    FuploadFileCommand: TDBXCommand;
    FendImportCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    function startImport: TJSONObject;
    function importTask(data: TJSONObject; st: TStream): TJSONObject;
    function uploadFile(data: TJSONObject; st: TStream): TJSONObject;
    function endImport(data: TJSONObject): TJSONObject;
  end;

  TDSMailClient = class(TDSAdminClient)
  private
    FsetMailStatusCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function setMailStatus(data: TJSONObject): TJSONObject;
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

function TAdminModClient.ServiceAction(data: TJSONObject): TJSONObject;
begin
  if FServiceActionCommand = nil then
  begin
    FServiceActionCommand := FDBXConnection.CreateCommand;
    FServiceActionCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FServiceActionCommand.Text := 'TAdminMod.ServiceAction';
    FServiceActionCommand.Prepare;
  end;
  FServiceActionCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FServiceActionCommand.ExecuteUpdate;
  Result := TJSONObject(FServiceActionCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
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
  FServiceActionCommand.DisposeOf;
  inherited;
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

procedure TdsTaskClient.TaskLogTabBeforePost(DataSet: TDataSet);
begin
  if FTaskLogTabBeforePostCommand = nil then
  begin
    FTaskLogTabBeforePostCommand := FDBXConnection.CreateCommand;
    FTaskLogTabBeforePostCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FTaskLogTabBeforePostCommand.Text := 'TdsTask.TaskLogTabBeforePost';
    FTaskLogTabBeforePostCommand.Prepare;
  end;
  FTaskLogTabBeforePostCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FTaskLogTabBeforePostCommand.ExecuteUpdate;
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

function TdsTaskClient.Assignments(taid: Integer): TJSONObject;
begin
  if FAssignmentsCommand = nil then
  begin
    FAssignmentsCommand := FDBXConnection.CreateCommand;
    FAssignmentsCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAssignmentsCommand.Text := 'TdsTask.Assignments';
    FAssignmentsCommand.Prepare;
  end;
  FAssignmentsCommand.Parameters[0].Value.SetInt32(taid);
  FAssignmentsCommand.ExecuteUpdate;
  Result := TJSONObject(FAssignmentsCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsTaskClient.AssignToGremium(data: TJSONObject): TJSONObject;
begin
  if FAssignToGremiumCommand = nil then
  begin
    FAssignToGremiumCommand := FDBXConnection.CreateCommand;
    FAssignToGremiumCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAssignToGremiumCommand.Text := 'TdsTask.AssignToGremium';
    FAssignToGremiumCommand.Prepare;
  end;
  FAssignToGremiumCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FAssignToGremiumCommand.ExecuteUpdate;
  Result := TJSONObject(FAssignToGremiumCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsTaskClient.AssignmentRemove(data: TJSONObject): TJSONObject;
begin
  if FAssignmentRemoveCommand = nil then
  begin
    FAssignmentRemoveCommand := FDBXConnection.CreateCommand;
    FAssignmentRemoveCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAssignmentRemoveCommand.Text := 'TdsTask.AssignmentRemove';
    FAssignmentRemoveCommand.Prepare;
  end;
  FAssignmentRemoveCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FAssignmentRemoveCommand.ExecuteUpdate;
  Result := TJSONObject(FAssignmentRemoveCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

procedure TdsTaskClient.checkFileStorage(taid: Integer);
begin
  if FcheckFileStorageCommand = nil then
  begin
    FcheckFileStorageCommand := FDBXConnection.CreateCommand;
    FcheckFileStorageCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FcheckFileStorageCommand.Text := 'TdsTask.checkFileStorage';
    FcheckFileStorageCommand.Prepare;
  end;
  FcheckFileStorageCommand.Parameters[0].Value.SetInt32(taid);
  FcheckFileStorageCommand.ExecuteUpdate;
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
  FTaskLogTabBeforePostCommand.DisposeOf;
  FnewTaskCommand.DisposeOf;
  FdeleteTaskCommand.DisposeOf;
  FTaskInfoCommand.DisposeOf;
  FAutoIncCommand.DisposeOf;
  FAssignGremiumCommand.DisposeOf;
  FmoveTaskCommand.DisposeOf;
  FcloseTaskCommand.DisposeOf;
  FsetFlagsCommand.DisposeOf;
  FAssignmentsCommand.DisposeOf;
  FAssignToGremiumCommand.DisposeOf;
  FAssignmentRemoveCommand.DisposeOf;
  FcheckFileStorageCommand.DisposeOf;
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

function TdsFileClient.deleteFile(data: TJSONObject): TJSONObject;
begin
  if FdeleteFileCommand = nil then
  begin
    FdeleteFileCommand := FDBXConnection.CreateCommand;
    FdeleteFileCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteFileCommand.Text := 'TdsFile.deleteFile';
    FdeleteFileCommand.Prepare;
  end;
  FdeleteFileCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FdeleteFileCommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteFileCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileClient.createRoot(data: TJSONObject): TJSONObject;
begin
  if FcreateRootCommand = nil then
  begin
    FcreateRootCommand := FDBXConnection.CreateCommand;
    FcreateRootCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FcreateRootCommand.Text := 'TdsFile.createRoot';
    FcreateRootCommand.Prepare;
  end;
  FcreateRootCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FcreateRootCommand.ExecuteUpdate;
  Result := TJSONObject(FcreateRootCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileClient.newFolder(data: TJSONObject): TJSONObject;
begin
  if FnewFolderCommand = nil then
  begin
    FnewFolderCommand := FDBXConnection.CreateCommand;
    FnewFolderCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FnewFolderCommand.Text := 'TdsFile.newFolder';
    FnewFolderCommand.Prepare;
  end;
  FnewFolderCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FnewFolderCommand.ExecuteUpdate;
  Result := TJSONObject(FnewFolderCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileClient.deleteFolder(data: TJSONObject): TJSONObject;
begin
  if FdeleteFolderCommand = nil then
  begin
    FdeleteFolderCommand := FDBXConnection.CreateCommand;
    FdeleteFolderCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteFolderCommand.Text := 'TdsFile.deleteFolder';
    FdeleteFolderCommand.Prepare;
  end;
  FdeleteFolderCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FdeleteFolderCommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteFolderCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileClient.renameFolder(data: TJSONObject): TJSONObject;
begin
  if FrenameFolderCommand = nil then
  begin
    FrenameFolderCommand := FDBXConnection.CreateCommand;
    FrenameFolderCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FrenameFolderCommand.Text := 'TdsFile.renameFolder';
    FrenameFolderCommand.Prepare;
  end;
  FrenameFolderCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FrenameFolderCommand.ExecuteUpdate;
  Result := TJSONObject(FrenameFolderCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileClient.move(data: TJSONObject): TJSONObject;
begin
  if FmoveCommand = nil then
  begin
    FmoveCommand := FDBXConnection.CreateCommand;
    FmoveCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FmoveCommand.Text := 'TdsFile.move';
    FmoveCommand.Prepare;
  end;
  FmoveCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FmoveCommand.ExecuteUpdate;
  Result := TJSONObject(FmoveCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileClient.getFileInfo(data: TJSONObject): TJSONObject;
begin
  if FgetFileInfoCommand = nil then
  begin
    FgetFileInfoCommand := FDBXConnection.CreateCommand;
    FgetFileInfoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetFileInfoCommand.Text := 'TdsFile.getFileInfo';
    FgetFileInfoCommand.Prepare;
  end;
  FgetFileInfoCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FgetFileInfoCommand.ExecuteUpdate;
  Result := TJSONObject(FgetFileInfoCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileClient.DeleteFileHistory(data: TJSONObject): TJSONObject;
begin
  if FDeleteFileHistoryCommand = nil then
  begin
    FDeleteFileHistoryCommand := FDBXConnection.CreateCommand;
    FDeleteFileHistoryCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeleteFileHistoryCommand.Text := 'TdsFile.DeleteFileHistory';
    FDeleteFileHistoryCommand.Prepare;
  end;
  FDeleteFileHistoryCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FDeleteFileHistoryCommand.ExecuteUpdate;
  Result := TJSONObject(FDeleteFileHistoryCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileClient.lock(data: TJSONObject): TJSONObject;
begin
  if FlockCommand = nil then
  begin
    FlockCommand := FDBXConnection.CreateCommand;
    FlockCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FlockCommand.Text := 'TdsFile.lock';
    FlockCommand.Prepare;
  end;
  FlockCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FlockCommand.ExecuteUpdate;
  Result := TJSONObject(FlockCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileClient.unlock(data: TJSONObject): TJSONObject;
begin
  if FunlockCommand = nil then
  begin
    FunlockCommand := FDBXConnection.CreateCommand;
    FunlockCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FunlockCommand.Text := 'TdsFile.unlock';
    FunlockCommand.Prepare;
  end;
  FunlockCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FunlockCommand.ExecuteUpdate;
  Result := TJSONObject(FunlockCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
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
  FcreateRootCommand.DisposeOf;
  FnewFolderCommand.DisposeOf;
  FdeleteFolderCommand.DisposeOf;
  FrenameFolderCommand.DisposeOf;
  FmoveCommand.DisposeOf;
  FgetFileInfoCommand.DisposeOf;
  FDeleteFileHistoryCommand.DisposeOf;
  FlockCommand.DisposeOf;
  FunlockCommand.DisposeOf;
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

function TdsMiscClient.LockDocument(req: TJSONObject): TJSONObject;
begin
  if FLockDocumentCommand = nil then
  begin
    FLockDocumentCommand := FDBXConnection.CreateCommand;
    FLockDocumentCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FLockDocumentCommand.Text := 'TdsMisc.LockDocument';
    FLockDocumentCommand.Prepare;
  end;
  FLockDocumentCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FLockDocumentCommand.ExecuteUpdate;
  Result := TJSONObject(FLockDocumentCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMiscClient.UnLockDocument(req: TJSONObject): TJSONObject;
begin
  if FUnLockDocumentCommand = nil then
  begin
    FUnLockDocumentCommand := FDBXConnection.CreateCommand;
    FUnLockDocumentCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FUnLockDocumentCommand.Text := 'TdsMisc.UnLockDocument';
    FUnLockDocumentCommand.Prepare;
  end;
  FUnLockDocumentCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FUnLockDocumentCommand.ExecuteUpdate;
  Result := TJSONObject(FUnLockDocumentCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMiscClient.isLocked(req: TJSONObject): TJSONObject;
begin
  if FisLockedCommand = nil then
  begin
    FisLockedCommand := FDBXConnection.CreateCommand;
    FisLockedCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FisLockedCommand.Text := 'TdsMisc.isLocked';
    FisLockedCommand.Prepare;
  end;
  FisLockedCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FisLockedCommand.ExecuteUpdate;
  Result := TJSONObject(FisLockedCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
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

function TdsMiscClient.getUserList: TJSONObject;
begin
  if FgetUserListCommand = nil then
  begin
    FgetUserListCommand := FDBXConnection.CreateCommand;
    FgetUserListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetUserListCommand.Text := 'TdsMisc.getUserList';
    FgetUserListCommand.Prepare;
  end;
  FgetUserListCommand.ExecuteUpdate;
  Result := TJSONObject(FgetUserListCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMiscClient.changeOnlineStatus(req: TJSONObject): TJSONObject;
begin
  if FchangeOnlineStatusCommand = nil then
  begin
    FchangeOnlineStatusCommand := FDBXConnection.CreateCommand;
    FchangeOnlineStatusCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FchangeOnlineStatusCommand.Text := 'TdsMisc.changeOnlineStatus';
    FchangeOnlineStatusCommand.Prepare;
  end;
  FchangeOnlineStatusCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FchangeOnlineStatusCommand.ExecuteUpdate;
  Result := TJSONObject(FchangeOnlineStatusCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMiscClient.getPublicKey(net: string; stamp: TDateTime): TStream;
begin
  if FgetPublicKeyCommand = nil then
  begin
    FgetPublicKeyCommand := FDBXConnection.CreateCommand;
    FgetPublicKeyCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetPublicKeyCommand.Text := 'TdsMisc.getPublicKey';
    FgetPublicKeyCommand.Prepare;
  end;
  FgetPublicKeyCommand.Parameters[0].Value.SetWideString(net);
  FgetPublicKeyCommand.Parameters[1].Value.AsDateTime := stamp;
  FgetPublicKeyCommand.ExecuteUpdate;
  Result := FgetPublicKeyCommand.Parameters[2].Value.GetStream(FInstanceOwner);
end;

function TdsMiscClient.getStorageList: TJSONObject;
begin
  if FgetStorageListCommand = nil then
  begin
    FgetStorageListCommand := FDBXConnection.CreateCommand;
    FgetStorageListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetStorageListCommand.Text := 'TdsMisc.getStorageList';
    FgetStorageListCommand.Prepare;
  end;
  FgetStorageListCommand.ExecuteUpdate;
  Result := TJSONObject(FgetStorageListCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMiscClient.ping(value: Integer): Integer;
begin
  if FpingCommand = nil then
  begin
    FpingCommand := FDBXConnection.CreateCommand;
    FpingCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FpingCommand.Text := 'TdsMisc.ping';
    FpingCommand.Prepare;
  end;
  FpingCommand.Parameters[0].Value.SetInt32(value);
  FpingCommand.ExecuteUpdate;
  Result := FpingCommand.Parameters[1].Value.GetInt32;
end;

function TdsMiscClient.checkFolder(data: TJSONObject): TJSONObject;
begin
  if FcheckFolderCommand = nil then
  begin
    FcheckFolderCommand := FDBXConnection.CreateCommand;
    FcheckFolderCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FcheckFolderCommand.Text := 'TdsMisc.checkFolder';
    FcheckFolderCommand.Prepare;
  end;
  FcheckFolderCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FcheckFolderCommand.ExecuteUpdate;
  Result := TJSONObject(FcheckFolderCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMiscClient.getConfigData(req: TJSONObject): TJSONObject;
begin
  if FgetConfigDataCommand = nil then
  begin
    FgetConfigDataCommand := FDBXConnection.CreateCommand;
    FgetConfigDataCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetConfigDataCommand.Text := 'TdsMisc.getConfigData';
    FgetConfigDataCommand.Prepare;
  end;
  FgetConfigDataCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FgetConfigDataCommand.ExecuteUpdate;
  Result := TJSONObject(FgetConfigDataCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
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
  FgetUserListCommand.DisposeOf;
  FchangeOnlineStatusCommand.DisposeOf;
  FgetPublicKeyCommand.DisposeOf;
  FgetStorageListCommand.DisposeOf;
  FpingCommand.DisposeOf;
  FcheckFolderCommand.DisposeOf;
  FgetConfigDataCommand.DisposeOf;
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

function TdsTemplateClient.getSysTemplates: TJSONObject;
begin
  if FgetSysTemplatesCommand = nil then
  begin
    FgetSysTemplatesCommand := FDBXConnection.CreateCommand;
    FgetSysTemplatesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetSysTemplatesCommand.Text := 'TdsTemplate.getSysTemplates';
    FgetSysTemplatesCommand.Prepare;
  end;
  FgetSysTemplatesCommand.ExecuteUpdate;
  Result := TJSONObject(FgetSysTemplatesCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
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
  FgetSysTemplatesCommand.DisposeOf;
  inherited;
end;

constructor TdsTaskViewClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsTaskViewClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsTaskViewClient.Destroy;
begin
  inherited;
end;

function TdsTextBlockClient.getTagList: TJSONObject;
begin
  if FgetTagListCommand = nil then
  begin
    FgetTagListCommand := FDBXConnection.CreateCommand;
    FgetTagListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetTagListCommand.Text := 'TdsTextBlock.getTagList';
    FgetTagListCommand.Prepare;
  end;
  FgetTagListCommand.ExecuteUpdate;
  Result := TJSONObject(FgetTagListCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

constructor TdsTextBlockClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsTextBlockClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsTextBlockClient.Destroy;
begin
  FgetTagListCommand.DisposeOf;
  inherited;
end;

function TdsFileCacheClient.AutoInc(gen: string): Integer;
begin
  if FAutoIncCommand = nil then
  begin
    FAutoIncCommand := FDBXConnection.CreateCommand;
    FAutoIncCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoIncCommand.Text := 'TdsFileCache.AutoInc';
    FAutoIncCommand.Prepare;
  end;
  FAutoIncCommand.Parameters[0].Value.SetWideString(gen);
  FAutoIncCommand.ExecuteUpdate;
  Result := FAutoIncCommand.Parameters[1].Value.GetInt32;
end;

function TdsFileCacheClient.upload(req: TJSONObject; st: TStream): TJSONObject;
begin
  if FuploadCommand = nil then
  begin
    FuploadCommand := FDBXConnection.CreateCommand;
    FuploadCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FuploadCommand.Text := 'TdsFileCache.upload';
    FuploadCommand.Prepare;
  end;
  FuploadCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FuploadCommand.Parameters[1].Value.SetStream(st, FInstanceOwner);
  FuploadCommand.ExecuteUpdate;
  Result := TJSONObject(FuploadCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileCacheClient.download(req: TJSONObject): TStream;
begin
  if FdownloadCommand = nil then
  begin
    FdownloadCommand := FDBXConnection.CreateCommand;
    FdownloadCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdownloadCommand.Text := 'TdsFileCache.download';
    FdownloadCommand.Prepare;
  end;
  FdownloadCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FdownloadCommand.ExecuteUpdate;
  Result := FdownloadCommand.Parameters[1].Value.GetStream(FInstanceOwner);
end;

function TdsFileCacheClient.deleteFile(req: TJSONObject): TJSONObject;
begin
  if FdeleteFileCommand = nil then
  begin
    FdeleteFileCommand := FDBXConnection.CreateCommand;
    FdeleteFileCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteFileCommand.Text := 'TdsFileCache.deleteFile';
    FdeleteFileCommand.Prepare;
  end;
  FdeleteFileCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FdeleteFileCommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteFileCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileCacheClient.Lock(req: TJSONObject): TJSONObject;
begin
  if FLockCommand = nil then
  begin
    FLockCommand := FDBXConnection.CreateCommand;
    FLockCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FLockCommand.Text := 'TdsFileCache.Lock';
    FLockCommand.Prepare;
  end;
  FLockCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FLockCommand.ExecuteUpdate;
  Result := TJSONObject(FLockCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsFileCacheClient.unlock(req: TJSONObject): TJSONObject;
begin
  if FunlockCommand = nil then
  begin
    FunlockCommand := FDBXConnection.CreateCommand;
    FunlockCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FunlockCommand.Text := 'TdsFileCache.unlock';
    FunlockCommand.Prepare;
  end;
  FunlockCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FunlockCommand.ExecuteUpdate;
  Result := TJSONObject(FunlockCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TdsFileCacheClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsFileCacheClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsFileCacheClient.Destroy;
begin
  FAutoIncCommand.DisposeOf;
  FuploadCommand.DisposeOf;
  FdownloadCommand.DisposeOf;
  FdeleteFileCommand.DisposeOf;
  FLockCommand.DisposeOf;
  FunlockCommand.DisposeOf;
  inherited;
end;

constructor TdsEpubClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsEpubClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsEpubClient.Destroy;
begin
  inherited;
end;

function TdsMeeingClient.AutoInc(gen: string): Integer;
begin
  if FAutoIncCommand = nil then
  begin
    FAutoIncCommand := FDBXConnection.CreateCommand;
    FAutoIncCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoIncCommand.Text := 'TdsMeeing.AutoInc';
    FAutoIncCommand.Prepare;
  end;
  FAutoIncCommand.Parameters[0].Value.SetWideString(gen);
  FAutoIncCommand.ExecuteUpdate;
  Result := FAutoIncCommand.Parameters[1].Value.GetInt32;
end;

function TdsMeeingClient.newMeeting(req: TJSONObject): TJSONObject;
begin
  if FnewMeetingCommand = nil then
  begin
    FnewMeetingCommand := FDBXConnection.CreateCommand;
    FnewMeetingCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FnewMeetingCommand.Text := 'TdsMeeing.newMeeting';
    FnewMeetingCommand.Prepare;
  end;
  FnewMeetingCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FnewMeetingCommand.ExecuteUpdate;
  Result := TJSONObject(FnewMeetingCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMeeingClient.deleteMeeting(req: TJSONObject): TJSONObject;
begin
  if FdeleteMeetingCommand = nil then
  begin
    FdeleteMeetingCommand := FDBXConnection.CreateCommand;
    FdeleteMeetingCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteMeetingCommand.Text := 'TdsMeeing.deleteMeeting';
    FdeleteMeetingCommand.Prepare;
  end;
  FdeleteMeetingCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FdeleteMeetingCommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteMeetingCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMeeingClient.Sendmail(req: TJSONObject): TJSONObject;
begin
  if FSendmailCommand = nil then
  begin
    FSendmailCommand := FDBXConnection.CreateCommand;
    FSendmailCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FSendmailCommand.Text := 'TdsMeeing.Sendmail';
    FSendmailCommand.Prepare;
  end;
  FSendmailCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FSendmailCommand.ExecuteUpdate;
  Result := TJSONObject(FSendmailCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMeeingClient.invite(req: TJSONObject): TJSONObject;
begin
  if FinviteCommand = nil then
  begin
    FinviteCommand := FDBXConnection.CreateCommand;
    FinviteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FinviteCommand.Text := 'TdsMeeing.invite';
    FinviteCommand.Prepare;
  end;
  FinviteCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FinviteCommand.ExecuteUpdate;
  Result := TJSONObject(FinviteCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMeeingClient.GetTree(req: TJSONObject): TJSONObject;
begin
  if FGetTreeCommand = nil then
  begin
    FGetTreeCommand := FDBXConnection.CreateCommand;
    FGetTreeCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetTreeCommand.Text := 'TdsMeeing.GetTree';
    FGetTreeCommand.Prepare;
  end;
  FGetTreeCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FGetTreeCommand.ExecuteUpdate;
  Result := TJSONObject(FGetTreeCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMeeingClient.changeStatus(req: TJSONObject): TJSONObject;
begin
  if FchangeStatusCommand = nil then
  begin
    FchangeStatusCommand := FDBXConnection.CreateCommand;
    FchangeStatusCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FchangeStatusCommand.Text := 'TdsMeeing.changeStatus';
    FchangeStatusCommand.Prepare;
  end;
  FchangeStatusCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FchangeStatusCommand.ExecuteUpdate;
  Result := TJSONObject(FchangeStatusCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsMeeingClient.changeUser(req: TJSONObject): TJSONObject;
begin
  if FchangeUserCommand = nil then
  begin
    FchangeUserCommand := FDBXConnection.CreateCommand;
    FchangeUserCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FchangeUserCommand.Text := 'TdsMeeing.changeUser';
    FchangeUserCommand.Prepare;
  end;
  FchangeUserCommand.Parameters[0].Value.SetJSONValue(req, FInstanceOwner);
  FchangeUserCommand.ExecuteUpdate;
  Result := TJSONObject(FchangeUserCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TdsMeeingClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsMeeingClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsMeeingClient.Destroy;
begin
  FAutoIncCommand.DisposeOf;
  FnewMeetingCommand.DisposeOf;
  FdeleteMeetingCommand.DisposeOf;
  FSendmailCommand.DisposeOf;
  FinviteCommand.DisposeOf;
  FGetTreeCommand.DisposeOf;
  FchangeStatusCommand.DisposeOf;
  FchangeUserCommand.DisposeOf;
  inherited;
end;

function TdsSitzungClient.enter(obj: TJSONObject): TJSONObject;
begin
  if FenterCommand = nil then
  begin
    FenterCommand := FDBXConnection.CreateCommand;
    FenterCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FenterCommand.Text := 'TdsSitzung.enter';
    FenterCommand.Prepare;
  end;
  FenterCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FenterCommand.ExecuteUpdate;
  Result := TJSONObject(FenterCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsSitzungClient.leave(obj: TJSONObject): TJSONObject;
begin
  if FleaveCommand = nil then
  begin
    FleaveCommand := FDBXConnection.CreateCommand;
    FleaveCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FleaveCommand.Text := 'TdsSitzung.leave';
    FleaveCommand.Prepare;
  end;
  FleaveCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FleaveCommand.ExecuteUpdate;
  Result := TJSONObject(FleaveCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsSitzungClient.changeState(obj: TJSONObject): TJSONObject;
begin
  if FchangeStateCommand = nil then
  begin
    FchangeStateCommand := FDBXConnection.CreateCommand;
    FchangeStateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FchangeStateCommand.Text := 'TdsSitzung.changeState';
    FchangeStateCommand.Prepare;
  end;
  FchangeStateCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FchangeStateCommand.ExecuteUpdate;
  Result := TJSONObject(FchangeStateCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsSitzungClient.startVote(obj: TJSONObject): TJSONObject;
begin
  if FstartVoteCommand = nil then
  begin
    FstartVoteCommand := FDBXConnection.CreateCommand;
    FstartVoteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FstartVoteCommand.Text := 'TdsSitzung.startVote';
    FstartVoteCommand.Prepare;
  end;
  FstartVoteCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FstartVoteCommand.ExecuteUpdate;
  Result := TJSONObject(FstartVoteCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsSitzungClient.Vote(obj: TJSONObject): TJSONObject;
begin
  if FVoteCommand = nil then
  begin
    FVoteCommand := FDBXConnection.CreateCommand;
    FVoteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FVoteCommand.Text := 'TdsSitzung.Vote';
    FVoteCommand.Prepare;
  end;
  FVoteCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FVoteCommand.ExecuteUpdate;
  Result := TJSONObject(FVoteCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsSitzungClient.endVote(obj: TJSONObject): TJSONObject;
begin
  if FendVoteCommand = nil then
  begin
    FendVoteCommand := FDBXConnection.CreateCommand;
    FendVoteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FendVoteCommand.Text := 'TdsSitzung.endVote';
    FendVoteCommand.Prepare;
  end;
  FendVoteCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FendVoteCommand.ExecuteUpdate;
  Result := TJSONObject(FendVoteCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsSitzungClient.requestLead(obj: TJSONObject): TJSONObject;
begin
  if FrequestLeadCommand = nil then
  begin
    FrequestLeadCommand := FDBXConnection.CreateCommand;
    FrequestLeadCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FrequestLeadCommand.Text := 'TdsSitzung.requestLead';
    FrequestLeadCommand.Prepare;
  end;
  FrequestLeadCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FrequestLeadCommand.ExecuteUpdate;
  Result := TJSONObject(FrequestLeadCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsSitzungClient.changeLead(obj: TJSONObject): TJSONObject;
begin
  if FchangeLeadCommand = nil then
  begin
    FchangeLeadCommand := FDBXConnection.CreateCommand;
    FchangeLeadCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FchangeLeadCommand.Text := 'TdsSitzung.changeLead';
    FchangeLeadCommand.Prepare;
  end;
  FchangeLeadCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FchangeLeadCommand.ExecuteUpdate;
  Result := TJSONObject(FchangeLeadCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

procedure TdsSitzungClient.updateDocument(obj: TJSONObject);
begin
  if FupdateDocumentCommand = nil then
  begin
    FupdateDocumentCommand := FDBXConnection.CreateCommand;
    FupdateDocumentCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FupdateDocumentCommand.Text := 'TdsSitzung.updateDocument';
    FupdateDocumentCommand.Prepare;
  end;
  FupdateDocumentCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FupdateDocumentCommand.ExecuteUpdate;
end;

constructor TdsSitzungClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsSitzungClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsSitzungClient.Destroy;
begin
  FenterCommand.DisposeOf;
  FleaveCommand.DisposeOf;
  FchangeStateCommand.DisposeOf;
  FstartVoteCommand.DisposeOf;
  FVoteCommand.DisposeOf;
  FendVoteCommand.DisposeOf;
  FrequestLeadCommand.DisposeOf;
  FchangeLeadCommand.DisposeOf;
  FupdateDocumentCommand.DisposeOf;
  inherited;
end;

function TdsUpdaterClient.download(obj: TJSONObject): TStream;
begin
  if FdownloadCommand = nil then
  begin
    FdownloadCommand := FDBXConnection.CreateCommand;
    FdownloadCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdownloadCommand.Text := 'TdsUpdater.download';
    FdownloadCommand.Prepare;
  end;
  FdownloadCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FdownloadCommand.ExecuteUpdate;
  Result := FdownloadCommand.Parameters[1].Value.GetStream(FInstanceOwner);
end;

function TdsUpdaterClient.getFileList: TJSONObject;
begin
  if FgetFileListCommand = nil then
  begin
    FgetFileListCommand := FDBXConnection.CreateCommand;
    FgetFileListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetFileListCommand.Text := 'TdsUpdater.getFileList';
    FgetFileListCommand.Prepare;
  end;
  FgetFileListCommand.ExecuteUpdate;
  Result := TJSONObject(FgetFileListCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

constructor TdsUpdaterClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsUpdaterClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsUpdaterClient.Destroy;
begin
  FdownloadCommand.DisposeOf;
  FgetFileListCommand.DisposeOf;
  inherited;
end;

constructor TStammModClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TStammModClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TStammModClient.Destroy;
begin
  inherited;
end;

function TdsPKIClient.uploadKeys(net: string; pub: TStream; priv: TStream): TJSONObject;
begin
  if FuploadKeysCommand = nil then
  begin
    FuploadKeysCommand := FDBXConnection.CreateCommand;
    FuploadKeysCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FuploadKeysCommand.Text := 'TdsPKI.uploadKeys';
    FuploadKeysCommand.Prepare;
  end;
  FuploadKeysCommand.Parameters[0].Value.SetWideString(net);
  FuploadKeysCommand.Parameters[1].Value.SetStream(pub, FInstanceOwner);
  FuploadKeysCommand.Parameters[2].Value.SetStream(priv, FInstanceOwner);
  FuploadKeysCommand.ExecuteUpdate;
  Result := TJSONObject(FuploadKeysCommand.Parameters[3].Value.GetJSONValue(FInstanceOwner));
end;

function TdsPKIClient.getPublicKey(net: string; stamp: TDateTime): TStream;
begin
  if FgetPublicKeyCommand = nil then
  begin
    FgetPublicKeyCommand := FDBXConnection.CreateCommand;
    FgetPublicKeyCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetPublicKeyCommand.Text := 'TdsPKI.getPublicKey';
    FgetPublicKeyCommand.Prepare;
  end;
  FgetPublicKeyCommand.Parameters[0].Value.SetWideString(net);
  FgetPublicKeyCommand.Parameters[1].Value.AsDateTime := stamp;
  FgetPublicKeyCommand.ExecuteUpdate;
  Result := FgetPublicKeyCommand.Parameters[2].Value.GetStream(FInstanceOwner);
end;

function TdsPKIClient.getPrivateKey: TStream;
begin
  if FgetPrivateKeyCommand = nil then
  begin
    FgetPrivateKeyCommand := FDBXConnection.CreateCommand;
    FgetPrivateKeyCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetPrivateKeyCommand.Text := 'TdsPKI.getPrivateKey';
    FgetPrivateKeyCommand.Prepare;
  end;
  FgetPrivateKeyCommand.ExecuteUpdate;
  Result := FgetPrivateKeyCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TdsPKIClient.hasValidKey(net: string; stamp: TDateTime): Boolean;
begin
  if FhasValidKeyCommand = nil then
  begin
    FhasValidKeyCommand := FDBXConnection.CreateCommand;
    FhasValidKeyCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FhasValidKeyCommand.Text := 'TdsPKI.hasValidKey';
    FhasValidKeyCommand.Prepare;
  end;
  FhasValidKeyCommand.Parameters[0].Value.SetWideString(net);
  FhasValidKeyCommand.Parameters[1].Value.AsDateTime := stamp;
  FhasValidKeyCommand.ExecuteUpdate;
  Result := FhasValidKeyCommand.Parameters[2].Value.GetBoolean;
end;

constructor TdsPKIClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsPKIClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsPKIClient.Destroy;
begin
  FuploadKeysCommand.DisposeOf;
  FgetPublicKeyCommand.DisposeOf;
  FgetPrivateKeyCommand.DisposeOf;
  FhasValidKeyCommand.DisposeOf;
  inherited;
end;

procedure TdsDairyClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FDBXConnection.CreateCommand;
    FDSServerModuleCreateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDSServerModuleCreateCommand.Text := 'TdsDairy.DSServerModuleCreate';
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

procedure TdsDairyClient.DITabBeforePost(DataSet: TDataSet);
begin
  if FDITabBeforePostCommand = nil then
  begin
    FDITabBeforePostCommand := FDBXConnection.CreateCommand;
    FDITabBeforePostCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDITabBeforePostCommand.Text := 'TdsDairy.DITabBeforePost';
    FDITabBeforePostCommand.Prepare;
  end;
  FDITabBeforePostCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FDITabBeforePostCommand.ExecuteUpdate;
end;

procedure TdsDairyClient.DataQryBeforeOpen(DataSet: TDataSet);
begin
  if FDataQryBeforeOpenCommand = nil then
  begin
    FDataQryBeforeOpenCommand := FDBXConnection.CreateCommand;
    FDataQryBeforeOpenCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDataQryBeforeOpenCommand.Text := 'TdsDairy.DataQryBeforeOpen';
    FDataQryBeforeOpenCommand.Prepare;
  end;
  FDataQryBeforeOpenCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FDataQryBeforeOpenCommand.ExecuteUpdate;
end;

constructor TdsDairyClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsDairyClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsDairyClient.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FDITabBeforePostCommand.DisposeOf;
  FDataQryBeforeOpenCommand.DisposeOf;
  inherited;
end;

function TdsStorageClient.AutoInc(gen: string): Integer;
begin
  if FAutoIncCommand = nil then
  begin
    FAutoIncCommand := FDBXConnection.CreateCommand;
    FAutoIncCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoIncCommand.Text := 'TdsStorage.AutoInc';
    FAutoIncCommand.Prepare;
  end;
  FAutoIncCommand.Parameters[0].Value.SetWideString(gen);
  FAutoIncCommand.ExecuteUpdate;
  Result := FAutoIncCommand.Parameters[1].Value.GetInt32;
end;

function TdsStorageClient.newStorage(data: TJSONObject): TJSONObject;
begin
  if FnewStorageCommand = nil then
  begin
    FnewStorageCommand := FDBXConnection.CreateCommand;
    FnewStorageCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FnewStorageCommand.Text := 'TdsStorage.newStorage';
    FnewStorageCommand.Prepare;
  end;
  FnewStorageCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FnewStorageCommand.ExecuteUpdate;
  Result := TJSONObject(FnewStorageCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TdsStorageClient.renameStorage(data: TJSONObject): TJSONObject;
begin
  if FrenameStorageCommand = nil then
  begin
    FrenameStorageCommand := FDBXConnection.CreateCommand;
    FrenameStorageCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FrenameStorageCommand.Text := 'TdsStorage.renameStorage';
    FrenameStorageCommand.Prepare;
  end;
  FrenameStorageCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FrenameStorageCommand.ExecuteUpdate;
  Result := TJSONObject(FrenameStorageCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TdsStorageClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TdsStorageClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdsStorageClient.Destroy;
begin
  FAutoIncCommand.DisposeOf;
  FnewStorageCommand.DisposeOf;
  FrenameStorageCommand.DisposeOf;
  inherited;
end;

procedure TTdsPluginClient.TabPluginBeforePost(DataSet: TDataSet);
begin
  if FTabPluginBeforePostCommand = nil then
  begin
    FTabPluginBeforePostCommand := FDBXConnection.CreateCommand;
    FTabPluginBeforePostCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FTabPluginBeforePostCommand.Text := 'TTdsPlugin.TabPluginBeforePost';
    FTabPluginBeforePostCommand.Prepare;
  end;
  FTabPluginBeforePostCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FTabPluginBeforePostCommand.ExecuteUpdate;
end;

function TTdsPluginClient.getList: TJSONObject;
begin
  if FgetListCommand = nil then
  begin
    FgetListCommand := FDBXConnection.CreateCommand;
    FgetListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetListCommand.Text := 'TTdsPlugin.getList';
    FgetListCommand.Prepare;
  end;
  FgetListCommand.ExecuteUpdate;
  Result := TJSONObject(FgetListCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TTdsPluginClient.download(data: TJSONObject): TStream;
begin
  if FdownloadCommand = nil then
  begin
    FdownloadCommand := FDBXConnection.CreateCommand;
    FdownloadCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdownloadCommand.Text := 'TTdsPlugin.download';
    FdownloadCommand.Prepare;
  end;
  FdownloadCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FdownloadCommand.ExecuteUpdate;
  Result := FdownloadCommand.Parameters[1].Value.GetStream(FInstanceOwner);
end;

function TTdsPluginClient.upload(data: TJSONObject; st: TStream): TJSONObject;
begin
  if FuploadCommand = nil then
  begin
    FuploadCommand := FDBXConnection.CreateCommand;
    FuploadCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FuploadCommand.Text := 'TTdsPlugin.upload';
    FuploadCommand.Prepare;
  end;
  FuploadCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FuploadCommand.Parameters[1].Value.SetStream(st, FInstanceOwner);
  FuploadCommand.ExecuteUpdate;
  Result := TJSONObject(FuploadCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TTdsPluginClient.setStatus(data: TJSONObject): TJSONObject;
begin
  if FsetStatusCommand = nil then
  begin
    FsetStatusCommand := FDBXConnection.CreateCommand;
    FsetStatusCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FsetStatusCommand.Text := 'TTdsPlugin.setStatus';
    FsetStatusCommand.Prepare;
  end;
  FsetStatusCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FsetStatusCommand.ExecuteUpdate;
  Result := TJSONObject(FsetStatusCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TTdsPluginClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TTdsPluginClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TTdsPluginClient.Destroy;
begin
  FTabPluginBeforePostCommand.DisposeOf;
  FgetListCommand.DisposeOf;
  FdownloadCommand.DisposeOf;
  FuploadCommand.DisposeOf;
  FsetStatusCommand.DisposeOf;
  inherited;
end;

procedure TDSImportClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FDBXConnection.CreateCommand;
    FDSServerModuleCreateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDSServerModuleCreateCommand.Text := 'TDSImport.DSServerModuleCreate';
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

function TDSImportClient.startImport: TJSONObject;
begin
  if FstartImportCommand = nil then
  begin
    FstartImportCommand := FDBXConnection.CreateCommand;
    FstartImportCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FstartImportCommand.Text := 'TDSImport.startImport';
    FstartImportCommand.Prepare;
  end;
  FstartImportCommand.ExecuteUpdate;
  Result := TJSONObject(FstartImportCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TDSImportClient.importTask(data: TJSONObject; st: TStream): TJSONObject;
begin
  if FimportTaskCommand = nil then
  begin
    FimportTaskCommand := FDBXConnection.CreateCommand;
    FimportTaskCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FimportTaskCommand.Text := 'TDSImport.importTask';
    FimportTaskCommand.Prepare;
  end;
  FimportTaskCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FimportTaskCommand.Parameters[1].Value.SetStream(st, FInstanceOwner);
  FimportTaskCommand.ExecuteUpdate;
  Result := TJSONObject(FimportTaskCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TDSImportClient.uploadFile(data: TJSONObject; st: TStream): TJSONObject;
begin
  if FuploadFileCommand = nil then
  begin
    FuploadFileCommand := FDBXConnection.CreateCommand;
    FuploadFileCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FuploadFileCommand.Text := 'TDSImport.uploadFile';
    FuploadFileCommand.Prepare;
  end;
  FuploadFileCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FuploadFileCommand.Parameters[1].Value.SetStream(st, FInstanceOwner);
  FuploadFileCommand.ExecuteUpdate;
  Result := TJSONObject(FuploadFileCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TDSImportClient.endImport(data: TJSONObject): TJSONObject;
begin
  if FendImportCommand = nil then
  begin
    FendImportCommand := FDBXConnection.CreateCommand;
    FendImportCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FendImportCommand.Text := 'TDSImport.endImport';
    FendImportCommand.Prepare;
  end;
  FendImportCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FendImportCommand.ExecuteUpdate;
  Result := TJSONObject(FendImportCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TDSImportClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TDSImportClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TDSImportClient.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FstartImportCommand.DisposeOf;
  FimportTaskCommand.DisposeOf;
  FuploadFileCommand.DisposeOf;
  FendImportCommand.DisposeOf;
  inherited;
end;

function TDSMailClient.setMailStatus(data: TJSONObject): TJSONObject;
begin
  if FsetMailStatusCommand = nil then
  begin
    FsetMailStatusCommand := FDBXConnection.CreateCommand;
    FsetMailStatusCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FsetMailStatusCommand.Text := 'TDSMail.setMailStatus';
    FsetMailStatusCommand.Prepare;
  end;
  FsetMailStatusCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FsetMailStatusCommand.ExecuteUpdate;
  Result := TJSONObject(FsetMailStatusCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TDSMailClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TDSMailClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TDSMailClient.Destroy;
begin
  FsetMailStatusCommand.DisposeOf;
  inherited;
end;

end.

