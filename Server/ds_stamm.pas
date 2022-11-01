unit ds_stamm;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt,
  Datasnap.Provider, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  TStammMod = class(TDSServerModule)
    FDTransaction1: TFDTransaction;
    TaskType: TFDTable;
    TYTab: TDataSetProvider;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation



{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

