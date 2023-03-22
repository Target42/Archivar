unit m_taskimporter;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, m_glob_client, xsd_TaskData, u_stub;

type
  TTaskImporterMod = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_client  : TDSImportClient;
    m_data    : IXMLList;
    m_token   : string;

    function find( name : string ) : IXMLField;
  public
    function import( path : string ) : boolean;
  end;

var
  TaskImporterMod: TTaskImporterMod;

procedure ImportPath( path : string);

implementation

uses
  System.IOUtils, System.Win.ComObj, System.Variants, System.JSON, u_json,
  Vcl.Dialogs, Vcl.Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure ImportPath( path : string);
var
  Importer: TTaskImporterMod;
begin
  Importer:= TTaskImporterMod.Create(NIL);
  Importer.import(path);
  Importer.free;

end;


procedure TTaskImporterMod.DataModuleCreate(Sender: TObject);
begin
  m_client := TDSImportClient.Create(GM.SQLConnection1.DBXConnection);
  m_data := NIL;
end;

procedure TTaskImporterMod.DataModuleDestroy(Sender: TObject);
begin
  m_data := NIL;
  m_client.Free;
end;

function TTaskImporterMod.find(name: string): IXMLField;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(m_data.Attributes.Count) do begin
    if SameText( name, m_data.Attributes.Field[i].Field) then begin
      Result := m_data.Attributes.Field[i];
      break;
    end;
  end;
end;

function TTaskImporterMod.import(path: string): boolean;
var
  fileName  : string;
  res, req  : TJSONObject;
  i         : integer;
  st        : TMemoryStream;
begin
  fileName := TPath.Combine( path, 'data.xml');
  Result   := FileExists(fileName);

  if not Result then exit;

  try
    m_data := LoadList(fileName)
  except
    on e : exception do begin

    end;
  end;
  if not Assigned(m_data) then begin
    ShowMessage('XML konnte nicht gelesen werden oder hat Fehler!');
    Result := false;
    exit;
  end;

  // start import
  res := m_client.startImport;
  Result := JBool( res, 'result' );
  if not Result then begin
    ShowMessage( JString( res, 'text' ));
    exit;
  end;
  m_token := JString( res, 'token');

  Req := TJSONObject.Create;
  JReplace( req, 'token', m_token);

  for i := 0 to pred(m_data.Attributes.Count) do begin
    JReplace(req, m_data.Attributes.Field[i].Field, m_data.Attributes.Field[i].Value);
  end;

  st  := TMemoryStream.Create;
  m_data.OwnerDocument.SaveToStream(st);
  st.Position := 0;

  res := m_client.importTask(req, st);

  Result := JBool(res, 'result');
  if not Result then begin
    ShowMessage( JString( res, 'text' ));
    exit;
  end;
end;

end.
