unit f_protokoll;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB,
  Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Menus,
  System.Actions, Vcl.ActnList, f_gremiumList, JvDateTimePicker,
  Vcl.Buttons,
  i_chapter,
  Vcl.OleCtrls, SHDocVw, System.Generics.Collections,
  u_teilnehmer, fr_protocol, u_ForceClose, JvExComCtrls, System.ImageList,
  Vcl.ImgList;

type
  TProtokollForm = class(TForm, IForceClose)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    Splitter1: TSplitter;
    MainMenu1: TMainMenu;
    Protokoll1: TMenuItem;
    Lesezeichenerstellen1: TMenuItem;
    N5: TMenuItem;
    Sperren1: TMenuItem;
    Freigeben1: TMenuItem;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button2: TBitBtn;
    TN: TListView;
    DBEdit1: TEdit;
    DBEdit2: TEdit;
    JvDBDateTimePicker1: TJvDateTimePicker;
    N3: TMenuItem;
    Speichern: TMenuItem;
    Panel3: TPanel;
    TG: TListView;
    btnNeu: TBitBtn;
    btnEdit: TBitBtn;
    btnDelete: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    WebBrowser1: TWebBrowser;
    Aktualisieren1: TMenuItem;
    N4: TMenuItem;
    Panel2: TPanel;
    ProtocolFrame1: TProtocolFrame;
    PopupMenu1: TPopupMenu;
    BitBtn3: TBitBtn;
    ImageList1: TImageList;
    ImageList2: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ac_pr_bookmarkExecute(Sender: TObject);
    procedure ac_pr_lockExecute(Sender: TObject);
    procedure ac_pr_unlockExecute(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeichernClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBEdit1Change(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnNeuClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure TGDblClick(Sender: TObject);
    procedure Aktualisieren1Click(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure BitBtn3Click(Sender: TObject);
  private
    m_prid          : integer;
    m_proto         : IProtocol;
    m_locked        : Boolean;

    m_grList        : TGremiumListForm;
    m_ro            : Boolean;

    m_statusMap: TDictionary<TTeilnehmerStatus, integer>;

    procedure setID(value: integer);
    function getID: integer;

    procedure setRO(value: Boolean);

    procedure setStatus(ts: TTeilnehmerStatus; grund: string = '');
    procedure UpdateTN;
    procedure UpdateTG;

    procedure save;

    procedure fillStatusMap;

    procedure reload;
    procedure RollChange(Sender: TObject);
  public
    property ID: integer read getID write setID;
    property RO: Boolean read m_ro write setRO;

    procedure ForceClose( force : boolean);
  end;

var
  ProtokollForm: TProtokollForm;

implementation

uses
  m_glob_client, u_bookmark, m_BookMarkHandler,
  u_berTypes, System.JSON, u_json,
  m_WindowHandler, System.UITypes,
  u_ProtocolImpl, u_speedbutton, f_abwesenheit,
  f_besucher, f_personen_list,
  CodeSiteLogging;

{$R *.dfm}
{ TProtokollForm }

procedure TProtokollForm.ac_pr_bookmarkExecute(Sender: TObject);
var
  mark: u_bookmark.TBookmark;
begin
  mark := BookMarkHandler.Bookmarks.newBookmark(m_proto.clid);
  mark.ID := m_proto.ID;
  mark.Titel := m_proto.Title;
  mark.Group := 'Protokoll';
  mark.Internal := true;
  mark.TypeID := 0;
  mark.DocType := dtProtokoll;
  PostMessage(Application.MainFormHandle, msgNewBookMark, 0, 0);
end;

procedure TProtokollForm.ac_pr_lockExecute(Sender: TObject);
var
  obj: TJSONObject;
begin
  // lock
  obj := GM.LockDocument(m_proto.ID, integer(ltProtokoll));
  if not JBool(obj, 'result') then
    ShowMessage(JString(obj, 'text'))
  else
  begin
    m_locked := true;

    reload;

    Caption := '*' + m_proto.Title;
    self.RO := false;
    ShowMessage('Das Protokoll kann jetzt bearbeitet werden.');
  end;
end;

procedure TProtokollForm.ac_pr_unlockExecute(Sender: TObject);
var
  Data: TJSONObject;
begin
  if m_proto.Modified then
  begin
    case MessageDlg('Die Daten wurden geändert.'+#13+#10+
                    ''+#13+#10+
                    'Änderungen speichern (Ja)'+#13+#10+
                    'Änderungen verwerfen (Nein)'+#13+#10+
                    'Im Dialog bleiben (Abbrechen)'+#13+#10+'',
                     mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes :
      begin
        m_proto.save;
      end;
      mrNo :
      begin
        m_proto.cancel;
        reload
      end;
      else
        exit
    end;
  end;

  Data := GM.UnlockDocument(m_proto.ID, integer(ltProtokoll));
  if JBool(Data, 'result') then
  begin
    self.RO   := true;
    Caption   := m_proto.Title;
    m_locked  := false;
  end;
  ShowMessage(JString(Data, 'text'));
end;

procedure TProtokollForm.Aktualisieren1Click(Sender: TObject);
begin
  if m_ro then
    reload;
end;

procedure TProtokollForm.BitBtn1Click(Sender: TObject);
var
  i: integer;
  b: IBesucher;
begin
  if m_proto.ReadOnly then
    exit;

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

procedure TProtokollForm.BitBtn2Click(Sender: TObject);
var
  i: integer;
  b: IBesucher;
begin
  if m_proto.ReadOnly then
    exit;

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

procedure TProtokollForm.BitBtn3Click(Sender: TObject);
begin
  try
    Application.CreateForm(TPersonenListForm, PersonenListForm);
    PersonenListForm.Teilnehmer := m_proto.Teilnehmer;
    if PersonenListForm.ShowModal = mrOk then begin
      m_proto.Modified := true;
      UpdateTN;
    end;
  finally
    PersonenListForm.Free;
  end;
end;

procedure TProtokollForm.btnDeleteClick(Sender: TObject);
var
  i: integer;
  b: IBesucher;
begin
  if m_proto.ReadOnly then exit;
  if not(MessageDlg('Sollen die ausgwewählten Gäste gelöscht werden?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    exit;

  for i := pred(TG.Items.Count) downto 0 do
  begin
    if TG.Items.Item[i].Selected then
    begin
      b := IBesucher(TG.Items.Item[i].Data);
      m_proto.Besucher.remove(b);
    end;
  end;
  UpdateTG;
end;

procedure TProtokollForm.btnEditClick(Sender: TObject);
var
  b: IBesucher;
begin
  if not Assigned(TG.Selected) then
    exit;

  b := IBesucher(TG.Selected.Data);
  Application.CreateForm(TBesucherForm, BesucherForm);
  BesucherForm.Besucher := b;
  if BesucherForm.ShowModal = mrOk then
  begin
    m_proto.Besucher.saveChanged;
  end;
  BesucherForm.Free;

  UpdateTG;
end;

procedure TProtokollForm.btnNeuClick(Sender: TObject);
var
  b: IBesucher;
begin
  b := m_proto.Besucher.newBesucher;
  Application.CreateForm(TBesucherForm, BesucherForm);
  BesucherForm.Besucher := b;
  if BesucherForm.ShowModal = mrOk then
  begin
    m_proto.Besucher.saveChanged;
  end
  else
    m_proto.Besucher.remove(b);
  BesucherForm.Free;

  UpdateTG;
end;


procedure TProtokollForm.Button2Click(Sender: TObject);
begin
  Application.CreateForm(TAbwesenForm, AbwesenForm);
  if AbwesenForm.ShowModal = mrOk then
  begin
    setStatus(AbwesenForm.Status, AbwesenForm.grund);
  end;
  AbwesenForm.Free;
end;

procedure TProtokollForm.DBEdit1Change(Sender: TObject);
begin
  if not m_proto.ReadOnly then
    m_proto.Modified := true;
end;

procedure TProtokollForm.fillStatusMap;
var
  inx: integer;
  procedure addGrp(Status: TTeilnehmerStatus; name: string);
  var
    grp: TListGroup;
  begin
    grp := TN.Groups.add;
    grp.Header := name;
    grp.GroupID := inx;
    grp.FooterAlign := taRightJustify;

    m_statusMap.add(Status, inx);
    inc(inx);
  end;

var
  st: TTeilnehmerStatus;
begin
  inx := 0;
  for st := tsUnbekannt to tsLast do
    addGrp(st, TeilnehmerStatusToString(st));
end;

procedure TProtokollForm.ForceClose(force: boolean);
begin
  if force then begin
    if m_proto.Modified then
      save;
  end;

  self.close;
end;

procedure TProtokollForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  if m_locked then
    GM.UnlockDocument(m_proto.ID, integer(ltProtokoll));
end;

procedure TProtokollForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if m_proto.Modified then
  begin
    case MessageDlg('Die Daten wurden geändert.' + #13 + #10 + '' + #13 + #10 +
      'Änderungen speichern (Ja)' + #13 + #10 + 'Änderungen verwerfen (Nein)' +
      #13 + #10 + 'Im Dialog bleiben (Abbrechen)' + #13 + #10 + '',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          save;
          CanClose := true;
        end;
      mrNo:
        begin
          m_proto.cancel;
          CanClose := true;
        end;
    else
      CanClose := false;
    end;
  end;
end;

procedure TProtokollForm.FormCreate(Sender: TObject);
var
  i : integer;
  item : TMenuItem;
begin
  m_statusMap := TDictionary<TTeilnehmerStatus, integer>.create;

  PageControl1.ActivePage := TabSheet1;

  updateSeedBtn(self, 1);

  m_locked := true;

  m_grList := TGremiumListForm.create(self);
  m_proto := NIL;

  fillStatusMap;
  m_prid := 0;
  ProtocolFrame1.init;
  ProtocolFrame1.Browser := WebBrowser1;

  for i := low(arrRolls) to high(arrRolls) do
  begin
    item := TMenuItem.Create(PopupMenu1);
    PopupMenu1.Items.Add(item);
    item.Tag := i;
    if i = 0 then
      item.Caption := 'Rolle entfernen'
    else
      item.Caption  := arrRolls[i];
    item.OnClick    := RollChange;
  end;
end;

procedure TProtokollForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(m_grList);

  WindowHandler.closeProtoclWindow(m_proto.ID);

  ProtocolFrame1.Protocol := NIL;
  m_proto.release;
  m_proto := NIL;

  m_statusMap.Free;
  ProtocolFrame1.release;
end;

function TProtokollForm.getID: integer;
begin
  Result := -1;
  if Assigned(m_proto) then
    Result := m_proto.ID;
end;

procedure TProtokollForm.reload;
begin
  CodeSite.EnterMethod(self, 'reload');
  if Assigned(m_proto) then begin

    CodeSite.SendMsg('Altes Protokoll löschen');
    ProtocolFrame1.Protocol := NIL;

    m_proto.release;
    m_proto := nil;
  end;

  CodeSite.SendFmtMsg('Versuche Protokoll %d zu Laden', [m_prid]);
  m_proto := TProtocolImpl.create;
  if m_proto.load(m_prid) then
  begin
    CodeSite.SendFmtMsg('Laden Protokoll %d erfolgreich', [m_prid]);

    Caption       := m_proto.Title;
    DBEdit1.Text  := m_proto.Title;
    DBEdit2.Text  := IntToStr(m_proto.Nr);

    JvDBDateTimePicker1.DateTime := m_proto.Date;
    ProtocolFrame1.Protocol      := m_proto;

    UpdateTN;
    UpdateTG;

    WebBrowser1.Navigate('about:blank');
  end;
  CodeSite.SendAssigned('m_proto', pointer(m_proto));

  m_proto.Modified := false;
  CodeSite.ExitMethod(self, 'reload');
end;

procedure TProtokollForm.RollChange(Sender: TObject);
var
  roll : string;
  t: ITeilnehmer;
begin
  if not Assigned(TN.Selected) then exit;

  roll    := arrRolls[(Sender as TMenuItem).Tag];
  t       := ITeilnehmer(TN.Selected.Data);
  t.Rolle := roll;

  m_proto.Teilnehmer.saveChanged;
  m_proto.Modified := true;

  UpdateTN;
end;

procedure TProtokollForm.save;
begin
  if m_ro then
    exit;

  m_proto.Title := trim(DBEdit1.Text);
  m_proto.Nr := StrToIntDef(DBEdit2.Text, -1);
  m_proto.Date := JvDBDateTimePicker1.DateTime;
  m_proto.save;
end;

procedure TProtokollForm.setID(value: integer);
begin
  m_prid := value;
  reload;
end;

procedure TProtokollForm.setRO(value: Boolean);
begin
  m_ro := value;

  Sperren1.Enabled      := m_ro;
  Freigeben1.Enabled    := not m_ro;
  Aktualisieren1.Enabled:= m_ro;

  Panel1.Enabled        := not m_ro;
  Panel4.Enabled        := not m_ro;
  Panel3.Enabled        := not m_ro;

  Speichern.Enabled     := not m_ro;

  ProtocolFrame1.ReadOnly := m_ro;

  m_proto.ReadOnly      := m_ro;
  if m_ro then
    m_proto.cancel
  else
    m_proto.edit;
  if m_ro then
    StatusBar1.Panels.Items[0].Text := 'Schreibgeschützt'
  else
    StatusBar1.Panels.Items[0].Text := 'Bearbeitbar';
  StatusBar1.Invalidate;
end;

procedure TProtokollForm.setStatus(ts: TTeilnehmerStatus; grund: string);
var
  i: integer;
  t: ITeilnehmer;
begin
  if m_proto.ReadOnly then
    exit;

  for i := 0 to pred(TN.Items.Count) do
  begin
    if TN.Items.Item[i].Selected then
    begin
      t := ITeilnehmer(TN.Items.Item[i].Data);
      t.grund := grund;
      t.Status := ts
    end;
  end;
  m_proto.Teilnehmer.saveChanged;
  m_proto.Modified := true;

  UpdateTN;
end;

procedure TProtokollForm.SpeichernClick(Sender: TObject);
begin
  if m_ro then
    exit;

  m_proto.Title := Trim(DBEdit1.Text);
  m_proto.Nr    :=  StrToIntDef(DBEdit2.Text, m_proto.Nr );
  m_proto.Date  := JvDBDateTimePicker1.DateTime;

  m_proto.save;
  m_proto.edit;
end;

procedure TProtokollForm.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  RectForText: TRect;
begin
  StatusBar1.Canvas.Font.Style := [];
  if Panel.ID = 0 then begin
    if m_ro then begin
      StatusBar1.Canvas.Font.Color := clRed;
      StatusBar1.Canvas.Font.Style := [fsBold ];
    end
    else
      StatusBar1.Canvas.Font.Color := clGreen;
  end
  else begin
    StatusBar.Canvas.Font.Color := clBlack;
  end;

  RectForText := Rect;
  StatusBar1.Canvas.FillRect(RectForText);
  DrawText(StatusBar1.Canvas.Handle, PChar(Panel.Text), -1, RectForText, DT_SINGLELINE or DT_VCENTER or DT_LEFT);
end;

procedure TProtokollForm.TGDblClick(Sender: TObject);
begin
  btnEdit.Click;
end;

procedure TProtokollForm.UpdateTG;
var
  i: integer;
  b: IBesucher;
  Item: TListItem;
begin
  TG.Items.BeginUpdate;
  TG.Items.Clear;
  for i := 0 to pred(m_proto.Besucher.Count) do
  begin
    b := m_proto.Besucher.Item[i];
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

procedure TProtokollForm.UpdateTN;
var
  i: integer;
  t: ITeilnehmer;
  Item: TListItem;
  sum: array of integer;
  st : TTeilnehmerStatus;
begin
  SetLength(sum, integer(tsLast)+1);
  TN.Items.BeginUpdate;
  TN.Items.Clear;

  for i := 0 to pred(m_proto.Teilnehmer.Count) do
  begin
    t := m_proto.Teilnehmer.Item[i];
    Item := TN.Items.add;

    Item.Data := t;
    Item.GroupID := m_statusMap[t.Status];
    Item.Caption := t.name;
    Item.SubItems.add(t.Vorname);
    Item.SubItems.add(t.Abteilung);
    Item.SubItems.add(t.Rolle);
    Item.SubItems.add(t.grund);

    sum[integer(t.Status)] := sum[integer(t.Status)] + 1;
  end;
  for st := tsUnbekannt to tsLast do
    TN.Groups.Items[integer(st)].Footer := Format( 'Anzahl: %d', [sum[integer(st)]]);

  TN.Items.EndUpdate;
  SetLength(sum, 0);
end;


end.
