unit f_gremium_edit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, fr_base, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.Buttons,
  Vcl.ExtCtrls;

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
    ColorDialog1: TColorDialog;
    Label4: TLabel;
    PB: TPaintBox;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure PBPaint(Sender: TObject);
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
  GRTab.FieldByName('GR_COLOR').AsInteger := PB.Tag;
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

procedure TGremiumEditForm.PBPaint(Sender: TObject);
var
  re : TRect;
begin
  if Pb.Tag = 0 then
    PB.Canvas.Brush.Color := self.Color
  else
    PB.Canvas.Brush.Color := TColor(PB.Tag);
  re := Rect(0, 0, PB.Width, PB.Height);
  PB.Canvas.FillRect(re);
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
    if GRTab.Locate('GR_ID', VarArrayOf([m_id]), opts) then begin
      GRTab.Edit;
      PB.Tag := GRTab.FieldByName('GR_COLOR').AsInteger;
    end else
      GRTab.Append;
  end
  else
    GRTab.Append;

  if GRTab.State = dsInsert then
    GRTab.FieldByName('GR_ID').AsInteger := 0;
end;

procedure TGremiumEditForm.SpeedButton1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
    PB.Tag := ColorDialog1.Color;
    PB.Invalidate;
  end;

end;

end.
