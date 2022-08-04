unit fr_taskList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts,
  Data.DB, Datasnap.DBClient, Datasnap.DSConnect,
  Vcl.Menus, System.Actions, Vcl.ActnList, System.Generics.Collections,
  Vcl.ComCtrls;

type
  TTaskListFrame = class(TFrame)
    ApplicationEvents1: TApplicationEvents;
    DSProviderConnection1: TDSProviderConnection;
    Tasks: TClientDataSet;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    av_move: TAction;
    Verschieben1: TMenuItem;
    av_delete: TAction;
    Lschen1: TMenuItem;
    LV: TListView;
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
    procedure LVColumnClick(Sender: TObject; Column: TListColumn);
    procedure LVDblClick(Sender: TObject);
    procedure LVCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure LVCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    type
      DataRec = class
        private
          FTitle: string;
          FTermin: TDateTime;
          FRest: integer;
          FType: string;
          FErzeugt: TDateTime;
          FEingang: TDate;
          FStatus: String;
          Fid: integer;
          Fty: integer;
          FFlags: integer;
          FIndex: integer;
          FRems: string;
          FColor: TColor;
        public
          constructor create;
          Destructor Destroy; override;

          property Title  : string      read FTitle   write FTitle;
          property Termin : TDateTime   read FTermin  write FTermin;
          property Rest   : integer     read FRest    write FRest;
          property Typ    : string      read FType    write FType;
          property Erzeugt: TDateTime   read FErzeugt write FErzeugt;
          property Eingang: TDate       read FEingang write FEingang;
          property Status : String      read FStatus  write FStatus;
          property id     : integer     read Fid      write Fid;
          property ty     : integer     read Fty      write Fty;
          property Flags  : integer     read FFlags   write FFlags;
          property Index  : integer     read FIndex   write FIndex;
          property Rem    : string      read FRems    write FRems;
          property Color  : TColor      read FColor   write FColor;
      end;
  private
    m_id      : integer;
    m_sortNr  : integer;
    m_list    : TList<DataRec>;
    m_up      : array[ 0..6] of boolean;

    procedure clearList;
    procedure fillList;
    procedure UpdateView;

    procedure refshData;
    procedure enableCtrl;
    procedure SortData;
  public
    procedure UpdateTaskList( gr_id : integer );
    procedure doOpen;
    procedure prepare;
    procedure shutdown;
  end;

implementation

uses
  m_glob_client, m_WindowHandler, f_gremiumList, u_stub, u_Konst,
  System.JSON, System.UITypes, u_json, System.Generics.Defaults, u_kategorie;

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
  d    : DataRec;
begin
  if Tasks.IsEmpty or not Assigned(LV.Selected) then
    exit;

  d := LV.Selected.Data;
  if WindowHandler.isTaskOpen(d.id) then
  begin
    ShowMessage('Das Dokument ist gerade geöffnet');
    exit;
  end;
  if not (MessageDlg('Soll die Aufgabe "'+d.Title+'" gelöscht werden?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    exit;
  client := NIL;
  try
    client := TdsTaskClient.Create(GM.SQLConnection1.DBXConnection);
    data := client.deleteTask(d.id);
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
  data   : TJSONObject;
  d      : DataRec;
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
    LV.Enabled := false;
    client := NIL;
    try
      client := TdsTaskClient.Create(GM.SQLConnection1.DBXConnection);

      for i := 0 to pred(LV.Items.Count) do
        begin
          if LV.Items.Item[i].Selected then
          begin
            d := LV.Items.Item[i].Data;
            data := client.moveTask(id, d.id);
            if not JBool( data, 'result') then
              ShowMessage( JString(data, 'text'));
          end;
        end;
    finally
      client.Free;
    end;
    refshData;
    LV.Enabled := true;
  end;
end;

procedure TTaskListFrame.clearList;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
    m_list[i].Free;
  m_list.Clear;

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
    fillList;
  end;
end;

procedure TTaskListFrame.doOpen;
var
  client : TdsTaskClient;
  flags  : integer;
  ta_id  : integer;
  data   : DataRec;
begin
  if not Assigned(LV.Selected) then
    exit;
  data := LV.Selected.Data;

  ta_id := data.id;
  flags := data.Flags;

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

  WindowHandler.openTaskWindow(ta_id, data.ty, true);
end;

procedure TTaskListFrame.enableCtrl;
begin
  if Tasks.IsEmpty then
  begin
    Tasks.Close;
    LV.Enabled := false;
  end
  else
    LV.Enabled := true;

  av_move.Enabled := LV.Enabled;
end;

procedure TTaskListFrame.fillList;
var
  data : DataRec;
begin
  clearList;

  Tasks.First;
  while not Tasks.Eof do
  begin
    data := DataRec.create;
    m_list.Add(data);

    data.Index    := m_list.Count-1;
    data.id       := Tasks.FieldByName('TA_ID').AsInteger;
    data.ty       := Tasks.FieldByName('TY_ID').AsInteger;
    data.Title    := Tasks.FieldByName('TA_NAME').AsString;
    data.Typ      := Tasks.FieldByName('TY_NAME').AsString;
    data.Erzeugt  := Tasks.FieldByName('TA_CREATED').AsDateTime;
    data.Termin   := Tasks.FieldByName('TA_TERMIN').AsDateTime;
    data.Eingang  := Tasks.FieldByName('TA_STARTED').AsDateTime;
    data.Rest     := round(Tasks.FieldByName('TA_TERMIN').AsDateTime - now);
    data.Status   := Tasks.FieldByName('TA_STATUS').AsString;
    data.Flags    := Tasks.FieldByName('TA_FLAGS').AsInteger;
    data.Rem      := Tasks.FieldByName('TA_REM').AsString;
    data.Color    := TColor(Tasks.FieldByName('TA_COLOR').AsInteger );
    Tasks.Next;
  end;

  // sort ...
  SortData;

  UpdateView;
end;

procedure TTaskListFrame.LVColumnClick(Sender: TObject; Column: TListColumn);
begin
  if m_sortNr = Column.Index then
    m_up[m_sortNr] := not m_up[m_sortNr];

  m_sortNr := Column.Index;
  SortData;
  UpdateView;
end;

procedure TTaskListFrame.LVCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
{
  if (item.Index mod 2 = 0 ) then
    LV.Font.Color := clRed
  else
    LV.Font.Color := clBlue;}
end;

procedure TTaskListFrame.LVCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  d : DataRec;
begin
  d := item.Data;
  if  (SubItem = 2) and (d.Rest <= 0) then
    LV.Canvas.Font.Color := clRed
  else
    LV.Canvas.Font.Color := clBlack;
  if (SubItem = 8) and ( d.Color <> 0 ) then
    LV.Canvas.Brush.Color := d.Color;
end;

procedure TTaskListFrame.LVDblClick(Sender: TObject);
begin
  doOpen;
end;

procedure TTaskListFrame.prepare;
var
  i : integer;
begin

  m_list := TList<DataRec>.create;
  m_sortNr := 0;

  for i := low(m_up) to high(m_up) do
    m_up[i] := true;

end;

procedure TTaskListFrame.refshData;
begin
  if Tasks.Active = false then
    Tasks.Open;
  Tasks.Refresh;

  fillList;

  enableCtrl;
end;

procedure TTaskListFrame.shutdown;
begin
  clearList;
  m_list.Free;
end;

procedure TTaskListFrame.SortData;
begin
  case m_sortNr of
    0 : m_list.Sort(
      TComparer<DataRec>.Construct(
        function(const Left, Right: DataRec): Integer
        begin
          Result := 0;
          if left.id > Right.id then Result :=  -1 else
          if left.id < right.id then Result :=  1;

          if not  m_up[m_sortNr] then
            Result := -Result;
        end)
      );

    1 : m_list.Sort(
      TComparer<DataRec>.Construct(
        function(const Left, Right: DataRec): Integer
        begin
          Result := CompareText(left.Title, right.Title);
          if Result = 0 then
          begin
            if left.id > Right.id then Result :=  -1 else
            if left.id < right.id then Result :=  1;
          end;
          if not  m_up[m_sortNr] then
            Result := -Result;
        end)
      );
    2 : m_list.Sort(
      TComparer<DataRec>.Construct(
        function(const Left, Right: DataRec): Integer
        begin
          Result := 0;
          if left.Rest > Right.Rest then Result :=  -1 else
          if left.Rest < Right.Rest then Result :=  1;
          if not  m_up[m_sortNr] then
            Result := -Result;
        end)
      );
    3 : m_list.Sort(
      TComparer<DataRec>.Construct(
        function(const Left, Right: DataRec): Integer
        begin
          Result := CompareText(left.Typ, right.Typ);
          if Result = 0 then
          begin
            if left.id > Right.id then Result :=  -1 else
            if left.id < right.id then Result :=  1;
          end;
          if not  m_up[m_sortNr] then
            Result := -Result;
        end)
      );
    4 : m_list.Sort(
      TComparer<DataRec>.Construct(
        function(const Left, Right: DataRec): Integer
        begin
          Result := 0;
          if left.Erzeugt> Right.Erzeugt then Result :=  -1 else
          if left.Erzeugt < right.Erzeugt then Result :=  1;

          if not  m_up[m_sortNr] then
            Result := -Result;
        end)
      );
    5 : m_list.Sort(
      TComparer<DataRec>.Construct(
        function(const Left, Right: DataRec): Integer
        begin
          Result := 0;
          if left.Eingang > Right.Eingang then Result :=  -1 else
          if left.Eingang < right.Eingang then Result :=  1;

          if not  m_up[m_sortNr] then
            Result := -Result;
        end)
      );
    6 : m_list.Sort(
      TComparer<DataRec>.Construct(
        function(const Left, Right: DataRec): Integer
        begin
          Result := 0;
            if left.Flags > Right.Flags then Result :=  -1 else
            if left.Flags < right.Flags then Result :=  1;
          if not  m_up[m_sortNr] then
            Result := -Result;
        end)
      );
  end;

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
  Text := flagsToStr( flags );
end;

procedure TTaskListFrame.UpdateTaskList(gr_id: integer);
begin
  m_id := gr_id;
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  Tasks.Close;
  Tasks.ParamByName('GR_ID').AsInteger := gr_id;
  Tasks.Open;

  fillList;

  enableCtrl;

end;

procedure TTaskListFrame.UpdateView;
var
  i : integer;
  item : TListItem;
begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;

  for i := 0 to pred(m_list.Count) do
  begin
    item := LV.Items.Add;
    item.Data := m_list[i];
    with m_list[i] do
    begin
      item.Caption := Title;
      item.SubItems.Add(FormatDateTime('dd.MM.yyyy', Termin));
      if Rest > 0 then
        item.SubItems.Add(intToStr(Rest))
      else
        item.SubItems.Add('Abgelaufen('+IntToStr(Rest)+')');
      item.SubItems.Add(Typ);
      item.SubItems.Add(FormatDateTime('dd.MM.yyyy', Erzeugt));
      item.SubItems.Add(FormatDateTime('dd.MM.yyyy', Eingang));
      item.SubItems.Add(flagsToStr(flags));
      item.SubItems.Add(Rem);
      item.SubItems.Add('');
      if Color = 0 then
        item.SubItems.Add('')
      else
        item.SubItems.Add( Kategorien.getColorName( color ));


    end;
  end;
  LV.Items.EndUpdate;
end;

{ TTaskListFrame.DataRec }

constructor TTaskListFrame.DataRec.create;
begin

end;

destructor TTaskListFrame.DataRec.Destroy;
begin

  inherited;
end;

end.
