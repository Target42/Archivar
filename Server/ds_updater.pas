unit ds_updater;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, System.JSON;

type
  [TRoleAuth('download,admin', 'user')]
  TdsUpdater = class(TDSServerModule)
  private
    { Private-Deklarationen }
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

  path    := TPath.Combine( ExtractFilePath(paramStr(0)), IniOptions.clientdir );
  fname   := TPath.Combine( path, JString(obj, 'name'));
  if FileExists(fname) then begin
    Result := TFileStream.Create(fname, fmOpenRead + fmShareDenyNone);
  end;
end;

function TdsUpdater.getFileList: TJSONObject;
var
  path    : string;
  arr     : TStringDynArray;
  len, i  : integer;
  list    : TJSONArray;
  row     : TJSONObject;
begin
  Result  := TJSONObject.Create;
  list    := TJSONArray.Create;

  if SameText(IniOptions.DNLactive, 'true') then begin
    path    := TPath.Combine( ExtractFilePath(paramStr(0)), IniOptions.clientdir );
    len     := Length( path ) + 1;
    arr     := TDirectory.GetFiles( path );

    for i := low(arr) to high(arr) do begin
      row := TJSONObject.Create;

      JReplace(row, 'name', Copy(arr[i], len));
      JReplace(row, 'md5',  GM.md5(arr[i]));
      JReplace(row, 'size', FileSizeByName( arr[i] ));

      list.Add(row)
    end;
  end;

  JReplace( Result, 'items', list);
end;

end.

