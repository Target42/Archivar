unit f_form_props;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, fr_base,
  i_taskEdit;

type
  TFormProperties = class(TForm)
    LabeledEdit1: TLabeledEdit;
    CheckBox1: TCheckBox;
    BaseFrame1: TBaseFrame;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_task : ITask;
    m_frm  : ITaskForm;

    procedure setFrm( value : ITaskForm );
  public
    property Task : ITask     read m_task write m_task;
    property Form : ITaskForm read m_frm  write setFrm;
  end;

var
  FormProperties: TFormProperties;

implementation

{$R *.dfm}

procedure TFormProperties.BaseFrame1OKBtnClick(Sender: TObject);
var
  s : string;
begin
  s := Trim( LabeledEdit1.Text);
  if s <> '' then
  begin
    if not Assigned(m_frm) then
      m_frm := m_task.NewForm;
      m_frm.Name := s;
      m_frm.MainForm := CheckBox1.Checked;
  end;
end;

procedure TFormProperties.FormCreate(Sender: TObject);
begin
  m_task := NIL;
  m_frm  := NIL;
end;

procedure TFormProperties.setFrm(value: ITaskForm);
begin
  m_frm := value;

  LabeledEdit1.Text := m_frm.Name;
  CheckBox1.Checked := m_frm.MainForm;
end;

end.
