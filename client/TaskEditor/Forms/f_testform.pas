unit f_testform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, i_taskEdit, fr_form;

type
  TTestForm = class(TForm)
    BaseFrame1: TBaseFrame;
    FormFrame1: TFormFrame;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    m_form : ITaskform;
    procedure setForm(value: ITaskform);
  public
    property  TaskForm : ITaskForm read m_form write setForm;
    procedure setTitle( text : string );
  end;

var
  TestForm: TTestForm;

implementation

{$R *.dfm}

procedure TTestForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if Assigned(m_form) then
  begin
    m_form.Base.dropControls;
    m_form.Base.Control := NIL;
  end;
end;

procedure TTestForm.FormCreate(Sender: TObject);
begin
  m_form := NIL;
end;

procedure TTestForm.setForm(value: ITaskform);
var
  x, y : integer;
begin
  m_form := value;
  FormFrame1.TaskForm := m_form;
  FormFrame1.getSize(x, y);

  ClientWidth  := x;
  ClientHeight := y + BaseFrame1.Height;
end;

procedure TTestForm.setTitle(text: string);
begin
  Caption := 'Formulartest : '+text;
end;

end.
