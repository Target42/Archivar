unit ds_chapter;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet, IBX.IBTable, IBX.IBQuery;

type
  TdsChapter = class(TDSServerModule)
    Chapter: TIBTable;
    IBTransaction1: TIBTransaction;
    ChapterTab: TDataSetProvider;
    TACp: TIBQuery;
    DataSetProvider1: TDataSetProvider;
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

