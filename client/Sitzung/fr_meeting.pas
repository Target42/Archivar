unit fr_meeting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.ComCtrls,
  System.Generics.Collections, Vcl.AppEvnts, Vcl.Menus;

type
  TMeetingFrame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    MeetingQry: TClientDataSet;
    Lv: TListView;
    ApplicationEvents1: TApplicationEvents;
    PopupMenu1: TPopupMenu;
    Bearbeiten1: TMenuItem;
    N1: TMenuItem;
    Ausfhren1: TMenuItem;
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure LvDblClick(Sender: TObject);
    procedure LvCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure LvCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure Bearbeiten1Click(Sender: TObject);
    procedure Ausfhren1Click(Sender: TObject);
  private
    type
      DataRec = class
        private
          FID: integer;
          FDatum: TDateTime;
          FZeit: TDateTime;
          FTitle: string;
          FChanged: TDateTime;
          FEnde: TDateTime;
          FRead: TDateTime;
          FStatus: string;
        FRunning: boolean;
        FEiladender: string;
        public
          constructor create;
          Destructor Destroy; override;

          property ID     : integer     read FID        write FID;
          property Datum  : TDateTime   read FDatum     write FDatum;
          property Zeit   : TDateTime   read FZeit      write FZeit;
          property Title  : string      read FTitle     write FTitle;
          property Changed: TDateTime   read FChanged   write FChanged;
          property Ende   : TDateTime   read FEnde      write FEnde;
          property Read   : TDateTime   read FRead      write FRead;
          property Status : string      read FStatus    write FStatus;
          property Running: boolean     read FRunning   write FRunning;
          property Einadender: string read FEiladender write FEiladender;
      end;
  private
    m_list : TList<DataRec>;

    procedure readData;
    procedure clear;
    procedure updateView;
    procedure UpdateMeetings( id : integer );
  public
    procedure init;
    procedure release;

    procedure remove( id : integer );
  end;

implementation

uses
  m_glob_client, System.Notification, u_teilnehmer, u_meeting_status;

{$R *.dfm}

{ TMeetingFrame }

procedure TMeetingFrame.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
  Handled := true;

  case Msg.message of
    msgUpdateMeetings : readData;
    msgNewMeeting     : UpdateMeetings( msg.lParam );
  else
    handled := false;
  end;

end;

procedure TMeetingFrame.Ausfhren1Click(Sender: TObject);
var
  da    : DataRec;
begin
  if not Assigned(LV.Selected) then
    exit;

  da := LV.Selected.Data;
  if da.Read = 0.0 then
    da.Read := now;

  PostMessage(Application.MainFormHandle, msgDoMeeting, 0, da.ID );
  Lv.Invalidate;
end;

procedure TMeetingFrame.Bearbeiten1Click(Sender: TObject);
var
  da    : DataRec;
begin
  if not Assigned(LV.Selected) then
    exit;

  da := LV.Selected.Data;
  if da.Read = 0.0 then
    da.Read := now;

  if not da.Running then
    PostMessage(Application.MainFormHandle, msgEditMeeting, 0, da.ID )
  else
    ShowMessage('Die Sitzung l�uft schon.');
end;


procedure TMeetingFrame.clear;
var
  d : DataRec;
begin
  for d in m_list do
    d.Free;
  m_list.Clear;
end;

procedure TMeetingFrame.init;
begin
  m_list := TList<DataRec>.create;
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
end;

procedure TMeetingFrame.LvCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  da : DataRec;
begin
  da := item.Data;
  if da.Read = 0.0 then
    LV.Canvas.Font.Color := clBlue
  else
    LV.Canvas.Font.Color := clWindowText;
end;

procedure TMeetingFrame.LvCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  da : DataRec;
begin
  da := item.Data;
  if da.Read = 0.0 then
    LV.Canvas.Font.Color := clBlue
  else
    LV.Canvas.Font.Color := clWindowText;
end;

procedure TMeetingFrame.LvDblClick(Sender: TObject);
var
  da    : DataRec;
begin
  if not Assigned(LV.Selected) then
    exit;

  da := LV.Selected.Data;
  if da.Read = 0.0 then
    da.Read := now;

  if not da.Running then
    PostMessage(Application.MainFormHandle, msgEditMeeting, 0, da.ID )
  else
    PostMessage(Application.MainFormHandle, msgDoMeeting, 0, da.ID );
  Lv.Invalidate;
end;

procedure TMeetingFrame.readData;
var
  da : DataRec;

  function buildName( data : TDataSet ) : string;
  begin
    Result :=
      data.FieldByName('TN_VORNAME').AsString + ' ' +
      data.FieldByName('TN_NAME').AsString;
      if data.FieldByName('TN_ROLLE').AsString <> '' then
        Result := Result + ' ('+data.FieldByName('TN_ROLLE').AsString+')';
  end;

  procedure readValues( data : TDataSet; flag : Boolean );
  begin
    while not data.Eof do
    begin
      da := DataRec.create;
      m_list.Add(da);

      da.ID       := data.FieldByName('EL_ID').AsInteger;
      da.Datum    := data.FieldByName('EL_DATUM').AsDateTime;
      da.Zeit     := data.FieldByName('EL_ZEIT').AsDateTime;
      da.Title    := data.FieldByName('EL_TITEL').AsString;
      da.Changed  := data.FieldByName('EL_DATA_STAMP').AsDateTime;
      da.Ende     := data.FieldByName('EL_ENDE').AsDateTime;
      da.Read     := data.FieldByName('TN_READ').AsDateTime;
      da.Status   := TeilnehmerStatusToString(TTeilnehmerStatus(data.FieldByName('TN_STATUS').AsInteger), false);
      da.Running  := flag;
      da.Einadender := buildName(data);
      data.Next;
    end;
  end;
begin
  clear;

  MeetingQry.ParamByName('PE_ID').AsInteger := GM.UserID;

  MeetingQry.ParamByName('STATUS').AsString := Meeting_Invited;
  MeetingQry.Open;
  readValues( MeetingQry, false );
  MeetingQry.Close;

  MeetingQry.ParamByName('STATUS').AsString := Meeting_Running;
  MeetingQry.Open;
  readValues( MeetingQry, true );
  MeetingQry.Close;

  updateView;
end;

procedure TMeetingFrame.release;
begin
  clear;
  m_list.Free;
end;

procedure TMeetingFrame.remove(id: integer);
var
  da : DataRec;
begin
  for da in m_list do begin
    if da.Id = Id  then begin
      m_list.Remove(da);
      da.Free;
      break;
    end;
  end;
  updateView;
end;

procedure TMeetingFrame.UpdateMeetings(id: integer);
var
  i : integer;
  da : DataRec;
  MyNotification: TNotification;
begin
  readData;
  for i := 0 to pred(Lv.Items.Count) do
  begin
    da := LV.Items.Item[i].Data;
    if da.ID = id  then
    begin
      LV.Selected := LV.Items.Item[i];
      MyNotification := GM.NotificationCenter1.CreateNotification;
      try
        MyNotification.Name       := 'Archivar';
        MyNotification.Title      := da.Title;
        MyNotification.AlertBody  := DateToStr(da.Datum)+' um '+FormatDateTime('hh:mm', da.Zeit);
        MyNotification.EnableSound:= true;

        GM.NotificationCenter1.PresentNotification(MyNotification);
      finally
        MyNotification.Free;
      end;
      break;
    end;
  end;
end;

procedure TMeetingFrame.updateView;
var
  da    : DataRec;
  item  : TListItem;
begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;
  for da in m_list do
  begin
    item := Lv.Items.Add;
    if da.Running then
      item.GroupID := 0
    else
      item.GroupID  := 1;

    item.Data     := da;
    item.Caption  := FormatDateTime('dd.mm.yyyy', da.Datum);
    item.SubItems.Add(FormatDateTime('hh:nn', da.Zeit));
    item.SubItems.Add(da.Title);
    item.SubItems.Add(FormatDateTime('hh:nn', da.Ende));
    item.SubItems.Add(DateTimeToStr(da.Changed));
    item.SubItems.Add(da.Status);
    if da.Read <> 0.0 then
      item.SubItems.Add(DateTimeToStr(da.Read))
    else
      item.SubItems.Add('');
    item.SubItems.Add(da.Einadender);
  end;
  LV.Items.EndUpdate;
end;

{ TMeetingFrame.DataRec }

constructor TMeetingFrame.DataRec.create;
begin

end;

destructor TMeetingFrame.DataRec.Destroy;
begin

  inherited;
end;

end.
