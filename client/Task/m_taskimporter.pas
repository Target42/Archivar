unit m_taskimporter;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, m_glob_client, xsd_TaskData;

type
  TTaskImporterMod = class(TDataModule)
    DSProviderConnection1: TDSProviderConnection;
    TaskTab: TClientDataSet;
    TaskTabTA_REST: TStringField;
    TaskTabTE_ID: TIntegerField;
    TaskTabTA_ID: TIntegerField;
    TaskTabTY_ID: TIntegerField;
    TaskTabTA_STARTED: TDateField;
    TaskTabTA_CREATED: TSQLTimeStampField;
    TaskTabTA_NAME: TStringField;
    TaskTabTA_DATA: TBlobField;
    TaskTabTA_CREATED_BY: TStringField;
    TaskTabTA_TERMIN: TDateField;
    TaskTabTA_CLID: TStringField;
    TaskTabTA_FLAGS: TIntegerField;
    TaskTabTA_STATUS: TStringField;
    TaskTabTA_STYLE: TStringField;
    TaskTabTA_STYLE_CLID: TStringField;
    TaskTabTA_REM: TStringField;
    TaskTabTA_COLOR: TIntegerField;
    TaskTabTA_DELETED: TStringField;
    TaskTabTA_BEARBEITER: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_data : IXMLList;
  public
    function import( path : string ) : boolean;
  end;

var
  TaskImporterMod: TTaskImporterMod;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TTaskImporterMod.DataModuleCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_data := NIL;
end;

procedure TTaskImporterMod.DataModuleDestroy(Sender: TObject);
begin
  m_data := NIL;
end;

function TTaskImporterMod.import(path: string): boolean;
begin
  Result := FileExists(fileName);

  try
    m_data := LoadList(fileName);
  except
    Result := false;

  end;
end;

end.
