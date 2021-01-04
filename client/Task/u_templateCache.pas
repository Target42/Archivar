unit u_templateCache;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, System.Generics.Collections, m_glob_client, i_taskEdit;

type
  TTemplateCacheMod = class(TDataModule)
    DSProviderConnection1: TDSProviderConnection;
    GetTEQry: TClientDataSet;
    GetSysTeQry: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_list  : Tlist<ITaskContainer>;
    m_idMap : TDictionary<integer, ITaskContainer>;
    m_map   : TDictionary<string, ITaskContainer>;
    function loadTemplate(dataset: TClientDataset) : boolean;

  public
    { Public-Deklarationen }
    function load( teid : integer ) : ITaskContainer;
    function SysLoad( clid : string ) : ITaskContainer;

  end;

var
  TemplateCacheMod: TTemplateCacheMod;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TTemplateCacheMod.DataModuleCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_list  := Tlist<ITaskContainer>.create;
  m_idMap := TDictionary<integer, ITaskContainer>.create;
  m_map   := TDictionary<string, ITaskContainer>.create;
end;

procedure TTemplateCacheMod.DataModuleDestroy(Sender: TObject);
var
  t : ITaskContainer;
begin
  for t in m_list do
    t.release;
  m_list.free;
  m_idMap.free;
  m_map.free;
end;

function TTemplateCacheMod.load(teid: integer): ITaskContainer;
begin
  Result := NIL;
  if not m_idmap.ContainsKey(teid) then
  begin
    GetTEQry.ParamByName('TE_ID').AsInteger := teid;
    GetTEQry.Open;

    loadTemplate(GetTEQry);

    GetTEQry.Close;
  end;
  if m_idMap.ContainsKey(teid) then
    Result := m_idMap[teid];
end;

function TTemplateCacheMod.loadTemplate(dataset: TClientDataset): boolean;
var
  st  : TStream;
  tc  : ITaskContainer;
begin
  if not dataset.IsEmpty then
  begin

   st := dataset.CreateBlobStream(dataset.FieldByName('TE_DATA'), bmRead);
   tc := loadTaskContainer(st, dataset.FieldByName('TE_NAME').AsString);

   m_list.Add(tc);
   m_idMap.AddOrSetValue(dataset.FieldByName('TE_ID').AsInteger, tc );
   m_map.AddOrSetValue(dataset.FieldByName('TE_CLID').AsString, tc );
  end;

  Result := Assigned(tc);
end;

function TTemplateCacheMod.SysLoad(clid: string): ITaskContainer;
begin
  Result := NIL;
  if not m_map.ContainsKey(clid) then
  begin
    GetSysTeQry.ParamByName('clid').AsString := clid;
    GetSysTeQry.Open;

    loadTemplate(GetSysTeQry);

    GetSysTeQry.Close;
  end;
  if m_map.ContainsKey(clid) then
    Result := m_map[clid];
end;

end.
