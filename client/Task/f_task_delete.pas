unit f_task_delete;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_gremium, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, fr_tasklist_delete, u_gremium, Vcl.ComCtrls;

type
  TTaskDeleteForm = class(TForm)
    GroupBox1: TGroupBox;
    GremiumFrame1: TGremiumFrame;
    Splitter1: TSplitter;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    UnusedTaskListFrame1: TUnusedTaskListFrame;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GremiumFrame1TVChange(Sender: TObject; Node: TTreeNode);
    procedure BitBtn1Click(Sender: TObject);
  private
    m_gremium : TGremium;
    procedure setGremium( value : TGremium);

  public
    { Public-Deklarationen }
  end;

var
  TaskDeleteForm: TTaskDeleteForm;

procedure execTaskDeleteForm;

implementation

uses
  System.Generics.Collections, u_stub, m_glob_client, System.JSON, u_json;

{$R *.dfm}
procedure execTaskDeleteForm;
begin
  Application.CreateForm(TTaskDeleteForm, TaskDeleteForm);
  try
    TaskDeleteForm.ShowModal;
  except

  end;
  TaskDeleteForm.Free;
end;

procedure TTaskDeleteForm.BitBtn1Click(Sender: TObject);
var
  list    : TList<integer>;
  id      : integer;
  client  : TdsTaskClient;
  data    : TJSONObject;
begin
  list := UnusedTaskListFrame1.Checked;
  if list.Count = 0 then exit;

  client := TdsTaskClient.Create(GM.SQLConnection1.DBXConnection);
  for id in list do begin
    try
      data := client.deleteTask(id);
      if not JBool( data, 'result') then
        ShowMessage( JString(data, 'text'));
    except

    end;
  end;
  client.Free;

  setGremium(m_gremium);
end;

procedure TTaskDeleteForm.FormCreate(Sender: TObject);
begin
  UnusedTaskListFrame1.prepare;
  GremiumFrame1.init;
end;

procedure TTaskDeleteForm.FormDestroy(Sender: TObject);
begin
  GremiumFrame1.release;
  UnusedTaskListFrame1.release;
end;

procedure TTaskDeleteForm.GremiumFrame1TVChange(Sender: TObject;
  Node: TTreeNode);
begin
  setGremium(GremiumFrame1.Gremium);
end;

procedure TTaskDeleteForm.setGremium(value: TGremium);
begin
  m_gremium := value;
  UnusedTaskListFrame1.GR_ID := m_gremium.ID;
end;

end.
