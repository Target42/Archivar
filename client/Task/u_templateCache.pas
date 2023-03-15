unit u_templateCache;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, System.Generics.Collections, m_glob_client, i_taskEdit,
  u_template;

type
  TTemplateCacheMod = class(TDataModule)
    DSProviderConnection1: TDSProviderConnection;
    GetTEQry: TClientDataSet;
    GetSysTeQry: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_list      : Tlist<TTemplate>;
    m_idMap     : TDictionary<integer, TTemplate>;
    m_map       : TDictionary<string,  TTemplate>;

    procedure loadTemplate( teid : integer );
    function loadTemplateData(dataset: TClientDataset) : boolean;

    function createTC( te : TTemplate ):ITaskContainer;
  public
    { Public-Deklarationen }

    function load( teid : integer )   : ITaskContainer;
    function Template( teid : integer ) : TTemplate;
    function SysLoad( clid : string ) : ITaskContainer;

    procedure setDirty( clid : string );

  end;

var
  TemplateCacheMod: TTemplateCacheMod;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TTemplateCacheMod.createTC(te: TTemplate): ITaskContainer;
var
  st : TStream;
begin
  Result := NIL;
  if not Assigned(te) then
    exit;

  st := TMemoryStream.Create;
  te.st.Position := 0;
  st.CopyFrom( te.st, -1);
  st.Position := 0;

  Result := loadTaskContainer(st, te.Name);
end;

procedure TTemplateCacheMod.DataModuleCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_list      := Tlist<TTemplate>.create;
  m_idMap     := TDictionary<integer, TTemplate>.create;
  m_map       := TDictionary<string, TTemplate>.create;
end;

procedure TTemplateCacheMod.DataModuleDestroy(Sender: TObject);
var
  t : TTemplate;
begin
  for t in m_list do
    t.free;

  m_list.free;
  m_idMap.free;
  m_map.free;
end;

function TTemplateCacheMod.load(teid: integer): ITaskContainer;
begin
  Result := NIL;
  if not m_idmap.ContainsKey(teid) then
  begin
    loadTemplate(teid);
  end;
  if m_idMap.ContainsKey(teid) then
  begin
    Result := createTC(m_idMap[teid]);
  end;

end;

procedure TTemplateCacheMod.loadTemplate(teid: integer);
begin
  GetTEQry.ParamByName('TE_ID').AsInteger := teid;
  GetTEQry.Open;

  loadTemplateData(GetTEQry);

  GetTEQry.Close;
end;

function TTemplateCacheMod.loadTemplateData(dataset: TClientDataset): boolean;
var
  te  : TTemplate;
  st  : TStream;
begin
  te := NIL;

  if not dataset.IsEmpty then
  begin
    te      := TTemplate.create;
    te.ID   := dataset.FieldByName('TE_ID').AsInteger;
    te.TYID := dataset.FieldByName('TY_ID').AsInteger;
    te.CLID := dataset.FieldByName('TE_CLID').AsString;
    te.Name := dataset.FieldByName('TE_NAME').AsString;

    st      := dataset.CreateBlobStream(dataset.FieldByName('TE_DATA'), bmRead);
    te.st.CopyFrom( st, -1);
    st.Free;

     m_list.Add(te);
     m_idMap.AddOrSetValue(te.ID, te );
     m_map.AddOrSetValue(te.CLID, te );
  end;

  Result := Assigned(te);
end;

procedure TTemplateCacheMod.setDirty(clid: string);
var
  te : TTemplate;
begin
  for te in m_list do
  begin
    if te.clid = clid then
    begin
      m_list.Remove(te);
      m_idMap.Remove(te.ID);
      m_map.Remove(te.clid);

      break;
    end;
  end;
end;

function TTemplateCacheMod.SysLoad(clid: string): ITaskContainer;
begin
  Result := NIL;
  if not m_map.ContainsKey(clid) then
  begin
    GetSysTeQry.ParamByName('clid').AsString := clid;
    GetSysTeQry.Open;

    loadTemplateData(GetSysTeQry);

    GetSysTeQry.Close;
  end;
  if m_map.ContainsKey(clid) then
    Result := createTC(m_map[clid]);
end;

function TTemplateCacheMod.Template(teid: integer): TTemplate;
begin
  Result := NIL;

  if not m_idMap.ContainsKey(teid) then
    loadTemplate(teid);

  m_idMap.TryGetValue(teid, Result);
end;


end.
