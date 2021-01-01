unit ds_taskView;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, IBX.IBDatabase,
  Data.DB, IBX.IBCustomDataSet, IBX.IBQuery, Datasnap.Provider, IBX.IBTable;

type
  TdsTaskView = class(TDSServerModule)
    GetTA: TIBQuery;
    GetTE: TIBQuery;
    IBTransaction1: TIBTransaction;
    GetTAQry: TDataSetProvider;
    GetTEQry: TDataSetProvider;
    Task: TIBTable;
    TaskTab: TDataSetProvider;
    BE: TIBTable;
    BETab: TDataSetProvider;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

uses
  m_glob_server, m_db;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.

