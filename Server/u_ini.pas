unit u_ini;

interface

uses
  Classes, SysUtils, IniFiles, Forms, Windows;

const
  csIniDBSection = 'DB';
  csIniDSSection = 'DS';
  csIniclientSection = 'client';
  csIniDNLSection = 'DNL';
  csInisecretSection = 'secret';
  csInisslSection = 'ssl';
  csIniPathSection = 'path';

  {Section: path }
  csIniPathLog = 'log';

  {Section: DB}
  csIniDBhost = 'host';
  csIniDBdb = 'db';
  csIniDBuser = 'user';
  csIniDBpwd = 'pwd';

  {Section: DS}
  csIniDStcpport = 'tcpport';
  csIniDShttpport = 'httpport';
  csIniDShttpsport = 'httpsport';

  {Section: client}
  csIniclientactive = 'active';
  csIniclientdir = 'dir';

  {Section: DNL}
  csIniDNLactive = 'active';
  csIniDNLport = 'port';
  csIniDNLwwwroot = 'wwwroot';
  csIniDNLlauncher = 'launcher';

  {Section: secret}
  csInisecretname = 'name';

  {Section: ssl}
  csInisslcrt = 'crt';
  csInisslkey = 'key';
  csInisslrootcrt = 'rootcrt';
  csInisslpassword = 'password';

type
  TIniOptions = class(TObject)
  private
    {Section: DB}
    FDBhost: string;
    FDBdb: string;
    FDBuser: string;
    FDBpwd: string;

    {Section: DS}
    FDStcpport: Integer;
    FDShttpport: Integer;
    FDShttpsport: Integer;

    {Section: client}
    Fclientactive: string;
    Fclientdir: string;

    {Section: DNL}
    FDNLactive: string;
    FDNLport: Integer;
    FDNLwwwroot: string;
    FDNLlauncher: string;

    {Section: secret}
    Fsecretname: string;

    {Section: ssl}
    Fsslcrt: string;
    Fsslkey: string;
    Fsslrootcrt: string;
    Fsslpassword: string;

    {Section: path }
    FPathIni : string;

  public
    procedure LoadSettings(Ini: TMemIniFile);
    procedure SaveSettings(Ini: TMemIniFile);

    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);

    {Section: DB}
    property DBhost: string read FDBhost write FDBhost;
    property DBdb: string read FDBdb write FDBdb;
    property DBuser: string read FDBuser write FDBuser;
    property DBpwd: string read FDBpwd write FDBpwd;

    {Section: DS}
    property DStcpport: Integer read FDStcpport write FDStcpport;
    property DShttpport: Integer read FDShttpport write FDShttpport;
    property DShttpsport: Integer read FDShttpsport write FDShttpsport;

    {Section: client}
    property clientactive: string read Fclientactive write Fclientactive;
    property clientdir: string read Fclientdir write Fclientdir;

    {Section: DNL}
    property DNLactive: string read FDNLactive write FDNLactive;
    property DNLport: Integer read FDNLport write FDNLport;
    property DNLwwwroot: string read FDNLwwwroot write FDNLwwwroot;
    property DNLlauncher: string read FDNLlauncher write FDNLlauncher;

    {Section: secret}
    property secretname: string read Fsecretname write Fsecretname;

    {Section: ssl}
    property sslcrt: string read Fsslcrt write Fsslcrt;
    property sslkey: string read Fsslkey write Fsslkey;
    property sslrootcrt: string read Fsslrootcrt write Fsslrootcrt;
    property sslpassword: string read Fsslpassword write Fsslpassword;

    {Section:path}
    property pathlog : string read FPathIni write FPathIni;

  end;

var
  IniOptions: TIniOptions = nil;

implementation

procedure TIniOptions.LoadSettings(Ini: TMemIniFile);
begin
  if Ini <> nil then
  begin
    {Section: DB}
    FDBhost := Ini.ReadString(csIniDBSection, csIniDBhost, 'localhost');
    FDBdb := Ini.ReadString(csIniDBSection, csIniDBdb, 'd:\db\archivar.fdb');
    FDBuser := Ini.ReadString(csIniDBSection, csIniDBuser, 'sysdba');
    FDBpwd := Ini.ReadString(csIniDBSection, csIniDBpwd, 'masterkey');

    {Section: DS}
    FDStcpport := Ini.ReadInteger(csIniDSSection, csIniDStcpport, 211);
    FDShttpport := Ini.ReadInteger(csIniDSSection, csIniDShttpport, 8088);
    FDShttpsport := Ini.ReadInteger(csIniDSSection, csIniDShttpsport, 8080);

    {Section: client}
    Fclientactive := Ini.ReadString(csIniclientSection, csIniclientactive, 'true');
    Fclientdir := Ini.ReadString(csIniclientSection, csIniclientdir, '.\client\latest\');

    {Section: DNL}
    FDNLactive := Ini.ReadString(csIniDNLSection, csIniDNLactive, 'true');
    FDNLport := Ini.ReadInteger(csIniDNLSection, csIniDNLport, 8090);
    FDNLwwwroot := Ini.ReadString(csIniDNLSection, csIniDNLwwwroot, '.\www_dnl\');
    FDNLlauncher := Ini.ReadString(csIniDNLSection, csIniDNLlauncher, '.\Launcher\');

    {Section: secret}
    Fsecretname := Ini.ReadString(csInisecretSection, csInisecretname, 'A9B5DD6E818D19B6704F64ED2B335D3E');

    {Section: ssl}
    Fsslcrt := Ini.ReadString(csInisslSection, csInisslcrt, '.\cert\BEROffice.crt');
    Fsslkey := Ini.ReadString(csInisslSection, csInisslkey, '.\cert\keyl.pem');
    Fsslrootcrt := Ini.ReadString(csInisslSection, csInisslrootcrt, '.\BEROffice.pem');
    Fsslpassword := Ini.ReadString(csInisslSection, csInisslpassword, '');

    {section: path}
    FPathIni := ini.ReadString(csIniPathSection, csIniPathSection, '.\log');
  end;
end;

procedure TIniOptions.SaveSettings(Ini: TMemIniFile);
begin
  if Ini <> nil then
  begin
    {Section: DB}
    Ini.WriteString(csIniDBSection, csIniDBhost, FDBhost);
    Ini.WriteString(csIniDBSection, csIniDBdb, FDBdb);
    Ini.WriteString(csIniDBSection, csIniDBuser, FDBuser);
    Ini.WriteString(csIniDBSection, csIniDBpwd, FDBpwd);

    {Section: DS}
    Ini.WriteInteger(csIniDSSection, csIniDStcpport, FDStcpport);
    Ini.WriteInteger(csIniDSSection, csIniDShttpport, FDShttpport);
    Ini.WriteInteger(csIniDSSection, csIniDShttpsport, FDShttpsport);

    {Section: client}
    Ini.WriteString(csIniclientSection, csIniclientactive, Fclientactive);
    Ini.WriteString(csIniclientSection, csIniclientdir, Fclientdir);

    {Section: DNL}
    Ini.WriteString(csIniDNLSection, csIniDNLactive, FDNLactive);
    Ini.WriteInteger(csIniDNLSection, csIniDNLport, FDNLport);
    Ini.WriteString(csIniDNLSection, csIniDNLwwwroot, FDNLwwwroot);
    Ini.WriteString(csIniDNLSection, csIniDNLlauncher, FDNLlauncher);

    {Section: secret}
    Ini.WriteString(csInisecretSection, csInisecretname, Fsecretname);

    {Section: ssl}
    Ini.WriteString(csInisslSection, csInisslcrt, Fsslcrt);
    Ini.WriteString(csInisslSection, csInisslkey, Fsslkey);
    Ini.WriteString(csInisslSection, csInisslrootcrt, Fsslrootcrt);
    Ini.WriteString(csInisslSection, csInisslpassword, Fsslpassword);

    {Section: path}
    ini.WriteString(csIniPathSection, csIniPathSection, '.\log');

  end;
end;

procedure TIniOptions.LoadFromFile(const FileName: string);
var
  Ini: TMemIniFile;
begin
  Ini := TMemIniFile.Create(FileName);
  try
    LoadSettings(Ini);
  finally
    Ini.Free;
  end;
end;

procedure TIniOptions.SaveToFile(const FileName: string);
var
  Ini: TMemIniFile;
begin
  Ini := TMemIniFile.Create(FileName);
  try
    SaveSettings(Ini);
    Ini.UpdateFile;
  finally
    Ini.Free;
  end;
end;

initialization
  IniOptions := TIniOptions.Create;

finalization
  IniOptions.Free;

end.

