unit f_protocol_sec;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, i_chapter,
  fr_chapter, Vcl.Buttons;

type
  TProtocolSectionForm = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    ChapterFrame1: TChapterFrame;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    m_proto : IProtocol;
    m_locked: boolean;
    m_ctid  : integer;
    function GetPRID: integer;
    procedure SetPRID(const Value: integer);
    { Private-Deklarationen }
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

procedure TProtocolSectionForm.BitBtn1Click(Sender: TObject);
var
  nr : integer;
  ct : IChapterTitle;
  obj : TJSONObject;
begin
  if ComboBox1.ItemIndex = -1 then
    exit;

  nr := integer(ComboBox1.Items.Objects[ ComboBox1.ItemIndex ]);
  ct := m_proto.Chapter.Items[ nr ];
  m_ctid := ct.ID;

  obj := gm.LockDocument(m_proto.ID, integer(ltProtokoll), m_ctid);
  if not JBool(obj, 'result') then
    ShowMessage(JString(obj, 'text'))
  else
  begin
    m_locked := true;
    ShowMessage('Das Protokoll kann jetzt bearbeitet werden.');
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
  m_proto := NIL;
  updateSeedBtn( self, 1 );
  ChapterFrame1.prepare( NIL );

  m_locked := false;
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

procedure TProtocolSectionForm.SetPRID(const Value: integer);
var
  i : integer;
begin
  ChapterFrame1.ReadOnly := true;
  m_proto := TProtocolImpl.create;
  if m_proto.load(value) then
  begin
    for i := 0 to pred(m_proto.Chapter.Count) do
    begin
      ComboBox1.Items.AddObject(m_proto.Chapter.Items[i].FullTitle, TObject(i) );
    end;
    if ComboBox1.Items.Count > 0 then
    begin
      ComboBox1.ItemIndex := 0;
      ComboBox1Change(NIL);
    end;
  end;
end;

end.
