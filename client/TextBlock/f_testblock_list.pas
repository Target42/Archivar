unit f_testblock_list;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.DBGrids, fr_base, Vcl.Grids;

type
  TTestBlockListForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DBGrid1: TDBGrid;
    DSProviderConnection1: TDSProviderConnection;
    TBTab: TClientDataSet;
    DataSource1: TDataSource;
    DelQry: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    m_id : integer;
    m_doDelete : boolean;
    procedure setID( value : integer );
  public
    property ID : integer read m_id write setID;
    property doDelete : boolean read m_doDelete write m_doDelete;
  end;

var
  TestBlockListForm: TTestBlockListForm;

implementation

uses
  m_glob_client, System.UITypes;

{$R *.dfm}

procedure TTestBlockListForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  s : string;
begin
  if not TBTab.IsEmpty then
    id := TBTab.FieldByName('TB_ID').AsInteger;

  if m_doDelete then
  begin
    s := 'Soll "'+TBTab.FieldByName('TB_NAME').AsString+'" wirklich gelöscht werden?';

    if not (MessageDlg(s, mtWarning, [mbYes, mbNo], 0) in [mrYes, mrNone]) then
      exit;
    DelQry.ParamByName('TB_ID').AsInteger := TBTab.FieldByName('TB_ID').AsInteger;
    DelQry.Execute;
  end;
end;

procedure TTestBlockListForm.DBGrid1DblClick(Sender: TObject);
begin
  BaseFrame1.OKBtn.Click;
end;

procedure TTestBlockListForm.FormCreate(Sender: TObject);
begin
  m_doDelete := false;
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_id := -1;
  TBTab.Open;
end;

procedure TTestBlockListForm.FormDestroy(Sender: TObject);
begin
  TBTab.Close;
end;

procedure TTestBlockListForm.setID(value: integer);
begin
  if TBTab.Locate('TB_ID', VarArrayOf([value]), []) then
  begin
    m_id := value;
  end;
end;

end.
