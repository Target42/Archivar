unit ds_meeting;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB,
  System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet ,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  [TRoleAuth('user,admin', 'download')]
  TdsMeeing = class(TDSServerModule)
    ListProtocolQry: TDataSetProvider;
    PRTab: TDataSetProvider;
    ElTab: TDataSetProvider;
    TNQry: TDataSetProvider;
    TGQry: TDataSetProvider;
    OptTnQry: TDataSetProvider;
    IBTransaction1: TFDTransaction;
    DeleteTN: TFDQuery;
    AddTN: TFDQuery;
    ProtoQry: TFDQuery;
    CPTab: TFDQuery;
    CTTab: TFDQuery;
    LastDocQry: TFDQuery;
    FrindELQry: TFDQuery;
    SetReadQry: TFDQuery;
    UpdateTnQry: TFDQuery;
    ResetReadQry: TFDQuery;
    ChangeELPEStatusQry: TFDQuery;
    PRTable: TFDTable;
    ElTable: TFDTable;
    AutoIncQry: TFDQuery;
    ListProtocol: TFDQuery;
    Teilnehmer: TFDQuery;
    Gaeste: TFDQuery;
    OptTn: TFDQuery;
    DelELQry: TFDQuery;
    Protokoll: TFDQuery;
    ProtokollQry: TDataSetProvider;
    InsertTNQry: TFDQuery;
  private
    procedure updateMeeting( el_id : integer );
  public
    function AutoInc( gen : string ) : integer;
    function newMeeting(    req : TJSONObject ) : TJSONObject;
    function deleteMeeting( req : TJSONObject ) : TJSONObject;
    function Sendmail(      req : TJSONObject ) : TJSONObject;
    function invite(        req : TJSONObject ) : TJSONObject;

    function GetTree(       req : TJSONObject ) : TJSONObject;

    function changeStatus(  req : TJSONObject ) : TJSONObject ;

    function changeUser(    req : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  u_json, System.Generics.Collections, u_tree, ServerContainerUnit1,
  Datasnap.DSSession, u_Konst;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsMeeing }

function TdsMeeing.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;

  if AutoIncQry.Transaction.Active then
    AutoIncQry.Transaction.Commit;

end;

function TdsMeeing.changeStatus(req: TJSONObject): TJSONObject;
var
  pr_id     : integer;
  pe_id     : integer;
  tn_id     : integer;
  newState  : integer;
  grund     : string;
begin
  Result := TJSONObject.Create;

  pr_id     := JInt(    req, 'prid' );
  pe_id     := JInt(    req, 'peid' );
  tn_id     := JInt(    req, 'tnid' );
  newState  := JInt(    req, 'state', -1);
  Grund     := JString( req, 'grund' );

  if newState = -1 then
  begin
    SetReadQry.ParamByName('PR_ID').AsInteger := pr_id;
    SetReadQry.ParamByName('PE_ID').AsInteger := pe_id;
    try
      SetReadQry.ExecSQL;

      if SetReadQry.Transaction.Active then
        SetReadQry.Transaction.Commit;
      JResult(Result, true, '');
    except
      on e : exception do
      begin
        JResult( Result, false, e.ToString);

        if SetReadQry.Transaction.Active then
          SetReadQry.Transaction.Rollback;
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

      if UpdateTnQry.Transaction.Active then
        UpdateTnQry.Transaction.Commit;
      JResult(Result, true, '');
    except
      on e : exception do
      begin
        JResult( Result, false, e.ToString);
        if UpdateTnQry.Transaction.Active then
          UpdateTnQry.Transaction.Rollback;
      end;
    end;
  end;
end;

function TdsMeeing.changeUser(req: TJSONObject): TJSONObject;
var
  cmd   : string;
  sql   : string;
  prid  : integer;
  list  : TList<integer>;

  procedure addUser;
  var
    id    : integer;
  begin
    sql :=  'insert into TN_TEILNEHMER '+
            '( PR_ID, TN_ID, TN_NAME, TN_VORNAME, TN_DEPARTMENT, TN_STATUS, PE_ID) '+
            'select ''%d'' as "pr_id", gen_id( GEN_TN_ID, 1), PE_NAME, PE_VORNAME, PE_DEPARTMENT, ''0'' as "tn_status", pe_id '+
            'from PE_PERSON '+
            'where pe_id = :pe_id';

    AddTN.SQL.Text := Format(sql, [prid]);

    AddTN.Prepare;
    try
    if AddTN.Prepared then
    begin
      for id in list do
      begin
        AddTN.ParamByName('pe_id').AsInteger  := id;
        AddTN.ExecSQL;
      end;
    end;
    except

    end;
    AddTN.UnPrepare;
  end;
  procedure removeUser;
  var
    id    : integer;
  begin
    DeleteTN.Prepare;
    try
      if DeleteTN.Prepared then
      begin
        for id in list do
        begin
          DeleteTN.ParamByName('TN_id').AsInteger := id;
          DeleteTN.ExecSQL;
        end;
      end;
    except

    end;
    DeleteTN.UnPrepare;
  end;

begin
  Result  := TJSONObject.Create;
  cmd     := JString(       req, 'cmd');
  prid    := JInt(          req, 'prid');
  list    := getIntNumbers( req, 'idlist');

  JResult(Result, false, 'Keine Personen angegeben!');
  if not Assigned(list) then
    exit;

  if cmd = 'add' then
    addUser
  else if cmd = 'remove' then
    removeUser;

  if Assigned(list) then
    list.Free;

  if IBTransaction1.Active then
    IBTransaction1.Commit;

  JResult( Result, true, 'ok');
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
    if FrindELQry.Transaction.Active then
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
    // delete the meeting ifself
    DelELQry.ParamByName('EL_ID').AsInteger := id;
    DelELQry.ExecSQL;

    if DelELQry.Transaction.Active then
      DelELQry.Transaction.Commit;

    JResult( Result, true, 'Die Einladung wurde gelöscht');
  except
    on e : exception do
    begin
      JResult( Result, false, e.ToString);

      if DelELQry.Transaction.Active then
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
  if ProtoQry.Transaction.Active then
    ProtoQry.Transaction.Commit;
end;

function TdsMeeing.invite(req: TJSONObject): TJSONObject;
var
  el_id : integer;
begin
  Result := TJSONObject.Create;
  el_id  := JInt( req, 'id');

  try
    ResetReadQry.ParamByName('el_id').AsInteger       := el_id;
    ResetReadQry.ExecSQL;

    if IBTransaction1.Active then
      IBTransaction1.Commit;
    JResult(Result, true, 'ok');

    updateMeeting( el_id );
  except
    on e : exception do
    begin
      JResult( Result, false, e.ToString);
    end;
  end;
  if IBTransaction1.Active then
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

    // und die Mitglieder des Gremium's
    InsertTNQry.SQL.Text := Format(
    'insert into TN_TEILNEHMER '+
    '(PR_ID, TN_ID, TN_NAME, TN_VORNAME, TN_DEPARTMENT, TN_ROLLE, TN_STATUS, PE_ID) '+
    'select ''%d'' as PR_ID, gen_id( GEN_TN_ID, 1) as TN_ID, b.PE_NAME, b.PE_VORNAME, b.PE_DEPARTMENT, a.GP_ROLLE, ''%d'' as TN_STATUS, b.PE_ID '+
    'from GR_PA a, PE_PERSON b '+
    'where a.GR_ID = 2 '+
    'and a.PE_ID = b.PE_ID', [prid, 0]);

    InsertTNQry.ExecSQL;


    JReplace( Result, 'id', id);
    JResult( Result, true, 'Eine neue Sitzung wurde angelegt.');

    if ElTable.Transaction.Active then
      ElTable.Transaction.Commit;
  except
    on e : exception do
    begin
      JReplace( Result, 'id', -1);
      JResult( Result, false, e.ToString);
      if ElTable.Transaction.Active then
        ElTable.Transaction.Rollback;
    end;
  end;

end;

function TdsMeeing.Sendmail(req: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  try
    ResetReadQry.ParamByName('PR_ID').AsInteger := JInt( req, 'prid');
    ResetReadQry.ExecSQL;

    JResult( Result, true, IntToStr( ResetReadQry.RowsAffected));

    if ResetReadQry.Transaction.Active then
      ResetReadQry.Transaction.Commit;

    updateMeeting(JInt(req, 'elid'));
  except
    on e : exception do
    begin
      JResult( Result, false, e.ToString);
      if ResetReadQry.Transaction.Active then
        ResetReadQry.Transaction.Rollback;

    end;
  end;
end;

procedure TdsMeeing.updateMeeting(el_id: integer);
var
  msg : TJSONObject;
begin
  msg := TJSONObject.Create;
  JAction(  msg, BRD_MEETING_NEW);
  JReplace( msg, 'id', el_id);
  ArchivService.BroadcastMessage(BRD_CHANNEL, msg);
end;

end.

