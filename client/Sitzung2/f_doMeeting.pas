unit f_doMeeting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, fr_teilnehmer,
  Vcl.ExtCtrls, i_chapter, Data.DB, Datasnap.DBClient, Datasnap.DSConnect,
  fr_protocol, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw, fr_MeetingTN, u_stub,
  System.JSON;

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
    WebBrowser1: TWebBrowser;
    �bersicht: TGroupBox;
    ProtocolFrame1: TProtocolFrame;
    MeetingTNFrame1: TMeetingTNFrame;
    TNQry: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    m_meid  : integer;
    m_prid  : integer;
    m_proto : IProtocol;
    m_hell  : TdsSitzungClient;

    procedure reload;

    function GetMeetingID: integer;
    procedure SetMeetingID(const Value: integer);
  public
    property ELID: integer read GetMeetingID write SetMeetingID;

    procedure exec( arg : TJSONObject );
  end;

var
  DoMeetingform: TDoMeetingform;

implementation

uses
  m_glob_client, u_ProtocolImpl, u_json;

{$R *.dfm}

procedure TDoMeetingform.exec(arg: TJSONObject);
begin
  TNQry.ParamByName('pr_id').AsInteger := m_prid;
  TNQry.Open;
  m_proto.Teilnehmer.loadFromSrc(TNQry);
  TNQry.Close;

  MeetingTNFrame1.Teilnehmer  := m_proto.Teilnehmer;
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

  PageControl1.ActivePage := TabSheet1;
  ProtocolFrame1.init;
  ProtocolFrame1.Browser := WebBrowser1;

  MeetingTNFrame1.init;

  m_hell := TdsSitzungClient.Create(DSProviderConnection1.SQLConnection.DBXConnection);

end;

procedure TDoMeetingform.FormDestroy(Sender: TObject);
begin

  m_hell.Free;

  ProtocolFrame1.release;
  DoMeetingform := NIL;

  MeetingTNFrame1.release;

  if Assigned(m_proto) then
    m_proto.release;
  m_proto := NIL;

  DoMeetingform := NIL;
end;

function TDoMeetingform.GetMeetingID: integer;
begin
  Result := m_meid;
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


  req := TJSONObject.Create;
  JReplace( req, 'id', m_meid);

  res := m_hell.enter(req);
  ShowResult( res );

  reload;
end;

initialization
  DoMeetingform := NIL;
end.
