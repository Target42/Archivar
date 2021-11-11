unit ds_template;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  System.JSON;

type
  [TRoleAuth('user,admin', 'download')]
  TdsTemplate = class(TDSServerModule)
    TemplateTab: TDataSetProvider;
    ListTempatesQry: TDataSetProvider;
    DataFields: TDataSetProvider;
    TYTab: TDataSetProvider;
    IBTransaction2: TFDTransaction;
    DaTab: TFDTable;
    IBTransaction1: TFDTransaction;
    TETab: TFDTable;
    SearchTab: TFDTable;
    TaskType: TFDTable;
    TEQry: TFDQuery;
    AutoIncQry: TFDQuery;
    FindCLIDQry: TFDQuery;
  private
    { Private-Deklarationen }
  public
    function AutoInc( gen : string ) : integer;
    function hasName( name : string ) : boolean;
    function getSysTemplates : TJSONObject;
  end;

implementation

uses
  m_db, System.Types, u_json;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsTemplate }

function TdsTemplate.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;

end;

function TdsTemplate.getSysTemplates: TJSONObject;
var
  RS  : TResourceStream;
  i   : integer;
  obj : TJSONObject;
  row : TJSONObject;
  arr : TJSONArray;

  temp: TJSONArray;
  line: TJSONObject;

begin
  RS := TResourceStream.Create(HInstance, 'systemTemplates', RT_RCDATA);
  obj := loadJSON( rs );
  rs.Free;

  Result := TJSONObject.Create;
  temp   := TJSONArray.Create;
  if Assigned(obj) then begin
    if FindCLIDQry.Transaction.Active then
      FindCLIDQry.Transaction.Rollback;

    arr := JArray( obj, 'templates');
    if Assigned(arr) then begin
      for i := 0 to pred(arr.Count) do begin
        row := getRow(arr, i);
        line := row.Clone as TJSONObject;

        FindCLIDQry.ParamByName('clid').AsString := JString( row, 'clid');
        FindCLIDQry.Open();
        JReplace( line, 'exists', FindCLIDQry.IsEmpty = false);
        FindCLIDQry.Close;
        temp.Add(line);
      end;
    end;
    obj.Free;

    if FindCLIDQry.Transaction.Active then
      FindCLIDQry.Transaction.Commit;
  end;
  JReplace( Result, 'templates', temp);
end;

function TdsTemplate.hasName(name: string): boolean;
begin
  Result := false;

  SearchTab.Open;
  SearchTab.First;
  while (SearchTab.Eof = false) and not Result do begin
    Result := SameText(name, SearchTab.FieldByName('TE_NAME').AsString);
    SearchTab.Next;
  end;
  SearchTab.Close;
end;

end.

