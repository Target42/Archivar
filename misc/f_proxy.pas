unit f_proxy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base,
  IdHTTP, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Samples.Spin, Data.SqlExpr, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient;

type
  TProxyForm = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    BitBtn1: TBitBtn;
    LabeledEdit4: TLabeledEdit;
    IdHTTP1: TIdHTTP;
    BaseFrame1: TBaseFrame;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    m_sql : TSQLConnection;
    function GetProxyServer: string;
    procedure SetProxyServer(const Value: string);
    function GetProxyPort: integer;
    procedure SetProxyPort(const Value: integer);
    function GetProxyUser: string;
    procedure SetProxyUser(const Value: string);
    function GetProxyPwd: string;
    procedure SetProxyPwd(const Value: string);
    function GetSQLConnection: TSQLConnection;
    procedure SetSQLConnection(const Value: TSQLConnection);
    { Private-Deklarationen }
  public
    property ProxyServer: string read GetProxyServer write SetProxyServer;
    property ProxyPort: integer read GetProxyPort write SetProxyPort;
    property ProxyUser: string read GetProxyUser write SetProxyUser;
    property ProxyPwd: string read GetProxyPwd write SetProxyPwd;

    property SQLConnection: TSQLConnection read GetSQLConnection write SetSQLConnection;
  end;

var
  ProxyForm: TProxyForm = NIL;

implementation

uses
  System.IOUtils, System.IniFiles;

{$R *.dfm}

procedure TProxyForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  if Assigned(m_sql) then begin
    m_sql.Params.Values['DSProxyHost']     := self.ProxyServer;
    m_sql.Params.Values['DSProxyPassword'] := self.ProxyPwd;
    m_sql.Params.Values['DSProxyPort']     := intToStr(self.ProxyPort);
    m_sql.Params.Values['DSProxyUsername'] := self.ProxyUser;
    m_sql.Params.Values['User_Name']       := self.ProxyUser;
    m_sql.Params.Values['Password']        := self.ProxyPwd;
  end;
end;

procedure TProxyForm.BitBtn1Click(Sender: TObject);
begin
  BaseFrame1.OKBtn.Enabled := false;
  IdHTTP1.ProxyParams.ProxyServer   := Trim(LabeledEdit1.Text);
  IdHTTP1.ProxyParams.ProxyPort     := SpinEdit1.Value;
  IdHTTP1.ProxyParams.ProxyUsername := LabeledEdit2.Text;
  IdHTTP1.ProxyParams.ProxyPassword := LabeledEdit3.Text;

  Screen.Cursor := crHourGlass;
  try
    IdHTTP1.Get(LabeledEdit4.Text);
    Screen.Cursor := crDefault;
    if IdHTTP1.ResponseCode = 200 then begin
      BaseFrame1.OKBtn.Enabled := true;
      ShowMessage('Test erfolgreich');
    end else
      ShowMessage(IdHTTP1.ResponseText);
  except
    on e : exception do begin
      Screen.Cursor := crDefault;
      ShowMessage('Test fehlgeschlagen'#13+e.ToString );
      BaseFrame1.OKBtn.Enabled := false;
    end;
  end;
end;

procedure TProxyForm.BitBtn2Click(Sender: TObject);
var
  fname : string;
  ini   : TIniFile;
begin
  fname := TPath.Combine(ExtractFilePath(ParamStr(0)), 'proxy.dat');

  ini := TIniFile.Create(fname);
  ini.WriteString('proxy', 'host', LabeledEdit1.Text);
  ini.WriteString('proxy', 'user', LabeledEdit2.Text);
  ini.WriteString('proxy', 'pwd', LabeledEdit3.Text);
  ini.WriteInteger('proxy','port', SpinEdit1.Value);
  ini.Free;

end;

procedure TProxyForm.FormCreate(Sender: TObject);
var
  fname : string;
  ini   : TIniFile;
begin
  BaseFrame1.OKBtn.Enabled := false;
  m_sql := NIL;
  fname := TPath.Combine(ExtractFilePath(ParamStr(0)), 'proxy.dat');

  if FileExists(fname) then begin
    ini := TIniFile.Create(fname);

    LabeledEdit1.Text := ini.ReadString('proxy', 'host', '');
    LabeledEdit2.Text := ini.ReadString('proxy', 'user', '');
    LabeledEdit3.Text := ini.ReadString('proxy', 'pwd', '');
    SpinEdit1.Value   := ini.ReadInteger('proxy','port', 8080);
    ini.Free;
  end;
end;

function TProxyForm.GetProxyPort: integer;
begin
  Result := SpinEdit1.Value;
end;

function TProxyForm.GetProxyPwd: string;
begin
  Result := LabeledEdit3.Text;
end;

function TProxyForm.GetProxyServer: string;
begin
  Result := LabeledEdit1.Text;
end;

function TProxyForm.GetProxyUser: string;
begin
  Result := LabeledEdit2.Text;
end;

function TProxyForm.GetSQLConnection: TSQLConnection;
begin
  Result := m_sql;
end;

procedure TProxyForm.SetProxyPort(const Value: integer);
begin
  SpinEdit1.Value := value;
end;

procedure TProxyForm.SetProxyPwd(const Value: string);
begin
  LabeledEdit3.Text := value;
end;

procedure TProxyForm.SetProxyServer(const Value: string);
begin
  LabeledEdit1.Text := value;
end;

procedure TProxyForm.SetProxyUser(const Value: string);
begin
  LabeledEdit2.Text := value;
end;

procedure TProxyForm.SetSQLConnection(const Value: TSQLConnection);
begin
  m_sql := value;

  if Assigned(m_sql) then begin
    m_sql.Params.Values['DSProxyHost']     := '';
    m_sql.Params.Values['DSProxyPassword'] := '';
    m_sql.Params.Values['DSProxyPort']     := '';
    m_sql.Params.Values['DSProxyUsername'] := '';
    m_sql.Params.Values['User_Name']       := '';
    m_sql.Params.Values['Password']        := '';
  end;

end;

end.
