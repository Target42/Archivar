unit m_html;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Web.HTTPProd, xsd_TaskData,
  JvComponentBase, JvRichEditToHtml, i_taskEdit, SHDocVw, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, System.Generics.Collections;

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
    // frame
    m_Framestyle    : ITaskStyle;
    m_FrameTC       : ITaskContainer;
    m_Framedata     : IXMLList;
    m_FrameTemplate : String;
    // task
    m_style         : ITaskStyle;
    m_tc            : ITaskContainer;
    m_task          : IXMLList;

    m_title         : string;


    m_stack         : TStringList;
    m_path          : string;
    m_clid          : string;

    function  getField( name : string; data : IXMLList )    : string;
    function  createTable( params : TStrings; data : IXMLList ) : String;
    function  addHeader( xHeader : IXMLHeader; params : TStrings; var indexTab : TList<integer> )  : string;
    function  execScript( TagParams: TStrings; style : ITaskStyle; data : IXMLList )  : string;
    procedure SaveImages( path : string; style : ITaskStyle );

    procedure TaskHTMLTag(Sender: TObject; Tag: TTag;
      cmd: string; TagParams: TStrings; var ReplaceText: string;
      style : ITaskStyle; data : IXMLList);
    procedure LoadHtlmFrame;
  public


    property TaskContainer  : ITaskContainer  read m_tc     write m_tc;
    property TaskData       : IXMLList        read m_task   write m_task;
    property TaskStyle      : ITaskStyle      read m_style  write m_style;
    property Title          : string          read m_title  write m_title;

    procedure setFrameData( tc : ITaskContainer; style : ITaskStyle; data :IXMLList );
    procedure clearFrameData;

    function Content : string;
    procedure SaveToFile( fname : string );

    procedure openStack(clid : string );
    procedure AddToStack;
    procedure AddTitleToStack( text : string ; level : integer );
    procedure AddTextToStack( text : string );
    procedure AddHtmlToStack( text : string );
    function  showStack( web : TWebBrowser) : string;

    function show(web : TWebBrowser ) : string;

    class procedure SetHTML(st : TStream; WebBrowser: TWebBrowser); overload;
    class procedure SetHTML(text : string; WebBrowser: TWebBrowser); overload;
    class function  Text2HTML( text : string ) : TStream;

    function loadByID(taid : integer ) : boolean;

    procedure clearFiles( path : string );
  end;

var
  HtmlMod: THtmlMod;

implementation

uses
  System.StrUtils, m_dws, Vcl.Forms, System.IOUtils, m_glob_client,
  Winapi.ActiveX, m_taskLoader, System.Types, vcl.Clipbrd, m_http;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


var
  defHTML : string =
  '<!DOCTYPE html>'+
  '<html>'+
    '<head>'+
      '<link rel="stylesheet" type="text/css" href="/css/archivar.css">'+
    '</head>'+
  '<body>'+
  '<#data>'+
  '</body>'+
  '</html>';

{ THtmlMod }

function THtmlMod.addHeader(xHeader: IXMLHeader; params : TStrings;
  var indexTab : TList<integer>): string;

  function calcLen : integer;
  var
    j   : integer;
    inx : integer;
  begin
    Result := 0;
    for j := 0 to pred(xHeader.Count) do
    begin
      if params.Count = 0 then begin
        Result := Result + xHeader.Field[j].Width;
        indexTab.Add(j);
      end
      else begin
        inx := params.IndexOf(xHeader.Field[j].Field);
        if  inx <> -1 then begin
          Result := Result + xHeader.Field[j].Width;
          indexTab.Add(inx);
        end;
      end;
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

procedure THtmlMod.AddHtmlToStack(text: string);
begin
  m_stack.Add( text );
end;

procedure THtmlMod.AddTextToStack(text: string);
var
  list : TStringList;
  i    : integer;
begin
  list := TStringList.Create;
  list.Text := text;
  for i := 0 to pred(list.Count) do
    list.Strings[i] := list.Strings[i]+'<br>';
  m_stack.AddStrings(list);
  list.Free;
end;

procedure THtmlMod.AddTitleToStack(text: string; level: integer);
begin
  if Level <= 0 then
    m_stack.Add(text+'<br>')
  else
    m_stack.Add(Format('<h%d>%s</h%d>', [level, text, level]));
end;

procedure THtmlMod.AddToStack;
var
  tf :ITaskFile;
  list : TStringList;

begin
  list := TStringList.create;
  PageProducer1.HTMLDoc.Clear;

  if Assigned(m_style) then
  begin
    tf := m_style.Files.getFile('index.html');
    if Assigned(tf) then
      PageProducer1.HTMLDoc.Text := tf.Text;
  end;

  list.text := PageProducer1.Content;
  m_stack.AddStrings(list);
  SaveImages(m_path, m_style);

  m_title := '';
  list.Free;
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

procedure THtmlMod.clearFrameData;
begin
  if FileExists(m_FrameTemplate) then
    Frame.HTMLDoc.LoadFromFile(m_FrameTemplate)
  else
    Frame.HTMLDoc.Text := defHTML;
end;

function THtmlMod.Content: string;
begin
  Result := PageProducer1.Content;
end;

function THtmlMod.createTable(params: Tstrings; data : IXMLList): String;
var
  xTab : IXMLTable;
  xRow : IXMLRow;
  i, j : integer;
  s    : string;
  indexTab : TList<integer>;
begin
  // not tablename
  if params.Count = 0 then begin
    Result := '<p>Es wurden keine Parameter angegeben!</p>';
    exit;
  end;

  xTab := NIL;
  if not Assigned(data) then
    exit;

    // find the table
  for i := 0 to pred(data.Tables.Count) do
  begin
    if SameText( params[0], data.Tables.Table[i].Field) then
    begin
      xTab := data.Tables.Table[i];
      break;
    end;
  end;

  // nor table -> exit;
  if not Assigned(xTab) then
  begin
    Result := '<p>Die Table : '+params[0]+' wurde nicht gefunden!</p>';
    exit;
  end;

  // remote the tablename from the params
  params.Delete(0);
  indexTab := TList<integer>.create;


  Result := '<table>' +sLineBreak+' <tbody>' +sLineBreak;
  Result := result + addHeader( xTab.Header, params, indexTab );

  for i := 0 to pred(xTab.Rows.Count) do
  begin
    Result := Result+'  <tr>'+sLineBreak;
    xRow := xTab.Rows.Row[i];
    for j := 0 to pred(indexTab.Count) do
    begin
      s := xRow.Value[indexTab[j]];
      if trim(s) = '' then
        s := '&nbsp;';

      Result := Result + Format('    <td>%s</td>', [s])+sLineBreak;
    end;
    Result := Result+'  </tr>'+sLineBreak;
  end;
  indexTab.Free;
  Result := Result + ' </tbody>'+sLineBreak+'</table>'+sLineBreak;
end;

procedure THtmlMod.DataModuleCreate(Sender: TObject);
begin
  m_task  := NIL;
  m_style := NIL;
  m_stack := TStringList.create;

  m_Framestyle    := NIL;
  m_FrameTC       := NIL;
  m_Framedata     := NIL;
  m_FrameTemplate := TPath.combine( GM.wwwHome, 'templates\frame.html');

  clearFrameData;
end;

procedure THtmlMod.DataModuleDestroy(Sender: TObject);
begin
  m_task  := NIL;
  m_style := NIL;

  m_stack.Free;

  m_Framestyle:= NIL;
  m_FrameTC   := NIL;
  m_Framedata := NIL;
end;

function THtmlMod.execScript(TagParams: TStrings; style : ITaskStyle; data : IXMLList): string;
var
  DwsMod : TDwsMod;
  tf     : ITaskFile;
begin
  tf := style.Files.getFile(TagParams[0]);
  if not Assigned(tf) then
  begin
    Result := '!!Das Script "'+TagParams[0]+'" wurde nicht gefunden!!';
    exit;
  end;

  Application.CreateForm(TDwsMod, DwsMod);

  DwsMod.Script     := tf.Text;
  DwsMod.Data       := data;
  DwsMod.TaskStyle  := style;
  DwsMod.Params.Assign(TagParams);
  if DwsMod.Params.Count > 0 then
    DwsMod.Params.Delete(0); // name of the script
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
  begin
    if m_stack.Count > 0 then
      ReplaceText := m_stack.Text
    else
      ReplaceText := PageProducer1.Content;
  end
  else
    TaskHTMLTag( Sender, Tag, cmd, TagParams, ReplaceText, m_Framestyle, m_Framedata );
end;

function THtmlMod.getField(name: string; data : IXMLList): string;
var
  i : integer;
begin
  Result := '&nbsp;';
  if not  Assigned(data) then
    exit;

  for i := 0 to pred( data.Values.Count) do
  begin
    if SameText( name, data.Values.Field[i].Field) then
    begin
      Result := ReplaceText( data.Values.Field[i].Value, #$A, '<br>' );
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

procedure THtmlMod.LoadHtlmFrame;
begin
  //{183C11C4-9864-451F-AFB2-05B10CC44D62}
end;

procedure THtmlMod.openStack(clid: string);
begin
  m_clid := clid;
  m_path := TPath.Combine(GM.wwwHome, m_clid);
  ForceDirectories(m_path);
  m_stack.Clear;
  m_stack.Add('');
   { TODO : Löschen einfügen }
end;

procedure THtmlMod.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  cmd : string;
begin
  cmd := LowerCase(tagString);

  TaskHTMLTag( Sender, Tag, cmd, TagParams, ReplaceText, m_style, m_task );
end;

procedure THtmlMod.SaveImages(path: string; style : ITaskStyle);
var
  i : integer;
  ex : string;
begin
  if not Assigned(style) then
    exit;

  for i := 0 to pred(style.Files.Count) do
  begin
    ex := LowerCase( style.Files.Items[i].Name);
    if (ex = '.png') or (ex = '.jpg') then
    begin
      style.Files.Items[i].save(path);
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

procedure THtmlMod.setFrameData(tc: ITaskContainer; style: ITaskStyle;
  data: IXMLList);
var
  tf :ITaskFile;
begin
  m_FrameTC     := tc;
  m_Framestyle  := style;
  m_Framedata   := data;


  clearFrameData;

  if Assigned(m_FrameTC) then
  begin
    if not Assigned(m_Framestyle)  then
      m_Framestyle := m_FrameTC.Styles.DefaultStyle;
    if Assigned(m_Framestyle) then
    begin
      tf := m_Framestyle.Files.getFile('index.html');
      if Assigned(tf) then
        frame.HTMLDoc.Text := tf.Text
    end;
  end
end;

class procedure THtmlMod.SetHTML(text: string; WebBrowser: TWebBrowser);
var
  list : TStringList;
  st : TStream;
begin
  st := TMemoryStream.Create;
  list := TStringList.Create;
  list.Text := text;
  list.SaveToStream(st);
  st.Position := 0;
  list.Free;
  setHTML( st, WebBrowser);
end;

class procedure THtmlMod.SetHTML(st: TStream; WebBrowser: TWebBrowser);
begin

  WebBrowser.Navigate('about:blank');

  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do begin
//  while WebBrowser.ReadyState <> READYSTATE_COMPLETE do begin
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
    begin
      PageProducer1.HTMLDoc.Text := tf.Text;
    end;
  end;

  Result := TPath.Combine(GM.wwwHome, m_tc.CLID);

  ForceDirectories(Result);
  clearFiles( Result );
  SaveImages(Result, m_style);

  list.Add('</ul>');

  list.Add('</body>');
  if err then
    list.SaveToFile(TPath.combine(Result, 'index.html'))
  else
    SaveToFile(TPath.combine(Result, 'index.html'));

  web.Navigate('http://localhost:'+IntToStr(HttpMod.Port)+'/'+m_tc.CLID+'/index.html');
  list.Free;
end;

function THtmlMod.showStack(web : TWebBrowser) : string;
var
  fname : string;
  list  : TStringList;
  url   : string;
begin
  if m_stack.Count = 0 then
    m_stack.Add('Kein Inhalt!');

  fname := TPath.Combine(m_path, 'index.html');
  list := TStringList.Create;
  try
    list.text := Frame.Content;
    list.SaveToFile(fname);
  finally
    list.Free;
  end;
  url := 'http://localhost:'+IntToStr(HttpMod.Port)+'/'+m_clid+'/index.html';
  web.Navigate(url);
  Clipboard.AsText := url;

end;

procedure THtmlMod.TaskHTMLTag(Sender: TObject; Tag: TTag; cmd: string;
  TagParams: TStrings; var ReplaceText: string; style: ITaskStyle;
  data: IXMLList);

begin
  if cmd = 'field' then
  begin
    if TagParams.Count>0 then
    ReplaceText := getField(  TagParams.Strings[0], data);
  end
  else if cmd = 'table' then
  begin
    ReplaceText := createTable( TagParams, data);
  end
  else if cmd = 'script' then
  begin
    if TagParams.Count > 0 then
      ReplaceText := execScript( TagParams, style, data)
    else
      ReplaceText := '!!Es wurde kein Script-Name angegeben!!';
  end
  else if cmd = 'system' then
  begin
    if TagParams.Count > 0 then
    begin
           if SameText(TagParams.Strings[0], 'title') then    ReplaceText := m_title
      else if SameText(TagParams.Strings[0], 'date') then     ReplaceText := FormatDateTime('dd.mm.yyyy', now)
      else if SameText(TagParams.Strings[0], 'time') then     ReplaceText := FormatDateTime('hh:nn', now)
      else if SameText(TagParams.Strings[0], 'user') then     ReplaceText := GM.UserName
      else if SameText(TagParams.Strings[0], 'host') then     ReplaceText := GM.JvComputerInfoEx1.Identification.LocalComputerName      else
        ReplaceText := 'Unbekannter system parameter : '+TagParams.Strings[0]+'<br>';
    end;

  end;
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
