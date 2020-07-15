unit ds_template;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet, IBX.IBTable, IBX.IBQuery;

type
  TdsTemplate = class(TDSServerModule)
    TETab: TIBTable;
    IBTransaction1: TIBTransaction;
    TemplateTab: TDataSetProvider;
    TEQry: TIBQuery;
    ListTempatesQry: TDataSetProvider;
    AutoIncQry: TIBQuery;
    SearchTab: TIBTable;
    DaTab: TIBTable;
    IBTransaction2: TIBTransaction;
    DataFields: TDataSetProvider;
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

