unit ds_taskView;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  Data.DB, Datasnap.Provider,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  [TRoleAuth('user,admin', 'download')]
  TdsTaskView = class(TDSServerModule)
    GetTAQry: TDataSetProvider;
    GetTEQry: TDataSetProvider;
    TaskTab: TDataSetProvider;
    BETab: TDataSetProvider;
    GetSysTeQry: TDataSetProvider;
    IBTransaction1: TFDTransaction;
    Task: TFDTable;
    BE: TFDTable;
    GetTA: TFDQuery;
    GetTE: TFDQuery;
    GetSysTe: TFDQuery;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation



{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.

