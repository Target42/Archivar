unit u_ini;

interface

uses
  Classes, SysUtils, IniFiles, Forms, Windows;

const
  csIniserverSection = 'server';
  csInirunSection = 'run';
  csInilauncherSection = 'launcher';

  {Section: server}
  csIniserverhost = 'host';
  csIniserverport = 'port';

  {Section: run}
  csInirunprg = 'prg';

  {Section: launcher}
  csInilauncherimage = 'image';
  csInilauncherterminate = 'terminate';

type
  TIniOptions = class(TObject)
  private
    {Section: server}
    Fserverhost: string;
    Fserverport: Integer;

    {Section: run}
    Frunprg: string;

    {Section: launcher}
    Flauncherimage: string;
    Flauncherterminate: string;
  public
    procedure LoadSettings(Ini: TIniFile);
    procedure SaveSettings(Ini: TIniFile);
    
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);

    {Section: server}
    property serverhost: string read Fserverhost write Fserverhost;
    property serverport: Integer read Fserverport write Fserverport;

    {Section: run}
    property runprg: string read Frunprg write Frunprg;

    {Section: launcher}
    property launcherimage: string read Flauncherimage write Flauncherimage;
    property launcherterminate: string read Flauncherterminate write Flauncherterminate;
  end;

var
  IniOptions: TIniOptions = nil;

implementation

procedure TIniOptions.LoadSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: server}
    Fserverhost := Ini.ReadString(csIniserverSection, csIniserverhost, 'localhost');
    Fserverport := Ini.ReadInteger(csIniserverSection, csIniserverport, 211);

    {Section: run}
    Frunprg := Ini.ReadString(csInirunSection, csInirunprg, 'Archivar.exe');

    {Section: launcher}
    Flauncherimage := Ini.ReadString(csInilauncherSection, csInilauncherimage, '');
    Flauncherterminate := Ini.ReadString(csInilauncherSection, csInilauncherterminate, 'true');
  end;
end;

procedure TIniOptions.SaveSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: server}
    Ini.WriteString(csIniserverSection, csIniserverhost, Fserverhost);
    Ini.WriteInteger(csIniserverSection, csIniserverport, Fserverport);

    {Section: run}
    Ini.WriteString(csInirunSection, csInirunprg, Frunprg);

    {Section: launcher}
    Ini.WriteString(csInilauncherSection, csInilauncherimage, Flauncherimage);
    Ini.WriteString(csInilauncherSection, csInilauncherterminate, Flauncherterminate);
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

