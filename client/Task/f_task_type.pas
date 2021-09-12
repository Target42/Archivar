unit f_task_type;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, fr_base, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TTaskTypeForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    TYTab: TClientDataSet;
    DBGrid1: TDBGrid;
    TYSrc: TDataSource;
    DBNavigator1: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TYTabBeforePost(DataSet: TDataSet);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  TaskTypeForm: TTaskTypeForm;

implementation

uses
  m_glob_client;

{$R *.dfm}

procedure TTaskTypeForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  if TYTab.UpdatesPending then
    TYTab.ApplyUpdates(-1);

end;

procedure TTaskTypeForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  TYTab.Open;
end;

procedure TTaskTypeForm.FormDestroy(Sender: TObject);
begin
  if TYTab.UpdatesPending then
    TYTab.CancelUpdates;
end;

procedure TTaskTypeForm.TYTabBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('TY_ID').IsNull then
    DataSet.FieldByName('TY_ID').AsInteger := GM.autoInc('gen_ty_id');
end;

end.
