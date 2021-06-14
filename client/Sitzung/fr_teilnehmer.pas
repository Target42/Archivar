unit fr_teilnehmer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, i_beschluss, i_personen,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TTNFrame = class(TFrame)
    GroupBox4: TGroupBox;
    LVGremium: TListView;
    Splitter4: TSplitter;
    Panel4: TPanel;
    Splitter5: TSplitter;
    GroupBox5: TGroupBox;
    LVAbwesend: TListView;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GroupBox6: TGroupBox;
    LVNichtabgestimmt: TListView;
    Panel2: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure LVAbwesendClick(Sender: TObject);
    procedure LVNichtabgestimmtClick(Sender: TObject);
    procedure LVGremiumClick(Sender: TObject);
  private
    FOnUserChange     : TNotifyEvent;
    m_be              : IBeschluss;
    m_gremium         : IPersonenListe;
    m_abwesende       : IPersonenListe;
    m_nichtAbgestimmt : IPersonenListe;


    function GetBeschluss: IBeschluss;
    procedure SetBeschluss(const Value: IBeschluss);

    procedure UpdateList( LV : TListView; list : IPersonenListe );

    procedure setOnChange( value :TNotifyEvent );
  public
    procedure init;
    procedure release;

    property Beschluss      : IBeschluss      read GetBeschluss       write SetBeschluss;
    property Gremium        : IPersonenListe  read m_gremium;
    property Abwesende      : IPersonenListe  read m_abwesende;
    property NichtAbgestimt : IPersonenListe  read m_nichtAbgestimmt;

    property OnUserChange : TNotifyEvent read FOnUserChange write setOnChange;
  end;

implementation

{$R *.dfm}

{ TTNFrame }

function TTNFrame.GetBeschluss: IBeschluss;
begin
  Result := m_be;
end;


procedure TTNFrame.init;
begin
  m_be              := NIL;
  m_gremium         := NIL;
  m_abwesende       := NIL;
  m_nichtAbgestimmt := NIL;
  FOnUserChange     := NIL;
end;

procedure TTNFrame.LVAbwesendClick(Sender: TObject);
begin
  SpeedButton1.Click;
end;

procedure TTNFrame.LVGremiumClick(Sender: TObject);
begin
  SpeedButton2.Click;
end;

procedure TTNFrame.LVNichtabgestimmtClick(Sender: TObject);
begin
  SpeedButton3.Click;
end;

procedure TTNFrame.release;
begin
  if Assigned(m_gremium) then
    m_gremium.release;

  if Assigned(m_abwesende) then
    m_abwesende.release;

  if Assigned(m_nichtAbgestimmt) then
    m_nichtAbgestimmt.release;

end;

procedure TTNFrame.SetBeschluss(const Value: IBeschluss);
begin
  m_be := value;
  m_gremium         := m_be.Abstimmung.Gremium.clone;
  m_abwesende       := m_be.Abstimmung.Abwesend.clone;
  m_nichtAbgestimmt := m_be.Abstimmung.NichtAbgestimmt.clone;

  UpdateList( LVGremium,          m_gremium   );
  UpdateList( LVNichtabgestimmt,  m_nichtAbgestimmt );
  UpdateList( LVAbwesend,         m_abwesende );

end;

procedure TTNFrame.setOnChange(value: TNotifyEvent);
begin
  FOnUserChange := value;
  if Assigned(FOnUserChange) then
    FOnUserChange(self);
end;

procedure TTNFrame.SpeedButton1Click(Sender: TObject);
var
  p : IPerson;
begin
  if not Assigned(LVAbwesend.Selected) then
    exit;

  p := IPerson(LVAbwesend.Selected.Data);
  m_gremium.add(p);

  UpdateList( LVGremium,  m_gremium);
  UpdateList( LVAbwesend, m_abwesende);

  if Assigned(FOnUserChange) then
    FOnUserChange( self );

end;

procedure TTNFrame.SpeedButton2Click(Sender: TObject);
var
  p : IPerson;
begin
  if not Assigned(LVGremium.Selected) then
    exit;

  p := IPerson(LVGremium.Selected.Data);
  m_abwesende.add(p);

  UpdateList( LVGremium,  m_gremium);
  UpdateList( LVAbwesend, m_abwesende);

  if Assigned(FOnUserChange) then
    FOnUserChange( self );
end;

procedure TTNFrame.SpeedButton3Click(Sender: TObject);
var
  p : IPerson;
begin
  if not Assigned(LVNichtabgestimmt.Selected) then
    exit;

  p := IPerson(LVNichtabgestimmt.Selected.Data);
  m_gremium.add(p);

  UpdateList( LVGremium,          m_gremium);
  UpdateList( LVNichtabgestimmt,  m_nichtAbgestimmt);

  if Assigned(FOnUserChange) then
    FOnUserChange( self );
end;

procedure TTNFrame.SpeedButton4Click(Sender: TObject);
var
  p : IPerson;
begin
  if not Assigned(LVGremium.Selected) then
    exit;

  p := IPerson(LVGremium.Selected.Data);
  m_nichtAbgestimmt.add(p);

  UpdateList( LVGremium,          m_gremium);
  UpdateList( LVNichtabgestimmt,  m_nichtAbgestimmt);

  if Assigned(FOnUserChange) then
    FOnUserChange( self );
end;

procedure TTNFrame.UpdateList(LV: TListView; list: IPersonenListe);
var
  i : integer;
  p : IPerson;
  item : TListItem;
begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;

  for i := 0 to pred(list.count) do
  begin
    p     := list.Items[i];
    item  := LV.Items.Add;
    item.Data := p;
    item.Caption := p.Name;
    item.SubItems.Add(p.Vorname);
    item.SubItems.Add(p.Abteilung);
    item.SubItems.Add(p.Rolle);
  end;
  LV.Items.EndUpdate;

  if LV = LVGremium then
    GroupBox4.Caption := 'Gremium '+IntToStr(LV.Items.Count)
  else if lv = LVAbwesend then
    GroupBox5.Caption := 'Abwesend '+IntToStr(LV.Items.Count)
  else if lv = LVNichtabgestimmt then
    GroupBox6.Caption := 'Nicht mit Abgestimt '+IntToStr(LV.Items.Count);
end;

end.
