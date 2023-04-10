unit ds_mail;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  m_db, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Datasnap.Provider,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDSMail = class(TDSServerModule)
    FDTransaction1: TFDTransaction;
    Mac: TFDTable;
    Maf: TFDTable;
    MailAccount: TDataSetProvider;
    Mailfolder: TDataSetProvider;
    DataSource1: TDataSource;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

