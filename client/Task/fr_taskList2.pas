unit fr_taskList2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, System.Generics.Collections, u_taskEntry,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TTaskList2Frame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    ListTasksQry: TClientDataSet;
    LV: TListView;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    CheckBox6: TCheckBox;
    procedure CheckBox1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    m_id : integer;
    m_filter : integer;
    m_noChange : boolean;

    m_all  : TList<TTaskEntry>;
    m_list : TList<TTaskEntry>;
    FOnTaskEntry: TNotifyTaskEntryEvent;

    procedure setGRID( value : integer );
    procedure setFilter( value : integer );

    procedure clear;

    function getItem( inx : integer ) :TTaskEntry;
    function getCount : integer;
  public

    property GR_ID : integer read m_id write setGRID;
    property Filter : integer read m_filter write setFilter;

    property OnTaskEntry: TNotifyTaskEntryEvent read FOnTaskEntry write FOnTaskEntry;

    procedure prepare;
    procedure shutdown;

    property Items[ inx : integer ] :TTaskEntry read getItem;
    property Count : Integer  read getCount;
  end;

implementation

uses
  m_glob_client, u_Konst;

{$R *.dfm}

{ TTaskList2Frame }

procedure TTaskList2Frame.CheckBox1Click(Sender: TObject);
var
  cb :TCheckBox;
begin
  if m_noChange then
    exit;

  cb := sender as TCheckBox;

  if not cb.Checked then
    m_filter := m_filter and not cb.Tag
  else
    m_filter := m_filter or cb.Tag;

  self.Filter := m_filter;
end;

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

procedure TTaskList2Frame.prepare;
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  FOnTaskEntry := NIL;

  m_all  := TList<TTaskEntry>.create;
  m_list := TList<TTaskEntry>.create;
  m_filter := taskWaitForOK;

  m_noChange := true;

  CheckBox1.Checked := (m_filter and taskNew)         = taskNew;
  CheckBox2.Checked := (m_filter and taskRead)        = taskRead;
  CheckBox3.Checked := (m_filter and taskInWork)      = taskInWork;
  CheckBox4.Checked := (m_filter and taskWorkEnd)     = taskWorkEnd;
  CheckBox5.Checked := (m_filter and taskWaitForInfo) = taskWaitForInfo;
  CheckBox6.Checked := (m_filter and taskWaitForOK)   = taskWaitForOK;

  m_noChange := false;
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
