unit ds_taskView;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  Data.DB, Datasnap.Provider,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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

uses
  m_glob_server, m_db;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.

