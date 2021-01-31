unit f_epub_mngr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons;

type
  TepubMngrForm = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    DSProviderConnection1: TDSProviderConnection;
    EPTab: TClientDataSet;
    EPSrc: TDataSource;
    btnUload: TBitBtn;
    FileOpenDialog1: TFileOpenDialog;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnUloadClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    function copyToTemp( fname : string ) : string;
    procedure upload( fileName : string );
    procedure setField( title, name : string );
  public
    { Public-Deklarationen }
  end;

var
  epubMngrForm: TepubMngrForm;

implementation

uses
  m_glob_client, system.ioUtils, System.Win.ComObj, u_ePub;

{$R *.dfm}

procedure TepubMngrForm.BitBtn1Click(Sender: TObject);
begin
  setField('Gruppe setzen', 'EP_GROUP');
end;

procedure TepubMngrForm.BitBtn2Click(Sender: TObject);
begin
  setField('Untergruppe setzen', 'EP_SUB');
end;

procedure TepubMngrForm.btnUloadClick(Sender: TObject);
var
  i : integer;
begin
  if FileOpenDialog1.Execute then
  begin
    for i := 0 to pred(FileOpenDialog1.Files.Count) do
      upload(FileOpenDialog1.Files[i]);
  end;
end;

function TepubMngrForm.copyToTemp(fname: string): string;
var
  dest : string;
begin
  dest := TPath.Combine(TPath.GetTempPath, createClassID);
  ForceDirectories(dest);
  dest := TPath.Combine( dest, ExtractFileName(fname));
  try
    TFile.Copy( fname, dest, true);
  except
    dest := '';
  end;
  Result := dest;
end;

procedure TepubMngrForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  EPTab.Open;
end;

procedure TepubMngrForm.FormDestroy(Sender: TObject);
begin
  if EPTab.UpdatesPending then
    EPTab.ApplyUpdates(0);
  EPTab.Close;
end;

procedure TepubMngrForm.setField(title, name: string);
var
  val : string;
  i   : integer;
begin
  if DBGrid1.SelectedRows.Count = 0 then
  begin
    ShowMessage('Es wurden keine Zeilen ausgewählt.');
    exit;
  end;

  if InputQuery(title, 'name', val) then
  begin
    for i := 0 to pred(DBGrid1.SelectedRows.Count) do
    begin
      EPTab.GotoBookmark(DBGrid1.SelectedRows.Items[i]);
      EPTab.Edit;
      EPTab.FieldByName(name).AsString := val;
      EPTab.Post;
    end;
  end;
end;

procedure TepubMngrForm.upload(fileName : string );
var
  fname : string;
  ep    : ePub;
  st    : TStream;
  src   : TStream;
begin
  Screen.Cursor := crHourGlass;

  fname :=copyToTemp(FileName);
  if fname <> '' then
  begin
    ep := ePub.create;
    if ep.setFileName(fname) then
    begin
      if EPTab.Locate('EP_NAME', VarArrayOf([ExtractFileName(fname)]), [loCaseInsensitive]) then
        EPTab.Edit
      else
      begin
        EPTab.Append;
        EPTab.FieldByName('EP_ID').AsInteger := GM.autoInc('gen_ep_id');
      end;
      EPTab.FieldByName('EP_MD5').AsString   := GM.md5(fname);
      EPTab.FieldByName('EP_NAME').AsString  := ExtractFileName(fname);
      EPTab.FieldByName('EP_TITLE').AsString := ep.Title;

      src := TFileStream.Create(fname,fmOpenRead + fmShareDenyNone);
      st := EPTab.CreateBlobStream(EPTab.FieldByName('EP_DATA'), bmWrite);
      st.CopyFrom(src, -1);
      st.Free;
      src.Free;
      EPTab.Post;
    end;
    ep.Free;
  end;
  Screen.Cursor := crDefault;
end;

end.
