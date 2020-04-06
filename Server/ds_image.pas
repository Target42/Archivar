unit ds_image;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, m_glob_server,
  IBX.IBDatabase, m_db, Datasnap.Provider, Data.DB, IBX.IBCustomDataSet,
  IBX.IBTable, System.JSON, IBX.IBQuery;

type
  [TRoleAuth('admin')]
  TdsImage = class(TDSServerModule)
    IBTransaction1: TIBTransaction;
    PicTab: TIBTable;
    PicturesTab: TDataSetProvider;
    AutoIncQry: TIBQuery;
  private
    { Private-Deklarationen }
  public
    function getimageList :TJSONObject;
    function getImage( data :  TJSONObject ) : TStream;
    function AutoInc( gen : string ) : integer;
  end;

implementation

uses
  u_json, System.Variants;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsImage }

function TdsImage.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;
end;

function TdsImage.getImage(data: TJSONObject): TStream;
var
  mem  : TMemoryStream;
  src  : TStream;
begin
  mem := TMemoryStream.Create;
  PicTab.Open;
  if PicTab.Locate('PI_NAME', VarArrayOf([JString(data, 'name')]), [loCaseInsensitive]) then
  begin
    src := PicTab.CreateBlobStream(PicTab.FieldByName('PI_DATA'), bmRead);
    mem.CopyFrom( src, src.Size);
    mem.Position := 0;
    src.Free;
  end;
  PicTab.Close;
  Result := mem;
end;

function TdsImage.getimageList: TJSONObject;
var
 arr : TJSONArray;
 row : TJSONObject;
begin
  Result := TJSONObject.Create;
  arr := TJSONArray.Create;
  PicTab.Open;
  while not PicTab.Eof do
  begin
    row := TJSONObject.Create;
    JReplace( row, 'name', PicTab.FieldByName('PI_NAME').AsString);
    JReplace( row, 'md5',  PicTab.FieldByName('PI_MD5').AsString);
    arr.AddElement(row);
    PicTab.Next;
  end;

  JReplace( Result, 'items', arr);
end;

end.

