unit u_ini;

interface

uses
  Classes, SysUtils, IniFiles, Forms, Windows;

const
  csIniserverSection = 'server';

  {Section: server}
  csIniserverhost = 'host';
  csIniserverport = 'port';

type
  TIniOptions = class(TObject)
  private
    {Section: server}
    Fserverhost: string;
    Fserverport: Integer;
  public
    procedure LoadSettings(Ini: TIniFile);
    procedure SaveSettings(Ini: TIniFile);
    
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);

    {Section: server}
    property serverhost: string read Fserverhost write Fserverhost;
    property serverport: Integer read Fserverport write Fserverport;
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
  end;
end;

procedure TIniOptions.SaveSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: server}
    Ini.WriteString(csIniserverSection, csIniserverhost, Fserverhost);
    Ini.WriteInteger(csIniserverSection, csIniserverport, Fserverport);
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

