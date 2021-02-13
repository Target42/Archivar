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
  private
    { Private-Deklarationen }
  public
    function newMeeting(    req : TJSONObject ) : TJSONObject;
    function deleteMeeting( req : TJSONObject ) : TJSONObject;
    function Sendmail(      req : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  m_db;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsMeeing }

function TdsMeeing.deleteMeeting(req: TJSONObject): TJSONObject;
begin
  Result := NIL;
end;

function TdsMeeing.newMeeting(req: TJSONObject): TJSONObject;
begin
  Result := NIL;
end;

function TdsMeeing.Sendmail(req: TJSONObject): TJSONObject;
begin
  Result := NIL;
end;

end.

