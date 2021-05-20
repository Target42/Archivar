unit ds_sitzung;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, IBX.IBDatabase,
  Datasnap.Provider, Data.DB, IBX.IBCustomDataSet, IBX.IBTable, System.JSON,
  IBX.IBQuery, u_teilnehmer;

type
  TdsSitzung = class(TDSServerModule)
    IBTransaction1: TIBTransaction;
    ELTab: TIBTable;
    ELSrc: TDataSetProvider;
    TNQry: TIBQuery;
    TNSrc: TDataSetProvider;
  private
  public
    function enter( obj : TJSONobject ) : TJSONObject;
    function leave( obj : TJSONobject ) : TJSONObject;

    function startVote( obj : TJSONobject ) : TJSONObject;
    function Vote( obj : TJSONobject ) : TJSONObject;
    function endVote( obj : TJSONobject ) : TJSONObject;
  end;

implementation

uses
  m_glob_server, m_db, Datasnap.DSSession, ServerContainerUnit1, u_json, m_hell;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsSitzung }


{ TdsSitzung }

function TdsSitzung.endVote(obj: TJSONobject): TJSONObject;
begin
  Result := NIL;
end;

function TdsSitzung.enter(obj: TJSONobject): TJSONObject;
var
  el_id, pe_id  : integer;
  Session       : TDSSession;
begin
  Result  := TJSONObject.Create;
  Session := TDSSessionManager.GetThreadSession;
  el_id   := JInt( obj, 'id');
  pe_id   := StrToInt(Session.GetData('id'));

  if HellMod.enter(el_id, pe_id, Session.Id) then
    JResult( Result, true, '')
  else
    JResult( Result, false, 'Es gibt die Sitzung nicht oder sie sind kein Teilnehmer');
end;

function TdsSitzung.leave(obj: TJSONobject): TJSONObject;
var
  el_id, pe_id  : integer;
  Session       : TDSSession;
begin
  Result  := TJSONObject.Create;
  Session := TDSSessionManager.GetThreadSession;
  el_id   := JInt( obj, 'id');
  pe_id   := StrToInt(Session.GetData('id'));

  if HellMod.leave(el_id, pe_id) then
    JResult( Result, true, '')
  else
    JResult( Result, false, 'Es gibt die Sitzung nicht oder sie sind kein Teilnehmer');
end;


function TdsSitzung.startVote(obj: TJSONobject): TJSONObject;
begin
  Result := NIL;
end;

function TdsSitzung.Vote(obj: TJSONobject): TJSONObject;
begin
  Result := NIL;
end;

end.

