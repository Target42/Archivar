unit f_meeting_proto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_gremium, Vcl.StdCtrls, fr_base,
  Data.DB, Vcl.DBGrids, Datasnap.DBClient, Datasnap.DSConnect,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids;

type
  TMeetingProtoForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    GremiumFrame1: TGremiumFrame;
    Splitter1: TSplitter;
    DSProviderConnection1: TDSProviderConnection;
    ProtoQry: TClientDataSet;
    ProcolSrc: TDataSource;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GremiumFrame1TVChange(Sender: TObject; Node: TTreeNode);
  private
    function getGRID : integer;
    function getPRID : integer;
  public
    property GR_ID : integer read getGRID;
    property PR_ID : integer read getPRID;
  end;

var
  MeetingProtoForm: TMeetingProtoForm;

implementation

uses
  m_glob_client;

{$R *.dfm}

procedure TMeetingProtoForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  GremiumFrame1.init;
end;

procedure TMeetingProtoForm.FormDestroy(Sender: TObject);
begin
  GremiumFrame1.release
end;

function TMeetingProtoForm.getGRID: integer;
begin
  Result := GremiumFrame1.GremiumID;
end;

function TMeetingProtoForm.getPRID: integer;
begin
  Result := -1;
  if not ProtoQry.IsEmpty then
    Result := ProtoQry.FieldByName('PR_ID').AsInteger;
end;

procedure TMeetingProtoForm.GremiumFrame1TVChange(Sender: TObject;
  Node: TTreeNode);
begin
  ProtoQry.Close;
  ProtoQry.ParamByName('GR_ID').AsInteger := GremiumFrame1.GremiumID;
  ProtoQry.Open;

  DBGrid1.Enabled           := not ProtoQry.IsEmpty;
  BaseFrame1.OKBtn.Enabled  := not ProtoQry.IsEmpty;
end;

end.
