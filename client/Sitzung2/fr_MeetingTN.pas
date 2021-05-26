unit fr_MeetingTN;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, i_chapter, Vcl.Menus, u_stub;

type
  TMeetingTNFrame = class(TFrame)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    GroupBox3: TGroupBox;
    Splitter2: TSplitter;
    GroupBox4: TGroupBox;
    Anwesend: TListView;
    Gremium: TListView;
    Entschuldigt: TListView;
    Unentschuldigt: TListView;
    PopupMenu1: TPopupMenu;
    Anwesend1: TMenuItem;
    Entschuldigt1: TMenuItem;
    Unentschuldigt1: TMenuItem;
    Gremium1: TMenuItem;
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Anwesend1Click(Sender: TObject);
    procedure GremiumDblClick(Sender: TObject);
  private
    m_tn  : ITeilnehmerListe;
    m_src : TListView;
    FClient: TdsSitzungClient;
    FELID: integer;
    function GetTeilnehmer: ITeilnehmerListe;
    procedure SetTeilnehmer(const Value: ITeilnehmerListe);

    procedure updateList;
  public
    property Teilnehmer: ITeilnehmerListe read GetTeilnehmer write SetTeilnehmer;

    property ELID: integer read FELID write FELID;
    property Client: TdsSitzungClient read FClient write FClient;

    procedure init;
    procedure release;
  end;

implementation

uses
  u_teilnehmer, System.JSON, u_json;

{$R *.dfm}

{ TMeetingTNFrame }

procedure TMeetingTNFrame.Anwesend1Click(Sender: TObject);
var
  item  : TMenuItem;
  i     : integer;
  t     : ITeilnehmer;
  ts    : TTeilnehmerStatus;
  req   : TJSONObject;
  arr   : TJSONArray;
begin
  req   := TJSONObject.Create;
  item  := sender as TMenuItem;
  arr   := TJSONArray.Create;

  case item.Tag of
   1 : ts := tsAnwesend;
   2 : ts := tsEntschuldigt;
   3 : ts := tsUnentschuldigt;
   4 : ts := tsUnbekannt;
   else
     ts := tsUnbekannt;
  end;
  JReplace(req, 'elid', FELID);
  JReplace(req, 'status', integer(ts));

  for i := 0 to pred(m_src.Items.Count) do
    begin
      if m_src.Items.Item[i].Selected then begin
        t := ITeilnehmer(m_src.Items.Item[i].Data);
        t.Status := ts;
        arr.AddElement(TJSONNumber.Create(t.PEID));
      end;
    end;
  updateList;
  JReplace(req, 'list', arr);

  if Assigned(FClient) then begin
    FClient.changeState(req);
  end
  else
    req.Free;
end;

function TMeetingTNFrame.GetTeilnehmer: ITeilnehmerListe;
begin
  Result := m_tn;
end;

procedure TMeetingTNFrame.GremiumDblClick(Sender: TObject);
begin
  m_src := Gremium;
  Anwesend1Click( Anwesend1 );
end;

procedure TMeetingTNFrame.init;
begin
  FClient := NIL;
end;

procedure TMeetingTNFrame.PopupMenu1Popup(Sender: TObject);
begin
  if      Anwesend.Focused        then m_src := Anwesend
  else if Entschuldigt.Focused    then m_src := Entschuldigt
  else if Unentschuldigt.Focused  then m_src := Unentschuldigt
  else if Gremium.Focused         then m_src := Gremium;

  Anwesend1.Visible       := m_src <> Anwesend;
  Entschuldigt1.Visible   := m_src <> Entschuldigt;
  Unentschuldigt1.Visible := m_src <> Unentschuldigt;
  Gremium1.Visible        := m_src <> Gremium;
end;

procedure TMeetingTNFrame.release;
begin

end;

procedure TMeetingTNFrame.SetTeilnehmer(const Value: ITeilnehmerListe);
begin
  m_tn := Value;

  updateList;
end;

procedure TMeetingTNFrame.updateList;
var
  i     : integer;
  t     : ITeilnehmer;
  item  : TListItem;
begin
  Gremium.Items.Clear;
  Anwesend.Items.Clear;
  Entschuldigt.Items.Clear;
  Unentschuldigt.Items.Clear;

  for i := 0 to pred(m_tn.Count) do begin
    t := m_tn.Item[i];
    case t.Status of
      tsUnbekannt:        item := Gremium.Items.Add;
      tsVerfuegbar:       item := Gremium.Items.Add;
      tsAnwesend:         item := Anwesend.Items.Add;
      tsEntschuldigt:     item := Entschuldigt.Items.Add;
      tsEingeladen:       item := Gremium.Items.Add;
      tsUnentschuldigt:   item := Unentschuldigt.Items.Add;
      tsZugesagt:         item := Gremium.Items.Add;
      tsAbgelehnt:        item := Gremium.Items.Add;
      else
        item := Gremium.Items.Add;
    end;
    item.Caption := t.Name;
    item.SubItems.Add(t.Vorname);
    item.SubItems.Add(t.Abteilung);
    item.SubItems.Add(t.Rolle);
    item.Data := t;
  end;
end;

end.
