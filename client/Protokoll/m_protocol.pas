unit m_protocol;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect;

type
  TProtocolMod = class(TDataModule)
    DSProviderConnection1: TDSProviderConnection;
    PRTab: TClientDataSet;
    CPTab: TClientDataSet;
    CPTextTab: TClientDataSet;
    UpdateCPQry: TClientDataSet;
    TNTab: TClientDataSet;
    TNTabPR_ID: TIntegerField;
    TNTabTN_ID: TIntegerField;
    TNTabTN_NAME: TWideStringField;
    TNTabTN_VORNAME: TWideStringField;
    TNTabTN_DEPARTMENT: TWideStringField;
    TNTabTN_ROLLE: TWideStringField;
    TNTabStatusText: TStringField;
    TNTabTN_STATUS: TIntegerField;
    TNTabPE_ID: TIntegerField;
    TGTab: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TNTabBeforePost(DataSet: TDataSet);
  private
    m_filter  : string;
    m_id      : integer;
    m_readOnly: boolean;

    function GetPR_ID: integer;
    procedure SetPR_ID(const Value: integer);
    function GetReadOnly: boolean;
    procedure SetReadOnly(const Value: boolean);

  public
    property ReadOnly: boolean read GetReadOnly write SetReadOnly;
    property PR_ID: integer read GetPR_ID write SetPR_ID;

    function getProtocolStream : TStream;

  end;

var
  ProtocolMod: TProtocolMod;

implementation

uses
  m_glob_client, System.Variants;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TProtocolMod.DataModuleCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
end;

procedure TProtocolMod.DataModuleDestroy(Sender: TObject);
begin
  PRTab.Close;
  CPTab.Close;
  TGTab.Close;
  TNTab.Close;
  CPTextTab.Close;
end;

function TProtocolMod.getProtocolStream: TStream;
begin
  Result := PRTab.CreateBlobStream(PRTab.FieldByName('PR_DATA'), bmRead);
end;

function TProtocolMod.GetPR_ID: integer;
begin
  Result := m_id;
end;

function TProtocolMod.GetReadOnly: boolean;
begin
  Result := m_readOnly;
end;

procedure TProtocolMod.SetPR_ID(const Value: integer);
begin
  m_id := value;
  PRTab.Open;
  if PRTab.Locate('PR_ID', VarArrayOf([m_id]), []) then
  begin
    PRTab.Edit;

    m_filter := 'PR_ID = '+IntToStr(m_id);
    CPTab.Filter := m_filter;
    CPTab.Filtered := true;
    CPTab.Open;

    CPTextTab.Open;

    TNTab.Filter    := m_filter;
    TNTab.Filtered  := true;
    TNTab.Open;

    TGTab.Filter    := m_filter;
    TGTab.Filtered  := true;
    TGTab.Open;


  end
  else
    prTab.Close;
end;

procedure TProtocolMod.SetReadOnly(const Value: boolean);
begin
  m_readOnly := value;

end;

procedure TProtocolMod.TNTabBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('TN_ID').AsInteger = 0 then
    DataSet.FieldByName('TN_ID').AsInteger := GM.autoInc('gen_tn_id');
end;

end.