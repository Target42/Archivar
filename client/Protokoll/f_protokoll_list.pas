unit f_protokoll_list;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids;

type
  TProtocollListForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DBGrid1: TDBGrid;
    DSProviderConnection1: TDSProviderConnection;
    ListPrQry: TClientDataSet;
    ListPrSrc: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    m_gr_id : integer;
    procedure setGRID( value : integer );
    function getPRID : integer;
  public
    property GremiumID : integer read m_gr_id write setGRID;
    property PR_ID : integer read getPRID;
  end;

var
  ProtocollListForm: TProtocollListForm;

implementation

uses
  m_glob_client;

{$R *.dfm}

{ TProtocollListForm }

procedure TProtocollListForm.DBGrid1DblClick(Sender: TObject);
begin
  BaseFrame1.OKBtn.Click;
end;

procedure TProtocollListForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
end;

function TProtocollListForm.getPRID: integer;
begin
  Result := ListPrQry.FieldByName('PR_ID').AsInteger;
end;

procedure TProtocollListForm.setGRID(value: integer);
begin
  m_gr_id :=value;
  ListPrQry.ParamByName('GR_ID').AsInteger := m_gr_id;
  ListPrQry.Open;

  DBGrid1.Enabled           := not ListPrQry.IsEmpty;
  BaseFrame1.OKBtn.Enabled  := not ListPrQry.IsEmpty;
end;

end.
