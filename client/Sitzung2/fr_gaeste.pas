unit fr_gaeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, i_chapter;

type
  TGaesteFrame = class(TFrame)
    Panel3: TPanel;
    btnNeu: TBitBtn;
    btnEdit: TBitBtn;
    btnDelete: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    TG: TListView;
    procedure btnNeuClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure TGDblClick(Sender: TObject);
  private
    m_besucher : IBesucherListe;
    FReadOnly: boolean;
    function GetBesucher: IBesucherListe;
    procedure SetBesucher(const Value: IBesucherListe);

    procedure UpdateTG;
  public
    procedure prepare;
    procedure release;

    property Besucher: IBesucherListe read GetBesucher write SetBesucher;
    property ReadOnly: boolean read FReadOnly write FReadOnly;
  end;

implementation

uses
  f_besucher;
{$R *.dfm}

{ TGästeFrame }

procedure TGaesteFrame.BitBtn1Click(Sender: TObject);
var
  i: integer;
  b: IBesucher;
begin
  if FReadOnly then exit;

  for i := 0 to pred(TG.Items.Count) do
  begin
    if TG.Items.Item[i].Selected then
    begin
      b := IBesucher(TG.Items.Item[i].Data);
      b.Von := now;
    end;
  end;
  UpdateTG;
end;

procedure TGaesteFrame.BitBtn2Click(Sender: TObject);
var
  i: integer;
  b: IBesucher;
begin
  if FReadOnly then exit;

  for i := 0 to pred(TG.Items.Count) do
  begin
    if TG.Items.Item[i].Selected then
    begin
      b := IBesucher(TG.Items.Item[i].Data);
      b.bis := now;
    end;
  end;
  UpdateTG;
end;

procedure TGaesteFrame.btnDeleteClick(Sender: TObject);
var
  i: integer;
  b: IBesucher;
begin
  if FReadOnly then exit;

  if not(MessageDlg('Sollen die ausgwewählten Gäste gelöscht werden?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    exit;

  for i := pred(TG.Items.Count) downto 0 do
  begin
    if TG.Items.Item[i].Selected then
    begin
      b := IBesucher(TG.Items.Item[i].Data);
      m_Besucher.remove(b);
    end;
  end;
  UpdateTG;
end;

procedure TGaesteFrame.btnEditClick(Sender: TObject);
var
  b: IBesucher;
begin
  if FReadOnly then exit;

  if not Assigned(TG.Selected) then
    exit;

  b := IBesucher(TG.Selected.Data);
  Application.CreateForm(TBesucherForm, BesucherForm);
  BesucherForm.Besucher := b;
  if BesucherForm.ShowModal = mrOk then
  begin
    m_Besucher.saveChanged;
  end;
  BesucherForm.Free;

  UpdateTG;
end;

procedure TGaesteFrame.btnNeuClick(Sender: TObject);
var
  b: IBesucher;
begin
  if FReadOnly then exit;

  b := m_Besucher.newBesucher;
  Application.CreateForm(TBesucherForm, BesucherForm);
  BesucherForm.Besucher := b;
  if BesucherForm.ShowModal = mrOk then
  begin
    m_Besucher.saveChanged;
  end
  else
    m_Besucher.remove(b);
  BesucherForm.Free;

  UpdateTG;
end;

function TGaesteFrame.GetBesucher: IBesucherListe;
begin
  Result := m_besucher;
end;

procedure TGaesteFrame.prepare;
begin
  m_besucher := NIL;
  FReadOnly  := false;
end;

procedure TGaesteFrame.release;
begin
  m_besucher := NIL;
end;

procedure TGaesteFrame.SetBesucher(const Value: IBesucherListe);
begin
  m_besucher := Value;
  UpdateTG;
end;

procedure TGaesteFrame.TGDblClick(Sender: TObject);
begin
  btnEdit.Click;
end;

procedure TGaesteFrame.UpdateTG;
var
  i: integer;
  b: IBesucher;
  Item: TListItem;
begin
  TG.Items.BeginUpdate;
  TG.Items.Clear;
  for i := 0 to pred(m_Besucher.Count) do
  begin
    b := m_Besucher.Item[i];
    Item := TG.Items.add;

    Item.Data := b;
    Item.Caption := b.name;
    Item.SubItems.add(b.Vorname);
    Item.SubItems.add(b.Abteilung);
    Item.SubItems.add(FormatDateTime('hh:mm', b.Von));
    Item.SubItems.add(FormatDateTime('hh:mm', b.bis));
    Item.SubItems.add(b.grund);
  end;
  TG.Items.EndUpdate;
end;

end.
