unit f_protocol_sec;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, i_chapter,
  fr_chapter, Vcl.Buttons, System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TProtocolSectionForm = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    ChapterFrame1: TChapterFrame;
    MainMenu1: TMainMenu;
    Abschnitt1: TMenuItem;
    ActionList1: TActionList;
    ac_lock: TAction;
    ac_unlock: TAction;
    Bearbeiten1: TMenuItem;
    Bearbeitenbeenden1: TMenuItem;
    ac_refresh: TAction;
    N1: TMenuItem;
    Aktualisieren1: TMenuItem;
    Speichern1: TMenuItem;
    N2: TMenuItem;
    ac_ave: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ac_lockExecute(Sender: TObject);
    procedure ac_unlockExecute(Sender: TObject);
    procedure ac_refreshExecute(Sender: TObject);
    procedure ac_aveExecute(Sender: TObject);
  private
    m_proto : IProtocol;
    m_locked: boolean;
    m_prid  : integer;
    m_ctid  : integer;
    m_title : string;

    function GetPRID: integer;
    procedure SetPRID(const Value: integer);

    procedure setLocked( flag : boolean );
    procedure reloadDoc;
  public
    property PRID: integer read GetPRID write SetPRID;
  end;

var
  ProtocolSectionForm: TProtocolSectionForm;

implementation

uses
  u_ProtocolImpl, u_speedbutton, m_glob_client, u_berTypes, System.JSON, u_json;

{$R *.dfm}

{ TProtocolSectionForm }

procedure TProtocolSectionForm.ac_aveExecute(Sender: TObject);
begin
  if not m_locked or not Assigned(m_proto) then
    exit;

  ChapterFrame1.save;
  m_proto.save;
end;

procedure TProtocolSectionForm.ac_lockExecute(Sender: TObject);
var
  nr : integer;
  ct : IChapterTitle;
  obj : TJSONObject;
begin
  if (ComboBox1.ItemIndex = -1) or m_locked then
    exit;

  nr := integer(ComboBox1.Items.Objects[ ComboBox1.ItemIndex ]);
  ct := m_proto.Chapter.Items[ nr ];

  m_ctid := ct.ID;
  m_title:= ct.FullTitle;

  obj := gm.LockDocument(m_proto.ID, integer(ltProtokoll), m_ctid);
  if not JBool(obj, 'result') then
    ShowMessage(JString(obj, 'text'))
  else
  begin
    setLocked(true);
    reloadDoc;
    ShowMessage('Der Protokollabschnitt kann jetzt bearbeitet werden.');
  end;
end;

procedure TProtocolSectionForm.ac_refreshExecute(Sender: TObject);
begin
  if m_locked then
    reloadDoc
  else
    ShowMessage('In der Bearbeitung kann das Dokument nicht aktualisiert werden.');
end;

procedure TProtocolSectionForm.ac_unlockExecute(Sender: TObject);
var
  data : TJSONObject;
begin
  if not m_locked then
    exit;

  Data := GM.UnLockDocument(m_proto.ID, integer(ltProtokoll), m_ctid);
  if JBool(Data, 'result') then
  begin
    setLocked(false);
  end;
end;

procedure TProtocolSectionForm.ComboBox1Change(Sender: TObject);
var
  nr : integer;
begin
  if ComboBox1.Items.Count = 0 then
    exit;
  nr := integer(ComboBox1.Items.Objects[ ComboBox1.ItemIndex ]);

  ChapterFrame1.Chapter := m_proto.Chapter.Items[ nr ];
end;

procedure TProtocolSectionForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TProtocolSectionForm.FormCreate(Sender: TObject);
begin
  m_locked := true;
  m_proto := NIL;
  m_prid  := 0;
  m_ctid  := 0;
  updateSeedBtn( self, 1 );
  ChapterFrame1.prepare( NIL );
end;

procedure TProtocolSectionForm.FormDestroy(Sender: TObject);
begin
  if m_locked then
    GM.UnLockDocument(m_proto.ID, integer(ltProtokoll), m_ctid);

  m_proto.release;
  ChapterFrame1.Shutdown;
end;

function TProtocolSectionForm.GetPRID: integer;
begin
  Result := -1;

  if Assigned(m_proto) then
    Result := m_proto.ID;
end;

procedure TProtocolSectionForm.reloadDoc;
var
  i : integer;
  cp : IChapterTitle;
begin
  if Assigned(m_proto) then
  begin
    ComboBox1.Items.Clear;
    m_proto.release;
  end;

  m_proto := TProtocolImpl.create;
  if m_proto.load(m_prid) then
  begin
    for i := 0 to pred(m_proto.Chapter.Count) do
    begin
      cp := m_proto.Chapter.Items[i];
      ComboBox1.Items.AddObject(cp.FullTitle, TObject(i) );
      if m_ctid = cp.ID then
        ComboBox1.ItemIndex := i;
    end;

    if (ComboBox1.Items.Count > 0) and ( ComboBox1.ItemIndex = -1 ) then
      ComboBox1.ItemIndex := 0;

    if ComboBox1.ItemIndex > -1 then
      ComboBox1Change(NIL);
  end;
end;

procedure TProtocolSectionForm.setLocked(flag: boolean);
begin
  m_locked := flag;

  ChapterFrame1.ReadOnly  := not m_locked;
  ComboBox1.Enabled       := not m_locked;
  ac_lock.Enabled         := not m_locked;
  ac_unlock.Enabled       := m_locked;
  ac_refresh.Enabled      := not m_locked;
  ac_ave.Enabled          := m_locked;

  if m_locked then
    Caption := m_proto.Title + ' - '+ m_title
  else
    Caption := m_proto.Title;
end;

procedure TProtocolSectionForm.SetPRID(const Value: integer);
begin
  ChapterFrame1.ReadOnly := true;
  m_prid := value;

  reloadDoc;
  setLocked(false );
end;

end.
