unit f_images;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, m_glob_client, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.DBGrids, fr_base,
  Vcl.ExtDlgs, Vcl.Buttons, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, System.Generics.Collections;

type
  TImagesForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    PicTab: TClientDataSet;
    PicSrc: TDataSource;
    Panel2: TPanel;
    Hinzufügen: TBitBtn;
    BitBtn1: TBitBtn;
    OpenPictureDialog1: TOpenPictureDialog;
    LV: TListView;
    ImageList1: TImageList;
    procedure HinzufügenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
  private
    type
      TBmp = class
        private
          FID: integer;
          FName: string;
          FStream: TMemoryStream;
          FMD5: string;
        public
          constructor create;
          Destructor Destroy; override;

          property ID: integer read FID write FID;
          property Name: string read FName write FName;
          property Stream: TMemoryStream read FStream write FStream;
          property MD5: string read FMD5 write FMD5;
      end;
  private
    m_list : TList<TBmp>;

    procedure FillBmps;
    procedure FillView;

    procedure updateImage( fname, md5 : string );

    function getID : integer;

  public
    { Public-Deklarationen }
  end;

var
  ImagesForm: TImagesForm;

implementation

uses
 IdHashMessageDigest, IdHash, System.UITypes, u_stub, f_image_preview,
  Vcl.Imaging.pngimage;
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
var
  bmp : TBmp;
begin
  if PicTab.IsEmpty or not Assigned(LV.Selected) then
    exit;
  if (MessageDlg('Soll das Bild wirklich gelöscht werden?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    bmp := LV.Selected.Data;
    if PicTab.Locate('PI_ID', VarArrayOf([bmp.ID]), []) then begin
      PicTab.Delete;
      m_list.Remove(bmp);
      bmp.Free;
    end;
  end;
  FillView;
end;

procedure TImagesForm.FillBmps;
var
  bmp : TBmp;
  bs  : TStream;
begin
  with PicTab do begin
    first;
    while not Eof do begin
      bmp := TBmp.create;
      m_list.Add(bmp);

      bmp.ID   := FieldByName('PI_ID').AsInteger;
      bmp.Name := FieldByName('PI_NAME').AsString;
      bmp.MD5  := FieldByName('PI_MD5').AsString;

      bs := CreateBlobStream(FieldByName('PI_DATA'), bmRead);
      bmp.Stream.CopyFrom(bs, bs.size);
      bs.free;
      next;
    end;
    First;
  end;

  FillView;
end;

procedure TImagesForm.FillView;
var
  img : Tbmp;
  png : TPngImage;
  bmp : Tbitmap;
  item: TListItem;

begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;
  ImageList1.Clear;

  png := TPngImage.Create;
  bmp := Tbitmap.Create;

  for img in m_list do begin
    item := LV.Items.Add;
    item.Data := img;
    item.Caption := img.Name;

    img.Stream.Position := 0;
    png.LoadFromStream(img.Stream);
    bmp.Assign(png);

    item.ImageIndex := ImageList1.Add(bmp, NIL)
  end;
  png.Free;
  bmp.Free;

  LV.Items.EndUpdate;
end;

procedure TImagesForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_list := TList<TBmp>.create;
  PicTab.Open;
  FillBmps;
end;

procedure TImagesForm.FormDestroy(Sender: TObject);
var
  bmp : TBmp;
begin
  PicTab.Close;
  if Assigned(ImagePreviewform) then
    ImagePreviewform.Free;

  for bmp in m_list do
    bmp.Free;
  m_list.Free;

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

        updateImage( fname, PicTab.FieldByName('PI_MD5').AsString );

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

procedure TImagesForm.LVDblClick(Sender: TObject);
var
  bmp : TBmp;
  png : TPngImage;
begin
  if not Assigned(LV.Selected) then exit;
  bmp := LV.Selected.Data;
  png := TPngImage.Create;
  bmp.Stream.Position := 0;
  png.LoadFromStream(bmp.Stream);

  if (png.Width > 32) or  (png.Height > 30) then begin
    if not Assigned(ImagePreviewform) then
      Application.CreateForm(TImagePreviewform, ImagePreviewform);

    ImagePreviewform.ClientHeight := png.Height;
    ImagePreviewform.ClientWidth  := png.Width;

    ImagePreviewform.Image1.Picture.Assign(png);
    ImagePreviewform.Show;
  end;
  png.free;
end;

procedure TImagesForm.updateImage(fname, md5: string);
var
  s   : string;
  i   : integer;
  bmp : TBmp;
begin
  s   := ExtractFileName(fname);
  bmp := NIL;

  for i := 0 to pred(m_list.Count) do begin
    if SameText( s, m_list[i].Name) then begin
      bmp := m_list[i];
      break;
    end;
  end;

  if not Assigned(bmp) then begin
    bmp := TBmp.create;
    m_list.Add(bmp);
  end;
  bmp.MD5 := md5;
  bmp.Stream.Clear;
  bmp.Stream.LoadFromFile(fname);

  FillView;
end;

{ TImagesForm.TBmp }

constructor TImagesForm.TBmp.create;
begin
  FStream := TMemoryStream.Create;
end;

destructor TImagesForm.TBmp.Destroy;
begin
  FStream.Free;
  inherited;
end;

end.
