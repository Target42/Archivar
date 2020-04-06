unit f_gremium_edit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, fr_base, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TGremiumEditForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    GRTab: TClientDataSet;
    GTSrc: TDataSource;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    Name: TLabel;
    Label2: TLabel;
    DBComboBox1: TDBComboBox;
    Label3: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    Images: TClientDataSet;
    ImageSrc: TDataSource;
    DBImage1: TDBImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_id : integer;
    procedure setID( value : integer);
  public
    property ID : integer read m_id write setID;
  end;

var
  GremiumEditForm: TGremiumEditForm;

implementation

uses
  m_glob_client, u_stub;

{$R *.dfm}

procedure TGremiumEditForm.BaseFrame1AbortBtnClick(Sender: TObject);
begin
  GRTab.Cancel;
end;

procedure TGremiumEditForm.BaseFrame1OKBtnClick(Sender: TObject);
var
   client : TdsGremiumClient;
begin
  if m_id = 0 then
  begin
    client := NIL;
    try
      client := TdsGremiumClient.Create(GM.SQLConnection1.DBXConnection);
      GRTab.FieldByName('GR_ID').AsInteger := client.AutoInc('gen_gr_id');
    finally
      client.Free;
    end;
  end;

  GRTab.Post;
  GRTab.ApplyUpdates(0);
end;

procedure TGremiumEditForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_id := 0;
end;

procedure TGremiumEditForm.FormDestroy(Sender: TObject);
begin
  try
    if GRTab.State <> dsBrowse then
      GRTab.Cancel
  except

  end;
  GRTab.Close;
end;

procedure TGremiumEditForm.setID(value: integer);
var
  opts : TLocateOptions;
begin
  m_id := value;
  DBComboBox1.Items.Add('');
  Images.Open;
  GRTab.Open;
  while not GRTab.Eof do
  begin
    DBComboBox1.Items.Add(GRTab.FieldByName('GR_SHORT').AsString);
    GRTab.Next;
  end;

  if m_id > 0 then
  begin
    if GRTab.Locate('GR_ID', VarArrayOf([m_id]), opts) then
      GRTab.Edit
    else
      GRTab.Append;
  end
  else
    GRTab.Append;

  if GRTab.State = dsInsert then
    GRTab.FieldByName('GR_ID').AsInteger := 0;
end;

end.
