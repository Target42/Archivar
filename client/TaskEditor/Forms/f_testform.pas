unit f_testform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, i_taskEdit;

type
  TTestForm = class(TForm)
    BaseFrame1: TBaseFrame;
    ScrollBox1: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    m_form : ITaskform;
    procedure setForm( value : ITaskform );
  public
    property TaskForm : ITaskForm read m_form write setForm;
  end;

var
  TestForm: TTestForm;

implementation

{$R *.dfm}

procedure TTestForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  m_form.Base.dropControls;
  m_form.Base.Control := NIL;
end;

procedure TTestForm.FormCreate(Sender: TObject);
begin
  m_form := NIL;
end;

procedure TTestForm.setForm(value: ITaskform);
begin
  m_form := value;
  m_form.Base.Control := ScrollBox1;
  m_form.Base.build;
end;

end.
