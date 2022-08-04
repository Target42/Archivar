unit f_chapterTask;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB,
  Vcl.StdCtrls, Vcl.ExtCtrls, fr_form,
  i_chapter;

type
  TChapterTaskForm = class(TForm)
    BaseFrame1: TBaseFrame;
    Panel1: TPanel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    CheckBox1: TCheckBox;
    FormFrame1: TFormFrame;
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_cp : IChapter;
    procedure setCP( value : IChapter );
  public
    property CP : IChapter read m_cp write setCP;

  end;

var
  ChapterTaskForm: TChapterTaskForm;

implementation



{$R *.dfm}

{ TChapterTaskForm }

procedure TChapterTaskForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  m_cp.Numbering  := CheckBox1.Checked;
  m_cp.Name       := LabeledEdit1.Text;
end;

procedure TChapterTaskForm.FormCreate(Sender: TObject);
begin
  FormFrame1.prepare;
end;

procedure TChapterTaskForm.FormDestroy(Sender: TObject);
begin
  FormFrame1.releaseData;
end;

procedure TChapterTaskForm.setCP(value: IChapter);
var
  h     : integer;
  delta : integer;
begin
  m_cp := value;

  CheckBox1.Checked := m_cp.Numbering;
  LabeledEdit1.Text := m_cp.Name;

  FormFrame1.loadByID( m_cp.TAID);
  FormFrame1.readOnly := true;

  h := FormFrame1.getHeight;
  if h > FormFrame1.Height then
  begin
    delta := h - FormFrame1.Height;
    if Screen.Height >  self.Height + delta + 8 then
      self.Height := self.Height + delta + 8;
  end;
end;

end.
