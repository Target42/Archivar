unit f_doMeeting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.ExtCtrls, i_chapter, Data.DB, Datasnap.DBClient, Datasnap.DSConnect,
  fr_protocol, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw, fr_MeetingTN, u_stub,
  System.JSON, Vcl.Buttons, fr_beschluss, i_beschluss;

type
  TDoMeetingform = class(TForm)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
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
    procedure BeschlussFrame1BitBtn4Click(Sender: TObject);
  private
    m_meid  : integer;
    m_prid  : integer;
    m_lead  : integer;
    m_proto : IProtocol;

    m_hell  : TdsSitzungClient;

    procedure reload;

    procedure Select( beid : integer );

    function GetMeetingID: integer;
    procedure SetMeetingID(const Value: integer);

    procedure doVote( value : integer );
    procedure VoteStop( cancel : boolean );

    procedure saveBeschlus( be : IBeschluss);

    procedure QuerySave;

    function handle_meeting(const arg : TJSONObject ) : boolean;
    function handle_requestLead(const arg : TJSONObject ) : boolean;
    function handle_changeLead(const arg : TJSONObject ) : boolean;
    function handle_docUpdate(const arg : TJSONObject ) : boolean;

    function handle_voteStart(const arg : TJSONObject ) : boolean;
    function handle_voteStop(const arg : TJSONObject ) : boolean;
    function handle_vote(const arg : TJSONObject ) : boolean;
  public
    property ELID: integer read GetMeetingID write SetMeetingID;
  end;

var
  DoMeetingform: TDoMeetingform;

implementation

uses
  m_glob_client, u_ProtocolImpl, u_json, system.UITypes, u_eventHandler, u_Konst,
  f_abstimmung;

{$R *.dfm}

procedure TDoMeetingform.BeschlussFrame1BitBtn4Click(Sender: TObject);
var
  req, res : TJSONObject;
begin
  if not Assigned(BeschlussFrame1.Beschluss) then begin
    ShowMessage('Es ist kein Beschluss ausgewählt!');
    exit;
  end;

  req := TJSONObject.Create;

  JReplace( req, 'sub', 'start');
  JReplace( req, 'beid', BeschlussFrame1.Beschluss.ID);
  JReplace( req, 'lead', m_lead );
  JReplace( req, 'meid', m_meid);

  res := Self.m_hell.startVote( req );

  ShowResult( res );
end;

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

  JReplace( req, 'id',    m_meid);
  JReplace( req, 'peid',  GM.UserID);

  m_hell.requestLead( req);
end;

procedure TDoMeetingform.doVote(value: integer);
var
  req, res : TJSONObject;
begin
  if not Assigned(AbstimmungsForm) then
    exit;

  req := TJSONObject.Create;

  JReplace( req, 'meid', m_meid);
  JReplace( req, 'beid', AbstimmungsForm.BEID );
  JReplace( req, 'usid', GM.UserID);
  JReplace( req, 'vote',  value);

  res := m_hell.Vote(req);
  ShowResult( res );
end;

procedure TDoMeetingform.FormClose(Sender: TObject; var Action: TCloseAction);
var
  req : TJSONObject;
begin
  Action := caFree;

  QuerySave;

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
  BeschlussFrame1.hasLead       := false;

  ProtocolFrame1.onBeschlusChange := BeschlussFrame1.setBeschluss;
  ProtocolFrame1.MeetingMode := true;

  MeetingTNFrame1.init;

  m_hell := TdsSitzungClient.Create(DSProviderConnection1.SQLConnection.DBXConnection);
  MeetingTNFrame1.Client  := m_hell;
  BeschlussFrame1.Hell    := m_hell;

  MeetingTNFrame1.Enabled := false;
  TabSheet6.Enabled       := false;

  EventHandler.Register( self, handle_meeting,      BRD_MEETING);
  EventHandler.Register( self, handle_requestLead,  BRD_LEAD_REQ);
  EventHandler.Register( self, handle_changeLead,   BRD_LEAD_CHG );
  EventHandler.Register( self, handle_docUpdate,    BRD_DOC_UPDATE );
  EventHandler.Register( self, handle_voteStart,    BRD_VOTE_START );
  EventHandler.Register( self, handle_voteStop,     BRD_VOTE_END );
  EventHandler.Register( self, handle_vote,         BRD_VOTE );

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

  if Assigned(EventHandler) then
    EventHandler.Unregister(self);

  if Assigned(AbstimmungsForm) then
    FreeAndNil(AbstimmungsForm);
end;

function TDoMeetingform.GetMeetingID: integer;
begin
  Result := m_meid;
end;

function TDoMeetingform.handle_changeLead(const arg: TJSONObject): boolean;
var
  lead  : integer;
  name  : string;
  id    : integer;
begin
  Result  := false;
  id      := JInt( arg, 'id');
  if id <> m_meid then
    exit;

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

  MeetingTNFrame1.Enabled := m_lead = GM.UserID;
  TabSheet6.Enabled := m_lead = GM.UserID;
  BitBtn6.Visible   := m_lead = GM.UserID;
  BitBtn7.Visible   := m_lead = GM.UserID;
  m_proto.ReadOnly  := m_lead <>GM.UserID;

  BeschlussFrame1.hasLead := m_lead = GM.UserID;

  ProtocolFrame1.ReadOnly := m_lead <> GM.UserID;

  Result := true;
end;

function TDoMeetingform.handle_docUpdate(const arg: TJSONObject): boolean;
begin
  reload;

  Result := true;
end;

function TDoMeetingform.handle_meeting(const arg: TJSONObject): boolean;
begin
  TNQry.ParamByName('pr_id').AsInteger := m_prid;
  TNQry.Open;
  m_proto.Teilnehmer.loadFromSrc(TNQry);
  TNQry.Close;

  MeetingTNFrame1.Teilnehmer  := m_proto.Teilnehmer;

  Result := true;
end;

function TDoMeetingform.handle_requestLead(const arg: TJSONObject): boolean;
var
  lead  : integer;
  req   : TJSONObject;
  name  : string;
  id    : Integer;
begin
  Result  := false;
  id      := JInt( arg, 'id');
  if id <> m_meid then
    exit;

  lead    := JInt( arg, 'lead');
  if lead = GM.UserID then begin
    name := Format('%s %s (%s) möchte die Sitzungsleitung übernehmen.',
      [
        JString(arg, 'name'),
        JString(arg, 'vorname'),
        JString(arg, 'dept')]);

    if (MessageDlg(name, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
      m_proto.save;

      ProtocolFrame1.ReadOnly := true;
      Req := TJSONObject.Create;

      JReplace( req, 'id',  m_meid);
      JReplace( req, 'newid', JInt( arg, 'newid'));

      m_hell.changeLead(req);
    end;
  end;
  Result := true;
end;

function TDoMeetingform.handle_vote(const arg: TJSONObject): boolean;
begin
  Result := false;
  if Assigned(AbstimmungsForm) then begin
    AbstimmungsForm.handle_vote(arg);
    Result := true;
  end;
end;

function TDoMeetingform.handle_voteStart(const arg: TJSONObject): boolean;
begin
  if not  Assigned( AbstimmungsForm ) then begin
    Application.CreateForm(TAbstimmungsForm, AbstimmungsForm);
    AbstimmungsForm.doVote    := doVote;
    AbstimmungsForm.VoteStop  := VoteStop;

    AbstimmungsForm.Show;
  end
  else
    AbstimmungsForm.BringToFront;


  Result := Assigned(AbstimmungsForm);
  if Result then begin
    AbstimmungsForm.handle_voteStart(arg);
    AbstimmungsForm.hasLead := m_lead = JInt( arg, 'lead');
    Select( AbstimmungsForm.BEID );
  end;
end;

function TDoMeetingform.handle_voteStop(const arg: TJSONObject): boolean;
begin
  Result := false;
  if Assigned(AbstimmungsForm) then begin
    AbstimmungsForm.handle_voteStop(arg);
    Result := true;
  end;

end;

procedure TDoMeetingform.ProtocolFrame1ac_beschlussExecute(Sender: TObject);
begin
  ProtocolFrame1.ac_beschlussExecute(Sender);

end;

procedure TDoMeetingform.QuerySave;
begin
  if m_proto.Modified then begin
    if (MessageDlg('Sollen die Änderungen gespeichert werden?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
      m_proto.save;
    end;
  end;
end;

procedure TDoMeetingform.reload;
begin
  Screen.Cursor := crHourGlass;

  WebBrowser1.Navigate('about:blank');
  try
    if Assigned(m_proto) then
      m_proto.release;
    m_proto := NIL;

    m_proto := TProtocolImpl.create;

    if m_proto.load(m_prid) then
    begin
      Caption                     := m_proto.Title;
      ProtocolFrame1.Protocol     := m_proto;
      MeetingTNFrame1.Teilnehmer  := m_proto.Teilnehmer;

    end;
    m_proto.Modified := false;
  except

  end;
  Screen.Cursor := crDefault;
end;

procedure TDoMeetingform.saveBeschlus(be: IBeschluss);
var
  req : TJSONObject;
begin
  if not Assigned(be) or not Assigned( be.Owner)  then
    exit;

  be.Owner.saveModified;
  m_proto.save;

  req := TJSONObject.Create;

  JReplace( req, 'type',    'beschluss' );
  JReplace( req, 'prid',    m_proto.ID);
  JReplace( req, 'beid',    be.ID );
  JReplace( req, 'sender',  GM.UserID );

  m_hell.updateDocument( req );
end;

procedure TDoMeetingform.Select(beid: integer);
begin
  ProtocolFrame1.SelectBeschlus(beid);
end;

procedure TDoMeetingform.SetMeetingID(const Value: integer);
var
  res, req : TJSONObject;
  lead  : integer;
  name  : string;
begin
  m_meid := value;

  ELTab.Open;

  if ELTab.Locate('EL_ID', VarArrayOf([m_meid]), []) then begin
    m_prid := ELTab.FieldByName('PR_ID').AsInteger;
  end;

  ELTab.Close;

  MeetingTNFrame1.ELID := m_meid;

  req := TJSONObject.Create;
  JReplace( req, 'id', m_meid);

  res := m_hell.enter(req);

  lead := JInt( res, 'lead');
  if lead = -1 then
    Panel1.Caption := ''
  else begin
      name := Format('%s %s (%s)',
      [
        JString(res, 'name'),
        JString(res, 'vorname'),
        JString(res, 'dept')]);
      Panel1.Caption := name;
  end;

  ShowResult( res );

  reload;
end;

procedure TDoMeetingform.VoteStop(cancel: boolean);
var
  req, res : TJSONObject;
begin
  req := TJSONObject.Create;
  JReplace( req, 'meid', m_meid);
  JReplace( req, 'beid', AbstimmungsForm.BEID );
  JReplace( req, 'usid', GM.UserID);
  JReplace( req, 'cancel', cancel );

  res := m_hell.endVote(req);
  ShowResult( res );
end;

initialization
  DoMeetingform := NIL;
end.
