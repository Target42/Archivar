unit f_images;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, m_glob_client, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, fr_base,
  Vcl.ExtDlgs, Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.ExtCtrls;

type
  TImagesForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DBGrid1: TDBGrid;
    DSProviderConnection1: TDSProviderConnection;
    PicTab: TClientDataSet;
    PicSrc: TDataSource;
    Panel2: TPanel;
    Hinzufügen: TBitBtn;
    BitBtn1: TBitBtn;
    OpenPictureDialog1: TOpenPictureDialog;
    DBImage1: TDBImage;
    procedure HinzufügenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    function getID : integer;
  public
    { Public-Deklarationen }
  end;

var
  ImagesForm: TImagesForm;

implementation

uses
 IdHashMessageDigest, IdHash, System.UITypes, u_stub, f_image_preview;
{$R *.dfm}

procedure TImagesForm.BaseFrame1AbortBtnClick(Sender: TObject);
begin
  if PicTab.State <> dsBrowse then
    PicTab.Cancel;
  if PicTab.UpdatesPending then
    PicTab.CancelUpdates;

end;

procedure TImagesForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  if PicTab.State <> dsBrowse then
    PicTab.Post;
  if PicTab.UpdatesPending then
    PicTab.ApplyUpdates(-1);
end;

procedure TImagesForm.BitBtn1Click(Sender: TObject);
begin
  if PicTab.IsEmpty then
    exit;
  if (MessageDlg('Soll das Bild wirklich gelöscht werden?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    PicTab.Delete;
end;

procedure TImagesForm.DBGrid1DblClick(Sender: TObject);
begin
  if (DBImage1.Picture.Width > 32) or  (DBImage1.Picture.Height > 30) then begin
    if not Assigned(ImagePreviewform) then
      Application.CreateForm(TImagePreviewform, ImagePreviewform);

    ImagePreviewform.ClientHeight := DBImage1.Picture.Height;
    ImagePreviewform.ClientWidth  := DBImage1.Picture.Width;

    ImagePreviewform.Image1.Picture.Assign(DBImage1.Picture);
    ImagePreviewform.Show;
  end;
end;

procedure TImagesForm.FormCreate(Sender: TObject);
begin
  PicTab.Open;
end;

procedure TImagesForm.FormDestroy(Sender: TObject);
begin
  PicTab.Close;
  if Assigned(ImagePreviewform) then
    ImagePreviewform.Free;

end;

function TImagesForm.getID: integer;
var
  client : TdsImageClient;
begin
  client := TdsImageClient.Create(GM.SQLConnection1.DBXConnection);
  try
    Result := client.AutoInc('gen_pi_id');
  finally
    Client.Free;
  end;
end;

procedure TImagesForm.HinzufügenClick(Sender: TObject);
var
  fname : string;
  fs   : TFileStream;
  IdMD5: TIdHashMessageDigest5;
  bs   : TStream;
  i    : integer;
begin
  if OpenPictureDialog1.Execute then
  begin
    for i := 0 to pred(OpenPictureDialog1.Files.Count) do
    begin
      fname := ExtractFileName(OpenPictureDialog1.Files.Strings[i]);
      IdMD5 := TIdHashMessageDigest5.Create;
      try
        if PicTab.Locate('PI_NAME', VarArrayOf([fname]), [loCaseInsensitive]) then
          PicTab.Edit
        else
          picTab.Append;

        PicTab.FieldByName('PI_ID').AsInteger := getID;
        fs := TFileStream.Create( OpenPictureDialog1.Files.Strings[i], fmOpenRead + fmShareDenyWrite);

        PicTab.FieldByName('PI_MD5').AsString :=  LowerCase(IdMD5.HashStreamAsHex(fs));
        PicTab.FieldByName('PI_NAME').AsString := fname;
        fs.Position := 0;

        bs := PicTab.CreateBlobStream(PicTab.FieldByName('PI_DATA'), bmWrite );
        bs.CopyFrom( fs, fs.Size);
        bs.free;
        fs.Free;
        PicTab.Post;
      except
        on e : exception do
        begin
          PicTab.Cancel;
          ShowMessage(e.ToString);
        end;
      end;
      IdMD5.free;
    end;
    if PicTab.UpdatesPending then
      PicTab.ApplyUpdates(-1);
  end;
end;

end.
