unit f_webserver_files;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, fr_base, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TWebServerFilesForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    HCTab: TClientDataSet;
    HCsrc: TDataSource;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    bntUpload: TBitBtn;
    btnDownload: TBitBtn;
    btnDelete: TBitBtn;
    btnNew: TBitBtn;
    BitBtn1: TBitBtn;
    FileSaveDialog1: TFileSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bntUploadClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    m_list : TStringList;
    procedure upload( field : TField; fname : string );
    procedure download ( field : TField; fname : string );
    function  exists( name, path : string ) : boolean;
  public
    { Public-Deklarationen }
  end;

var
  WebServerFilesForm: TWebServerFilesForm;

implementation

uses
  m_glob_client, f_web_file, f_web_editor, System.IOUtils, system.uiTypes;

{$R *.dfm}

procedure TWebServerFilesForm.BitBtn1Click(Sender: TObject);
var
  fname       : string;
  md5         : string;
begin
  if HCTab.IsEmpty then
    exit;
  fname := TPath.Combine( GM.wwwHome, HCTab.FieldByName('HC_PATH').AsString+'\'+HCTab.FieldByName('HC_NAME').AsString);

  if not FileExists(fname) then
  begin
    ShowMessage('Die Datei wurde nicht gefunden!');
    exit;
  end;

  Application.CreateForm(TWebEditorForm, WebEditorForm);
  if not  WebEditorForm.canEdit(HCTab.FieldByName('HC_NAME').AsString) then
  begin
    WebEditorForm.Free;
    ShowMessage('Diese Datei kann nicht direkt editiert werden!');
    exit;

  end;

  WebEditorForm.Path      := HCTab.FieldByName('HC_PATH').AsString;
  WebEditorForm.FileName  := fname;
  if WebEditorForm.ShowModal = mrOk then
  begin
    if WebEditorForm.NeedUpload then
    begin
      md5 := GM.md5(fname);
      if md5 <> HCTab.FieldByName('HC_MD5').AsString then
      begin
        HCTab.Edit;
        upload(HCTab.FieldByName('HC_DATA'), fname);
        HCTab.FieldByName('HC_MD5').AsString  := md5;
        HCTab.Post;
      end;
    end;
  end;

  FreeAndNil(WebEditorForm);
end;

procedure TWebServerFilesForm.bntUploadClick(Sender: TObject);
var
  doUpload  : boolean;
  msg       : string;
begin
  if HCTab.IsEmpty then
    exit;

  Application.CreateForm(TWebFileForm, WebFileForm);
  WebFileForm.Dirs      := m_list;
  WebFileForm.Path      := HCTab.FieldByName('HC_PATH').AsString;
  WebFileForm.FileName  := HCTab.FieldByName('HC_NAME').AsString;

  if WebFileForm.ShowModal = mrOk then
  begin
    doUpload := SameText( HCTab.FieldByName('HC_NAME').AsString, ExtractFileName(WebFileForm.FileName));
    if not doUpload then begin
      msg := format('Die Serverdatei "%s" wird mit dem Iinhalt'#13+
      'der lokalen Datei "%s" überschrieben',
      [
        HCTab.FieldByName('HC_NAME').AsString,
        ExtractFileName(WebFileForm.FileName) ]);
      doUpload := (MessageDlg(msg, mtConfirmation, [mbYes, mbNo], 0) = mrYes);
    end;

    if doUpload then begin
      HCTab.Edit;
      upload(HCTab.FieldByName('HC_DATA'), WebFileForm.FileName);
      HCTab.FieldByName('HC_MD5').AsString  := GM.md5(WebFileForm.FileName);
      HCTab.Post;
    end;
  end;
  WebFileForm.free;

end;

procedure TWebServerFilesForm.btnDeleteClick(Sender: TObject);
var
  name : string;
begin
  if HCTab.IsEmpty then
    exit;

  name := HCTab.FieldByName('HC_PATH').AsString+'\'+HCTab.FieldByName('HC_NAME').AsString;
  if (MessageDlg('Soll die Datei '+name+' wirklich gelöscht werden?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    HCTab.Delete;
  end;
end;

procedure TWebServerFilesForm.btnDownloadClick(Sender: TObject);
begin
  if HCTab.IsEmpty then
    exit;

  FileSaveDialog1.FileName := HCTab.FieldByName('HC_NAME').AsString;
  if FileSaveDialog1.Execute then
  begin
    try
      download(HCTab.FieldByName('HC_DATA'), FileSaveDialog1.FileName);
    except
      on e : exception do
        ShowMessage( e.ToString );
    end;
  end;
end;

procedure TWebServerFilesForm.btnNewClick(Sender: TObject);
var
  name, path : string;
begin
  Application.CreateForm(TWebFileForm, WebFileForm);
  WebFileForm.Dirs := m_list;
  if WebFileForm.ShowModal = mrOk then
  begin
    name := ExtractFileName(WebFileForm.FileName);
    path := WebFileForm.Path;

    if not Exists( name, path ) then
    begin
      HCTab.Append;
      HCTab.FieldByName('HC_ID').AsInteger  := GM.autoInc('gen_hc_id');
      HCTab.FieldByName('HC_NAME').AsString := name;
      HCTab.FieldByName('HC_PATH').AsString := WebFileForm.Path;
      HCTab.FieldByName('HC_MD5').AsString  := GM.md5(WebFileForm.FileName);

      upload(HCTab.FieldByName('HC_DATA'), WebFileForm.FileName);
      HCTab.Post;
    end;
  end;
  WebFileForm.free;

end;

procedure TWebServerFilesForm.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn1.Click;
end;

procedure TWebServerFilesForm.download(field: TField; fname: string);
var
  st  : TStream;
  src : TFileStream;
begin
  src := TFileStream.Create(fname, fmCreate + fmShareDenyNone);
  st  := HCTab.CreateBlobStream(field, bmRead);
  st.CopyFrom( src, -1);
  st.Free;
  src.Free;
end;

function TWebServerFilesForm.exists(name, path: string): boolean;
begin
  Result := false;
  HCTab.First;
  while not HCTab.Eof do
  begin
    Result := SameText(name, HCTab.FieldByName('HC_NAME').AsString) and
              SameText(path, HCTab.FieldByName('HC_PATH').AsString);
    if Result then
      exit;

    HCTab.Next;
  end;
end;

procedure TWebServerFilesForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  m_list        := TStringList.Create;
  m_list.Sorted := true;

  HCTab.Open;
  while not HCTab.Eof do
  begin
    if m_list.IndexOf(HCTab.FieldByName('HC_PATH').AsString) = -1 then
      m_list.Add(HCTab.FieldByName('HC_PATH').AsString);
    HCTab.Next;
  end;
  HCTab.First;
end;

procedure TWebServerFilesForm.FormDestroy(Sender: TObject);
begin
  if HCTab.UpdatesPending then begin
    HCTab.ApplyUpdates(0);
    // update the changes ..
    GM.checkWWWRoot;
  end;

  HCTab.Close;
  m_list.Free;
end;

procedure TWebServerFilesForm.upload(field: TField; fname: string);
var
  st  : TStream;
  src : TFileStream;
begin
  src := TFileStream.Create(fname, fmOpenRead + fmShareDenyNone);
  st  := HCTab.CreateBlobStream(field, bmWrite);
  st.CopyFrom( src, -1);
  st.Free;
  src.Free;
end;

end.
