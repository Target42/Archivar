unit ds_dairy;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DSSession,
  Datasnap.Provider, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  TdsDairy = class(TDSServerModule)
    DITab: TFDTable;
    FDTransaction1: TFDTransaction;
    DISrc: TDataSetProvider;
    DataQry: TFDQuery;
    DataSrc: TDataSetProvider;
    procedure DSServerModuleCreate(Sender: TObject);
    procedure DITabBeforePost(DataSet: TDataSet);
    procedure DataQryBeforeOpen(DataSet: TDataSet);
  private
    m_id : integer;
  public
    { Public-Deklarationen }
  end;

implementation

uses
  Grijjy.CloudLogging;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdsDairy.DataQryBeforeOpen(DataSet: TDataSet);
begin
  GrijjyLog.EnterMethod(self, 'DataQryBeforeOpen');

  DataQry.ParamByName('PE_ID').AsInteger := m_id;
  GrijjyLog.Send('ID', DataQry.ParamByName('PE_ID').AsInteger );
  GrijjyLog.Send('start',   DataQry.ParamByName('start').AsString );
  GrijjyLog.Send('ende',    DataQry.ParamByName('ende').AsString );


  GrijjyLog.ExitMethod(self, 'DataQryBeforeOpen');
end;

procedure TdsDairy.DITabBeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('PE_ID').AsInteger := m_id;
end;

procedure TdsDairy.DSServerModuleCreate(Sender: TObject);
var
  Session : TDSSession;
begin
  Session := TDSSessionManager.GetThreadSession;

  m_id := StrToIntDef( Session.GetData('id'), -1 );
  DataQry.ParamByName('PE_ID').AsInteger := m_id;

end;

end.

