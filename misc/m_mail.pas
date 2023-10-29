unit m_mail;

interface

uses
  System.SysUtils, System.Classes, IdSMTP, IdMessage, IdIOHandler,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdTCPConnection,
  IdIMAP4, System.JSON, System.Generics.Collections, IdSMTPBase,
  IdIOHandlerSocket, IdComponent, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient;

type
  TMailMod = class(TDataModule)
    IdIMAP41: TIdIMAP4;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    TestMsg: TIdMessage;
    IdSMTP1: TIdSMTP;
    IdSSLIOHandlerSocketOpenSSL2: TIdSSLIOHandlerSocketOpenSSL;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_mailFolder : TStringlist;
    m_selectedMailFolder : TStringList;
    m_list       : TList<TIdMessage>;

    function GetIMapHost: string;
    procedure SetIMapHost(const Value: string);
    function GetImapPort: integer;
    procedure SetImapPort(const Value: integer);
    function GetImapUser: string;
    procedure SetImapUser(const Value: string);
    function GetImapPWD: string;
    procedure SetImapPWD(const Value: string);
    function GetSmtpHost: string;
    procedure SetSmtpHost(const Value: string);
    function GetSmtpPort: integer;
    procedure SetSmtpPort(const Value: integer);
    function GetSmtpUser: string;
    procedure SetSmtpUser(const Value: string);
    function GetSmtpPwd: string;
    procedure SetSmtpPwd(const Value: string);
    procedure clearMails;
  public

    // common
    procedure load;
    function save : boolean;
    class function getMailConfig : TJSONObject;

    procedure config( data : TJSONObject );
    function currentConfig : TJSONObject;

    // imap
    property IMapHost: string read GetIMapHost write SetIMapHost;
    property ImapPort: integer read GetImapPort write SetImapPort;
    property IMapUser: string read GetImapUser write SetImapUser;
    property IMapPWD: string read GetImapPWD write SetImapPWD;

    property MailFolder : TStringList read m_mailFolder;
    property SelectedMailFolder : TStringList read m_selectedMailFolder;
    property Mails      : TList<TIdMessage> read m_list;

    procedure loadImap;
    function saveIMap : boolean;

    function testImap : boolean;

    function connect : boolean;
    procedure disconnect;

    function connectImap : boolean;
    procedure closeImap;

    function connectSmtp:boolean;
    procedure closeSmtp;

    function updateMailFolder : boolean;
    function SelectInbox( name : string ) : boolean;
    function updateMails : boolean;

    //smtp
    property SmtpHost: string read GetSmtpHost write SetSmtpHost;
    property SmtpPort: integer read GetSmtpPort write SetSmtpPort;
    property SmtpUser: string read GetSmtpUser write SetSmtpUser;
    property SmtpPwd: string read GetSmtpPwd write SetSmtpPwd;

    procedure loadSmtp;
    function saveSmtp : boolean;
    function testSmtp( mail : string ) : boolean;

    function sendText( names : TStringList; subject, text : string ) : boolean;

    function checkImap : boolean;
    function checkSmtp : boolean;

  end;

var
  MailMod: TMailMod;

implementation

uses
  System.Win.Registry, Winapi.Windows, vcl.Dialogs,
  IdText, IdEMailAddress, Vcl.Forms, Vcl.Controls, u_json;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TMailMod.checkImap: boolean;
begin
  Result := (IdIMAP41.Host <> '') and (IdIMAP41.Username <> '' ) and
            (IdIMAP41.Password <> '' ) and ( IdIMAP41.Port <> 0 );
end;

function TMailMod.checkSmtp: boolean;
begin
  Result := ( IdSMTP1.Host <> '' ) and ( IdIMAP41.Username <> '' ) and
            ( IdSMTP1.Password <> '' ) and ( IdSMTP1.Port <> 0 );
end;

procedure TMailMod.clearMails;
var
  mail : TIdMessage;
begin
  for mail in m_list do
    mail.Free;
  m_list.Clear;
end;

procedure TMailMod.closeImap;
begin
  IdIMAP41.Disconnect;
end;

procedure TMailMod.closeSmtp;
begin
  IdSMTP1.Disconnect;
end;

procedure TMailMod.config(data: TJSONObject);
var
  obj : TJSONObject;
begin
  if not Assigned(data) then exit;

  try
    obj := JObject( data, 'imap');
    if Assigned(obj) then begin
      IdIMAP41.Host     := JString( obj, 'host');
      IdIMAP41.Port     := JInt(    obj, 'port');
      IdIMAP41.Username := JString( obj, 'user');
      IdIMAP41.Password := JString( obj, 'pwd' );
      getText( obj, 'folder', m_selectedMailFolder);
    end;
  except

  end;

  try
    obj := JObject( data, 'smtp');
    if Assigned(obj) then begin
      IdSMTP1.Host     := JString( obj, 'host');
      IdSMTP1.Port     := JInt(    obj, 'port');
      IdSMTP1.Username := JString( obj, 'user');
      IdSMTP1.Password := JString( obj, 'pwd' );
    end;
  except

  end;

end;

function TMailMod.connect: boolean;
begin
  Result :=false;
  try
    IdIMAP41.Connect;
    Result := IdIMAP41.Connected;
  except

  end;
end;

function TMailMod.connectImap: boolean;
begin
  Result :=false;
  try
    IdIMAP41.Connect;
    Result := IdIMAP41.Connected;
  except

  end;
end;

function TMailMod.connectSmtp: boolean;
begin
  Result := false;
  try
    IdSMTP1.Connect;

    Result := IdSMTP1.Connected;
  except
  end;

end;

function TMailMod.currentConfig: TJSONObject;
var
  obj : TJSONObject;
begin
  Result := TJSONObject.Create;
  JReplace(Result, 'typ', 'imap/smtp');

  obj := TJSONObject.Create;
  JReplace( obj, 'host', IdIMAP41.Host );
  JReplace( obj, 'port', IdIMAP41.Port );
  JReplace( obj, 'user', IdIMAP41.Username );
  JReplace( obj, 'pwd',  IdIMAP41.Password );
  setText( obj, 'folder', m_selectedMailFolder);
  JReplace(Result, 'imap', obj);

  obj := TJSONObject.Create;
  JReplace( obj, 'host', IdSMTP1.Host );
  JReplace( obj, 'port', IdSMTP1.Port );
  JReplace( obj, 'user', IdSMTP1.Username );
  JReplace( obj, 'pwd',  IdSMTP1.Password );
  JReplace(Result, 'smtp', obj);
end;

procedure TMailMod.DataModuleCreate(Sender: TObject);
begin
  m_mailFolder          := TStringlist.Create;
  m_selectedMailFolder  := TStringList.Create;
  m_list                := TList<TIdMessage>.create;
end;

procedure TMailMod.DataModuleDestroy(Sender: TObject);
begin
  m_mailFolder.free;
  m_selectedMailFolder.Free;
  clearmails;
  m_list.Free;
end;

procedure TMailMod.disconnect;
begin
  closeImap;
  closeImap;
end;

function TMailMod.GetIMapHost: string;
begin
  Result := IdIMAP41.Host;
end;

function TMailMod.GetImapPort: integer;
begin
  Result := IdIMAP41.Port;
end;

function TMailMod.GetImapPWD: string;
begin
  Result := IdIMAP41.Password;
end;

function TMailMod.GetImapUser: string;
begin
  Result := IdIMAP41.Username;
end;

class function TMailMod.getMailConfig: TJSONObject;
var
  reg : TRegistry;

  function get(path : string ) : TJSONObject;
  begin
    Result := TJSONObject.Create;
    if reg.OpenKey(path, false) then begin
      JReplace( Result, 'host', reg.ReadString('host'));
      JReplace( Result, 'port', reg.ReadInteger('port'));
      JReplace( Result, 'user', reg.ReadString('user'));
      JReplace( Result, 'pwd',  reg.ReadString('pwd'));
    end;
  end;
begin
  Result := TJSONObject.Create;

  reg := TRegistry.Create(KEY_READ or KEY_WOW64_64KEY);
  reg.RootKey := HKEY_LOCAL_MACHINE;

  JReplace(Result, 'kontoname', 'system');
  JReplace(Result, 'typ', 'imap/smtp');

  if reg.KeyExists('Software\Archivar\imap') then begin
    JReplace( Result, 'imap', get('Software\Archivar\imap'));
    setText( Result, 'folder', 'INBOX');
  end;
  if reg.KeyExists('Software\Archivar\smtp') then
    JReplace( Result, 'smtp', get('Software\Archivar\smtp'));

  reg.Free;
end;

function TMailMod.GetSmtpHost: string;
begin
  Result := IdSMTP1.Host;
end;

function TMailMod.GetSmtpPort: integer;
begin
  Result := IdSMTP1.Port;
end;

function TMailMod.GetSmtpPwd: string;
begin
  Result := IdSMTP1.Password;
end;

function TMailMod.GetSmtpUser: string;
begin
  Result := IdSMTP1.Username;
end;

procedure TMailMod.load;
begin
  loadImap;
  loadSmtp;
end;

procedure TMailMod.loadImap;
var
  reg : TRegistry;
begin
  reg := TRegistry.Create( KEY_READ or KEY_WOW64_64KEY );
  reg.RootKey := HKEY_LOCAL_MACHINE;

  if reg.OpenKey('Software\Archivar\imap', false) then begin

    IdIMAP41.Host     := reg.ReadString('host');
    IdIMAP41.Port     := reg.ReadInteger('port');
    IdIMAP41.Username := reg.ReadString('user');
    IdIMAP41.Password := reg.ReadString('pwd');
  end;
  reg.Free;
end;

procedure TMailMod.loadSmtp;
var
  reg : TRegistry;
begin
  reg := TRegistry.Create( KEY_READ or KEY_WOW64_64KEY );
  reg.RootKey := HKEY_LOCAL_MACHINE;

  if reg.OpenKey('Software\Archivar\smtp', false) then begin

    IdSMTP1.Host     := reg.ReadString('host');
    IdSMTP1.Port     := reg.ReadInteger('port');
    IdSMTP1.Username := reg.ReadString('user');
    IdSMTP1.Password := reg.ReadString('pwd');
  end;

  reg.Free;
end;

function TMailMod.save: boolean;
begin
  Result := saveIMap and saveSmtp;
end;

function TMailMod.saveIMap: boolean;
var
  reg : TRegistry;
begin
  Result := false;
  reg := TRegistry.Create(KEY_WRITE );
  reg.RootKey := HKEY_CURRENT_USER;
  try
    if reg.OpenKey('Software\Archivar\imap', true) then begin
      reg.WriteString('host',   IdIMAP41.Host);
      reg.WriteInteger('port',  IdIMAP41.Port);
      reg.WriteString('user',   IdIMAP41.Username);
      reg.WriteString('pwd',    IdIMAP41.Password);
    end;
    Result := true;
  except

  end;
  reg.Free;
end;

function TMailMod.saveSmtp: boolean;
var
  reg : TRegistry;
begin
  Result := false;
  reg := TRegistry.Create(KEY_WRITE );
  reg.RootKey := HKEY_CURRENT_USER;
  try
    if reg.OpenKey('Software\Archivar\smtp', true) then begin

      reg.WriteString('host',   IdSMTP1.Host);
      reg.WriteInteger('port',  IdSMTP1.Port);
      reg.WriteString('user',   IdSMTP1.Username);
      reg.WriteString('pwd',    IdSMTP1.Password);
    end;
    Result := true;
  except

  end;

  reg.Free;
end;

function TMailMod.SelectInbox(name: string): boolean;
begin
  Result := false;
  if IdIMAP41.Connected then begin
    Result := IdIMAP41.SelectMailBox(name);
    if Result  then
      Result := updateMails;
  end;
end;

function TMailMod.sendText(names: TStringList; subject, text: string): boolean;
var
  msg : TIdMessage;
  mtext : TIdText;
  addr  : TIdEMailAddressItem;
  i     : integer;
begin
  Result := false;

  msg := TIdMessage.Create();
  msg.ContentType := 'multipart/alternative';
  msg.AttachmentEncoding := 'MIME';
  msg.Encoding  := meMIME;
  msg.NoEncode  := false;
  msg.NoDecode  := false;
  msg.IsEncoded := true;

  msg.From.Address  := IdSMTP1.Username;
  msg.From.Name     := 'Archivar-Server';

  for i := 0 to pred(names.Count) do begin
    addr := msg.Recipients.Add();
    addr.Address      := names[i]
  end;

  addr := msg.ReplyTo.Add();
  addr.Name     := 'noreply-Archivar-Server';
  addr.Address  := IdSMTP1.Username;

  msg.Subject := subject;

  mtext := TIdText.Create(msg.MessageParts);
  mtext.ContentType := 'text/html';
  mtext.Body.Text   := text;

  try
    IdSMTP1.Connect;
    IdSMTP1.Send(msg);
    Result := true;
  except
    on e :exception do begin

    end;
  end;
  IdSMTP1.Disconnect();

  msg.Free;
end;

procedure TMailMod.SetIMapHost(const Value: string);
begin
  IdIMAP41.Host := value;
  IdIMAP41.IOHandler.Host := IdIMAP41.Host;
end;

procedure TMailMod.SetImapPort(const Value: integer);
begin
  IdIMAP41.Port := value;
  IdIMAP41.IOHandler.Port := IdIMAP41.Port;
end;

procedure TMailMod.SetImapPWD(const Value: string);
begin
  IdIMAP41.Password := value;
end;

procedure TMailMod.SetImapUser(const Value: string);
begin
  IdIMAP41.Username := value;
end;

procedure TMailMod.SetSmtpHost(const Value: string);
begin
  IdSMTP1.Host := value;
  IdSMTP1.IOHandler.Host := IdSMTP1.Host;
end;

procedure TMailMod.SetSmtpPort(const Value: integer);
begin
  IdSMTP1.Port := value;
  IdSMTP1.IOHandler.Port := IdSMTP1.Port;
end;

procedure TMailMod.SetSmtpPwd(const Value: string);
begin
  IdSMTP1.Password := value;
end;

procedure TMailMod.SetSmtpUser(const Value: string);
begin
  IdSMTP1.Username := value;
end;

function TMailMod.testImap: boolean;
begin
  Result := false;
  try
    IdIMAP41.Connect;
    Result := IdIMAP41.Connected;
    IdIMAP41.Disconnect;
  except
    on e : exception do
      ShowMessage( e.ToString );
  end;
end;

function TMailMod.testSmtp(mail: string): boolean;
var
  msg : TIdMessage;
  mtext : TIdText;
  addr  : TIdEMailAddressItem;
begin
  Result := false;

  msg := TIdMessage.Create();
  msg.ContentType := 'multipart/alternative';
  msg.AttachmentEncoding := 'MIME';
  msg.Encoding  := meMIME;
  msg.NoEncode  := false;
  msg.NoDecode  := false;
  msg.IsEncoded := true;

  msg.From.Name     := 'Archivar-Server';
  msg.From.Address  := IdSMTP1.Username;

  addr := msg.Recipients.Add();
  addr.Address      := mail;

  addr := msg.ReplyTo.Add();
  addr.Name     := 'noreply';
  addr.Address  := mail;

  msg.Subject := 'Archivar-Server-Testmail';

  mtext := TIdText.Create(msg.MessageParts);
  mtext.ContentType := 'text/html';
  mtext.Body.Text   := 'Dies ist eine Textmail vom Archivar-Server!';

  Screen.Cursor := crHourGlass;
  try
    IdSMTP1.Connect;
    IdSMTP1.Send(msg);
    Result := true;
  except
    on e :exception do
      ShowMessage( e.toString );
  end;
  IdSMTP1.Disconnect();
  Screen.Cursor := crDefault;

  msg.Free;
end;

function TMailMod.updateMailFolder: boolean;
begin
  m_mailFolder.Clear;
  if IdIMAP41.Connected then
    IdIMAP41.ListMailBoxes(m_mailFolder);
  Result := m_mailFolder.Count > 0;
end;

function TMailMod.updateMails: boolean;
var
  i : integer;
  mail : TIdMessage;
begin
  Result := false;
  if not IdIMAP41.Connected then exit;

  clearMails;
  for i := IdIMAP41.MailBox.TotalMsgs downto 1 do begin
    mail := TIdMessage.Create;
    m_list.Add(mail);
    IdIMAP41.Retrieve(i, mail);
  end;
end;

end.
