unit fr_meeting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.ComCtrls,
  System.Generics.Collections, Vcl.AppEvnts;

type
  TMeetingFrame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    MeetingQry: TClientDataSet;
    Lv: TListView;
    ApplicationEvents1: TApplicationEvents;
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure LvDblClick(Sender: TObject);
    procedure LvCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure LvCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
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
        FRead: boolean;
        public
          constructor create;
          Destructor Destroy; override;

          property ID     : integer     read FID        write FID;
          property Datum  : TDateTime   read FDatum     write FDatum;
          property Zeit   : TDateTime   read FZeit      write FZeit;
          property Title  : string      read FTitle     write FTitle;
          property Changed: TDateTime   read FChanged   write FChanged;
          property Ende   : TDateTime   read FEnde      write FEnde;
          property Read   : boolean     read FRead      write FRead;
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
  end;

implementation

uses
  m_glob_client, System.Notification;

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
  if not da.Read then
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
  if not da.Read then
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
  PostMessage(Application.MainFormHandle, msgEditMeeting, 0, da.ID );
  da.Read := true;
  Lv.Invalidate;
end;

procedure TMeetingFrame.readData;
var
  da : DataRec;
begin
  clear;

  MeetingQry.ParamByName('PE_ID').AsInteger := GM.UserID;
  MeetingQry.ParamByName('STATUS').AsString := 'O';

  MeetingQry.Open;

  while not MeetingQry.Eof do
  begin
    da := DataRec.create;
    m_list.Add(da);

    da.ID     := MeetingQry.FieldByName('EL_ID').AsInteger;
    da.Datum  := MeetingQry.FieldByName('EL_DATUM').AsDateTime;
    da.Zeit   := MeetingQry.FieldByName('EL_ZEIT').AsDateTime;
    da.Title  := MeetingQry.FieldByName('EL_TITEL').AsString;
    da.Changed:= MeetingQry.FieldByName('EL_DATA_STAMP').AsDateTime;
    da.Ende   := MeetingQry.FieldByName('EL_ENDE').AsDateTime;
    da.Read   := not MeetingQry.FieldByName('EP_READ').IsNull;
    MeetingQry.Next;
  end;
  MeetingQry.Close;
  updateView;
end;

procedure TMeetingFrame.release;
begin
  clear;
  m_list.Free;
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
    item.Data     := da;
    item.Caption  := FormatDateTime('dd.mm.yyyy', da.Datum);
    item.SubItems.Add(FormatDateTime('hh:nn', da.Zeit));
    item.SubItems.Add(da.Title);
    item.SubItems.Add(FormatDateTime('hh:nn', da.Ende));
    item.SubItems.Add(DateTimeToStr(da.Changed));
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
