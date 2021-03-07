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
        public
          constructor create;
          Destructor Destroy; override;

          property ID     : integer     read FID        write FID;
          property Datum  : TDateTime   read FDatum     write FDatum;
          property Zeit   : TDateTime   read FZeit      write FZeit;
          property Title  : string      read FTitle     write FTitle;
          property Changed: TDateTime   read FChanged   write FChanged;
          property Ende   : TDateTime   read FEnde      write FEnde;
      end;
  private
    m_list : TList<DataRec>;

    procedure readData;
    procedure clear;
    procedure updateView;
  public
    procedure init;
    procedure release;
  end;

implementation

uses
  m_glob_client;

{$R *.dfm}

{ TMeetingFrame }

procedure TMeetingFrame.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
  Handled := true;

  case Msg.message of
    msgUpdateMeetings : readData;
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

procedure TMeetingFrame.updateView;
var
  da    : DataRec;
  item  : TListItem;
begin
  for da in m_list do
  begin
    item := Lv.Items.Add;
    item.Caption := FormatDateTime('dd.mm.yyyy', da.Datum);
    item.SubItems.Add(FormatDateTime('hh:nn', da.Zeit));
    item.SubItems.Add(da.Title);
    item.SubItems.Add(FormatDateTime('hh:nn', da.Ende));
    item.SubItems.Add(DateTimeToStr(da.Changed));
  end;
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
