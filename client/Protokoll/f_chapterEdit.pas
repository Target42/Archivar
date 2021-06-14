unit f_chapterEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.StdCtrls,
  Vcl.ExtCtrls, fr_editForm, i_chapter, fr_textblock, Vcl.Buttons;

type
  TChapterEditForm = class(TForm)
    BaseFrame1: TBaseFrame;
    Panel1: TPanel;
    EditFrame1: TEditFrame;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    TextBlockFrame1: TTextBlockFrame;
    SpeedButton1: TSpeedButton;
    procedure CheckBox1Click(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditFrame1REDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure EditFrame1REDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    m_cp : IChapter;
    procedure setCP( value : IChapter );
  public
    property CP : IChapter read m_cp write setCP;
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
  m_cp.Rem        := EditFrame1.Text;
end;

procedure TChapterEditForm.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    if Assigned(m_cp.Parent) then
      m_cp.Parent.Childs.renumber;
    LabeledEdit2.Text := IntToStr( cp.Nr);
  end
  else
    LabeledEdit2.Text := '';
end;

procedure TChapterEditForm.EditFrame1REDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  text : string;
begin
  if sender = Source then
    exit;
  if (source = TextBlockFrame1.LV)  and( Sender = EditFrame1.RE) then
  begin
    if TextBlockFrame1.getContent(text) then
      EditFrame1.Add(text);
  end;
end;

procedure TChapterEditForm.EditFrame1REDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;

procedure TChapterEditForm.FormCreate(Sender: TObject);
begin
  TextBlockFrame1.init(false);
end;

procedure TChapterEditForm.FormDestroy(Sender: TObject);
begin
  TextBlockFrame1.release;
end;

procedure TChapterEditForm.setCP(value: IChapter);
begin
  m_cp := value;
  CheckBox1.Checked   := m_cp.Numbering;
  LabeledEdit1.Text   := m_cp.Name;
  EditFrame1.Text     := m_cp.Rem;
  EditFrame1.ReadOnly := false;
end;

procedure TChapterEditForm.SpeedButton1Click(Sender: TObject);
begin
  GroupBox1.Visible := not GroupBox1.Visible;
end;

end.
