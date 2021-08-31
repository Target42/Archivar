unit ds_template;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

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
  private
    { Private-Deklarationen }
  public
    function AutoInc( gen : string ) : integer;
    function hasName( name : string ) : boolean;
  end;

implementation

uses
  m_db;

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

