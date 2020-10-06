unit f_chapter_content;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_chapter, fr_base, u_titel,
  Datasnap.DSConnect;

type
  TChapterContentForm = class(TForm)
    BaseFrame1: TBaseFrame;
    ChapterFrame1: TChapterFrame;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_cp : TChapterTitle;
    function GetChapterTitle: TChapterTitle;
    procedure SetChapterTitle(const Value: TChapterTitle);
  public
    property ChapterTitle: TChapterTitle read GetChapterTitle write SetChapterTitle;
  end;

var
  ChapterContentForm: TChapterContentForm;

implementation

{$R *.dfm}

{ TChapterContentForm }

procedure TChapterContentForm.BaseFrame1AbortBtnClick(Sender: TObject);
begin
  ChapterFrame1.cancel;
end;

procedure TChapterContentForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  ChapterFrame1.save;
  m_cp.xChapter := ChapterFrame1.xChapter;
end;

procedure TChapterContentForm.FormCreate(Sender: TObject);
begin
  ChapterFrame1.prepare( nil );
end;

procedure TChapterContentForm.FormDestroy(Sender: TObject);
begin
  ChapterFrame1.Shutdown;
end;

function TChapterContentForm.GetChapterTitle: TChapterTitle;
begin
  Result := m_cp;
end;

procedure TChapterContentForm.SetChapterTitle(const Value: TChapterTitle);
begin
  m_cp := value;

  ChapterFrame1.CP_ID := m_cp.ID;
  ChapterFrame1.Label2.Caption := m_cp.Text;
end;


end.
