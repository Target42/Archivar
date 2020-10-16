unit f_chapterTask;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.StdCtrls, Vcl.ExtCtrls, fr_form,
  i_chapter;

type
  TChapterTaskForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    GetTAQry: TClientDataSet;
    GetTEQry: TClientDataSet;
    Panel1: TPanel;
    Label1: TLabel;
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

uses
  m_glob_client;

{$R *.dfm}

{ TChapterTaskForm }

procedure TChapterTaskForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  m_cp.Numbering  := CheckBox1.Checked;
  m_cp.Name       := LabeledEdit1.Text;
end;

procedure TChapterTaskForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  FormFrame1.prepare;
end;

procedure TChapterTaskForm.FormDestroy(Sender: TObject);
begin
  FormFrame1.releaseData;
end;

procedure TChapterTaskForm.setCP(value: IChapter);
begin
  m_cp := value;


  CheckBox1.Checked := m_cp.Numbering;
  LabeledEdit1.Text := m_cp.Name;

  GetTAQry.ParamByName('TA_ID').AsInteger := m_cp.TAID;
  GetTAQry.Open;

  GetTEQry.ParamByName('TE_ID').AsInteger := GetTAQry.FieldByName('TE_ID').AsInteger;
  GetTEQry.Open;

  FormFrame1.loadTask(GetTEQry);
  FormFrame1.loadData(GetTAQry);
  FormFrame1.readOnly := true;
end;

end.
