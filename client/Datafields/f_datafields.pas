unit f_datafields;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, fr_base, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TDataFieldForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    DATab: TClientDataSet;
    DASrc: TDataSource;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
  public
    { Public-Deklarationen }
  end;

var
  DataFieldForm: TDataFieldForm;

implementation

uses
  m_glob_client, f_datafield_edit;

var
  DatafieldEditform : TDatafieldEditform;
{$R *.dfm}

procedure TDataFieldForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  if DATab.UpdatesPending then
    DATab.ApplyUpdates(-1);
end;

procedure TDataFieldForm.BitBtn1Click(Sender: TObject);
begin
  try
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);
    DATab.Append;
    DatafieldEditform.IsGlobal := true;
    DatafieldEditform.DataSet := DATab;
    if DatafieldEditform.ShowModal = mrOk then
    begin
      DATab.Post;
    end
    else
      DATab.Cancel;
  finally
    DatafieldEditform.free;
  end;
end;

procedure TDataFieldForm.BitBtn2Click(Sender: TObject);
begin
  if DATab.IsEmpty then
    exit;

  try
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);
    DATab.Edit;
    DatafieldEditform.IsGlobal := true;
    DatafieldEditform.DataSet := DATab;
    if DatafieldEditform.ShowModal = mrOk then
      DATab.Post
    else
      DATab.Cancel;
  finally
    DatafieldEditform.free;
  end;
end;

procedure TDataFieldForm.BitBtn3Click(Sender: TObject);
begin
  if DATab.IsEmpty then
    exit;
  if (MessageDlg('Soll das Datenfeld "'+DATab.FieldByName('DA_NAME').AsString+
      '" wirklich gelöscht werden?', mtConfirmation, [mbYes, mbNo], 0) in [mrYes, mrNo, mrNone]) then
  begin
    DATab.Delete;
  end;
end;

procedure TDataFieldForm.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn2.Click;
end;

procedure TDataFieldForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  DATab.Open;
end;

procedure TDataFieldForm.FormDestroy(Sender: TObject);
begin
  if DATab.UpdatesPending then
    DATab.CancelUpdates;

  DATab.Close;
end;

end.
