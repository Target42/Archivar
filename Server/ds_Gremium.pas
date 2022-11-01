unit ds_Gremium;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, System.JSON, m_glob_server,
  Datasnap.Provider, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  [TRoleAuth('user,admin', 'download')]
  TdsGremium = class(TDSServerModule)
    GRTab: TDataSetProvider;
    AllUserQry: TDataSetProvider;
    GrUserQry: TDataSetProvider;
    Images: TDataSetProvider;
    GremiumTab: TFDTable;
    FDTransaction1: TFDTransaction;
    AutoIncQry: TFDQuery;
    PicTab: TFDTable;
    GRPE: TFDTable;
    FindMAQry: TFDQuery;
    AddMAQry: TFDQuery;
    RemoveMAQry: TFDQuery;
    changeRollQry: TFDQuery;
    SelectAllUserQry: TFDQuery;
    SelectGrUserQry: TFDQuery;
    TY: TFDTable;
    TYTab: TDataSetProvider;
    GRTY: TFDTable;
    GRTYTab: TDataSetProvider;
    procedure GremiumTabBeforePost(DataSet: TDataSet);
  private

  public
    function ImportGremiumCSV( st : TStream ) : TJSONObject;
    function ExportGremiumCSV : TStream;

    function AutoInc( gen : string ) : integer;

    procedure AddMA( grid, id: integer );
    procedure RemoveMA( grid, id: integer );
    procedure changeRoll( grid, id: integer; roll : string);
  end;

implementation

uses
  u_json, system.variants;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsGremium }


procedure TdsGremium.AddMA(grid, id: integer);
var
  canAdd : boolean;
begin
  FindMAQry.ParamByName('gr_id').AsInteger := grid;
  FindMAQry.ParamByName('pe_id').AsInteger := id;
  FindMAQry.Open;
  canAdd := FindMAQry.IsEmpty;
  FindMAQry.Close;

  if canAdd then
  begin
    AddMAQry.ParamByName('gr_id').AsInteger := grid;
    AddMAQry.ParamByName('pe_id').AsInteger := id;
    AddMAQry.ExecSQL;
  end;

  if AddMAQry.Transaction.Active then
    AddMAQry.Transaction.Commit;
end;

function TdsGremium.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;
end;


procedure TdsGremium.changeRoll(grid, id: integer; roll: string);
begin
  changeRollQry.ParamByName('gr_id').AsInteger := grid;
  changeRollQry.ParamByName('pe_id').AsInteger := id;
  changeRollQry.ParamByName('rolle').AsString   := roll;
  changeRollQry.ExecSQL;

  if changeRollQry.Transaction.Active then
    changeRollQry.Transaction.Commit;
end;

function TdsGremium.ExportGremiumCSV: TStream;
begin
  Result := NIL;
end;

procedure TdsGremium.GremiumTabBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('GR_ID').AsInteger = 0 then
    DataSet.FieldByName('GR_ID').AsInteger := AutoInc('gen_GR_ID');
end;

function TdsGremium.ImportGremiumCSV(st: TStream): TJSONObject;
var
  list : TStringList;
  line : TStringList;
  mem  : TMemoryStream;
  i    : integer;
  opts : TLocateOptions;
  key  : string;
  impCount : integer;
begin
  Result := TJSONObject.Create;

  if GremiumTab.Transaction.Active then
    GremiumTab.Transaction.Rollback;

  mem := GM.downloadMem(st);
  if not Assigned(mem) then
  begin
    JResponse( Result, false, 'file upload failed!');

    exit;
  end;
  list   := TStringList.Create;
  line   := TStringList.Create;
  line.StrictDelimiter := true;
  line.Delimiter := ';';
  impCount := 0;

  list.LoadFromStream(mem);
  mem.Free;

  GremiumTab.Transaction.StartTransaction;
  GremiumTab.Open;

  for i := 1 to pred(list.Count) do
  begin
    line.DelimitedText := list.Strings[i];
    if line.Count>=2 then
    begin
      key := UpperCase(Trim(line.Strings[0]));
      if not GremiumTab.Locate('GR_SHORT', VarArrayOf([key]), opts) then
      begin
        GremiumTab.Append;
        GremiumTab.FieldByName('GR_ID').AsInteger := AutoInc('gen_GR_ID');
        GremiumTab.FieldByName('GR_SHORT').AsString := key;
        GremiumTab.FieldByName('GR_NAME').AsString:= Trim(line.Strings[1]);
        if line.Count>=3 then
          GremiumTab.FieldByName('GR_PARENT_SHORT').AsString:= Trim(line.Strings[2]);
        if line.Count >= 4 then
          GremiumTab.FieldByName('GR_PIC_NAME').AsString:= Trim(line.Strings[3]);

        GremiumTab.Post;
        inc(impCount);
      end;
    end;
  end;
  if GremiumTab.Transaction.Active then
    GremiumTab.Transaction.Commit;
  GremiumTab.Close;

  line.Free;
  list.Free;
  JResponse( Result, true, 'Import : '+Inttostr(impCount));
end;

procedure TdsGremium.RemoveMA(grid, id: integer);
var
  canDel : boolean;
begin
  FindMAQry.ParamByName('gr_id').AsInteger := grid;
  FindMAQry.ParamByName('pe_id').AsInteger := id;
  FindMAQry.Open;
  canDel := not FindMAQry.IsEmpty;
  FindMAQry.Close;

  if canDel then
  begin
    RemoveMAQry.ParamByName('gr_id').AsInteger := grid;
    RemoveMAQry.ParamByName('pe_id').AsInteger := id;
    RemoveMAQry.ExecSQL;

  end;
  if RemoveMAQry.Transaction.Active then
    RemoveMAQry.Transaction.Commit;
end;

end.

