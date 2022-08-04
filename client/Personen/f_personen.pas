unit f_personen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Datasnap.DBClient, Datasnap.DSConnect, Vcl.DBGrids, Vcl.Grids;

type
  TPersonenForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    OpenDialog1: TOpenDialog;
    DBGrid1: TDBGrid;
    DSProviderConnection1: TDSProviderConnection;
    PETab: TClientDataSet;
    PESrc: TDataSource;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    procedure refreshDB;
  public
    { Public declarations }
  end;

var
  PersonenForm: TPersonenForm;

implementation

uses
  u_stub, m_glob_client, System.JSON, u_json, f_person_edit;

{$R *.dfm}

procedure TPersonenForm.BitBtn1Click(Sender: TObject);
var
  needUpdate : boolean;
begin
  try
    Application.CreateForm(TPersonEditForm, PersonEditForm);
    PersonEditForm.ID := 0;
    needUpdate :=  PersonEditForm.ShowModal = mrOk;
  finally
    PersonEditForm.free;
  end;
  if needUpdate then
    refreshDB;
end;

procedure TPersonenForm.BitBtn2Click(Sender: TObject);
var
  needUpdate : boolean;
begin
  if PETab.IsEmpty then
    exit;
  try
    Application.CreateForm(TPersonEditForm, PersonEditForm);
    PersonEditForm.ID := PETab.FieldByName('PE_ID').AsInteger;
    needUpdate :=  PersonEditForm.ShowModal = mrOk;
  finally
    PersonEditForm.free;
  end;
  if needUpdate then
    refreshDB;
end;

procedure TPersonenForm.BitBtn3Click(Sender: TObject);
var
  client : TdsPersonClient;
  data : TJSONObject;
  st   : TStream;
begin
  if OpenDialog1.Execute then
  begin
    Screen.Cursor :=crHourGlass;
    client := TdsPersonClient.Create(GM.SQLConnection1.DBXConnection);
    try
      st     := TFileStream.Create(OpenDialog1.FileName, fmOpenRead + fmShareDenyWrite);
      data   := client.ImportPersonenCSV(st);
      ShowMessage(JString( data, 'text'));
    finally
      client.Free;
    end;
    refreshDB;
    Screen.Cursor :=crDefault;
  end;
end;

procedure TPersonenForm.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn2.Click;
end;

procedure TPersonenForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  PETab.Open;
end;

procedure TPersonenForm.refreshDB;
var
  id : integer;
  opts : TLocateOptions;
begin
  id := -1;
  if not PETab.IsEmpty then
    id := PETab.FieldByName('PE_ID').AsInteger;

  PETab.Close;
  PETab.Open;
  if id > -1 then
  begin
    PETab.Locate('PE_ID', VarArrayOf([id]), opts);
  end;
end;

end.
