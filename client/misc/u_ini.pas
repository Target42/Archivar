unit u_ini;

interface

type
  TIniObject = class
    private
      const
        secProxy      = 'Proxy';
        keyProxyActive= 'active';
        keyProxyHost  = 'host';
        keyProxyPort  = 'port';
        keyProxyUser  = 'user';
        keyProxyPwd   = 'pwd';

        secSpell      = 'Spell';
        keySpellDict  = 'spell';
        keySpellHyphen= 'hyphen';

    private
      m_fname : string;

      FProxyHost: string;
      FProxyPort: integer;
      FProxyUser: string;
      FProxyPwd: string;
      FProxyActive: boolean;
      FSpellDict: string;
      FSpellHyphen: string;

    public
      constructor create;
      Destructor Destroy; override;

      property ProxyActive: boolean read FProxyActive write FProxyActive;
      property ProxyHost: string read FProxyHost write FProxyHost;
      property ProxyPort: integer read FProxyPort write FProxyPort;
      property ProxyUser: string read FProxyUser write FProxyUser;
      property ProxyPwd: string read FProxyPwd write FProxyPwd;

      property SpellDict: string read FSpellDict write FSpellDict;
      property SpellHyphen: string read FSpellHyphen write FSpellHyphen;

      procedure load;
      procedure save;
  end;

var
  IniObject : TIniObject;
implementation

uses
  IniFiles;
{ TIniObject }

constructor TIniObject.create;
begin
  m_fname := ParamStr(0)+'.ini';
end;

destructor TIniObject.Destroy;
begin

  inherited;
end;

procedure TIniObject.load;
var
  ini : TIniFile;
begin
  ini := TiniFile.Create(m_fname);

  FProxyActive:= ini.ReadBool(    secProxy, keyProxyActive, false);
  FProxyHost  := ini.ReadString(  secProxy, keyProxyHost,   '');
  FProxyPort  := ini.ReadInteger( secProxy, keyProxyPort,   0);
  FProxyUser  := ini.ReadString(  secProxy, keyProxyUser,   '');
  FProxyPwd   := ini.ReadString(  secProxy, keyProxyPwd,    '');

  FSpellDict  := ini.ReadString(  secSpell, keySpellDict,   'Deutsch (Deutschland)');
  FSpellHyphen:= ini.ReadString(  secSpell, keySpellHyphen, 'Deutsch (Deutschland)');

  ini.Free;
end;

procedure TIniObject.save;
var
  ini : TIniFile;
begin
  ini := TiniFile.Create(m_fname);
  ini.WriteBool(    secProxy, keyProxyActive, FProxyActive);
  ini.WriteString(  secProxy, keyProxyHost,   FProxyHost);
  ini.WriteInteger( secProxy, keyProxyPort,   FProxyPort);
  ini.WriteString(  secProxy, keyProxyUser,   FProxyUser);
  ini.WriteString(  secProxy, keyProxyPwd,    FProxyPwd);

  ini.WriteString(  secSpell, keySpellDict,   FSpellDict);
  ini.WriteString(  secSpell, keySpellHyphen, FSpellHyphen);

  ini.Free;
end;

initialization
  IniObject := TIniObject.Create;
finalization
  IniObject.Free;
end.
