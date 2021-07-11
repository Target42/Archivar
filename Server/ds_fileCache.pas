unit ds_fileCache;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet, IBX.IBTable;

type
  [TRoleAuth('user,admin,broadcast', 'download')]
  TdsFileCache = class(TDSServerModule)
    HC: TIBTable;
    IBTransaction1: TIBTransaction;
    HCTab: TDataSetProvider;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

uses
  m_db;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.

