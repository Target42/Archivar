unit f_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, Vcl.StdCtrls, Vcl.Buttons, Data.DB, Data.SqlExpr,
  u_stub, System.JSON, u_ini, JvComponentBase, JvCreateProcess, JvBaseDlg,
  JvBrowseFolder, Vcl.ExtCtrls, pngimage;

type
  TMainForm = class(TForm)
    StatusBar1: TStatusBar;
    SQLConnection1: TSQLConnection;
    BitBtn1: TBitBtn;
    ProgressBar1: TProgressBar;
    JvCreateProcess1: TJvCreateProcess;
    Panel1: TPanel;
    LabeledEdit1: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    JvBrowseForFolderDialog1: TJvBrowseForFolderDialog;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SQLConnection1AfterConnect(Sender: TObject);
    procedure SQLConnection1AfterDisconnect(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    type rFile = record
      name        : string;
      md5         : string;
      size        : int64;
      needUpdate  : boolean;
      locked      : boolean;
    end;
  private
    m_client : TdsUpdaterClient;
    m_files  : array of rFile;
    m_root   : string;

    function CheckFiles : boolean;

    function CalcMd5( fname : string  ) : string; overload;
    function CalcMd5( st    : TStream ) : string; overload;

    function download(fname: string; st: TStream; size : int64): boolean;
    function DownloadFiles : Boolean;
    procedure startProgram;

    procedure setRoot( value : string );
  public
    property Root : string read m_root write setRoot;
  end;

var
  MainForm: TMainForm;

implementation

uses
  IdHashMessageDigest, u_json, System.IOUtils;

{$R *.dfm}

procedure TMainForm.BitBtn1Click(Sender: TObject);
var
  obj     : TJSONObject;
  row     : TJSONObject;
  arr     : TJSONArray;
  i       : integer;
begin
  try
    StatusBar1.SimpleText := 'Connect .... ';
    SQLConnection1.Open;
    StatusBar1.SimpleText := 'connected';

    if Assigned(m_client) then begin
      obj := m_client.getFileList;

      arr := JArray( obj, 'items');
      setLength( m_files, arr.Count);

      if Assigned(arr) then begin
        for i := 0 to pred(arr.Count) do begin
          row := getRow( arr, i);

          m_files[i].name := JString( row, 'name');
          m_files[i].md5  := JString( row, 'md5');
          m_files[i].size := JInt64(  row, 'size');

          m_files[i].needUpdate := true;
          m_files[i].locked     := false;
        end;
      end;
    end;
    if CheckFiles then
      DownloadFiles;
  except
    on e : exception do
      ShowMessage( e.ToString );
  end;
end;

function TMainForm.CheckFiles : boolean;
var
  i     : integer;
  fname : string;
  md5   : string;
  st    : TFileStream;
  s     : string;
begin
  Result := true;
  for i := low(m_files) to high(m_files) do begin
    fname := TPath.combine( ExtractFilePath(Application.ExeName), m_files[i].name );
    if FileExists( fname ) then begin
      StatusBar1.SimpleText := 'Check:'+m_files[i].name;

      md5 := CalcMd5(fname);

      try
        st := TFileStream.Create(fname, fmOpenWrite + fmShareExclusive );
        m_files[i].locked := false;
        st.Free;
      except
        begin
          m_files[i].locked := true;
          if SameText( m_files[i].name, 'ssleay32.dll') or
             SameText( m_files[i].name, 'libeay32.dll') then
            m_files[i].needUpdate := false
          else
            Result := false;
        end
      end;
    end;
  end;
  if not Result then begin
    s := 'Die folgenden Datein sind noch in Benutzung:'+sLineBreak;

    for i := low(m_files) to high(m_files) do begin
      if m_files[i].locked and m_files[i].needUpdate then
        s := s + m_files[i].name;
    end;
    ShowMessage(s);
  end;
end;

function TMainForm.download(fname: string; st: TStream; size : int64): boolean;
const
  BSize = 1024 * 4;
var bytes : integer;
   buffer : array  of byte;
   fout   : TFileStream;
begin
  StatusBar1.SimpleText := 'downloading ' + ExtractFileName(fname);
  ProgressBar1.Max := size;
  ProgressBar1.Position := 0;
  Result := true;
  try
    SetLength(Buffer, BSize);
    fout := TFileStream.Create( fname, fmCreate);
    repeat
      bytes := st.Read( buffer[0], BSize);
      ProgressBar1.Position := ProgressBar1.Position + bytes;
      fout.Write(buffer[0], bytes)
    until bytes <> BSize;
    FreeAndNil(fout);
  except
    Result := false;
  end;
  SetLength(Buffer, 0);

  ProgressBar1.Position := ProgressBar1.Max;
end;

function TMainForm.DownloadFiles : boolean;
var
  i     : integer;
  path  : string;
  fname : string;
  req   : TJSONObject;
  st    : TStream;
begin
  Result := true;

  path := ExtractFilePath(Application.ExeName);

  for i := low(m_files) to high(m_files) do begin
    if m_files[i].needUpdate then begin

      fname := TPath.Combine( path, m_files[i].name);
      if FileExists( fname ) then
        DeleteFile(fname);

      req := TJSONObject.Create;
      JReplace( req, 'name', m_files[i].name);
      st := m_client.download(req);
      Result := download(fname, st, m_files[i].size) and Result;
    end;
  end;
  StatusBar1.SimpleText := 'Ferting';

  if Result then
    startProgram;

end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  fname : string;
begin
  m_client := NIL;

  fname := paramStr(0)+'.ini';
  if FileExists(fname) then
    IniOptions.LoadFromFile(fname);

  self.Root := ExtractFilePath(ParamStr(0));

  if IniOptions.launcherimage <> '' then begin
    fname := TPath.Combine( ExtractFilePath(paramStr(0)), IniOptions.launcherimage);

    if FileExists(fname) then
      Image1.Picture.LoadFromFile(fname);
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  SetLength( m_files, 0 );
end;

procedure TMainForm.setRoot(value: string);
begin
  m_root := value;
  LabeledEdit1.Text := m_root;
  if not DirectoryExists(m_root) then
    ShowMessage('Das Verzeichniss'+sLineBreak+m_root+sLineBreak+'ung�ltig');
end;

function TMainForm.CalcMd5(st: TStream): string;
var
  IdMD5: TIdHashMessageDigest5;
begin
  IdMD5 := TIdHashMessageDigest5.Create;
  try
    Result := LowerCase( IdMD5.HashStreamAsHex(st));
  finally
    IdMD5.Free;
  end;
end;

function TMainForm.CalcMd5(fname: string): string;
var
  fs   : TFileStream;
begin
  Result := '';

  fs := NIL;
  if not FileExists(fname) then
    exit;

  try
    fs    := TFileStream.Create(fname, fmOpenRead + fmShareDenyWrite);
    Result := CalcMd5(fs);
  finally
    fs.Free;
  end;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  JvBrowseForFolderDialog1.Directory := self.Root;

  if JvBrowseForFolderDialog1.Execute then
    self.Root := JvBrowseForFolderDialog1.Directory;
end;

procedure TMainForm.SQLConnection1AfterConnect(Sender: TObject);
begin
  m_client := TdsUpdaterClient.Create(SQLConnection1.DBXConnection);
end;

procedure TMainForm.SQLConnection1AfterDisconnect(Sender: TObject);
begin
  if Assigned(m_client) then
    FreeAndNil(m_client);
end;

procedure TMainForm.startProgram;
var
  fname : string;
begin
  fname := TPath.Combine( ExtractFilePath(Application.ExeName), IniOptions.runprg);
  if FileExists( fname ) then begin
    JvCreateProcess1.CurrentDirectory := ExtractFilePath(fname);
    JvCreateProcess1.CommandLine := fname;
    JvCreateProcess1.Run;
  end;
  if SameText(IniOptions.launcherterminate, 'true') then
    Close;
end;


end.

