unit u_ini;

interface

uses
  Classes, SysUtils, IniFiles, Forms, Windows;

const
  csIniDBSection = 'DB';
  csIniDSSection = 'DS';
  csIniclientSection = 'client';
  csIniDNLSection = 'DNL';
  cdSecretSection = 'secret';

  {Section: DB}
  csIniDBhost = 'host';
  csIniDBdb = 'db';
  csIniDBuser = 'user';
  csIniDBpwd = 'pwd';

  {Section: DS}
  csIniDSport = 'port';

  {Section: client}
  csIniclientactive = 'active';
  csIniclientport = 'port';
  csIniclientdir = 'dir';

  {Section: DNL}
  csIniDNLactive = 'active';
  csIniDNLport = 'port';
  csIniDNLwwwroot = 'wwwroot';

  {Section: secret }
  csIniSecretName = 'name';

type
  TIniOptions = class(TObject)
  private
    {Section: DB}
    FDBhost: string;
    FDBdb: string;
    FDBuser: string;
    FDBpwd: string;

    {Section: DS}
    FDSport: Integer;

    {Section: client}
    Fclientactive: string;
    Fclientport: Integer;
    Fclientdir: string;

    {Section: DNL}
    FDNLactive: string;
    FDNLport: Integer;
    FDNLwwwroot: string;

    {section: secret}
    FSecretName : string;
  public
    procedure LoadSettings(Ini: TIniFile);
    procedure SaveSettings(Ini: TIniFile);
    
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);

    {Section: DB}
    property DBhost: string read FDBhost write FDBhost;
    property DBdb: string read FDBdb write FDBdb;
    property DBuser: string read FDBuser write FDBuser;
    property DBpwd: string read FDBpwd write FDBpwd;

    {Section: DS}
    property DSport: Integer read FDSport write FDSport;

    {Section: client}
    property clientactive: string read Fclientactive write Fclientactive;
    property clientport: Integer read Fclientport write Fclientport;
    property clientdir: string read Fclientdir write Fclientdir;

    {Section: DNL}
    property DNLactive: string read FDNLactive write FDNLactive;
    property DNLport: Integer read FDNLport write FDNLport;
    property DNLwwwroot: string read FDNLwwwroot write FDNLwwwroot;

    {Section: secret}
    property SecretName : string read FSecretName write FSecretName;
  end;

var
  IniOptions: TIniOptions = nil;

implementation

procedure TIniOptions.LoadSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: DB}
    FDBhost := Ini.ReadString(csIniDBSection, csIniDBhost, 'localhost');
    FDBdb := Ini.ReadString(csIniDBSection, csIniDBdb, 'd:\db\archivar.gdb');
    FDBuser := Ini.ReadString(csIniDBSection, csIniDBuser, 'sysdba');
    FDBpwd := Ini.ReadString(csIniDBSection, csIniDBpwd, 'masterkey');

    {Section: DS}
    FDSport := Ini.ReadInteger(csIniDSSection, csIniDSport, 211);

    {Section: client}
    Fclientactive := Ini.ReadString(csIniclientSection, csIniclientactive, 'true');
    Fclientport := Ini.ReadInteger(csIniclientSection, csIniclientport, 42000);
    Fclientdir := Ini.ReadString(csIniclientSection, csIniclientdir, '.\client\latest\');

    {Section: DNL}
    FDNLactive := Ini.ReadString(csIniDNLSection, csIniDNLactive, 'true');
    FDNLport := Ini.ReadInteger(csIniDNLSection, csIniDNLport, 42001);
    FDNLwwwroot := Ini.ReadString(csIniDNLSection, csIniDNLwwwroot, '.\www_dnl\');

    {Section: secret}
    FSecretName := ini.ReadString(cdSecretSection, csIniSecretName, '');
  end;
end;

procedure TIniOptions.SaveSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: DB}
    Ini.WriteString(csIniDBSection, csIniDBhost, FDBhost);
    Ini.WriteString(csIniDBSection, csIniDBdb, FDBdb);
    Ini.WriteString(csIniDBSection, csIniDBuser, FDBuser);
    Ini.WriteString(csIniDBSection, csIniDBpwd, FDBpwd);

    {Section: DS}
    Ini.WriteInteger(csIniDSSection, csIniDSport, FDSport);

    {Section: client}
    Ini.WriteString(csIniclientSection, csIniclientactive, Fclientactive);
    Ini.WriteInteger(csIniclientSection, csIniclientport, Fclientport);
    Ini.WriteString(csIniclientSection, csIniclientdir, Fclientdir);

    {Section: DNL}
    Ini.WriteString(csIniDNLSection, csIniDNLactive, FDNLactive);
    Ini.WriteInteger(csIniDNLSection, csIniDNLport, FDNLport);
    Ini.WriteString(csIniDNLSection, csIniDNLwwwroot, FDNLwwwroot);

    {Section: secret}
    ini.WriteString(cdSecretSection, csIniSecretName, FSecretName);
  end;
end;

procedure TIniOptions.LoadFromFile(const FileName: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FileName);
  try
    LoadSettings(Ini);
  finally
    Ini.Free;
  end;
end;

procedure TIniOptions.SaveToFile(const FileName: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FileName);
  try
    SaveSettings(Ini);
  finally
    Ini.Free;
  end;
end;

initialization
  IniOptions := TIniOptions.Create;

finalization
  IniOptions.Free;

end.

