unit ds_taskEdit;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  [TRoleAuth('user,admin', 'download')]
  TdsTaskEdit = class(TDSServerModule)
    DATab: TDataSetProvider;
    IBTransaction1: TFDTransaction;
    DataField: TFDTable;
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

