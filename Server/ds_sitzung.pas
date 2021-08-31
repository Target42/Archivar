unit ds_sitzung;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  Datasnap.Provider, Data.DB, System.JSON,
  u_teilnehmer, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;

type
  [TRoleAuth('user,admin', 'download')]
  TdsSitzung = class(TDSServerModule)
    ELSrc: TDataSetProvider;
    TNSrc: TDataSetProvider;
    IBTransaction1: TFDTransaction;
    TNQry: TFDQuery;
    ELTab: TFDTable;
  private
  public
    // enter & leave the meeting
    function enter( obj : TJSONobject ) : TJSONObject;
    function leave( obj : TJSONobject ) : TJSONObject;

    // change user status
    function changeState( obj : TJSONobject ) : TJSONObject;

    // vote
    function startVote( obj : TJSONobject ) : TJSONObject;
    function Vote( obj : TJSONobject ) : TJSONObject;
    function endVote( obj : TJSONobject ) : TJSONObject;

    // meeting lead ...
    function requestLead( obj : TJSONObject ) : TJSONObject;
    function changeLead( obj : TJSONObject ) : TJSONObject;

    procedure updateDocument( obj : TJSONObject );

  end;

implementation

uses
  m_glob_server, m_db, Datasnap.DSSession, ServerContainerUnit1, u_json, m_hell,
  Grijjy.CloudLogging, u_Konst;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsSitzung }

function TdsSitzung.changeLead(obj: TJSONObject): TJSONObject;
begin
  Result := HellMod.changeLead( obj );
end;

function TdsSitzung.changeState(obj: TJSONobject): TJSONObject;
begin
  Result := HellMod.changeStatus( obj );
end;

function TdsSitzung.endVote(obj: TJSONobject): TJSONObject;
begin
  Result := HellMod.endVote(obj);
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

  if HellMod.enter(el_id, pe_id, Session.Id, Result) then begin
    JResult( Result, true, '');
  end
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

function TdsSitzung.requestLead(obj: TJSONObject): TJSONObject;
begin
  Result := HellMod.requestLead( obj );
end;

function TdsSitzung.startVote(obj: TJSONobject): TJSONObject;
begin
  Result := HellMod.startVote(obj);
end;

procedure TdsSitzung.updateDocument(obj: TJSONObject);
var
  msg : TJSONObject;
begin
  GrijjyLog.EnterMethod(self, 'updateDocument');

  GrijjyLog.Send('data in', obj.ToJSON);
  msg := obj.Clone as TJSONObject;

  JAction( msg, BRD_DOC_UPDATE);
  GrijjyLog.Send('data out', msg.ToJSON);

  ServerContainer1.BroadcastMessage(BRD_CHANNEL, msg);

  GrijjyLog.ExitMethod(self, 'updateDocument');
end;

function TdsSitzung.Vote(obj: TJSONobject): TJSONObject;
begin
  Result := HellMod.Vote(obj);
end;

end.

