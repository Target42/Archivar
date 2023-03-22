unit ds_import;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, m_db, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider;

type
  TDSImport = class(TDSServerModule)
    IBTransaction1: TFDTransaction;
    AutoIncQry: TFDQuery;
    Task: TFDTable;
    TaskTab: TDataSetProvider;
    Template: TFDTable;
    GRTab: TFDTable;
    TOTab: TFDTable;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    m_token : string;
    m_grid  : integeR;
    function autoInc( name : string ) : integer;
    function TemplateByName( name : string ; var teid, tyid : integer ) : boolean;
    function GremiumByShortName( name : string; var grid : integer ) : boolean;
  public

    function startImport : TJSONObject;

    function importTask( data : TJSONObject; st : TStream ) : TJSONObject;
    function uploadFile( data : TJSONObject; st : TStream ) : TJSONObject;

    function endImport( data : TJSONObject ): TJSONObject;
  end;

implementation

uses
  System.Variants, u_json, System.Win.ComObj, m_glob_server;

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

procedure TDSImport.DSServerModuleCreate(Sender: TObject);
begin
  m_token := '';
  m_grid  := 0;
end;

function TDSImport.endImport(data: TJSONObject): TJSONObject;
var
  token : string;
begin
  Result := TJSONObject.Create;
  token := trim(JString( data, 'data'));
  if (token = '') or ( m_token <> token) then begin
    JResponse(Result, false, 'Das ist nicht das gültige Import-Token.');
    exit;
  end;
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
  token : string;
  s : string;
begin
  Result := TJSONObject.Create;

  token := trim(JString( data, 'token'));
  if (token = '') or ( m_token <> token) then begin
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
//    Task.FieldByName('DR_ID').AsInteger
    Task.FieldByName('TA_STARTED').AsDateTime := StrToDateTimeDef( JString(data, 'Gestartet' ), now );
    Task.FieldByName('TA_CREATED').AsDateTime := StrToDateTimeDef( JString(data, 'Erfasst' ), now );
    Task.FieldByName('TA_NAME').AsString      := JString(data, 'Titel' );
    Task.FieldByName('TA_TERMIN').AsDateTime  := StrToDateTimeDef( JString(data, 'Termin' ), now + 7.0 );
    Task.FieldByName('TA_CLID').AsString      := CreateClassID;
//    Task.FieldByName('TA_FLAGS').AsInteger    := 0;
    Task.FieldByName('TA_STATUS').AsString    := JString( data, 'Status');
    Task.FieldByName('TA_REM').AsString       := JString( data, 'Kommentar');
    Task.FieldByName('TA_BEARBEITER').AsString:= JString( data, 'Antragsteller');

    dst := Task.CreateBlobStream(Task.FieldByName('TA_DATA'),bmWrite );
    GM.downloadInto(st, dst);
    dst.Free;

    Task.Post;

    TOTab.Append;
    TOTab.FieldByName('TA_ID').AsInteger := Task.FieldByName('TA_ID').AsInteger;
    TOTab.FieldByName('GR_ID').AsInteger := grid;

    TOTab.Post;

    JResult( Result, true, 'Import ok');
    JReplace( Result, 'id',  Task.FieldByName('TA_ID').AsInteger );
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

function TDSImport.startImport: TJSONObject;
begin
  Result := TJSONObject.Create;
  if m_token <> '' then begin
    JResponse( Result, false, 'Es ist noch ein Import aktiv!');
    exit;
  end;

  m_token := CreateClassID;
  JReplace( Result, 'token', m_token);

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
  token : string;
begin
  Result := TJSONObject.Create;
  token := trim(JString( data, 'data'));
  if (token = '') or ( m_token <> token) then begin
    JResponse(Result, false, 'Das ist nicht das gültige Import-Token.');
    exit;
  end;
end;

end.

