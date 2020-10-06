unit f_chapterEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, u_chapter, Vcl.StdCtrls,
  Vcl.ExtCtrls, fr_editForm;

type
  TChapterEditForm = class(TForm)
    BaseFrame1: TBaseFrame;
    Panel1: TPanel;
    EditFrame1: TEditFrame;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    procedure CheckBox1Click(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    m_cp : TChapter;
    procedure setCP( value : TChapter );
  public
    property CP : TChapter read m_cp write setCP;
  end;

var
  ChapterEditForm: TChapterEditForm;

implementation

{$R *.dfm}

{ TChapterEditForm }

procedure TChapterEditForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  m_cp.Numbering  := CheckBox1.Checked;
  m_cp.Name       := LabeledEdit1.Text;
  m_cp.Rem        := EditFrame1.getText;
end;

procedure TChapterEditForm.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    if Assigned(m_cp.Owner) then
      m_cp.Owner.Childs.renumber;
    LabeledEdit2.Text := IntToStr( cp.Nr);
  end
  else
    LabeledEdit2.Text := '';
end;

procedure TChapterEditForm.setCP(value: TChapter);
begin
  m_cp := value;
  CheckBox1.Checked := m_cp.Numbering;
  LabeledEdit1.Text := m_cp.Name;
  EditFrame1.setText(m_cp.Rem);
end;

end.
