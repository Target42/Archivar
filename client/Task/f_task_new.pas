unit f_task_new;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, fr_base, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.Mask, JvExComCtrls, JvDateTimePicker, JvDBDateTimePicker;

type
  TTaskform = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    TaskTypes: TClientDataSet;
    TaskTypeSrc: TDataSource;
    Task: TClientDataSet;
    TaskSrc: TDataSource;
    Label1: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    JvDBDateTimePicker1: TJvDBDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    JvDBDateTimePicker2: TJvDBDateTimePicker;
    Label7: TLabel;
    DBEdit3: TDBEdit;
    LV: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure JvDBDateTimePicker1Change(Sender: TObject);
  private
    m_id   : integer;
    m_grid : integer;
    procedure setID( value : integer );

    procedure setGRID( value : integer );
    function  getGRID : integer;
  public
    property ID : integer read m_id write setID;
    property GRID : integer read getGRID write setGRID;
  end;

var
  Taskform: TTaskform;

implementation

uses
  m_glob_client, u_stub, f_taskEdit, m_WindowHandler, Win.ComObj, u_gremium;

{$R *.dfm}

procedure TTaskform.BaseFrame1AbortBtnClick(Sender: TObject);
begin
  if Task.State <> dsBrowse then
    Task.Cancel;
end;

procedure TTaskform.BaseFrame1OKBtnClick(Sender: TObject);
var
   client       : TdsTaskClient;
   tyid         : integer;
   gr           : TGremium;
begin
  if not Assigned(LV.Selected) then
    exit;

  client := NIL;
  tyid := Task.FieldByName('TY_ID').AsInteger;
  if m_id = 0 then
  begin
    try
      client := TdsTaskClient.Create(GM.SQLConnection1.DBXConnection);
      m_id   := client.AutoInc('gen_ta_id');
      Task.FieldByName('TA_ID').AsInteger := m_id;
      Task.FieldByName('TA_STARTED').AsDateTime := JvDBDateTimePicker1.DateTime;
    finally
      client.Free;
    end;
  end;

  Task.Post;
  Task.ApplyUpdates(0);

  gr := TGremium(LV.Selected.Data);
  m_grid := gr.ID;
  try
    client := TdsTaskClient.Create(GM.SQLConnection1.DBXConnection);
    client.AssignGremium(m_grid, m_id, 'O');
  finally
    client.Free;
  end;

  GM.LockDocument( m_id, tyid);
  WindowHandler.openTaskWindow(m_id, tyid, false);
  ModalResult := mrOk;
end;

procedure TTaskform.FormCreate(Sender: TObject);
var
  i : integer;
  gr : TGremium;
  item : TListItem;
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  LV.Items.BeginUpdate;
  for i := 0 to pred(GM.Gremien.Count) do
  begin
    gr := GM.Gremien.Items[i];
    item := LV.Items.Add;
    item.caption := gr.ShortName;
    Item.SubItems.Add(gr.Name);
    item.data :=  gr;
    if gr.ParentShort = '' then
      LV.Selected := item;
  end;
  LV.Items.EndUpdate;
end;

procedure TTaskform.FormDestroy(Sender: TObject);
begin
  try
    if Task.State <> dsBrowse then
      Task.Cancel
  except

  end;
  Task.Close;
  TaskTypes.Close;
end;

function TTaskform.getGRID: integer;
begin
  Result := 0;
  if not Assigned(LV.Selected) then
    exit;
  Result := TGremium(LV.Selected.Data).ID;
end;

procedure TTaskform.JvDBDateTimePicker1Change(Sender: TObject);
begin
  Task.FieldByName('TA_TERMIN').AsDateTime :=
    Task.FieldByName('TA_STARTED').AsDateTime +
    TaskTypes.FieldByName('TY_TAGE').AsInteger;
end;

procedure TTaskform.setGRID(value: integer);
var
  i : integer;
  gr : TGremium;
begin
  for i := 0 to pred(LV.Items.Count) do
  begin
    gr := TGremium(LV.Items.Item[i].Data);
    if gr.ID = value then
    begin
      LV.Selected := LV.Items.Item[i];
      LV.Selected.MakeVisible(false);
      break;
    end;
  end;

end;

procedure TTaskform.setID(value: integer);
var
  opts : TLocateOptions;
begin
  m_id := value;
  Task.Open;
  if m_id > 0 then
  begin
    if Task.Locate('TA_ID', VarArrayOf([m_id]), opts) then
      Task.Edit
    else
      Task.Append;
  end
  else
    Task.Append;

  if Task.State = dsInsert then
  begin
    Task.FieldByName('TA_ID').AsInteger := 0;
    Task.FieldByName('TA_CLID').AsString := CreateClassID;
  end;

  TaskTypes.Open;

  Task.FieldByName('TA_CREATED_BY').AsString := GM.Name+', '+GM.Vorname;
  Task.FieldByName('TY_ID').AsInteger := TaskTypes.FieldByName('TY_ID').AsInteger;
  Task.FieldByName('TA_STARTED').AsDateTime := NOW;

  JvDBDateTimePicker1Change(NIL);
end;

end.
