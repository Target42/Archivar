unit f_chapter_content;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_chapter, fr_base,
  Datasnap.DSConnect, i_chapter;

type
  TChapterContentForm = class(TForm)
    BaseFrame1: TBaseFrame;
    ChapterFrame1: TChapterFrame;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_cp : IChapterTitle;
    function GetChapterTitle: IChapterTitle;
    procedure SetChapterTitle(const Value: IChapterTitle);
  public
    property ChapterTitle: IChapterTitle read GetChapterTitle write SetChapterTitle;
  end;

var
  ChapterContentForm: TChapterContentForm;

implementation

{$R *.dfm}

uses
  u_speedbutton;
{ TChapterContentForm }

procedure TChapterContentForm.BaseFrame1AbortBtnClick(Sender: TObject);
begin
  ChapterFrame1.cancel;
end;

procedure TChapterContentForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  ChapterFrame1.save;
end;

procedure TChapterContentForm.FormCreate(Sender: TObject);
begin
  updateSeedBtn( self, 1 );
  ChapterFrame1.prepare(NIL);
end;

procedure TChapterContentForm.FormDestroy(Sender: TObject);
begin
  ChapterFrame1.Shutdown;
end;

function TChapterContentForm.GetChapterTitle: IChapterTitle;
begin
  Result := m_cp;
end;

procedure TChapterContentForm.SetChapterTitle(const Value: IChapterTitle);
begin
  m_cp := value;
  ChapterFrame1.Chapter := m_cp;
end;


end.
