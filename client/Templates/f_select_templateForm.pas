unit f_select_templateForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, fr_base,
  Datasnap.DBClient, Datasnap.DSConnect;

type
  TSelectTemplateForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DBGrid1: TDBGrid;
    DSProviderConnection1: TDSProviderConnection;
    ListDataSet: TClientDataSet;
    DataSource1: TDataSource;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_id : integer;
    FSys: boolean;
    FEdit: boolean;
    procedure setSys( value : boolean );
    procedure setEdit(const Value: boolean);

    function getTEID: integer;
  public
    property Sys  : boolean read FSys   write setSys;
    property Edit : boolean read FEdit  write setEdit;

    property TE_ID: integer read getTEID;

    procedure start;
  end;

var
  SelectTemplateForm: TSelectTemplateForm;

implementation

uses
  m_glob_client;

{$R *.dfm}

procedure TSelectTemplateForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  if ListDataSet.IsEmpty then
    exit;
  m_id := ListDataSet.FieldByName('TE_ID').AsInteger;
end;

procedure TSelectTemplateForm.DBGrid1DblClick(Sender: TObject);
begin
  BaseFrame1.OKBtn.Click;
end;

procedure TSelectTemplateForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_id  := -1;
  FSys  := false;
  FEdit := false;
end;

function TSelectTemplateForm.getTEID: integer;
begin
  Result := m_id;
end;

procedure TSelectTemplateForm.setEdit(const Value: boolean);
begin
  FEdit := Value;
end;

procedure TSelectTemplateForm.setSys(value: boolean);
begin
  FSys := value;
end;

procedure TSelectTemplateForm.start;
begin
  if FSys then
    ListDataSet.ParamByName('SYS').AsString := 'T'
  else
    ListDataSet.ParamByName('SYS').AsString := 'F';
  if FEdit then
    ListDataSet.ParamByName('STATE').AsString := 'E'
  else
    ListDataSet.ParamByName('STATE').AsString := 'V';

  ListDataSet.Open;
end;

end.
