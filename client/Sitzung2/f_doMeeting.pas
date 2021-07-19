unit f_doMeeting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, fr_teilnehmer,
  Vcl.ExtCtrls, i_chapter, Data.DB, Datasnap.DBClient, Datasnap.DSConnect,
  fr_protocol, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw, fr_MeetingTN, u_stub,
  System.JSON, Vcl.Buttons, fr_editForm, fr_beschluss, i_beschluss;

type
  TDoMeetingform = class(TForm)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    Splitter1: TSplitter;
    DSProviderConnection1: TDSProviderConnection;
    ELTab: TClientDataSet;
    Übersicht: TGroupBox;
    ProtocolFrame1: TProtocolFrame;
    MeetingTNFrame1: TMeetingTNFrame;
    TNQry: TClientDataSet;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    WebBrowser1: TWebBrowser;
    Panel4: TPanel;
    GroupBox3: TGroupBox;
    Splitter2: TSplitter;
    GroupBox2: TGroupBox;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BeschlussFrame1: TBeschlussFrame;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure ProtocolFrame1ac_beschlussExecute(Sender: TObject);
  private
    m_meid  : integer;
    m_prid  : integer;
    m_lead  : integer;
    m_proto : IProtocol;

    m_hell  : TdsSitzungClient;

    procedure reload;

    function GetMeetingID: integer;
    procedure SetMeetingID(const Value: integer);

    procedure doVote( value : integer );
    procedure saveBeschlus( be : IBeschluss);
  public
    property ELID: integer read GetMeetingID write SetMeetingID;

    procedure exec( arg : TJSONObject );
  end;

var
  DoMeetingform: TDoMeetingform;

implementation

uses
  m_glob_client, u_ProtocolImpl, u_json, system.UITypes;

{$R *.dfm}

procedure TDoMeetingform.BitBtn1Click(Sender: TObject);
var
  req : TJSONObject;
begin
  if m_lead <> GM.UserID then begin
    ShowMessage('Du hast nicht die Sitzungleitung!');
    exit;
  end;

  req := TJSONObject.Create;

  JReplace( req, 'id',  m_meid);
  JReplace( req, 'newid', -1);

  m_hell.changeLead( req );

end;

procedure TDoMeetingform.BitBtn2Click(Sender: TObject);
begin
  doVote(+1);
end;

procedure TDoMeetingform.BitBtn3Click(Sender: TObject);
begin
  doVote(0);
end;

procedure TDoMeetingform.BitBtn4Click(Sender: TObject);
begin
  doVote(-1);
end;

procedure TDoMeetingform.BitBtn5Click(Sender: TObject);
begin
  doVote(-2);
end;

procedure TDoMeetingform.Button1Click(Sender: TObject);
var
  req : TJSONObject;
begin
  if m_lead = GM.UserID then begin
    ShowMessage('Du hast schon die Sitzungleitung!');
    exit;
  end;

  req := TJSONObject.Create;

  JReplace( req, 'id',  m_meid);
  JReplace( req, 'peid',  GM.UserID);

  m_hell.requestLead( req);

end;

procedure TDoMeetingform.doVote(value: integer);
var
  req, res : TJSONObject;
begin
  req := TJSONObject.Create;
  JReplace( req, 'vote',  value);

  res := m_hell.Vote(req);
  ShowResult( res );
end;

procedure TDoMeetingform.exec(arg: TJSONObject);
var
  cmd   : string;
  lead  : integer;
  req   : TJSONObject;
  name  : string;
begin
  cmd := lowerCase(Jstring( arg, 'action'));
  if cmd = 'meeting' then begin
    TNQry.ParamByName('pr_id').AsInteger := m_prid;
    TNQry.Open;
    m_proto.Teilnehmer.loadFromSrc(TNQry);
    TNQry.Close;

    MeetingTNFrame1.Teilnehmer  := m_proto.Teilnehmer;

  end else if cmd = 'requestlead' then begin
    lead := JInt( arg, 'lead');
    if lead = GM.UserID then begin
      name := Format('%s %s (%s) möchte die Sitzungsleitung übernehmen.',
        [
          JString(arg, 'name'),
          JString(arg, 'vorname'),
          JString(arg, 'dept')]);

      if (MessageDlg(name, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
        ProtocolFrame1.ReadOnly := true;
        Req := TJSONObject.Create;

        JReplace( req, 'id',  m_meid);
        JReplace( req, 'newid', JInt( arg, 'newid'));

        m_hell.changeLead(req);
      end;
    end;
  end else if cmd = 'changelead' then begin
    lead := JInt( arg, 'lead');
    m_lead := lead;
    if lead = -1 then
      Panel1.Caption := ''
    else begin
        name := Format('%s %s (%s)',
        [
          JString(arg, 'name'),
          JString(arg, 'vorname'),
          JString(arg, 'dept')]);
        Panel1.Caption := name;
    end;
    TabSheet5.Enabled := m_lead = GM.UserID;
    TabSheet6.Enabled := m_lead = GM.UserID;
    BitBtn6.Visible   := m_lead = GM.UserID;
    BitBtn7.Visible   := m_lead = GM.UserID;
    m_proto.ReadOnly  := m_lead <> GM.UserID;

    ProtocolFrame1.ReadOnly := m_lead <> GM.UserID;
  end;
end;

procedure TDoMeetingform.FormClose(Sender: TObject; var Action: TCloseAction);
var
  req : TJSONObject;
begin
  Action := caFree;

  req := TJSONObject.Create;
  JReplace( req, 'id', m_meid);
  m_hell.leave(req);
end;

procedure TDoMeetingform.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_meid  := 0;
  m_proto := NIL;
  m_lead  := -1;

  PageControl1.ActivePage := TabSheet1;
  ProtocolFrame1.init;
  ProtocolFrame1.Browser := WebBrowser1;

  BeschlussFrame1.init;
  BeschlussFrame1.SaveBeschluss := self.saveBeschlus;

  ProtocolFrame1.onBeschlusChange := BeschlussFrame1.setBeschluss;
  ProtocolFrame1.MeetingMode := true;

  MeetingTNFrame1.init;

  m_hell := TdsSitzungClient.Create(DSProviderConnection1.SQLConnection.DBXConnection);
  MeetingTNFrame1.Client := m_hell;

  TabSheet5.Enabled := false;
  TabSheet6.Enabled := false;

end;

procedure TDoMeetingform.FormDestroy(Sender: TObject);
begin
  ProtocolFrame1.onBeschlusChange := NIL;
  m_hell.Free;

  BeschlussFrame1.release;
  ProtocolFrame1.release;
  MeetingTNFrame1.release;

  DoMeetingform := NIL;

  if Assigned(m_proto) then
    m_proto.release;
  m_proto := NIL;

  DoMeetingform := NIL;
  PostMessage( Application.MainFormHandle, msgMeetingEnd, 0, 0 );
end;

function TDoMeetingform.GetMeetingID: integer;
begin
  Result := m_meid;
end;

procedure TDoMeetingform.ProtocolFrame1ac_beschlussExecute(Sender: TObject);
begin
  ProtocolFrame1.ac_beschlussExecute(Sender);

end;

procedure TDoMeetingform.reload;
begin
  if Assigned(m_proto) then
    m_proto.release;

  m_proto := TProtocolImpl.create;

  if m_proto.load(m_prid) then
  begin
    Caption                     := m_proto.Title;
    ProtocolFrame1.Protocol     := m_proto;
    MeetingTNFrame1.Teilnehmer  := m_proto.Teilnehmer;

    WebBrowser1.Navigate('about:blank');
  end;
  m_proto.Modified := false;
end;

procedure TDoMeetingform.saveBeschlus(be: IBeschluss);
begin
  if not Assigned(be) or not Assigned( be.Owner)  then
    exit;

  be.Owner.saveModified;
end;

procedure TDoMeetingform.SetMeetingID(const Value: integer);
var
  res, req : TJSONObject;
begin
  m_meid := value;

  ELTab.Open;

  if ELTab.Locate('EL_ID', VarArrayOf([m_meid]), []) then begin
    m_prid := ELTab.FieldByName('PR_ID').AsInteger;
  end else
    ELTab.Close;

  MeetingTNFrame1.ELID := m_meid;

  req := TJSONObject.Create;
  JReplace( req, 'id', m_meid);

  res := m_hell.enter(req);
  ShowResult( res );

  reload;
end;

initialization
  DoMeetingform := NIL;
end.
