unit ds_sitzung;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, IBX.IBDatabase,
  Datasnap.Provider, Data.DB, IBX.IBCustomDataSet, IBX.IBTable, System.JSON;

type
  TdsSitzung = class(TDSServerModule)
    IBTransaction1: TIBTransaction;
    ELTab: TIBTable;
    ELSrc: TDataSetProvider;
  private
  public
    function startMeeting( data : TJSONObject ) : TJSONObject;
    function endMeeting( data : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  m_glob_server, m_db;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdsSitzung }

function TdsSitzung.endMeeting(data: TJSONObject): TJSONObject;
begin
  Result := NIL;
end;

function TdsSitzung.startMeeting(data: TJSONObject): TJSONObject;
begin
  Result := NIL;
end;

end.

