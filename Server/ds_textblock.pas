unit ds_textblock;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB, IBX.IBCustomDataSet, IBX.IBDatabase,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  System.JSON, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  [TRoleAuth('user,admin', 'download')]
  TdsTextBlock = class(TDSServerModule)
    TBTab: TDataSetProvider;
    DelTB: TDataSetProvider;
    IBTransaction1: TFDTransaction;
    TB: TFDTable;
    DelQry: TFDQuery;
    ListTagQry: TFDQuery;
    FDTransaction1: TFDTransaction;
  private
    { Private-Deklarationen }
  public
    function getTagList : TJSONObject;
  end;

implementation

uses
  u_json;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsTextBlock }

function TdsTextBlock.getTagList: TJSONObject;
var
  split   : TSTringList;
  list    : TStringList;
  inx, i  : integer;
begin
  Result := TJSONObject.Create;
  split  := TSTringList.Create;
  list   := TStringList.Create;

  ListTagQry.Open;
  while not ListTagQry.Eof do begin
    split.DelimitedText := ListTagQry.FieldByName('TB_TAGS').AsString;
    for i := 0 to pred(split.Count) do begin
      inx := list.IndexOf(split[i]);
      if inx = -1 then
        list.Add(split[i]);
    end;
    ListTagQry.Next;
  end;
  ListTagQry.Close;

  list.Sort;

  setText(Result, 'tags', list);
  list.Free;
  split.Free;

  if FDTransaction1.Active then
    FDTransaction1.Commit;
end;

end.

