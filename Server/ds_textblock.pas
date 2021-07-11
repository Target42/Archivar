unit ds_textblock;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB, IBX.IBCustomDataSet, IBX.IBTable, IBX.IBDatabase, IBX.IBQuery;

type
  [TRoleAuth('user,admin', 'download')]
  TdsTextBlock = class(TDSServerModule)
    IBTransaction1: TIBTransaction;
    TB: TIBTable;
    TBTab: TDataSetProvider;
    DelQry: TIBQuery;
    DelTB: TDataSetProvider;
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

