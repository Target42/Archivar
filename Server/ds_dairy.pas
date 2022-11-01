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
    procedure DSServerModuleCreate(Sender: TObject);
    procedure DITabBeforePost(DataSet: TDataSet);
  private
    m_id : integer;
  public
    { Public-Deklarationen }
  end;

implementation



{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

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
  DITab.Filter    := 'PE_ID = '+intToStr(m_id);
  DITab.Filtered  := true;
end;

end.

