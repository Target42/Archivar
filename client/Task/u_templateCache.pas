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
    type
      Template = class
        private
          FCLID : string;
          FID   : integer;
          FNAME : string;
          m_st  : TMemoryStream;

          function Getst: TStream;
        public
          constructor create;
          Destructor Destroy; override;

          property Name : string read FNAME write FNAME;
          property CLID: string read FCLID write FCLID;
          property ID: integer read FID write FID;
          property st: TStream read Getst;
      end;
  private
    m_list      : Tlist<Template>;
    m_idMap     : TDictionary<integer, Template>;
    m_map       : TDictionary<string,  Template>;

    function loadTemplate(dataset: TClientDataset) : boolean;

    function createTC( te : Template ):ITaskContainer;
  public
    { Public-Deklarationen }
    function load( teid : integer )   : ITaskContainer;
    function SysLoad( clid : string ) : ITaskContainer;

    procedure setDirty( clid : string );

  end;

var
  TemplateCacheMod: TTemplateCacheMod;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TTemplateCacheMod.createTC(te: Template): ITaskContainer;
var
  st : TStream;
begin
  Result := NIL;
  if not Assigned(te) then
    exit;

  st := TMemoryStream.Create;
  te.m_st.Position := 0;
  st.CopyFrom( te.st, -1);
  st.Position := 0;

  Result := loadTaskContainer(st, te.Name);
end;

procedure TTemplateCacheMod.DataModuleCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_list      := Tlist<Template>.create;
  m_idMap     := TDictionary<integer, Template>.create;
  m_map       := TDictionary<string, Template>.create;
end;

procedure TTemplateCacheMod.DataModuleDestroy(Sender: TObject);
var
  t : Template;
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
    GetTEQry.ParamByName('TE_ID').AsInteger := teid;
    GetTEQry.Open;

    loadTemplate(GetTEQry);

    GetTEQry.Close;
  end;
  if m_idMap.ContainsKey(teid) then
  begin
    Result := createTC(m_idMap[teid]);
  end;

end;

function TTemplateCacheMod.loadTemplate(dataset: TClientDataset): boolean;
var
  te  : Template;
  st  : TStream;
begin
  te := NIL;

  if not dataset.IsEmpty then
  begin
    te      := Template.create;
    te.ID   := dataset.FieldByName('TE_ID').AsInteger;
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
  te : Template;
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

    loadTemplate(GetSysTeQry);

    GetSysTeQry.Close;
  end;
  if m_map.ContainsKey(clid) then
    Result := createTC(m_map[clid]);
end;

{ TTemplateCacheMod.Template }

constructor TTemplateCacheMod.Template.create;
begin
  m_st  := TMemoryStream.Create;
end;

destructor TTemplateCacheMod.Template.Destroy;
begin
  m_st.Free;
  inherited;
end;

function TTemplateCacheMod.Template.Getst: TStream;
begin
  Result := m_st;
end;


end.
