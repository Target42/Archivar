unit ds_updater;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, System.JSON;

type
  [TRoleAuth('download,admin', 'user')]
  TdsUpdater = class(TDSServerModule)
  private
    function ScanPath(base: string): TJSONObject;
  public
    function download( obj : TJSONObject ) : TStream;
    function getFileList : TJSONObject;
  end;

implementation

uses
  u_ini, System.IOUtils, System.Types, u_json, m_glob_server, IdGlobalProtocols;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdsUpdater }

function TdsUpdater.download(obj: TJSONObject): TStream;
var
  path : string;
  fname : string;
begin
  Result := NIL;
  if not SameText(IniOptions.DNLactive, 'true') then exit;

  path    := ExpandUNCFileName(TPath.Combine( ExtractFilePath(paramStr(0)), IniOptions.clientdir ));
  fname   := ExpandUNCFileName(TPath.Combine( path, JString(obj, 'name')));

  if pos( path, fname) = 1 then begin
    if FileExists(fname) then begin
      Result := TFileStream.Create(fname, fmOpenRead + fmShareDenyNone);
    end;
  end;
end;

function TdsUpdater.getFileList: TJSONObject;
var
  path    : string;
begin

  if SameText(IniOptions.DNLactive, 'true') then begin
    path    := TPath.Combine( ExtractFilePath(paramStr(0)), IniOptions.clientdir );
    Result  := ScanPath(path);
  end else
    Result := TJSONObject.Create;
end;

function TdsUpdater.ScanPath(base: string): TJSONObject;
var
  len : integer;
  function addFolder( path : string ) : TJSONObject;
  var
    arr : TStringDynArray;
    items : TJSONArray;

    procedure addFiles;
    var
      i : integer;
      s : string;
      obj : TJSONObject;
    begin
      arr := TDirectory.GetFiles(path);
      if Length(arr) > 0 then begin
        items := TJSONArray.Create;
        for i := low(arr) to High(arr) do begin
          s := ExtractFileName(arr[i]);
          if s[1] <> '.' then begin
            obj := TJSONObject.Create;
            JReplace( obj, 'name', s);
            JReplace( obj, 'size', FileSizeByName( arr[i] ));
            JReplace( obj, 'md5',  GM.md5(arr[i]));

            items.AddElement(obj);
          end;
        end;

        JReplace(Result, 'files', items);
        SetLength(arr, 0);
      end;
    end;

    procedure AddSubFolder;
    var
      i : integer;
    begin
      items := TJSONArray.Create;
      arr := TDirectory.GetDirectories(path);
      if length(arr) > 0 then begin
        for i := low(arr) to high(arr) do begin
          items.AddElement( addFolder(arr[i]));
        end;
        JReplace( Result, 'childs', items);
        setLength(arr, 0);
      end;
    end;
  begin
    Result := TJSONObject.Create;
    JReplace(Result, 'path', copy( path, len));
    // Files
    AddFiles;

    // SubFolder
    AddSubFolder;
  end;
begin
  Result := TJSONObject.Create;
  base := Trim(base);

  if base[length(base)] <> '\' then
    base := base+ '\';

  len := Length(base)+1;

  JReplace( Result, 'folder', AddFolder( base ));
end;

end.

