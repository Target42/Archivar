unit f_taksListForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, u_gremium, fr_taskList,
  fr_gremium, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TTaskListForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    GremiumFrame1: TGremiumFrame;
    TaskListFrame1: TTaskListFrame;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GremiumFrame1TVChange(Sender: TObject; Node: TTreeNode);
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

  GremiumFrame1.init;
end;

procedure TTaskListForm.FormDestroy(Sender: TObject);
begin
  TaskListFrame1.shutdown;
  GremiumFrame1.release;
end;

procedure TTaskListForm.GremiumFrame1TVChange(Sender: TObject; Node: TTreeNode);
begin
  setGremium(  GremiumFrame1.Gremium);
end;

procedure TTaskListForm.setGremium(value: TGremium);
begin
  m_gremium := value;
  Caption := 'Aufgabeliste : '+m_gremium.Name;
  TaskListFrame1.UpdateTaskList( m_gremium.ID);
end;

end.
