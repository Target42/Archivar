unit f_gremiumForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, m_glob_client, Data.DB,
  Datasnap.DBClient, Datasnap.Provider, Datasnap.DSConnect, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TGremiumForm = class(TForm)
    Frame11: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    GRTab: TClientDataSet;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure refeshDB;
  public
    { Public declarations }
  end;

var
  GremiumForm: TGremiumForm;

implementation

uses
  u_stub, System.JSON, u_json, f_gremium_edit, f_gremium_MA_form;


{$R *.dfm}

procedure TGremiumForm.BitBtn1Click(Sender: TObject);
var
  st : TStream;
  client : TDSGremiumClient;
  data : TJSONObject;
  s : string;
begin
  if not OpenDialog1.Execute then
    exit;
  client := NIL;
  Screen.Cursor := crHourGlass;
  try
    client := TDSGremiumClient.Create(GM.SQLConnection1.DBXConnection);
    st     := TFileStream.Create(OpenDialog1.FileName, fmOpenRead + fmShareDenyWrite);
    data := client.ImportGremiumCSV(st);
    if Assigned(data) then
    begin
      s := JString( data, 'text');
    end;
    GRTab.Close;
    GRTab.Open;
  finally
    client.Free;
  end;
  Screen.Cursor := crDefault;
  ShowMessage(s);
end;

procedure TGremiumForm.BitBtn2Click(Sender: TObject);
var
  needUpdate : Boolean;
begin
  try
    Application.CreateForm(TGremiumEditForm, GremiumEditForm);
    GremiumEditForm.ID := 0;
    needUpdate := GremiumEditForm.ShowModal = mrOk;
  finally
    GremiumEditForm.Free;
  end;
  if needUpdate then
    refeshDB;
end;

procedure TGremiumForm.BitBtn3Click(Sender: TObject);
var
  needUpdate : boolean;
  id : integer;
begin
  if GRTab.IsEmpty then
    exit;

  id := GRTab.FieldByName('GR_ID').AsInteger;
  try
    Application.CreateForm(TGremiumEditForm, GremiumEditForm);
    GremiumEditForm.ID := id;
    needUpdate := GremiumEditForm.ShowModal = mrOk;
  finally
    GremiumEditForm.Free;
  end;
  if needUpdate then
    refeshDB;
end;


procedure TGremiumForm.Button1Click(Sender: TObject);
begin
  if GRTab.IsEmpty then
    exit;

  try
    Application.CreateForm(TGremiumMAForm, GremiumMAForm);
    GremiumMAForm.GremiumTitel := GRTab.FieldByName('GR_NAME').AsString+'('+
      GRTab.FieldByName('GR_SHORT').AsString+')';
    GremiumMAForm.GremiumID := GRTab.FieldByName('GR_ID').AsInteger;
    GremiumMAForm.showModal;
  finally
    GremiumMAForm.Free;
  end;
end;

procedure TGremiumForm.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn3.Click;
end;

procedure TGremiumForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  GRTab.Open;
end;

procedure TGremiumForm.FormDestroy(Sender: TObject);
begin
  PostMessage( Application.MainFormHandle, msgUpdateGr, 0, 0);
end;

procedure TGremiumForm.refeshDB;
var
  id : integer;
  opts : TLocateOptions;
begin
  id := -1;
  if not GRTab.IsEmpty then
    id := GRTab.FieldByName('GR_ID').AsInteger;

  GRTab.Close;
  GRTab.Open;
  if id > -1 then
  begin
    GRTab.Locate('GR_ID', VarArrayOf([id]), opts);
  end;
end;

end.
