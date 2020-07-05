unit u_zipHelper;

interface

uses
  system.zip, System.Classes;


function getZipFiles( zip : TZipfile ; path, mask : string ) : TStringList;
function loadStreamFromZip( zip : TZipfile ; fname : string ) : TStream;
function loadStringListFromZip(zip : TZipfile ; fname : string ) : TStringList;

implementation

uses
  system.IOUtils, System.RegularExpressions, System.SysUtils;

function getZipFiles( zip : TZipfile ; path, mask : string ) : TStringList;
var
  i : integer;
  cmp : string;
  regEx : TRegEx;
begin
  REsult := TStringList.Create;
  cmp   := stringreplace( path, '\', '\\', [rfReplaceAll, rfIgnoreCase]);
  cmp   := stringreplace( cmp, '{', '\{', [rfReplaceAll, rfIgnoreCase]);
  cmp   := stringreplace( cmp, '}', '\}', [rfReplaceAll, rfIgnoreCase]);
  cmp := cmp  + '\\'+mask;


  regEx := TRegEx.Create(cmp, [roIgnoreCase, roNotEmpty]);

  for i := 0 to pred(zip.FileCount) do begin
    if regEx.Match(zip.FileNames[i]).Success then
      Result.Add(zip.FileNames[i])
  end;

end;

function loadStreamFromZip( zip : TZipfile ; fname : string ) : TStream;
var
  lh : TZipHeader;
begin
  Result := NIL;
  zip.Read(fname, Result, lh);
  Result.Position := 0;
end;

function loadStringListFromZip(zip : TZipfile ; fname : string ) : TStringList;
var
  st : TStream;
begin
  Result := TStringList.Create;
  st := loadStreamFromZip(zip, fname);
  Result.LoadFromStream(st);
  st.Free;
end;

end.
