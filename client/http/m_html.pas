unit m_html;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Web.HTTPProd, xsd_TaskData,
  JvComponentBase, JvRichEditToHtml, i_taskEdit, SHDocVw, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect;

type
  THtmlMod = class(TDataModule)
    PageProducer1: TPageProducer;
    Frame: TPageProducer;
    JvRichEditToHtml1: TJvRichEditToHtml;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure FrameHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
  private
    m_task : IXMLList;
    m_style: ITaskStyle;
    m_tc   : ITaskContainer;

    function getField( name : string )          : string;

    function createTable( name : string )       : String;
    function addHeader( xHeader : IXMLHeader )  : string;
    function execScript( TagParams: TStrings )  : string;
    procedure SaveImages( path : string );

  public
    property TaskContainer  : ITaskContainer  read m_tc     write m_tc;
    property TaskData       : IXMLList        read m_task   write m_task;
    property TaskStyle      : ITaskStyle      read m_style  write m_style;

    function Content : string;
    procedure SaveToFile( fname : string );

    function show(web : TWebBrowser ) : string;

    class procedure SetHTML(st : TStream; WebBrowser: TWebBrowser);
    class function  Text2HTML( text : string ) : TStream;

    function loadByID(taid : integer ) : boolean;

    procedure clearFiles( path : string );
  end;

var
  HtmlMod: THtmlMod;

implementation

uses
  System.StrUtils, m_dws, Vcl.Forms, System.IOUtils, m_glob_client,
  Winapi.ActiveX, m_taskLoader, System.Types;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ THtmlMod }

function THtmlMod.addHeader(xHeader: IXMLHeader): string;

  function calcLen : integer;
  var
    j : integer;
  begin
    Result := 0;
    for j := 0 to pred(xHeader.Count) do
    begin
      Result := Result + xHeader.Field[j].Width;
    end;
  end;
var
  i : integer;
  len : double;
begin
  Result := '  <tr>'+sLineBreak;
  len := calcLen;
  for i := 0 to pred(xHeader.Count) do
    Result := Result + Format('    <th style="width:%d%%">%s</th>',
      [trunc(( xHeader.Field[i].Width / len)*100.0),
       xHeader.Field[i].Header]) + sLineBreak;
  Result := Result + '  </tr>'+sLineBreak;
end;

procedure THtmlMod.clearFiles( path : string );
var
  i : integer;
  arr : TStringDynArray;
begin
  if (path<>'') and DirectoryExists(path) then
  begin
    arr := TDirectory.GetFiles(path);
    for i := 0 to pred(Length(arr)) do
      DeleteFile(arr[i]);
  end;
end;

function THtmlMod.Content: string;
begin
  Result := PageProducer1.Content;
end;

function THtmlMod.createTable(name: string): String;
var
  xTab : IXMLTable;
  xRow : IXMLRow;
  i, j : integer;
  s    : string;
begin
  xTab := NIL;
  for i := 0 to pred(m_task.Tables.Count) do
  begin
    if SameTExt( name, m_task.Tables.Table[i].Field) then
    begin
      xTab := m_task.Tables.Table[i];
      break;
    end;
  end;
  if not Assigned(xTab) then
  begin
    Result := '<p>Table : '+name+' not found!</p>';
    exit;
  end;

  Result := '<table>' +sLineBreak+' <tbody>' +sLineBreak;
  Result := result + addHeader( xTab.Header );
  for i := 0 to pred(xTab.Rows.Count) do
  begin
    Result := Result+'  <tr>'+sLineBreak;
    xRow := xTab.Rows.Row[i];
    for j := 0 to pred(xRow.Count) do
    begin
      s := xRow.Value[j];
      if trim(s) = '' then
        s := '&nbsp;';

      Result := Result + Format('    <td>%s</td>', [s])+sLineBreak;
    end;
    Result := Result+'  </tr>'+sLineBreak;
  end;
  Result := Result + ' </tbody>'+sLineBreak+'</table>'+sLineBreak;
end;

procedure THtmlMod.DataModuleCreate(Sender: TObject);
begin
  m_task  := NIL;
  m_style := NIL;
end;

procedure THtmlMod.DataModuleDestroy(Sender: TObject);
begin
  m_task  := NIL;
  m_style := NIL;
end;

function THtmlMod.execScript(TagParams: TStrings): string;
var
  DwsMod : TDwsMod;
  tf     : ITaskFile;
begin
  tf := m_style.Files.getFile(TagParams[0]);
  if not Assigned(tf) then
  begin
    Result := '!!Das Script "'+TagParams[0]+'" wurde nicht gefunden!!';
    exit;
  end;

  Application.CreateForm(TDwsMod, DwsMod);

  DwsMod.Script     := tf.Text;
  DwsMod.Data       := m_task;
  DwsMod.TaskStyle  := m_style;
  DwsMod.Params.Assign(TagParams);
  try
    Result := DwsMod.run;
  except

  end;
  DwsMod.Free;
end;

procedure THtmlMod.FrameHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  cmd : string;
begin
  cmd := LowerCase(TagString);

  if cmd = 'data' then
    ReplaceText := PageProducer1.Content;

end;

function THtmlMod.getField(name: string): string;
var
  i : integer;
begin
  for i := 0 to pred( m_task.Values.Count) do
  begin
    if SameText( name, m_task.Values.Field[i].Field) then
    begin
      Result := ReplaceText( m_task.Values.Field[i].Value, #$A, '<br>' );
    end;
  end;
  if Trim(Result) = '' then
    Result := '&nbsp;';
end;

function THtmlMod.loadByID(taid: integer): boolean;
var
  loader : TTaskLoaderMod;
begin
  loader := TTaskLoaderMod.Create(self);
  Result := loader.load(taid);
  if Result then
  begin
    self.TaskContainer  := loader.TaskContainer;
    self.TaskStyle      := loader.TaskStyle;
    self.TaskData       := loader.TaskData;
  end;
  loader.Free;
end;

procedure THtmlMod.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  cmd : string;
begin
  cmd := LowerCase(tagString);

  if cmd = 'field' then
  begin
    if TagParams.Count>0 then
    ReplaceText := getField(  TagParams.Strings[0]);
  end
  else if cmd = 'table' then
  begin
    ReplaceText := createTable( TagParams.Strings[0]);
  end
  else if cmd = 'script' then
  begin
    if TagParams.Count > 0 then
      ReplaceText := execScript( TagParams)
    else
      ReplaceText := '!!Es wurde kein Script-Name angegeben!!';
  end;
end;

procedure THtmlMod.SaveImages(path: string);
var
  i : integer;
  ex : string;
begin
  if not Assigned(m_style) then
    exit;

  for i := 0 to pred(m_style.Files.Count) do
  begin
    ex := LowerCase( m_style.Files.Items[i].Name);
    if (ex = '.png') or (ex = '.jpg') then
    begin
      m_style.Files.Items[i].save(path);
    end;
  end;
end;

procedure THtmlMod.SaveToFile(fname: string);
var
  list : TStringList;
begin

  list := TStringList.Create;
  try
    if Assigned(m_task) then
      list.text := Frame.Content
    else
      list.text := 'Keine Testdaten ausgewählt!';
    list.SaveToFile(fname);
  finally
    list.Free;
  end;
end;

class procedure THtmlMod.SetHTML(st: TStream; WebBrowser: TWebBrowser);
begin
  WebBrowser.Navigate('about:blank');
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do begin
   Application.ProcessMessages;
  end;

  if Assigned(WebBrowser.Document) then begin
    try
      st.Seek(0, 0);
      (WebBrowser.Document as IPersistStreamInit).Load
        (TStreamAdapter.Create(st));
    finally
      st.Free;
    end;
  end;
end;

function THtmlMod.show( web : TWebBrowser) : string;
var
  list : TStringList;
  err  : boolean;
  tf    : ITaskFile;
begin
  Result := '';

  err := false;
  list:= TStringList.Create;
  list.Add('<body>');
  list.Add('<ul>Fehler:<br>');
  if not Assigned(m_task) then
  begin
    err := true;
    list.Add('<li>Kein Daten zur Darstellung</li>');
  end;

  if not Assigned(m_style) then
  begin
    err := true;
    list.Add('<li>Kein Style zur Formatierung</li>');
  end
  else
  begin
    tf := m_style.Files.getFile('index.html');
    if not Assigned(tf) then
    begin
      err := true;
      list.Add('<li>Die Datei "index.html" wurde nicht gefunden</li>');
    end
    else
      PageProducer1.HTMLDoc.Text := tf.Text;
  end;
  Result := TPath.Combine(GM.wwwHome, m_tc.CLID);
  ForceDirectories(Result);
  clearFiles( Result );
  SaveImages(Result);

  list.Add('</ul>');
  list.Add('</body>');
  if err then
    list.SaveToFile(TPath.combine(Result, 'index.html'))
  else
    SaveToFile(TPath.combine(Result, 'index.html'));

  web.Navigate('http://localhost:42424/'+m_tc.CLID+'/index.html');
  list.Free;
end;

class function THtmlMod.Text2HTML(text: string): TStream;
var
  list : TStringList;
  i    : integer;
begin
  Result := TMemoryStream.create;

  list := TStringList.Create;
  list.Text := text;

  for i := 0 to pred(list.Count) do
    list[i] := list[i]+'<br>';
  list.Insert(0, '<html>');
  list.Append('</html>');

  list.SaveToStream(Result);
  list.Free;
  Result.Position := 0;

end;

end.
