unit ds_meeting;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB, IBX.IBCustomDataSet, IBX.IBQuery, IBX.IBDatabase, IBX.IBTable,
  System.JSON;

type
  TdsMeeing = class(TDSServerModule)
    IBTransaction1: TIBTransaction;
    ListProtocol: TIBQuery;
    ListProtocolQry: TDataSetProvider;
    PRTable: TIBTable;
    PRTab: TDataSetProvider;
    ElTable: TIBTable;
    ElTab: TDataSetProvider;
    ProtoQry: TIBQuery;
    CPTab: TIBQuery;
    CTTab: TIBQuery;
    ELPETab: TIBTable;
    GrPeQry: TIBQuery;
    AutoIncQry: TIBQuery;
    LastDocQry: TIBQuery;
  private
    { Private-Deklarationen }
  public
    function AutoInc( gen : string ) : integer;
    function newMeeting(    req : TJSONObject ) : TJSONObject;
    function deleteMeeting( req : TJSONObject ) : TJSONObject;
    function Sendmail(      req : TJSONObject ) : TJSONObject;

    function GetTree(       req : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  m_db, u_json, System.Generics.Collections, u_tree;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsMeeing }

function TdsMeeing.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;
end;

function TdsMeeing.deleteMeeting(req: TJSONObject): TJSONObject;
begin
  Result := NIL;
end;

function TdsMeeing.GetTree(req: TJSONObject): TJSONObject;
var
  prid  :  integer;
  obj   :  TJSONObject;
  list  : TList<TNode>;

  procedure addToParent( node : TNode );
  var
    i : integer;
  begin
    if node.pid = -1 then
      exit;

    for i := 0 to pred(list.Count) do
    begin
      if list[i].id = node.pid then
      begin
        list[i].Childs.Add(node);
        break;
      end;
    end;
  end;

  procedure addChilds;
  var
    i   : integer;
  begin
    for i := 0 to pred(list.Count) do
      begin
        addToParent(list[i]);
      end;
  end;

  function addItems : TJSONObject;
  var
    node : TNode;
  begin
    list  := TList<TNode>.create;
    node := TNode.Create;
    node.PID  := -1;
    node.ID   := 0;
    list.Add( node);

    CTTab.Open;
    while not CTTab.Eof do
    begin
      node        := TNode.Create;
      node.ID     := CTTab.FieldByName('CT_ID').AsInteger;
      node.PID    := CTTab.FieldByName('CT_PARENT').AsInteger;
      node.Title  := CTTab.FieldByName('CT_TITLE').AsString;
      node.Nr     := CTTab.FieldByName('CT_NUMBER').AsInteger;
      node.pos    := CTTab.FieldByName('CT_POS').AsInteger;
      node.Date   := CTTab.FieldByName('CT_CREATED').AsDateTime;

      list.Add(node);

      CTTab.Next;
    end;
    CTTab.Close;

    addChilds;

    Result := list[0].toJson;

    list.Free;
  end;

  function AddTitle : TJSONArray;
  begin
    Result := TJSONArray.Create;

    CPTab.Open;
    while not CPTab.Eof do
    begin
      CTTab.ParamByName('cp_id').AsInteger := CPTab.FieldByName('CP_ID').AsInteger;
      obj := TJSONObject.Create;

      JReplace( obj, 'title',  CPTab.FieldByName('CP_TITLE').AsString);
      JReplace( obj, 'nr',     CPTab.FieldByName('CP_NR').AsInteger );
      JReplace( obj, 'date',   FormatDateTime('dd.mm.yyyy hh:nn:ss', CPTab.FieldByName('CP_CREATED').AsDateTime));
      JReplace( obj, 'childs', addItems);

      Result.AddElement(obj);
      CPTab.Next;
    end;
    CPTab.Close;
  end;

begin
  Result  := TJSONObject.Create;
  prid    := JInt( Req, 'prid');

  ProtoQry.ParamByName('pr_id').AsInteger := prid;
  ProtoQry.Open;
  if not ProtoQry.IsEmpty then
  begin
    CPTab.ParamByName('PR_ID').AsInteger := prid;

    JReplace( Result, 'name', ProtoQry.FieldByName('pr_name').AsString);
    JReplace( Result, 'titles', AddTitle);
    JResult(  Result, true, '');
  end
  else
    JResult( Result, false, 'Das Protokoll wurde nicht gefunden!');
  ProtoQry.Close;
end;

function TdsMeeing.newMeeting(req: TJSONObject): TJSONObject;
var
  grid : integer;
  id   : integer;
begin
  Result  := TJSONObject.Create;
  grid    := JInt( req, 'grid');
  id      := AutoInc('gen_el_id');

  try
  ElTable.Open;
  ElTable.Append;
  ElTable.FieldByName('EL_ID').AsInteger      := id;
  ElTable.FieldByName('GR_ID').AsInteger      := grid;
  ElTable.FieldByName('EL_TITEL').AsString    :='Sitzungeinladung';
  ElTable.FieldByName('EL_DATUM').AsDateTime  := Date + 3;
  ElTable.FieldByName('EL_ZEIT').AsDateTime   := EncodeTime(  9, 0, 0, 0);
  ElTable.FieldByName('EL_ENDE').AsDateTime   := EncodeTime( 12, 0, 0, 0);

  LastDocQry.ParamByName('gr_id').AsInteger   := grid;
  LastDocQry.Open;
  if not LastDocQry.IsEmpty then
  begin
    ElTable.FieldByName('PR_ID').AsInteger := LastDocQry.FieldByName('PR_ID').AsInteger;
  end;
  LastDocQry.Close;
  ElTable.Post;

  ELPETab.Open;
  GrPeQry.ParamByName('GR_ID').AsInteger := grid;
  GrPeQry.Open;
  while not GrPeQry.Eof do
  begin
    ELPETab.Append;
    ELPETab.FieldByName('EL_ID').AsInteger := id;
    ELPETab.FieldByName('PE_ID').AsInteger := GrPeQry.FieldByName('PE_ID').AsInteger;
    ELPETab.Post;
    GrPeQry.Next;
  end;
  GrPeQry.Close;
  ELPETab.Close;

  JReplace( Result, 'id', id);
  JResult( Result, true, 'Eine neue sitzung wurde angelegt.');

  if ElTable.Transaction.InTransaction then
    ElTable.Transaction.Commit;
  except
    on e : exception do
    begin
      JReplace( Result, 'id', -1);
      JResult( Result, false, e.ToString);
      if ElTable.Transaction.InTransaction then
        ElTable.Transaction.Rollback;
    end;
  end;
end;

function TdsMeeing.Sendmail(req: TJSONObject): TJSONObject;
begin
  Result := NIL;
end;

end.

