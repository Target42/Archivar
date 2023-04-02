unit ds_import;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, m_db, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider, Datasnap.DSSession;

type
  TDSImport = class(TDSServerModule)
    IBTransaction1: TFDTransaction;
    AutoIncQry: TFDQuery;
    Task: TFDTable;
    TaskTab: TDataSetProvider;
    Template: TFDTable;
    GRTab: TFDTable;
    TOTab: TFDTable;
    findTaskQry: TFDQuery;
    CreateDirQry: TFDQuery;
    FileData: TFDTable;
    UpdateDirSum: TFDQuery;
    UpdateTask: TFDQuery;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    const
      TOKEN_KEY = 'import_token';
  private
    m_session : TDSSession;

    function checkSessionToken( token : string ) : boolean;
    function autoInc( name : string ) : integer;
    function TemplateByName( name : string ; var teid, tyid : integer ) : boolean;
    function GremiumByShortName( name : string; var grid : integer ) : boolean;
    procedure sendNotify( grid, taid : integer; assign : boolean );
  public

    function startImport : TJSONObject;

    function importTask( data : TJSONObject; st : TStream ) : TJSONObject;
    function uploadFile( data : TJSONObject; st : TStream ) : TJSONObject;

    function endImport( data : TJSONObject ): TJSONObject;
  end;

implementation

uses
  System.Variants, u_json, System.Win.ComObj, m_glob_server, u_Konst,
  ServerContainerUnit1;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDSImport }

function TDSImport.autoInc(name: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+name+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;

end;

function TDSImport.checkSessionToken( token : string ): boolean;
begin
  Result := not token.IsEmpty;

  if Result then begin
    Result := m_session.HasData(TOKEN_KEY);
    if Result then
      Result := token = m_session.GetData(TOKEN_KEY);
  end;
end;

procedure TDSImport.DSServerModuleCreate(Sender: TObject);
begin
  m_session := TDSSessionManager.GetThreadSession;
end;

function TDSImport.endImport(data: TJSONObject): TJSONObject;
var
  taid, grid : integer;
begin
  Result := TJSONObject.Create;
  if not m_session.HasData(TOKEN_KEY) then begin
    JResponse(Result, false, 'Es ist kein Import aktiv!.');
    exit;

  end;
  if not checkSessionToken(JString( data, 'token')) then begin
    JResponse(Result, false, 'Das ist nicht das gültige Import-Token.');
    exit;
  end;
  taid := StrToIntDef( m_session.GetData('import_ta_id'), 0 );
  grid := StrToIntDef( m_session.GetData('import_gr_id'), 0 );


  m_session.RemoveData(TOKEN_KEY);
  m_session.RemoveData('import_ta_id');
  m_session.RemoveData('import_gr_id');

  sendNotify(grid, taid, true);
  JResult(Result, true, '');
end;

function TDSImport.GremiumByShortName(name: string; var grid: integer): boolean;
begin
  grid := -1;
  GRTab.Open;
  if GRTab.Locate('GR_PARENT_SHORT', VarArrayOf(['']), [loCaseInsensitive]) then
    grid := GRTab.FieldByName('GR_ID').AsInteger;

  if (grid <> -1) and GRTab.Locate('GR_SHORT', VarArrayOf([name]), [loCaseInsensitive]) then
    grid := GRTab.FieldByName('GR_ID').AsInteger;
  GRTab.Close;

  Result := grid <> -1;
end;

function TDSImport.importTask(data: TJSONObject; st: TStream): TJSONObject;
var
  teid, tyid : integer;
  grid       : integer;
  dst   : TStream;
  s : string;
begin
  Result := TJSONObject.Create;

  if not checkSessionToken(JString( data, 'token')) then begin
    JResponse(Result, false, 'Das ist nicht das gültige Import-Token.');
    exit;
  end;

  s := JString(data, 'Gremium');
  if not GremiumByShortName(s, grid) then begin
    JResponse(Result, false, 'Das Gremium wurde nicht gefunden!');
    exit;
  end;

  s := JString(data, 'Template');
  if not TemplateByName(s, teid, tyid) then begin
    JResponse(Result, false, 'Die Vorlage wurde nicht gefunden!');
    exit;
  end;

  Task.Open;
  TOTab.Open;
  try
    Task.Append;

    Task.FieldByName('TE_ID').AsInteger       := teid;
    Task.FieldByName('TA_ID').AsInteger       := autoInc('gen_ta_id');
    Task.FieldByName('TY_ID').AsInteger       := tyid;
    Task.FieldByName('TA_STARTED').AsDateTime := StrToDateTimeDef( JString(data, 'Gestartet' ), now );
    Task.FieldByName('TA_CREATED').AsDateTime := now;
    Task.FieldByName('TA_NAME').AsString      := JString(data, 'Titel' );
    Task.FieldByName('TA_TERMIN').AsDateTime  := StrToDateTimeDef( JString(data, 'Termin' ), now + 7.0 );
    Task.FieldByName('TA_CLID').AsString      := CreateClassID;
    Task.FieldByName('TA_STATUS').AsString    := JString( data, 'Status', 'Importiert');
    Task.FieldByName('TA_REM').AsString       := JString( data, 'Kommentar');
    Task.FieldByName('TA_BEARBEITER').AsString:= JString( data, 'Antragsteller');
    if JString(data, 'Erfasst') = '' then
      Task.FieldByName('TA_CREATED_BY').AsString:= GM.getNameFromSession
    else
      Task.FieldByName('TA_CREATED_BY').AsString:= JString(data, 'Erfasst');

    dst := Task.CreateBlobStream(Task.FieldByName('TA_DATA'),bmWrite );
    GM.downloadInto(st, dst);
    dst.Free;

    Task.Post;

    TOTab.Append;
    TOTab.FieldByName('TA_ID').AsInteger := Task.FieldByName('TA_ID').AsInteger;
    TOTab.FieldByName('GR_ID').AsInteger := grid;
    TOTab.Post;

    m_session.PutData('import_ta_id', Task.FieldByName('TA_ID').AsString);
    m_session.PutData('import_gr_id', IntToStr( grid ) );

    JReplace( Result, 'id',  Task.FieldByName('TA_ID').AsInteger );
    JResult( Result, true, 'Import ok');
  except
    on e : exception do begin
      Task.Cancel;
      Task.Transaction.Rollback;
      JResponse(Result, false, e.ToString);
    end;
  end;
  Task.Close;
  TOTab.Close;

  if Task.Transaction.Active then
    Task.Transaction.Commit;
end;

procedure TDSImport.sendNotify(grid, taid: integer; assign: boolean);
var
  msg : TJSONObject;
begin
  if (grid = 0 ) or (taid = 0 )then exit;

  msg := TJSONObject.Create;
  JAction(  msg, BRD_TASK_ASSIGN);
  JReplace( msg, 'taid', taid);
  JReplace( msg, 'grid', grid);
  JReplace( msg, 'assign', assign );
  ArchivService.BroadcastMessage(BRD_CHANNEL, msg);
end;

function TDSImport.startImport: TJSONObject;
var
  token : string;
begin
  Result := TJSONObject.Create;
  if m_session.HasData(TOKEN_KEY) then begin
    JResponse( Result, false, 'Es ist noch ein Import aktiv!');
    exit;
  end;

  token := CreateClassID;
  m_session.PutData(TOKEN_KEY, token);
  JReplace( Result, 'token', token);

  JResponse(Result, true, 'Import gestartet.');
end;

function TDSImport.TemplateByName(name: string; var teid,
  tyid: integer): boolean;
begin
  Template.Open;
  Result := Template.Locate('TE_NAME', VarArrayOf([name]), [loCaseInsensitive]);
  if Result then begin
    teid := Template.FieldByName('TE_ID').AsInteger;
    tyid := Template.FieldByName('TY_ID').AsInteger;
  end;
  Template.Close;
end;

function TDSImport.uploadFile(data: TJSONObject; st: TStream): TJSONObject;
var
  drid  : integer;
  fiid  : integer;
  taid  : integer;
  bst   : TStream;
begin
  Result := TJSONObject.Create;
  if not checkSessionToken(JString( data, 'token')) then begin
    JResponse(Result, false, 'Das ist nicht das gültige Import-Token.');
    exit;
  end;

  drid := -1;
  taid := JInt(data, 'id', -1);

  findTaskQry.ParamByName('TA_ID').AsInteger := taid;
  findTaskQry.open;
  if not findTaskQry.IsEmpty then begin
    drid := findTaskQry.FieldByName('DR_ID').AsInteger;
  end;
  findTaskQry.Close;

  if drid = -1 then begin
    JResult(Result, false, 'Die Aufgabe wurde nicht gefunden!');
    exit;
  end;

  if drid = 0 then begin
    drid := AutoInc('gen_dr_id');
    CreateDirQry.ParamByName('DR_ID').AsInteger     := drid;
    CreateDirQry.ParamByName('DR_GROUP').AsInteger  := drid;

    CreateDirQry.ExecSQL;

    UpdateTask.ParamByName('DR_ID').AsInteger := drid;
    UpdateTask.ParamByName('TA_ID').AsInteger := taid;
    UpdateTask.ExecSQL;
  end;

  FileData.Open;
  fiid  := AutoInc('gen_fi_id');
  try
    FileData.Append;
    FileData.FieldByName('FI_ID').AsInteger        := fiid;
    FileData.FieldByName('DR_ID').AsInteger        := drid;
    FileData.FieldByName('FI_NAME').AsString       := JString( data, 'fname');
    FileData.FieldByName('FI_TYPE').AsString       := JString( data, 'type');
    FileData.FieldByName('FI_CREATED').AsDateTime  := now;
    FileData.FieldByName('FI_TODELETE').AsDateTime := IncMonth(now, JInt( data, 'todelete', 6));
    FileData.FieldByName('FI_VERSION').AsInteger   := 1;
    FileData.FieldByName('FI_CREATED_BY').AsString := GM.getNameFromSession;

    FileData.FieldByName('PE_ID').AsInteger        := GM.getIDFromSession;

    bst := FileData.CreateBlobStream( FileData.FieldByName('FI_DATA'), bmWrite);
    FileData.FieldByName('FI_SIZE').AsLargeInt := GM.CopyStream( st, bst);
    bst.Free;
    FileData.Post;

    JResult( Result, true, '');
  except
    on e : exception do begin
      JResult( Result, false, e.ToString );
      if IBTransaction1.Active then
        IBTransaction1.Rollback;
    end;
  end;

  UpdateDirSum.ParamByName('id').AsInteger := drid;
  UpdateDirSum.ExecSQL;

  if UpdateDirSum.Transaction.Active then
    UpdateDirSum.Transaction.Commit;

  FileData.Close;
end;

end.

