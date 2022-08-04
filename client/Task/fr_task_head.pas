unit fr_task_head;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.Mask;

type
  TTaskHeaderFrame = class(TFrame)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    ComboBox1: TComboBox;
    procedure ComboBox1Change(Sender: TObject);
  private
    m_source : TDataSource;
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
    { Private declarations }
  public
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

implementation

uses
  u_Konst;

{$R *.dfm}

{ TTaskHeaderFrame }

procedure TTaskHeaderFrame.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
   -1 : m_source.DataSet.FieldByName('TA_FLAGS').AsInteger := taskNew;
    0 : m_source.DataSet.FieldByName('TA_FLAGS').AsInteger := taskRead;
    1 : m_source.DataSet.FieldByName('TA_FLAGS').AsInteger := taskInWork;
    2 : m_source.DataSet.FieldByName('TA_FLAGS').AsInteger := taskWorkEnd;
    3 : m_source.DataSet.FieldByName('TA_FLAGS').AsInteger := taskWaitForInfo;
  end;
end;

function TTaskHeaderFrame.GetDataSource: TDataSource;
begin
  Result := m_source;
end;

procedure TTaskHeaderFrame.SetDataSource(const Value: TDataSource);
var
  flags : Integer;
begin
  m_source := value;

  DBEdit1.DataSource := m_source;
  DBEdit2.DataSource := m_source;
  DBEdit3.DataSource := m_source;
  DBEdit4.DataSource := m_source;

  flags := m_source.DataSet.FieldByName('TA_FLAGS').AsInteger;

  if (flags and taskRead) = taskRead then
    ComboBox1.ItemIndex := 0
  else if (flags and taskInWork) = taskInWork then
    ComboBox1.ItemIndex := 1
  else if (flags and taskWorkEnd) = taskWorkEnd then
    ComboBox1.ItemIndex := 2
  else if (flags and taskWaitForInfo) = taskWaitForInfo then
    ComboBox1.ItemIndex := 3;
end;

end.
