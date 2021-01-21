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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bntUploadClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    m_list : TStringList;
    procedure upload( field : TField; fname : string );
    function  exists( name, path : string ) : boolean;
  public
    { Public-Deklarationen }
  end;

var
  WebServerFilesForm: TWebServerFilesForm;

implementation

uses
  m_glob_client, f_web_file, f_web_editor, System.IOUtils;

{$R *.dfm}

procedure TWebServerFilesForm.BitBtn1Click(Sender: TObject);
var
  fname       : string;
  needUpload  : boolean;
  ext         : string;
  md5         : string;
begin
  if HCTab.IsEmpty then
    exit;
  ext := LowerCase(ExtractFileExt(HCTab.FieldByName('HC_NAME').AsString));
  if  not( (ext = '.html') or ( ext = '.htm') or (ext = '.css') ) then
  begin
    ShowMessage('Diese Datei kann nicht direkt editiert werden!');
    exit;
  end;
  fname := TPath.Combine( GM.wwwHome, HCTab.FieldByName('HC_PATH').AsString+'\'+HCTab.FieldByName('HC_NAME').AsString);

  if not FileExists(fname) then
  begin
    ShowMessage('Die Datei wurde nicht gefunden!');
    exit;
  end;
  Application.CreateForm(TWebEditorForm, WebEditorForm);
  WebEditorForm.FileName := fname;
  WebEditorForm.ShowModal;
  needUpload := WebEditorForm.NeedUpload;
  FreeAndNil(WebEditorForm);

  if needUpload then
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

procedure TWebServerFilesForm.bntUploadClick(Sender: TObject);
begin
  if HCTab.IsEmpty then
    exit;

  Application.CreateForm(TWebFileForm, WebFileForm);
  WebFileForm.Dirs      := m_list;
  WebFileForm.Path      := HCTab.FieldByName('HC_PATH').AsString;
  WebFileForm.FileName  := HCTab.FieldByName('HC_NAME').AsString;
  if WebFileForm.ShowModal = mrOk then
  begin
    HCTab.Edit;
    HCTab.FieldByName('HC_PATH').AsString := WebFileForm.Path;
    upload(HCTab.FieldByName('HC_DATA'), WebFileForm.FileName);
    HCTab.FieldByName('HC_MD5').AsString  := GM.md5(WebFileForm.FileName);
    HCTab.Post;
  end;
  WebFileForm.free;

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
  if HCTab.UpdatesPending then
    HCTab.ApplyUpdates(0);

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
