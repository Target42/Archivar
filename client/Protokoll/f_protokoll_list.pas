unit f_protokoll_list;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, fr_gremium,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TProtocollListForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    ListPrQry: TClientDataSet;
    ListPrSrc: TDataSource;
    GroupBox1: TGroupBox;
    GremiumFrame1: TGremiumFrame;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GremiumFrame1TVChange(Sender: TObject; Node: TTreeNode);
  private
    m_gr_id : integer;
    procedure setGRID( value : integer );
    function getPRID : integer;
    function getTitle : string;
  public
    property PR_ID : integer read getPRID;
    property Title : string read getTitle;
  end;

var
  ProtocollListForm: TProtocollListForm;


function deleteProtocol( id : integer ) : boolean;

implementation

uses
  m_glob_client, u_stub, System.JSON, u_json;

{$R *.dfm}

function deleteProtocol( id : integer ) : boolean;
var
  client : TdsProtocolClient;
  res, req : TJSONObject;
begin
  client := TdsProtocolClient.Create(GM.SQLConnection1.DBXConnection);
  try
    req := TJSONObject.Create;
    JReplace( req, 'id', id);

    Res := client.deleteProtocol(req);

    Result := ShowResult( res );
  except
    Result := false;
  end;
  client.Free;
end;

{ TProtocollListForm }

procedure TProtocollListForm.DBGrid1DblClick(Sender: TObject);
begin
  BaseFrame1.OKBtn.Click;
end;

procedure TProtocollListForm.FormCreate(Sender: TObject);
begin

  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  BaseFrame1.OKBtn.Enabled := false;

  GremiumFrame1.init;
end;

procedure TProtocollListForm.FormDestroy(Sender: TObject);
begin
  GremiumFrame1.release;
end;

function TProtocollListForm.getPRID: integer;
begin
  Result := -1;
  if not ListPrQry.IsEmpty then
    Result := ListPrQry.FieldByName('PR_ID').AsInteger;
end;

function TProtocollListForm.getTitle: string;
begin
  Result := 'Fehler in der Auswahl!';
  if not ListPrQry.IsEmpty then
    Result := ListPrQry.FieldByName('PR_NAME').AsString;
end;

procedure TProtocollListForm.GremiumFrame1TVChange(Sender: TObject;
  Node: TTreeNode);
begin
  setGRID(GremiumFrame1.GremiumID);
end;

procedure TProtocollListForm.setGRID(value: integer);
begin
  m_gr_id :=value;

  ListPrQry.Close;
  ListPrQry.ParamByName('GR_ID').AsInteger := m_gr_id;
  ListPrQry.Open;

  DBGrid1.Enabled           := not ListPrQry.IsEmpty;
  BaseFrame1.OKBtn.Enabled  := not ListPrQry.IsEmpty;
end;

end.
