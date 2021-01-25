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
    procedure FormCreate(Sender: TObject);
    procedure btnUloadClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function copyToTemp( fname : string ) : string;
  public
    { Public-Deklarationen }
  end;

var
  epubMngrForm: TepubMngrForm;

implementation

uses
  m_glob_client, system.ioUtils, System.Win.ComObj, u_ePub;

{$R *.dfm}

procedure TepubMngrForm.btnUloadClick(Sender: TObject);
var
  fname : string;
  ep    : ePub;
  st    : TStream;
  src   : TStream;
begin
  if FileOpenDialog1.Execute then
  begin
    fname :=copyToTemp(FileOpenDialog1.FileName);
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

end.
