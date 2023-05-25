unit fr_files_to_delete;

interface

uses
  m_glob_client, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.ComCtrls;

type
  TFilesToDeleteFrame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    FilesToDeleteQry: TClientDataSet;
    LV: TListView;
    FilesToDeleteQryFI_ID: TIntegerField;
    FilesToDeleteQryFI_NAME: TStringField;
    FilesToDeleteQryFI_CREATED: TDateField;
    FilesToDeleteQryFI_TODELETE: TDateField;
    FilesToDeleteQryFI_VERSION: TIntegerField;
    FilesToDeleteQryFI_CREATED_BY: TStringField;
    FilesToDeleteQryDR_ID: TIntegerField;
    FilesToDeleteQryFI_SIZE: TLargeintField;
    FilesToDeleteQryFI_LOCKED: TStringField;
  private
    procedure UpdateFiles;
  public
    procedure prepare;
    procedure release;
  end;

implementation

uses
  System.DateUtils;


{$R *.dfm}

procedure TFilesToDeleteFrame.prepare;
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  UpdateFiles;
end;

procedure TFilesToDeleteFrame.release;
begin
  LV.Items.Clear;
end;

procedure TFilesToDeleteFrame.UpdateFiles;
var
  item :  TListItem;
begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;

  FilesToDeleteQry.ParamByName('tage').AsInteger := 30;
  FilesToDeleteQry.ParamByName('PE_ID').AsInteger := GM.UserID;
  FilesToDeleteQry.Open;
  while not FilesToDeleteQry.Eof do begin
    item := LV.Items.Add;
    item.Data := Pointer(FilesToDeleteQryFI_ID.AsInteger);
    item.Caption := FilesToDeleteQryFI_NAME.AsString;
    item.SubItems.Add(FilesToDeleteQryFI_TODELETE.AsString);
    item.SubItems.Add(intToStr(DaysBetween(now, FilesToDeleteQryFI_TODELETE.AsDateTime)));
    FilesToDeleteQry.Next;
  end;
  FilesToDeleteQry.Close;

  LV.Items.EndUpdate;
end;

end.
