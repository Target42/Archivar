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
    DelPEQry: TIBQuery;
    DelELQry: TIBQuery;
    FrindELQry: TIBQuery;
    Teilnehmer: TIBQuery;
    TNQry: TDataSetProvider;
    SetReadQry: TIBQuery;
    UpdateTnQry: TIBQuery;
    Gaeste: TIBQuery;
    TGQry: TDataSetProvider;
    ChangeELStatusQry: TIBQuery;
    ResetReadQry: TIBQuery;
    ChangeELPEStatusQry: TIBQuery;
  private
    { Private-Deklarationen }
  public
    function AutoInc( gen : string ) : integer;
    function newMeeting(    req : TJSONObject ) : TJSONObject;
    function deleteMeeting( req : TJSONObject ) : TJSONObject;
    function Sendmail(      req : TJSONObject ) : TJSONObject;
    function invite(        req : TJSONObject ) : TJSONObject;

    function GetTree(       req : TJSONObject ) : TJSONObject;

    function changeStatus(  req : TJSONObject ) : TJSONObject ;
  end;

implementation

uses
  m_db, u_json, System.Generics.Collections, u_tree, ServerContainerUnit1, u_teilnehmer,
  Datasnap.DSSession;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsMeeing }

function TdsMeeing.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;

  if AutoIncQry.Transaction.InTransaction then
    AutoIncQry.Transaction.Commit;

end;

function TdsMeeing.changeStatus(req: TJSONObject): TJSONObject;
var
  el_id     : integer;
  pe_id     : integer;
  tn_id     : integer;
  newState  : integer;
  grund     : string;
begin
  Result := TJSONObject.Create;

  el_id     := JInt(    req, 'elid' );
  pe_id     := JInt(    req, 'peid' );
  tn_id     := JInt(    req, 'tnid' );
  newState  := JInt(    req, 'state', -1);
  Grund     := JString( req, 'grund' );

  if newState = -1 then
  begin
    SetReadQry.ParamByName('EL_ID').AsInteger := el_id;
    SetReadQry.ParamByName('PE_ID').AsInteger := pe_id;
    try
      SetReadQry.ExecSQL;
      if SetReadQry.Transaction.InTransaction then
        SetReadQry.Transaction.Commit;
      JResult(Result, true, '');
    except
      on e : exception do
      begin
        JResult( Result, false, e.ToString);
      end;
    end;
  end
  else
  begin
    try
      UpdateTnQry.ParamByName('grund').AsString   := grund;
      UpdateTnQry.ParamByName('status').AsInteger := newState;
      UpdateTnQry.ParamByName('TN_ID').AsInteger  := tn_id;

      UpdateTnQry.ExecSQL;

      ChangeELPEStatusQry.ParamByName('EL_ID').AsInteger  := el_id;
      ChangeELPEStatusQry.ParamByName('PE_ID').AsInteger  := pe_id;
      ChangeELPEStatusQry.ParamByName('status').AsString  := TeilnehmerStatusToString( TTeilnehmerStatus(newState));

      ChangeELPEStatusQry.ExecSQL;

      if UpdateTnQry.Transaction.InTransaction then
        UpdateTnQry.Transaction.Commit;
      JResult(Result, true, '');
    except
      on e : exception do
      begin
        JResult( Result, false, e.ToString);
      end;
    end;
  end;
end;

function TdsMeeing.deleteMeeting(req: TJSONObject): TJSONObject;
var
  id        : integer;
  prid      : integer;
  peid      : integer;
  Session   : TDSSession;
  canDelete : boolean;
  procedure Cancel(text : string );
  begin
    if FrindELQry.Transaction.InTransaction then
      FrindELQry.Transaction.Commit;

    JResult( Result, false, text);
  end;
begin
  Result    := TJSONObject.Create;
  id        := JInt( req, 'id');
  prid      := -1;
  canDelete := false;
  Session   := TDSSessionManager.GetThreadSession;
  peid      := StrToIntDef( Session.GetData('ID'), -1);

  if peid = 0 then
  begin
    Cancel('Der Benutzer kann nicht eindeutig identifiziert werden!');
    exit;
  end;

  FrindELQry.ParamByName('el_id').AsInteger;
  FrindELQry.Open;
  if not FrindELQry.IsEmpty then
  begin
    prid      := FrindELQry.FieldByName('PR_ID').AsInteger;
    canDelete := FrindELQry.FieldByName('PE_ID').AsInteger = peid;
  end;
  FrindELQry.Close;

  if not canDelete then
  begin
    Cancel('Es fehlen die Berechtigungen diese Sitzung zu löschen.');
    exit;
  end;

  if prid = -1 then
  begin
    Cancel('Die Sitzung wurde nicht gefunden!');
    exit;
  end;

  try
    // delete the people from the meeting
    DelPEQry.ParamByName('EL_ID').AsInteger := id;
    DelPEQry.ExecSQL;

    // delete the meeting ifself
    DelELQry.ParamByName('EL_ID').AsInteger := id;
    DelELQry.ExecSQL;

    if DelELQry.Transaction.InTransaction then
      DelELQry.Transaction.Commit;

    JResult( Result, true, 'Die Einladung wurde gelöscht');
  except
    on e : exception do
    begin
      JResult( Result, false, e.ToString);

      if DelELQry.Transaction.InTransaction then
        DelELQry.Transaction.Rollback;
    end;
  end;
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

function TdsMeeing.invite(req: TJSONObject): TJSONObject;
var
  el_id : integer;
  msg   : TJSONObject;
begin
  Result := TJSONObject.Create;
  el_id  := JInt( req, 'id');

  try
    ChangeELStatusQry.ParamByName('status').AsString  := 'O';
    ChangeELStatusQry.ParamByName('el_id').AsInteger  := el_id;
    ChangeELStatusQry.ExecSQL;

    ResetReadQry.ParamByName('el_id').AsInteger       := el_id;
    ResetReadQry.ExecSQL;

    if IBTransaction1.InTransaction then
      IBTransaction1.Commit;
    JResult(Result, true, 'ok');

    msg := TJSONObject.Create;
    JReplace(msg, 'action', 'newmeeting');
    JReplace( msg, 'id', el_id);
    ServerContainer1.BroadcastMessage('storage', msg);

  except
    on e : exception do
    begin
      JResult( Result, false, e.ToString);
    end;
  end;
  if IBTransaction1.InTransaction then
    IBTransaction1.Rollback;



end;

function TdsMeeing.newMeeting(req: TJSONObject): TJSONObject;
var
  grid    : integer;
  id      : integer;
  prid    : integer;
  Session : TDSSession;
  peid    : integeR;
begin

  Result  := TJSONObject.Create;
  grid    := JInt( req, 'grid');
  prid    := JInt( req, 'prid');

  Session := TDSSessionManager.GetThreadSession;
  peid := StrToIntDef( Session.GetData('ID'), -1);
  if peid = 0 then
  begin
    JResponse(Result, false, 'Der Benutzer kann nicht eindeutig identifiziert werden!');
    exit;
  end;

  id    := AutoInc('gen_el_id');
  try
    ElTable.Open;
    ElTable.Append;
    ElTable.FieldByName('EL_ID').AsInteger      := id;
    ElTable.FieldByName('GR_ID').AsInteger      := grid;
    ElTable.FieldByName('EL_TITEL').AsString    :='Sitzungeinladung';
    ElTable.FieldByName('EL_DATUM').AsDateTime  := Date + 3;
    ElTable.FieldByName('EL_ZEIT').AsDateTime   := EncodeTime(  9, 0, 0, 0);
    ElTable.FieldByName('EL_ENDE').AsDateTime   := EncodeTime( 12, 0, 0, 0);
    ElTable.FieldByName('EL_STATUS').AsString   := 'O';
    ElTable.FieldByName('PR_ID').AsInteger      := prid;
    ElTable.FieldByName('PE_ID').AsInteger      := peid;
    ElTable.Post;

    ELPETab.Open;

    GrPeQry.ParamByName('PR_ID').AsInteger := prid;
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
    JResult( Result, true, 'Eine neue Sitzung wurde angelegt.');

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
  Result := TJSONObject.Create;
  JResult( Result, true, '');
end;

end.

