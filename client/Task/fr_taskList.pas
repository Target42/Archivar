unit fr_taskList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, Vcl.StdCtrls,
  Data.DB, Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids,
  Vcl.Menus, System.Actions, Vcl.ActnList;

type
  TTaskListFrame = class(TFrame)
    ApplicationEvents1: TApplicationEvents;
    DSProviderConnection1: TDSProviderConnection;
    Tasks: TClientDataSet;
    DBGrid1: TDBGrid;
    TaskSrc: TDataSource;
    TaskscalcCreated: TDateField;
    TasksclacRest: TStringField;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    av_move: TAction;
    Verschieben1: TMenuItem;
    TasksUnread: TStringField;
    av_delete: TAction;
    Lschen1: TMenuItem;
    TasksGR_ID: TIntegerField;
    TasksTA_ID: TIntegerField;
    TasksTA_ID1: TIntegerField;
    TasksTY_ID: TIntegerField;
    TasksTA_STARTED: TDateField;
    TasksTA_CREATED: TDateTimeField;
    TasksTA_NAME: TWideStringField;
    TasksTA_DATA: TBlobField;
    TasksTA_CREATED_BY: TWideStringField;
    TasksTA_TERMIN: TDateField;
    TasksTA_CLID: TWideStringField;
    TasksTA_SUB_ID: TIntegerField;
    TasksTA_FLAGS: TIntegerField;
    TasksTA_STATUS: TWideStringField;
    TasksTY_ID1: TIntegerField;
    TasksTY_NAME: TWideStringField;
    TasksTY_TAGE: TIntegerField;
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure TaskscalcCreatedGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure TasksclacRestGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure av_moveExecute(Sender: TObject);
    procedure TasksUnreadGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure av_deleteExecute(Sender: TObject);
  private
    m_id : integer;
    procedure refshData;
    procedure enableCtrl;
  public
    procedure UpdateTaskList( gr_id : integer );
    procedure doOpen;
  end;

implementation

uses
  m_glob_client, f_taskEdit, m_WindowHandler, f_gremiumList, u_stub, u_Konst,
  System.JSON, System.UITypes, u_json;

{$R *.dfm}

procedure TTaskListFrame.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
  Handled := true;
  case msg.message of
    msgFilterTasks :
      begin
        if msg.wParam = 0 then
          UpdateTaskList( msg.lParam)
        else
          refshData;
      end;
      msgNewTask :
      begin
        if Tasks.Active then
          refshData
        else
          UpdateTaskList(m_id);

      end
  else
    Handled := false;
  end;
end;

procedure TTaskListFrame.av_deleteExecute(Sender: TObject);
var
  client : TdsTaskClient;
  data : TJSONObject;
begin
  if Tasks.IsEmpty then
    exit;
  if WindowHandler.isTaskOpen(Tasks.FieldByName('TA_ID').AsInteger) then
  begin
    ShowMessage('Das Dokument ist gerade geöffnet');
    exit;
  end;
  if not (MessageDlg('Soll die Aufgabe "'+Tasks.FieldByName('TA_NAME').AsString+'" gelöscht werden?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    exit;
  client := NIL;
  try
    client := TdsTaskClient.Create(GM.SQLConnection1.DBXConnection);
    data := client.deleteTask(Tasks.FieldByName('TA_ID').AsInteger);
    if not JBool( data, 'result') then
      ShowMessage( JString(data, 'text'));
  finally
    client.Free;
  end;
  refshData;
end;

procedure TTaskListFrame.av_moveExecute(Sender: TObject);
var
  id, i  : Integer;
  client : TdsTaskClient;
  mark   : TBookmark;
  data   : TJSONObject;
begin
  id := -1;
  if WindowHandler.isTaskOpen(Tasks.FieldByName('TA_ID').AsInteger) then
  begin
    ShowMessage('Das Dokument ist gerade geöffnet');
    exit;
  end;

  Application.CreateForm(TGremiumListForm, GremiumListForm);
  GremiumListForm.GremiumID := m_id;
  if GremiumListForm.ShowModal = mrOk then
    id := GremiumListForm.GremiumID;

  GremiumListForm.free;

  if id <> -1 then
  begin
    DBGrid1.Enabled := false;
    client := NIL;
    try
      client := TdsTaskClient.Create(GM.SQLConnection1.DBXConnection);
      for i := 0 to pred(DBGrid1.SelectedRows.Count) do
        begin
          mark := DBGrid1.SelectedRows.Items[i];
          Tasks.GotoBookmark(mark);
          data := client.moveTask(id, Tasks.FieldByName('TA_ID').AsInteger);
          if not JBool( data, 'result') then
            ShowMessage( JString(data, 'text'));
        end;
    finally
      client.Free;
    end;
    Tasks.Refresh;
    DBGrid1.Enabled := true;
  end;
end;

procedure TTaskListFrame.DBGrid1DblClick(Sender: TObject);
begin
  doOpen;
end;

procedure TTaskListFrame.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F5 then
  begin
    Tasks.Refresh;
  end;
end;

procedure TTaskListFrame.doOpen;
var
  client : TdsTaskClient;
  flags  : integer;
  ta_id  : integer;
begin
  if Tasks.IsEmpty then
    exit;

  ta_id := Tasks.FieldByName('TA_ID').AsInteger;

  flags := Tasks.FieldByName('TA_FLAGS').AsInteger;
  if (flags and taskNew) = taskNew then
  begin
    flags := taskRead;
    client := NIL;
    try
      client := TdsTaskClient.Create(GM.SQLConnection1.DBXConnection);
      client.setFlags( ta_id, flags);
    finally
      client.Free;
    end;
    Tasks.Refresh;
  end;
  WindowHandler.openTaskWindow(ta_id, Tasks.FieldByName('TY_ID').AsInteger, true);
end;

procedure TTaskListFrame.enableCtrl;
begin
  if Tasks.IsEmpty then
  begin
    Tasks.Close;
    DBGrid1.Enabled := false;
  end
  else
    DBGrid1.Enabled := true;

  av_move.Enabled := DBGrid1.Enabled;
end;

procedure TTaskListFrame.refshData;
begin
  if Tasks.Active = false then
    Tasks.Open;
  Tasks.Refresh;
  enableCtrl;
end;

procedure TTaskListFrame.TaskscalcCreatedGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := FormatDateTime('dd.MM.yyyy', Tasks.FieldByName('TA_CREATED').AsDateTime);
end;

procedure TTaskListFrame.TasksclacRestGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
var
  da : TDate;
begin
  da := Tasks.FieldByName('TA_TERMIN').AsDateTime;
  if da > date then
  begin
    Text := intToStr( round(da - now));
  end
  else
    Text :=' Abgelaufen';

end;

procedure TTaskListFrame.TasksUnreadGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
var
  flags : Integer;
begin
  flags := Tasks.FieldByName('TA_FLAGS').AsInteger;
  Text := '';

  if (flags and taskNew) = taskNew then
    Text := 'Neu'
  else if (flags and taskRead) = taskRead then
    Text := 'Gelesen'
  else if (flags and taskInWork) = taskInWork then
    Text := 'In Bearbeitung'
  else if (flags and taskWorkEnd) = taskWorkEnd then
    Text := 'Bearbeitung abgeschlossen'
  else if (flags and taskWaitForInfo) = taskWaitForInfo then
    Text := 'Klärungsbedarf';
end;

procedure TTaskListFrame.UpdateTaskList(gr_id: integer);
begin
  m_id := gr_id;
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  Tasks.Close;
  Tasks.ParamByName('GR_ID').AsInteger := gr_id;
  Tasks.Open;

  enableCtrl;

end;

end.
