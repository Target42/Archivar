unit f_doMeeting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, fr_teilnehmer;

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
    TNFrame1: TTNFrame;
    TabSheet6: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_meid : integer;
    function GetMeetingID: integer;
    procedure SetMeetingID(const Value: integer);
  public
    property MeetingID: integer read GetMeetingID write SetMeetingID;
  end;

var
  DoMeetingform: TDoMeetingform;

implementation

{$R *.dfm}

procedure TDoMeetingform.FormCreate(Sender: TObject);
begin
  m_meid := 0;
  PageControl1.ActivePage := TabSheet1;
  TNFrame1.init;
end;

procedure TDoMeetingform.FormDestroy(Sender: TObject);
begin
  TNFrame1.release;
  DoMeetingform := NIL;
end;

function TDoMeetingform.GetMeetingID: integer;
begin
  Result := m_meid;
end;

procedure TDoMeetingform.SetMeetingID(const Value: integer);
begin
  m_meid := value;
end;

end.
