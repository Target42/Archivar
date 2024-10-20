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
    m_path    : string;

    function find( name : string ) : IXMLField;

    function prepare_import( path : string ): boolean;
    function start_import : boolean;
    procedure UploadFiles(id : integer);
    procedure end_import;

  public
    function import( path : string ) : boolean;
  end;

var
  TaskImporterMod: TTaskImporterMod;

procedure ImportPath( path : string);

implementation

uses
  System.IOUtils, System.Win.ComObj, System.Variants, System.JSON, u_json,
  Vcl.Dialogs, Vcl.Forms, System.Types, CodeSiteLogging, f_importStatus;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure ImportPath( path : string);
var
  Importer: TTaskImporterMod;
begin
  Application.CreateForm(TSTatusForm, STatusForm);
  STatusForm.Show;
  Importer:= TTaskImporterMod.Create(NIL);
  Importer.import(path);
  Importer.free;
  STatusForm.Free;
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

procedure TTaskImporterMod.end_import;
var
  req, res : TJSONObject;
begin
  req := TJSONObject.Create;
  JReplace( req, 'token', m_token );

  res := m_client.endImport(req);

  if not JBool( res, 'result') then
    ShowMessage( JString( res, 'text'));

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
label
  raus;
var
  res, req  : TJSONObject;
  st        : TMemoryStream;
  i         : integer;
begin
  STatusForm.Show;
  STatusForm.PathLab.Caption := path;
  STatusForm.Invalidate;

  CodeSite.EnterMethod(Self, 'import');
  Result := false;
  if not prepare_import(path) then
    exit;

  if not start_import then
    exit;

  Req := TJSONObject.Create;
  JReplace( req, 'token', m_token);

  for i := 0 to pred(m_data.Attributes.Count) do begin
    JReplace(req, m_data.Attributes.Field[i].Field, m_data.Attributes.Field[i].Value);
  end;

  STatusForm.PathLab.Caption := 'data.xml';
  STatusForm.Invalidate;

  st  := TMemoryStream.Create;
  m_data.OwnerDocument.SaveToStream(st);
  st.Position := 0;

  CodeSite.Send(req.ToJSON);
  res := m_client.importTask(req, st);

  Result := JBool(res, 'result');
  if not Result then begin
    ShowMessage( JString( res, 'text' ));

    goto raus;
  end;

  UploadFiles(JInt( res, 'id'));

raus:
  end_import;
  CodeSite.ExitMethod(Self, 'import');
end;

function TTaskImporterMod.prepare_import(path : string ): boolean;
var
  fileName : string;
begin
  STatusForm.fileLab.Caption := 'data.xml';
  STatusForm.fileLab.Invalidate;
  Application.ProcessMessages;
  m_path   := path;
  fileName := TPath.Combine( path, 'data.xml');
  Result   := FileExists(fileName);

  if not Result then exit;

  try
    m_data := LoadList(fileName);
    Result := true;
  except
    on e : exception do begin

    end;
  end;
  if not Assigned(m_data) then begin
    ShowMessage('XML konnte nicht gelesen werden oder hat Fehler!');
    Result := false;
  end;

end;

function TTaskImporterMod.start_import : boolean;
var
  res : TJSONObject;
begin
  // start import
  res := m_client.startImport;
  Result := JBool( res, 'result' );
  if not Result then begin
    ShowMessage( JString( res, 'text' ));
  end else
    m_token := JString( res, 'token');

end;

procedure TTaskImporterMod.UploadFiles(id : integer);
var
  arr : TStringDynArray;
  i   : integer;
  req : TJSONObject;
  res : TJSONObject;
  fname : string;
  st    : TStream;
begin
  arr := TDirectory.GetFiles(m_path);

  STatusForm.ProgressBar1.Max := length(arr);
  STatusForm.Invalidate;

  for i := low(arr) to High(arr) do begin
    STatusForm.ProgressBar1.Position := i;
    STatusForm.Invalidate;
    Application.ProcessMessages;

    fname := ExtractFileName(arr[i]);
    if not SameText(fname, 'data.xml') then begin
      req := TJSONObject.Create;

      JReplace( req, 'token', m_token);
      JReplace( req, 'fname', ExtractFileName(arr[i]));
      JReplace( req, 'id', id);

      st := TFileStream.Create(arr[i], fmOpenRead + fmShareDenyNone);

      Res := m_client.uploadFile( req, st );
      if not Jbool(res, 'result') then begin
        ShowMessage( JString( res, 'text'));
      end;
    end;
  end;
end;

end.
