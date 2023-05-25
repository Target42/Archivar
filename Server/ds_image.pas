unit ds_image;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  Datasnap.Provider, Data.DB,
  System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  [TRoleAuth('admin,user')]
  TdsImage = class(TDSServerModule)
    PicturesTab: TDataSetProvider;
    AutoIncQry: TFDQuery;
    PicTab: TFDTable;
    IBTransaction1: TFDTransaction;
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
  if PicTab.Transaction.Active then
    PicTab.Transaction.Commit;

  Result := mem;
end;

function TdsImage.getimageList: TJSONObject;
var
 arr : TJSONArray;
 row : TJSONObject;
begin
  Result := TJSONObject.Create;
  arr := TJSONArray.Create;
  PicTab.Transaction.StartTransaction;
  try
    PicTab.Open;
    while not PicTab.Eof do
    begin
      row := TJSONObject.Create;
      JReplace( row, 'name', PicTab.FieldByName('PI_NAME').AsString);
      JReplace( row, 'md5',  PicTab.FieldByName('PI_MD5').AsString);
      arr.AddElement(row);
      PicTab.Next;
    end;
    PicTab.Close;

    if PicTab.Transaction.Active then
      PicTab.Transaction.Commit;
  except
    if PicTab.Transaction.Active then
      PicTab.Transaction.Rollback;

  end;

  JReplace( Result, 'items', arr);
end;

end.

