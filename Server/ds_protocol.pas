unit ds_protocol;

interface

uses
  System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, System.JSON,
  Data.DB,
  Datasnap.Provider, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  [TRoleAuth('user,admin', 'download')]
  TdsProtocol = class(TDSServerModule)
    PRTable: TDataSetProvider;
    TGTable: TDataSetProvider;
    ListPrQry: TDataSetProvider;
    AutoIncValue: TDataSetProvider;
    ChapterTab: TDataSetProvider;
    UpdateCPQry: TDataSetProvider;
    ListTasks: TDataSetProvider;
    CPTextTab: TDataSetProvider;
    BETab: TDataSetProvider;
    DeleteTrans: TFDTransaction;
    deleteTNQry: TFDQuery;
    deleteTGQry: TFDQuery;
    deletePR: TFDQuery;
    DeleteChapter: TFDQuery;
    SelectChapterQry: TFDQuery;
    SelectChapterTextQry: TFDQuery;
    deleteBEQry: TFDQuery;
    deleteCT: TFDQuery;
    BE: TFDTable;
    PRTab: TFDTable;
    TGTab: TFDTable;
    CPTab: TFDTable;
    IBTransaction1: TFDTransaction;
    CPText: TFDTable;
    ListPr: TFDQuery;
    incQry: TFDQuery;
    AutoIncQry: TFDQuery;
    PEQry: TFDQuery;
    UpdateCP: TFDQuery;
    DeleteCPQry: TFDQuery;
    ListTasksQry: TFDQuery;
    TNTab: TFDTable;
    NextNrQry: TFDQuery;
  private
    { Private-Deklarationen }
  public
    function AutoInc( gen : string ) : integer;
    function newProtocol( data : TJSONObject) : TJSONObject;
    function deleteProtocol( data : TJSONObject) : TJSONObject;
    function deleteCP( id : integer ) : TJSONObject;
  end;

implementation

uses
  Grijjy.CloudLogging, u_json, System.SysUtils, System.Win.ComObj;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdsProtocol }

function TdsProtocol.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;

end;

function TdsProtocol.deleteCP(id: integer): TJSONObject;
begin
  Result := TJSONObject.create;
  if DeleteTrans.Active then
    DeleteTrans.Rollback;
  DeleteTrans.StartTransaction;
  try
    DeleteCPQry.ParamByName('CP_ID').Asinteger := id;
    DeleteCPQry.ExecSQL;
    DeleteTrans.commit;
    JResult(Result, true, 'Das Kapitel wurde gelöscht');
  except
    on e : exception do
    begin
      GrijjyLog.Send('delete cp', e.ToString, TgoLogLevel.Error);
      DeleteTrans.Rollback;
      JResult(Result, false, e.toString);
    end;
  end;
end;

function TdsProtocol.deleteProtocol(data: TJSONObject): TJSONObject;
var
  id  : integer;
  ct  : integer;
begin
  Result := TJSONObject.create;
  id := JInt( data, 'id', -1);
  if id = -1 then
  begin
    JResult( Result, false, 'Es ist kein gültiges Protokoll');
    exit;
  end;
  DeleteTrans.StartTransaction;
  try
    // teilnehmer
    deleteTNQry.ParamByName('PR_ID').AsInteger := id;
    deleteTNQry.ExecSQL;

    // gäste ...
    deleteTGQry.ParamByName('PR_ID').AsInteger := id;
    deleteTGQry.ExecSQL;

    // schleife über alle Chapter ..
    SelectChapterQry.ParamByName('PR_ID').AsInteger := id;
    SelectChapterQry.Open;
    while not SelectChapterQry.Eof do
    begin
      SelectChapterTextQry.ParamByName('CP_ID').AsInteger := SelectChapterQry.FieldByName('CP_ID').AsInteger;
      SelectChapterTextQry.Open;
      while not SelectChapterTextQry.Eof do
      begin

        // beschlüsse
        ct := SelectChapterTextQry.FieldByName('CT_ID').AsInteger;
        if ct <> 0 then
        begin
          deleteBEQry.ParamByName('CT_ID').AsInteger := ct;
          deleteBEQry.ExecSQL;
        end;
        // chapter content
        deleteCT.ParamByName('CP_ID').AsInteger := SelectChapterTextQry.FieldByName('CP_ID').AsInteger;
        deleteCT.ExecSQL;

        SelectChapterTextQry.Next;
      end;
      SelectChapterTextQry.Close;
      SelectChapterQry.Next;
    end;
    SelectChapterQry.close;

    // chapter
    DeleteChapter.ParamByName('PR_ID').AsInteger := id;
    DeleteChapter.ExecSQL;

    // das protokoll
    deletePR.ParamByName('PR_ID').AsInteger := id;
    deletePR.ExecSQL;

    JResult( Result, true, 'Es wurde gelöscht.');
    DeleteTrans.commit;
  except
    on e : exception do
    begin
      JResult( Result, false, 'Es ist ein Fehler beim Löschen aufgetreten. ' + e.toString);
      DeleteTrans.rollBack;
    end;
  end;

end;

function TdsProtocol.newProtocol(data: TJSONObject): TJSONObject;
var
  id : integer;
  obj: TJSONObject;

  procedure addKapitel( cp_id : integer; kapitel : TJSONArray );
  var
    i : integer;
    row : TJSONObject;
  begin
    if not Assigned(kapitel) then exit;

    for i := 0 to pred(kapitel.Count) do begin
      row := getRow(kapitel, i);

      CPText.Append;
      CPText.FieldByName('cp_id').AsInteger       := cp_id;
      CPText.FieldByName('ct_id').AsInteger       := AutoInc('gen_ct_id');
      CPText.FieldByName('ct_parent').AsInteger   := 0;
      CPText.FieldByName('CT_TITLE').AsString     := JString( row, 'titel');
      CPText.FieldByName('ct_pos').AsInteger      := i + 1;
      CPText.FieldByName('ct_number').AsInteger   := i + 1;
      CPText.FieldByName('ct_created').AsDateTime := now;
      CPText.Post;
    end;
  end;

  procedure AddTemplate;
  var
    i : integer;
    arr : TJSONArray;
    row : TJSONObject;
    cp_id  : integer;
  begin
    arr := JArray(obj, 'chapter');
    if not Assigned(arr) then  exit;

    for i := 0 to pred(arr.Count) do begin
      row := getRow(arr, i);
      cp_id := AutoInc('gen_cp_id');
      CPTab.Append;
      CPTab.FieldByName('pr_id').AsInteger        := id;
      CPTab.FieldByName('cp_id').AsInteger        := cp_id;
      CPTab.FieldByName('cp_title').AsString      := JString( row, 'titel' );
      CPTab.FieldByName('cp_nr').AsInteger        := i + 1;
      CPTab.FieldByName('cp_created').AsDateTime  := now;
      CPTab.post;

      addKapitel(cp_id, JArray( row, 'kapitel'));
    end;

  end;
var
  nr : integer;
begin
  Result := TJSONObject.create;

  if IBTransaction1.Active then
    IBTransaction1.Rollback;

  IBTransaction1.StartTransaction;
  try
    id := AutoInc('gen_pr_id');
    JReplace( Result, 'id', id);

    NextNrQry.ParamByName('GR_ID').AsInteger := JInt( data, 'grid' );
    NextNrQry.Open;
    nr := NextNrQry.FieldByName('max').AsInteger + 1;
    NextNrQry.Close;


    PRTab.Open;
    PRTab.Append;
    PRTab.FieldByName('PR_ID').AsInteger     := id;
    PRTab.FieldByName('GR_ID').AsInteger     := JInt( data, 'grid' );
    PRTab.FieldByName('PR_DATUM').AsDateTime := now + 7;
    PRTab.FieldByName('PR_NAME').AsString    := JString( data, 'short')+'_'+FormatDateTime('yyyyMMdd', now);
    PRTab.FieldByName('PR_CLID').AsString    := createClassID;
    PRTab.FieldByName('PR_STATUS').AsString  := 'E';
    PRTab.FieldByName('PR_NR').AsInteger     := nr;
    PRTab.post;


    PEQry.ParamByName('GR_ID').AsInteger := JInt( data, 'grid' );
    PEQry.Open;
    TNTab.Open;
    while not PEQry.eof do
    begin
      TNTab.Append;
      TNTab.FieldByName('PR_ID').AsInteger        := id;
      TNTab.FieldByName('TN_ID').AsInteger        := AutoInc('gen_TN_ID');
      TNTab.FieldByName('PE_ID').AsInteger        := PEQry.FieldByName('PE_ID').AsInteger;
      TNTab.FieldByName('TN_NAME').AsString       := PEQry.FieldByName('PE_NAME').AsString;
      TNTab.FieldByName('TN_VORNAME').AsString    := PEQry.FieldByName('PE_VORNAME').AsString;
      TNTab.FieldByName('TN_DEPARTMENT').AsString := PEQry.FieldByName('PE_DEPARTMENT').AsString;
      TNTab.FieldByName('TN_ROLLE').AsString      := PEQry.FieldByName('GP_ROLLE').AsString;
      TNTab.FieldByName('TN_STATUS').AsString     := '0';
      TNTab.Post;
      PEQry.next;
    end;

    PRTab.close;
    PEQry.close;
    TNTab.Close;

    obj := JObject( data, 'template');
    if Assigned( obj ) then begin
      CPTab.Open;
      CPText.Open;

      AddTemplate;

      CPTab.close;
      CPText.close;
    end;

    if IBTransaction1.Active then
      IBTransaction1.commit;



    JResult( Result, true, 'Das Protokoll wurde erfolgreich angelegt.');
    GrijjyLog.Send('new protocol', id);
  except
    on e : exception do
    begin
      GrijjyLog.Send('new protocol', e.ToString, TgoLogLevel.Error);
      IBTransaction1.RollBack;
      JResult( Result, false, 'Fehler bei dem Anlegen des Protokolls');
    end;
  end;
end;

end.

