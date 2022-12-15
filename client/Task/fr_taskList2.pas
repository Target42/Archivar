unit fr_taskList2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, System.Generics.Collections, u_taskEntry,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.Menus;

type
  TTaskList2Frame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    ListTasksQry: TClientDataSet;
    LV: TListView;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ChapterTextTab: TClientDataSet;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
  private
    m_id     : integer;
    m_filter : integer;
    m_ro     : boolean;

    m_all  : TList<TTaskEntry>;
    m_list : TList<TTaskEntry>;
    FOnTaskEntry: TNotifyTaskEntryEvent;

    procedure setGRID( value : integer );
    procedure setFilter( value : integer );

    procedure clear;

    function getItem( inx : integer ) :TTaskEntry;
    function getCount : integer;
    function GetReadOnly: boolean;
    procedure SetReadOnly(const Value: boolean);

  public

    property GR_ID : integer read m_id write setGRID;
    property Filter : integer read m_filter write setFilter;

    property OnTaskEntry: TNotifyTaskEntryEvent read FOnTaskEntry write FOnTaskEntry;

    procedure prepare;
    procedure shutdown;

    property Items[ inx : integer ] :TTaskEntry read getItem;
    property Count : Integer  read getCount;

    procedure ShowFilterDlg;

    property ReadOnly: boolean read GetReadOnly write SetReadOnly;
  end;

implementation

uses
  m_glob_client, u_Konst, f_task_filter, m_WindowHandler;

{$R *.dfm}

{ TTaskList2Frame }

procedure TTaskList2Frame.clear;
var
  i : integer;
begin
  for i := 0 to pred(m_all.Count) do
    m_all[i].Free;
  m_all.Clear;
  m_list.Clear;
end;

function TTaskList2Frame.getCount: integer;
begin
  Result := m_all.Count;
end;

function TTaskList2Frame.getItem(inx: integer): TTaskEntry;
begin
  Result := m_list[inx];
end;

function TTaskList2Frame.GetReadOnly: boolean;
begin
  Result := m_ro;
end;

procedure TTaskList2Frame.LVDblClick(Sender: TObject);
var
  en : TTaskEntry;
begin
  if not Assigned(LV.Selected) then
    exit;
  en := TTaskEntry(LV.Selected.Data);

  WindowHandler.openTaskWindow(en.TaskID, -1, m_id, true, true);
end;

procedure TTaskList2Frame.prepare;
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  FOnTaskEntry := NIL;

  m_all     := TList<TTaskEntry>.create;
  m_list    := TList<TTaskEntry>.create;
  m_filter  := taskReady;
  m_ro      := false;
end;

procedure TTaskList2Frame.setFilter(value: integer);
var
  i : integer;
  item :TListItem;
begin
  m_filter := value;
  m_list.Clear;
  LV.Items.BeginUpdate;
  LV.Items.Clear;

  for i := 0 to pred(m_all.Count) do
    begin
      if (m_all[i].Flags and value) >0  then
      begin
        m_list.Add(m_all[i]);
        item := LV.Items.Add;
        item.Data := m_all[i];
        item.Caption := m_all[i].TaskName;
        item.SubItems.Add(m_all[i].TaskType );
        item.SubItems.Add(m_all[i].Termin);
        item.SubItems.Add(m_all[i].TaskStart);
        item.SubItems.Add(m_all[i].Status);
        item.SubItems.Add(m_all[i].Gremium );
      end;
    end;

  LV.Items.EndUpdate;
end;

procedure TTaskList2Frame.setGRID(value: integer);
var
  entry : TTaskEntry;
begin
  m_id := value;

  clear;

  if m_id = 0 then
    ListTasksQry.Filtered := false
  else
  begin
    ListTasksQry.Filter := 'GR_ID='+intToStr(m_id);
    ListTasksQry.Filtered := true;
  end;

  ListTasksQry.Open;
  ListTasksQry.Refresh;
  while not ListTasksQry.Eof do
  begin
    entry := TTaskEntry.Create;
    m_all.Add(entry);
    entry.setData(ListTasksQry);
    entry.Gremium := GM.GremiumName( ListTasksQry.FieldByName('GR_ID').AsInteger);
    ListTasksQry.Next;
  end;
  ListTasksQry.Close;
  self.Filter := m_filter;
end;

procedure TTaskList2Frame.SetReadOnly(const Value: boolean);
begin
  m_ro := value;

  SpeedButton1.Enabled  := not m_ro;
  SpeedButton2.Enabled  := not m_ro;

end;

procedure TTaskList2Frame.ShowFilterDlg;
begin
  Application.CreateForm(TTaskFilterForm, TaskFilterForm);
  TaskFilterForm.Filter := m_filter;
  if TaskFilterForm.ShowModal = mrOk then
    setFilter(TaskFilterForm.Filter);
  TaskFilterForm.Free;
end;

procedure TTaskList2Frame.shutdown;
begin
  clear;
  m_all.Free;
  m_list.Free;
end;

procedure TTaskList2Frame.SpeedButton1Click(Sender: TObject);
var
  list : TEntryList;
  i    : integer;
begin
  if not Assigned(FOnTaskEntry) or not Assigned(LV.Selected) then
    exit;

  list := TEntryList.Create;
  for i := 0 to pred(LV.Items.Count) do
  begin
    if LV.Items.Item[i].Selected then
      list.Add(LV.Items.Item[i].data);
  end;
  FOnTaskEntry(self, list );
  list.Free
end;

procedure TTaskList2Frame.SpeedButton2Click(Sender: TObject);
var
  i : integer;
  list : TEntryList;
begin
  list := TEntryList.Create;

  for i := 0 to pred(LV.Items.Count) do
    begin
      list.Add(LV.Items.Item[i].data);
    end;
  if Assigned(FOnTaskEntry) then
    FOnTaskEntry(self, list);
  list.Free;
end;

end.
