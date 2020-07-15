unit f_template_new;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, u_stub;

type
  TTemplateNewForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    TETab: TClientDataSet;
    TESrc: TDataSource;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TETabBeforePost(DataSet: TDataSet);
    procedure TETabNewRecord(DataSet: TDataSet);
  private
    m_id : integer;
    m_cl : TdsTemplateClient;
    procedure setTEID( value : integer );
  public
    property TE_ID : integer read m_id write setTEID;
  end;

var
  TemplateNewForm: TTemplateNewForm;

implementation

uses
  m_glob_client, System.Win.ComObj;

{$R *.dfm}

{ TTemplateNewForm }

procedure TTemplateNewForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  TETab.Post;

  if TETab.UpdatesPending then
    TETab.ApplyUpdates(0);

  m_id := TETab.FieldByName('TE_ID').AsInteger;
end;

procedure TTemplateNewForm.FormCreate(Sender: TObject);
begin
   DSProviderConnection1.SQLConnection := GM.SQLConnection1;
   m_id := -1;
   m_cl := TdsTemplateClient.Create(GM.SQLConnection1.DBXConnection);
end;

procedure TTemplateNewForm.FormDestroy(Sender: TObject);
begin
  if TETab.State <> dsBrowse then
    TETab.Cancel;

  if TETab.UpdatesPending then
    TETab.CancelUpdates;
  TETab.Close;
  m_cl.free;
end;

procedure TTemplateNewForm.setTEID(value: integer);
begin
  m_id := value;

  TETab.Open;
  if m_id = -1 then begin
    TETab.Append;
    DBCheckBox1.Visible := true;
  end else begin
    if TETab.Locate('TE_ID', VarArrayOf([m_id]), []) then
      TETab.Edit;
  end;
end;

procedure TTemplateNewForm.TETabBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('TE_ID').AsInteger = 0 then
    DataSet.FieldByName('TE_ID').AsInteger := GM.autoInc('gen_te_id');
end;

procedure TTemplateNewForm.TETabNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('TE_SYSTEM').AsString   := 'F';
  DataSet.FieldByName('TE_CLID').AsString     := CreateClassID;
  DataSet.FieldByName('TE_STATE').AsString    := 'E';
  DataSet.FieldByName('TE_VERSION').AsInteger := 1;
end;

end.
