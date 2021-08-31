unit ds_textblock;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB, IBX.IBCustomDataSet, IBX.IBTable, IBX.IBDatabase, IBX.IBQuery,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  [TRoleAuth('user,admin', 'download')]
  TdsTextBlock = class(TDSServerModule)
    TBTab: TDataSetProvider;
    DelTB: TDataSetProvider;
    IBTransaction1: TFDTransaction;
    TB: TFDTable;
    DelQry: TFDQuery;
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

