unit f_person_edit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TPersonEditForm = class(TForm)
    DSProviderConnection1: TDSProviderConnection;
    PETab: TClientDataSet;
    PESrc: TDataSource;
    BaseFrame1: TBaseFrame;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_id : integer;
    function GetID: integer;
    procedure SetID(const Value: integer);
  public
    property ID: integer read GetID write SetID;
  end;

var
  PersonEditForm: TPersonEditForm;

implementation

uses
  m_glob_client, u_stub;

{$R *.dfm}

{ TPersonEditForm }

procedure TPersonEditForm.BaseFrame1AbortBtnClick(Sender: TObject);
begin
  PETab.Cancel;
end;

procedure TPersonEditForm.BaseFrame1OKBtnClick(Sender: TObject);
var
   client : TdsPersonClient;
begin
  if m_id = 0 then
  begin
    client := NIL;
    try
      client := TdsPersonClient.Create(GM.SQLConnection1.DBXConnection);
      PeTab.FieldByName('PE_ID').AsInteger := client.AutoInc('gen_pe_id');
    finally
      client.Free;
    end;
  end;

  PETab.Post;
  PETab.ApplyUpdates(0);
end;

procedure TPersonEditForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_id := 0;
end;

procedure TPersonEditForm.FormDestroy(Sender: TObject);
begin
  try
    if PETab.State <> dsBrowse then
      PETab.Cancel
  except

  end;
  PETab.Close;
end;

function TPersonEditForm.GetID: integer;
begin
  Result := m_id;
end;

procedure TPersonEditForm.SetID(const Value: integer);
var
  opts : TLocateOptions;
begin
  m_id := value;

  PETab.Open;
  if m_id > 0 then
  begin
    if PETab.Locate('PE_ID', VarArrayOf([m_id]), opts) then
      PETab.Edit
    else
      PETab.Append;
  end
  else
    PETab.Append;

  if PETab.State = dsInsert then
    PETab.FieldByName('PE_ID').AsInteger := 0;
end;


end.
