unit f_personen_list;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  fr_base, Datasnap.DBClient, Datasnap.DSConnect, i_chapter;

type
  TPersonenListForm = class(TForm)
    DSProviderConnection1: TDSProviderConnection;
    PETab: TClientDataSet;
    PESrc: TDataSource;
    BaseFrame1: TBaseFrame;
    DBGrid1: TDBGrid;
    PETabPE_ID: TIntegerField;
    PETabPE_NAME: TStringField;
    PETabPE_VORNAME: TStringField;
    PETabPE_DEPARTMENT: TStringField;
    PETabPE_NET: TStringField;
    PETabPE_MAIL: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_teilnehmer : ITeilnehmerListe;

    function GetTeilnehmer: ITeilnehmerListe;
    procedure SetTeilnehmer(const Value: ITeilnehmerListe);
    { Private-Deklarationen }
  public
    property Teilnehmer: ITeilnehmerListe read GetTeilnehmer write SetTeilnehmer;
  end;

var
  PersonenListForm: TPersonenListForm;

implementation

uses
  m_glob_client;

{$R *.dfm}

procedure TPersonenListForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  i  : integer;
  bm : TBookmark;
  tn : ITeilnehmer;
begin
  if not Assigned(m_teilnehmer) then exit;

  PETab.DisableControls;
  for i:= 0 to pred(DBGrid1.SelectedRows.Count) do begin
    bm := DBGrid1.SelectedRows.Items[i];
    PETab.GotoBookmark(bm);
    tn := m_teilnehmer.getByPEID( PETabPE_ID.Value );
    if not Assigned(tn) then begin
      tn := m_teilnehmer.newTeilnehmer;
      tn.Name       := PETabPE_NAME.AsString;
      tn.Vorname    := PETabPE_VORNAME.AsString;
      tn.Abteilung  := PETabPE_DEPARTMENT.AsString;
      tn.PEID       := PETabPE_ID.Value;
      tn.Modified   := true;
    end;
  end;
  m_teilnehmer.saveChanged;

  PETab.EnableControls;
end;

procedure TPersonenListForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  PETab.Open;
end;

function TPersonenListForm.GetTeilnehmer: ITeilnehmerListe;
begin
  Result := m_teilnehmer;
end;

procedure TPersonenListForm.SetTeilnehmer(const Value: ITeilnehmerListe);
begin
  m_teilnehmer := value;
end;

end.
