unit f_meeting_select;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.StdCtrls, fr_gremium,
  Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls;

type
  TSelectMeetingForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    GremiumFrame1: TGremiumFrame;
    DSProviderConnection1: TDSProviderConnection;
    ELTab: TClientDataSet;
    ELSrc: TDataSource;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    ELTabPR_ID: TIntegerField;
    ELTabEL_ID: TIntegerField;
    ELTabGR_ID: TIntegerField;
    ELTabPE_ID: TIntegerField;
    ELTabEL_DATUM: TDateField;
    ELTabEL_ZEIT: TTimeField;
    ELTabEL_TITEL: TStringField;
    ELTabEL_DATA: TBlobField;
    ELTabEL_DATA_STAMP: TSQLTimeStampField;
    ELTabEL_ENDE: TTimeField;
    ELTabEL_STATUS: TStringField;
    ELTabEL_CLID: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GremiumFrame1TVChange(Sender: TObject; Node: TTreeNode);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    m_filter : string;

    function getMEID  : integer;
    function getTitle : string;
    procedure setFilter( value : string );
  public
    property EL_ID  : integer read getMEID;
    property Title  : string  read getTitle;
    property Filter : string  read m_filter write setFilter;
  end;

var
  SelectMeetingForm: TSelectMeetingForm;

implementation

uses
  m_glob_client;

{$R *.dfm}

procedure TSelectMeetingForm.DBGrid1DblClick(Sender: TObject);
begin
  BaseFrame1.OKBtn.Click;
end;

procedure TSelectMeetingForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  GremiumFrame1.init;

  m_filter        := 'O';
  ELTab.Filter    := 'EL_STATUS=''X''';
  ELTab.Filtered  := true;
  ELTab.Open;

  DBGrid1.Enabled           := not ELTab.IsEmpty;
  BaseFrame1.OKBtn.Enabled  := not ELTab.IsEmpty;

  GremiumFrame1.selectFirst;

end;

procedure TSelectMeetingForm.FormDestroy(Sender: TObject);
begin
  GremiumFrame1.release;
  ELTab.Close;
end;

function TSelectMeetingForm.getMEID: integer;
begin
  Result := 0;
  if not ELTab.IsEmpty then
    Result := ELTab.FieldByName('EL_ID').AsInteger;
end;

function TSelectMeetingForm.getTitle: string;
begin
  Result :='';
  if not ELTab.IsEmpty then
    Result := ELTab.FieldByName('EL_TITEL').AsString;
end;

procedure TSelectMeetingForm.GremiumFrame1TVChange(Sender: TObject;
  Node: TTreeNode);
var
  grid : integer;
begin
  if not ELTab.Active then
    exit;

  grid                      := GremiumFrame1.GremiumID;
  ELTab.Filter              := Format('GR_ID=%d and EL_STATUS in (%s)', [grid, m_filter]);
  //ELTab.Filter              := Format('GR_ID=%d and EL_STATUS in (''R'')', [grid]);
  ELTab.Filtered            := true;

  DBGrid1.Enabled           := not ELTab.IsEmpty;
  BaseFrame1.OKBtn.Enabled  := not ELTab.IsEmpty;
end;

procedure TSelectMeetingForm.setFilter(value: string);
begin
  m_filter := value;
  GremiumFrame1TVChange( NIL, NIL );
end;


end.
