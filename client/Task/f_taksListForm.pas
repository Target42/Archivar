unit f_taksListForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, u_gremium, fr_taskList;

type
  TTaskListForm = class(TForm)
    BaseFrame1: TBaseFrame;
    TaskListFrame1: TTaskListFrame;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_gremium : TGremium;
    procedure setGremium( value : TGremium);

    procedure DBGrid1DblClick(Sender: TObject);
  public
    property Gremium : TGremium read m_gremium write setGremium;
  end;

var
  TaskListForm: TTaskListForm;

implementation

{$R *.dfm}

{ TTaskListForm }

procedure TTaskListForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  TaskListFrame1.doOpen;
end;

procedure TTaskListForm.DBGrid1DblClick(Sender: TObject);
begin
  BaseFrame1.OKBtn.Click;
end;

procedure TTaskListForm.FormCreate(Sender: TObject);
begin
  TaskListFrame1.prepare;
  TaskListFrame1.LV.OnDblClick := self.DBGrid1DblClick;
end;

procedure TTaskListForm.FormDestroy(Sender: TObject);
begin
  TaskListFrame1.shutdown;
end;

procedure TTaskListForm.setGremium(value: TGremium);
begin
  m_gremium := value;
  Caption := 'Aufgabeliste : '+m_gremium.Name;
  TaskListFrame1.UpdateTaskList( m_gremium.ID);
end;

end.
