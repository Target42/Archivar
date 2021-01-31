unit f_downloadEpub;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids;

type
  TDownloadEpubform = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    EPTab: TClientDataSet;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_ds : TDataSet;

    procedure download;
  public
    procedure setDataset( ds : TDataSet );

  end;

var
  DownloadEpubform: TDownloadEpubform;

implementation

uses
  m_glob_client, system.IOUtils;

{$R *.dfm}

procedure TDownloadEpubform.BaseFrame1OKBtnClick(Sender: TObject);
var
  i : integer;
begin
  Screen.Cursor := crSQLWait;

  for i := 0 to pred(DBGrid1.SelectedRows.Count) do
  begin
    EPTab.GotoBookmark(DBGrid1.SelectedRows.Items[i]);
    download;
  end;
  Screen.Cursor := crDefault;
end;

procedure TDownloadEpubform.download;
var
  st : TStream;
  fs : TStream;
  fname : string;
begin
  fname := TPath.Combine( Gm.ePubHome, EPTab.FieldByName('EP_NAME').AsString );

  if m_ds.Locate('EP_ID', VarArrayOf([EPTab.FieldByName('EP_ID').Asinteger]), []) then
    m_ds.Edit
  else
    m_ds.Append;

  m_ds.FieldByName('EP_ID').AsInteger       := EPTab.FieldByName('EP_ID').AsInteger;
  m_ds.FieldByName('EP_NAME').AsString      := EPTab.FieldByName('EP_NAME').AsString;
  m_ds.FieldByName('EP_TITEL').AsString     := EPTab.FieldByName('EP_TITLE').AsString;
  m_ds.FieldByName('EP_MD5').AsString       := EPTab.FieldByName('EP_MD5').AsString;
  m_ds.FieldByName('EP_GROUP').AsString     := EPTab.FieldByName('EP_GROUP').AsString;
  m_ds.FieldByName('EP_SUBGROUP').AsString  := EPTab.FieldByName('EP_SUB').AsString;

  m_ds.Append;
  try
    fs := TFileStream.Create( fname, fmCreate + fmShareDenyNone);
    st := EPTab.CreateBlobStream(EPTab.FieldByName('EP_DATA'), bmRead);

    fs.CopyFrom( st, -1);

    fs.Free;
    st.Free;
  except
  end;
end;

procedure TDownloadEpubform.FormCreate(Sender: TObject);
begin
  BaseFrame1.StatusBar1.SimplePanel := true;
  m_ds := NIL;
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  EPTab.Open;
end;

procedure TDownloadEpubform.setDataset(ds: TDataSet);
begin
  m_ds := ds;
end;

end.
