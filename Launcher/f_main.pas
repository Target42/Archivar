unit f_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, Vcl.StdCtrls, Vcl.Buttons, Data.DB, Data.SqlExpr,
  u_stub, System.JSON, u_ini;

type
  TMainForm = class(TForm)
    StatusBar1: TStatusBar;
    SQLConnection1: TSQLConnection;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SQLConnection1AfterConnect(Sender: TObject);
    procedure SQLConnection1AfterDisconnect(Sender: TObject);
  private
    m_client : TdsUpdaterClient;

    function md5( fname : string  ) : string; overload;
    function md5( st    : TStream ) : string; overload;

    function download(fname: string; st: TStream): boolean;
  public
    { Public-Deklarationen }
  end;

var
  MainForm: TMainForm;

implementation

uses
  IdHashMessageDigest;

{$R *.dfm}

procedure TMainForm.BitBtn1Click(Sender: TObject);
var
  obj     : TJSONObject;
begin
  try
  SQLConnection1.Open;

  if Assigned(m_client) then begin
    obj := m_client.getFileList;
    ShowMessage( obj.ToString);
  end;
  except
    on e : exception do
      ShowMessage( e.ToString );
  end;
end;

function TMainForm.download(fname: string; st: TStream): boolean;
const
  BSize = 1024 * 1024;
var bytes : integer;
   buffer : array  of byte;
   fout   : TFileStream;
begin
  Result := true;
  try
    SetLength(Buffer, BSize);
    fout := TFileStream.Create( fname, fmCreate);
    repeat
      bytes := st.Read( buffer[0], BSize);
      fout.Write(buffer[0], bytes)
    until bytes <> BSize;
    FreeAndNil(fout);
  except
    Result := false;
  end;
  SetLength(Buffer, 0);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  fname : string;
begin
  m_client := NIL;

  fname := paramStr(0)+'.ini';
  if FileExists(fname) then
    IniOptions.LoadFromFile(fname);
end;

function TMainForm.md5(st: TStream): string;
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

function TMainForm.md5(fname: string): string;
var
  fs   : TFileStream;
begin
  Result := '';

  fs := NIL;
  if not FileExists(fname) then
    exit;

  try
    fs    := TFileStream.Create(fname, fmOpenRead + fmShareDenyWrite);
    Result := md5(fs);
  finally
    fs.Free;
  end;
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

end.


