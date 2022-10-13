unit f_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvWizard, Data.DB,
  JvExControls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  xsd_StoreLimits,
  Inifiles, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Comp.Script, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TMainSetupForm = class(TForm)
    StatusBar1: TStatusBar;
    JvWizard1: TJvWizard;
    WelcomePage: TJvWizardWelcomePage;
    SearchGDS: TJvWizardInteriorPage;
    ServerInfo: TJvWizardInteriorPage;
    Memo1: TMemo;
    edHostname: TLabeledEdit;
    edDatabase: TLabeledEdit;
    edDBUser: TLabeledEdit;
    edDBPwd: TLabeledEdit;
    btnCreate: TBitBtn;
    InitData: TJvWizardInteriorPage;
    Panel1: TPanel;
    LV: TListView;
    BitBtn1: TBitBtn;
    esDSServer: TLabeledEdit;
    ArchivarConnection: TFDConnection;
    TETab: TFDQuery;
    PITab: TFDQuery;
    IBTransaction1: TFDTransaction;
    IBScript1: TFDScript;
    AutoIncQry: TFDQuery;
    FDTab: TFDQuery;
    TYTab: TFDQuery;
    GRTab: TFDQuery;
    DATab: TFDQuery;
    CreateDB: TFDScript;
    Sicherheit: TJvWizardInteriorPage;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    SetPwdQry: TFDQuery;
    HCTab: TFDTable;
    EPTab: TFDTable;
    ProgressBar1: TProgressBar;
    TBTab: TFDTable;
    FCTab: TFDTable;
    Label1: TLabel;
    ComboBox1: TComboBox;
    procedure SearchGDSEnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure ServerInfoEnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure btnCreateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitDataEnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure BitBtn1Click(Sender: TObject);
    procedure JvWizard1FinishButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SicherheitEnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure SicherheitExitPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure JvWizard1CancelButtonClick(Sender: TObject);
  private
    m_home  : string;
    m_ini   : TiniFile;

    procedure importImages;
    procedure importTaskTypes;
    procedure importDelTimes;
    procedure importDataTypes;
    procedure importGremium;
    procedure importTasks;
    procedure importWWW;
    procedure importEPub;
    procedure importTextblock;
    procedure importFileCache;

    procedure updateLV;

    function combineDrivePath( drv, path : string ) : string;

    function progress( name : string ) : TListItem;
    procedure initPGBar( count : integer );

    function AutoInc( name : string ) : integer;
    function md5( fname : string ) : string;
  public
    { Public-Deklarationen }
  end;

var
  MainSetupForm: TMainSetupForm;

implementation

uses
  System.IOUtils, System.Types, IdHashMessageDigest, xsd_TaskType,
  xsd_Betriebsrat, xsd_DataField, FireDAC.Phys.IBWrapper,
  System.Win.ComObj, System.Hash, u_ePub, xsd_TextBlock,
  System.Zip, Xml.XMLIntf, Xml.XMLDoc, System.JSON, u_json;

{$R *.dfm}

function TMainSetupForm.AutoInc(name: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+name+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;
end;

procedure TMainSetupForm.BitBtn1Click(Sender: TObject);
begin
  importImages;
  importTaskTypes;
  importDelTimes;
  importDataTypes;
  importGremium;
  importTasks;
  importWWW;
  importEPub;
  importTextblock;
  importFileCache;

  InitData.VisibleButtons := [TJvWizardButtonKind.bkFinish];
end;

procedure TMainSetupForm.btnCreateClick(Sender: TObject);
var
  db    : TFDConnection;
  dbok  : boolean;
  fname : string;
  dbname: string;
begin

  dbName := combineDrivePath(ComboBox1.Items[ComboBox1.ItemIndex], edDatabase.Text);

  if not ForceDirectories(ExtractFilePath(dbname)) then begin
    ShowMessage(Format('Der Pfad "%s" kann nicht erzeugt werden!', [ExtractFilePath(dbname)]));
    exit;
  end;

  db := TFDConnection.Create(NIL);
  dbok := false;
  try
    db.DriverName := 'FB';
    db.LoginPrompt := false;
    with db.Params as TFDPhysFBConnectionDefParams do begin
      Protocol  := ipTCPIP;
      Server    := edHostname.Text;
      Database  := dbname;
      UserName  := edDBUser.Text;
      Password  := edDBPwd.Text;
      SQLDialect:= 3;
      PageSize  := ps4096;
    end;


    Screen.Cursor := crSQLWait;
    with CreateDB do begin
      SQLScripts.Clear;
      SQLScripts.Add;
      with SQLScripts[0].SQL do begin
        add( format('CREATE DATABASE ''%s'' ',      [dbname]));
        add( format('USER ''%s'' PASSWORD ''%s'' ', [edDBUser.Text, edDBPwd.Text]));
        add( format('PAGE_SIZE %d',                 [4096]));
        add( 'DEFAULT CHARACTER SET NONE;');
      end;
      ValidateAll;
      ExecuteAll;
    end;

    Screen.Cursor := crDefault;

    dbok := true;
  except
    on e : exception do
    begin
     Screen.Cursor := crDefault;
     ShowMessage(e.ToString);
    end;
  end;
  db.Free;
  if not dbok then
    exit;

  ArchivarConnection.Params.Clear;
  ArchivarConnection.DriverName := 'FB';
  ArchivarConnection.LoginPrompt := false;
  with ArchivarConnection.Params as TFDPhysFBConnectionDefParams do
  begin

    Protocol  := ipTCPIP;
    Server    := edHostname.Text;
    Database  := dbname;
    UserName  := edDBUser.Text;
    Password  := edDBPwd.Text;
    SQLDialect:= 3;
    PageSize  := ps4096;
  end;
  fname := TPath.Combine(m_home, 'crebas.sql');

  if not FileExists(fname) then begin
    ShowMessage('Das Datenbankscript wurde nicht gefunden');
    exit;
  end;

  Screen.Cursor := crSQLWait;
  try
    ArchivarConnection.Open;

    IBTransaction1.StartTransaction;

    IBScript1.SQLScripts.Clear;
    IBScript1.ExecuteFile(fname);

    if IBTransaction1.Active then
      IBTransaction1.Commit;

    Screen.Cursor := crDefault;
    ShowMessage('Die Datenbankstruktur wurde angelegt');
    ServerInfo.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkNext, TJvWizardButtonKind.bkCancel];

    m_ini.WriteString('DB', 'host', edHostname.Text);
    m_ini.WriteString('DB', 'db',   dbname);
    m_ini.WriteString('DB', 'user', edDBUser.Text);
    m_ini.WriteString('DB', 'pwd',  edDBPwd.Text);

    m_ini.WriteString('DS', 'port', esDSServer.Text);
  except
    on e : exception do
    begin
     Screen.Cursor := crDefault;
     ShowMessage(e.ToString);
    end;
  end;
  ArchivarConnection.Close;
end;

function TMainSetupForm.combineDrivePath(drv, path: string): string;
begin
  Result := '';
  if drv = '' then
    drv := 'c:\';

  if path = '' then
    Path := '\db\archivar.fdb';

   Result := drv + '\'+ path;
   Result := StringReplace(Result, '\\', '\', [rfReplaceAll]);
   Result := StringReplace(Result, '\\', '\', [rfReplaceAll]);
end;

procedure TMainSetupForm.FormCreate(Sender: TObject);
begin
  m_home := TPath.Combine(ExtractFileDir(Application.ExeName), 'InitialData');
  DeleteFile('d:\db\ARCHIVAR.GDB');
  m_ini   := TiniFile.Create(TPath.Combine(ExtractFileDir(Application.ExeName), 'ArchivServer.exe.ini'));
end;

procedure TMainSetupForm.FormDestroy(Sender: TObject);
begin
  m_ini.Free;
end;

procedure TMainSetupForm.importDataTypes;
var
  item  : TListItem;
  path  : string;
  i     : integer;
  xml   : IXMLDataField;
  fi    : TStringDynArray;
  bs    : TStream;
  st    : TStream;
begin
  item          := progress('Datenfelder');

  path := TPath.Combine(m_home, 'Datafields');
  fi := TDirectory.GetFiles(path, '*.xml');
  DATab.Open;
  initPGBar( Length(fi ));
  for i := 0 to pred(Length(fi)) do
  begin
    xml := LoadDataField(fi[i]);
    DATab.Append;
    DATab.FieldByName('DA_ID').AsInteger  := AutoInc('gen_da_id');
    DATab.FieldByName('DA_NAME').AsString := xml.Name;
    DATab.FieldByName('DA_TYPE').AsString := xml.Datatype;
    DATab.FieldByName('DA_REM').AsString  := xml.Text;
    DATab.FieldByName('DA_CLID').AsString := xml.Clid;

    bs :=  DATab.CreateBlobStream(DATab.FieldByName('DA_PROPS'), bmWrite);
    st := TFileStream.Create(fi[i], fmOpenRead + fmShareDenyNone);
    bs.CopyFrom(st, st.Size);
    bs.Free;
    st.Free;

    DATab.Post;
    ProgressBar1.Position := i;
  end;
  DATab.Close;
  item.SubItems.Strings[0] := 'Abgeschlossen';
  updateLV;
end;

procedure TMainSetupForm.importDelTimes;
var
  item  : TListItem;
  fname : string;
  xml   : IXMLStoreLimits;
  i     : integer;
begin
  item := progress('Löschfristen');

  fname := TPath.Combine(m_home, 'StoreLimits.xml');
  xml   := LoadStoreLimits(fname);

  initPGBar( xml.Count );
  FDTab.Open;
  for i := 0 to pred(xml.Count) do
  begin
    FDTab.Append;
    FDTab.FieldByName('FD_ID').Asinteger      := AutoInc('gen_fd_id');
    FDTab.FieldByName('FD_NAME').AsString     := xml.Limit[i].Name;
    FDTab.FieldByName('FD_MONATE').AsInteger  := xml.Limit[i].Monate;
    FDTab.FieldByName('FD_TEXT').AsString     := xml.Limit[i].Rem;
    FDTab.Post;
    ProgressBar1.Position := i;
  end;
  FDTab.Close;

  item.SubItems.Strings[0] := 'Abgeschlossen';
  updateLV;
end;

procedure TMainSetupForm.importEPub;
var
  item  : TListItem;
  i     : integer;
  path  : string;
  arr   : TStringDynArray;
  book  : ePub;
begin
  item := progress('ePub');

  EPTab.Open;
  path  := TPath.Combine(m_home, 'ePub');
  arr   := TDirectory.GetFiles(path, '*.epub');
  initPGBar( high(arr));
  for i := low(arr) to High(arr) do begin
    EPTab.Append;
    EPTab.FieldByName('EP_ID').AsInteger  := AutoInc('gen_EP_ID');
    EPTab.FieldByName('EP_NAME').AsString := ExtractFileName(arr[i]);
    EPTab.FieldByName('EP_MD5').AsString  := md5(arr[i]);
    TBlobField(EPTab.FieldByName('EP_DATA')).LoadFromFile(arr[i]);
    book := epub.create;
    try
      if book.setFileName(arr[i]) then
        EPTab.FieldByName('EP_TITLE').AsString := book.Title;
      book.deleteData;
    finally
      book.Free;
    end;
    EPTab.Post;
    ProgressBar1.Position := i;
  end;
  item.SubItems.Strings[0] := 'Abgeschlossen';
  EPTab.Close;
  updateLV;
end;

procedure TMainSetupForm.importFileCache;
var
  item  : TListItem;
  path  : String;
  subs  : TStringDynArray;
  arr   : TStringDynArray;
  i, j  : integer;
  st    : TStream;
  fi    : TStream;
  function subFolder : string;
  begin
    Result := copy( subs[i], length(path)+1 + 1); // inkl \
  end;
begin
  item := progress('Filecache');
  path := TPath.Combine(m_home, 'FileCache');

  FCTab.Open;

  subs := TDirectory.GetDirectories(path);
  initPGBar( high(subs));

  for i := low(subs) to high(subs) do begin
    arr := TDirectory.GetFiles(subs[i]);
    for j:= Low(arr) to High(arr) do begin
      FCTab.Append;
      FCTab.FieldByName('FC_ID').AsInteger    := AutoInc('gen_fc_id');
      FCTab.FieldByName('FC_NAME').AsString   := ExtractFileName(arr[j]);
      FCTab.FieldByName('FC_CACHE').AsString  := subFolder;
      FCTab.FieldByName('FC_STAMP').AsDateTime:= now;
      FCTab.FieldByName('FC_MD5').AsString    := md5(arr[j]);

      st  := FCTab.CreateBlobStream(FCTab.FieldByName('FC_DATA'), bmWrite);
      fi  := TFileStream.Create(arr[j], fmOpenRead + fmShareDenyNone);
      st.CopyFrom(fi, -1);
      fi.Free;
      st.Free;

      FCTab.Post;

      ProgressBar1.Position := i;
    end;
  end;

  FCTab.Close;

  item.SubItems.Strings[0] := 'Abgeschlossen';
  updateLV;
end;

procedure TMainSetupForm.importGremium;
var
  item  : TListItem;
  fname : string;
  i     : integer;
  xml   : IXMLBER;
begin
  item := progress('Gremium');

  fname := TPath.Combine(m_home, 'gremium.xml');
  xml   := LoadBER(fname);
  initPGBar( xml.Count);
  GRTab.Open;
  for i := 0 to pred(xml.Count) do
  begin
    GRTab.Append;
    GRTab.FieldByName('GR_ID').AsInteger            := AutoInc('gen_gr_id');
    GRTab.FieldByName('GR_NAME').AsString           := xml.Gremium[i].Name;
    GRTab.FieldByName('GR_SHORT').AsString          := xml.Gremium[i].Kurz;
    GRTab.FieldByName('GR_PARENT_SHORT').AsString   := xml.Gremium[i].Pkurz;
    GRTab.FieldByName('GR_PIC_NAME').AsString       := xml.Gremium[i].Pic;
    GRTab.Post;
    ProgressBar1.Position := i;
  end;

  GRTab.Close;

  item.SubItems.Strings[0] := 'Abgeschlossen';
  updateLV;
end;

procedure TMainSetupForm.importImages;
var
  item : TListItem;
  path : string;
  fi : TStringDynArray;
  i  : integer;
  bs : TStream;
  st : TStream;
begin
  item := progress('Bilder');

  PITab.Open;
  path := TPath.Combine(m_home, 'images');
  fi := TDirectory.GetFiles(path, '*.png');

  initPGBar(Length(fi)-1);
  for i := 0 to Length(fi)-1 do begin


    PITab.Append;
    PITab.FieldByName('PI_ID').AsInteger := AutoInc('gen_pi_id');
    PITab.FieldByName('PI_NAME').AsString:= ExtractFileName(fi[i]);
    PITab.FieldByName('PI_MD5').AsString := md5(fi[i]);

    st := TFileStream.Create(fi[i], fmOpenRead + fmShareDenyNone);
    bs := PITab.CreateBlobStream(PITab.FieldByName('PI_DATA'), bmWrite );
    bs.CopyFrom(st, st.Size);
    bs.Free;
    st.Free;

    PITab.Post;
    ProgressBar1.Position := i;
  end;
  PITab.Close;
  SetLength(fi, 0);
  item.SubItems.Strings[0] := 'Abgeschlossen';
  updateLV;
end;

procedure TMainSetupForm.importTasks;
  procedure getTaskInfo( fname : string ; var clid : string ) ;
  var
    zip : TZipFile;
    mem : TSTream;
    he  : TZipHeader;
    xml : IXmlDocument;
  begin
    clid  := '';

    mem   := TMemoryStream.Create;
    zip   := TZipFile.Create;
    zip.Open(fname, zmRead);

    zip.Read('task.xml', mem, he);

    mem.Position := 0;

    if mem.Size > 0 then begin
      xml := TXMLDocument.create(NIL);
      xml.LoadFromStream(mem);

      if xml.DocumentElement.HasAttribute('clid') then
        clid := xml.DocumentElement.Attributes['clid'];
    end;
    zip.Close;
    mem.Free;
  end;
var
  clid, path, fname : string;
  item              : TListItem;
  i                 : integer;
  bs, st            : TStream;
  obj, row          : TJSONObject;
  arr               : TJSONArray;
begin
  item := progress('Vorlagen');

  TETab.Open;
  path := TPath.Combine(m_home, 'Templates');

  fname := TPath.Combine(path, 'list.json');
  obj := LoadJSON(fname);
  arr := JArray(obj, 'files');

  if not Assigned(arr) or ( arr.Count = 0 ) then begin
    item.SubItems.Strings[0] := 'Importfehler!';
    updateLV;
    exit;
  end;

  initPGBar(arr.Count-1);
  for i := 0 to pred(arr.Count) do
  begin
    row := getRow(arr, i);
    fname := TPath.Combine(path, JString(row, 'file'));

    getTaskInfo(fname, clid);

    TETab.Append;
    TETab.FieldByName('TE_ID').AsInteger      := AutoInc('gen_TE_id');
    TETab.FieldByName('TE_NAME').AsString     := JString(row, 'name');
    if JBool(row, 'system') then
      TETab.FieldByName('TE_SYSTEM').AsString   := 'T'
    else
      TETab.FieldByName('TE_SYSTEM').AsString   := 'F';
    TETab.FieldByName('TE_TAGS').AsString     := JString(row, 'tags');
    TETab.FieldByName('TE_SHORT').AsString    := JString(row, 'titel');
    TETab.FieldByName('TE_STATE').AsString    := 'E';
    TETab.FieldByName('TE_VERSION').AsString  := '1';
    TETab.FieldByName('TE_CLID').AsString     := clid;

    if JInt(row, 'type') > 0 then
      TETab.FieldByName('TY_ID').AsInteger := JInt(row, 'type');

    st := TFileStream.Create(fname, fmOpenRead + fmShareDenyNone);
    bs := TETab.CreateBlobStream(TETab.FieldByName('TE_DATA'), bmWrite );
    bs.CopyFrom(st, st.Size);
    bs.Free;
    st.Free;

    TETab.Post;

    ProgressBar1.Position := i;
  end;
  TETab.Close;

  item.SubItems.Strings[0] := 'Abgeschlossen';
  updateLV;
end;

procedure TMainSetupForm.importTaskTypes;
var
  item : TListItem;
  xml  : IXMLTaskTypes;
  fname: string;
  i    : integer;
begin
  item := progress('Aufgabentypen');

  fname := TPath.Combine(m_home, 'Templates\TaskTypes.xml');
  xml := LoadTaskTypes(fname);
  initPGBar(xml.Count);

  TYTab.Open;
  for i := 0 to pred(xml.Count) do
  begin
    TYTab.Append;
    TYTab.FieldByName('TY_ID').AsInteger    := AutoInc('gen_ty_id');
    TYTab.FieldByName('TY_NAME').AsString   := xml.TaskType[i].Name;
    TYTab.FieldByName('TY_TAGE').AsInteger  := xml.TaskType[i].Tage;
    TYTab.post;
    ProgressBar1.Position := i;
  end;
  TYTab.close;
  item.SubItems.Strings[0] := 'Abgeschlossen';
  updateLV;
end;

procedure TMainSetupForm.importTextblock;
var
  item : TListItem;
  path : string;
  fi : TStringDynArray;
  i  : integer;
  st : TStream;
  xBlock  : IXMLBlock;
begin
  item := progress('Textblöcke');

  TBTab.Open;
  path := TPath.Combine(m_home, 'Textbausteine');
  fi := TDirectory.GetFiles(path, '*.xml');
  initPGBar(Length(fi)-1);
  for i := 0 to Length(fi)-1 do
  begin

    xBlock := LoadBlock(fi[i]);

    TBtab.Append;
    TBtab.FieldByName('TB_ID').AsInteger := autoInc('gen_tb_id');
    TBtab.FieldByName('TB_CLID').AsString:= xblock.Id;
    TBtab.FieldByName('TB_NAME').AsString:= xblock.Name;
    TBtab.FieldByName('TB_TAGS').AsString:= xblock.Tags;

    st := TBtab.CreateBlobStream(TBtab.FieldByName('TB_TEXT'), bmWrite);
    xBlock.OwnerDocument.SaveToStream(st);
    st.Free;
    TBTab.Post;
    ProgressBar1.Position := i;
  end;
  TBTab.Close;
  SetLength(fi, 0);
  item.SubItems.Strings[0] := 'Abgeschlossen';
  updateLV;
end;

procedure TMainSetupForm.importWWW;
var
  item  : TListItem;
  path  : string;
  start : integer;
  arr   : TStringDynArray;
  i     : integer;
begin
  item := progress('Webserverdateien');

  path  :=TPath.Combine(m_home, 'wwwroot');
  start := Length(path);
  arr   := TDirectory.GetFiles(path, '*.*', TSearchOption.soAllDirectories );

  initPGBar(high(arr));
  HCTab.Open;
  for i := low(arr) to High(arr) do begin
    path := copy( arr[i], start+2 );  // remove root
    path := ExcludeTrailingPathDelimiter(ExtractFilePath(path) ); //

    HCTab.Append;
    HCTab.FieldByName('HC_ID').AsInteger  := AutoInc('gen_HC_ID');
    HCTab.FieldByName('HC_MD5').AsString  := md5( arr[i] );
    TBlobField(HCTab.FieldByName('HC_DATA')).LoadFromFile(arr[i]);
    HCTab.FieldByName('HC_NAME').AsString := ExtractFileName(arr[i]);
    HCTab.FieldByName('HC_PATH').AsString := path;
    HCTab.Post;

    ProgressBar1.Position := i;
  end;
  HCTab.Close;
  item.SubItems.Strings[0] := 'Abgeschlossen';
  updateLV;
end;

procedure TMainSetupForm.InitDataEnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
  InitData.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkCancel];
end;

procedure TMainSetupForm.initPGBar(count: integer);
begin
  ProgressBar1.Max      := count;
  ProgressBar1.Position := 0;
end;

procedure TMainSetupForm.JvWizard1CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMainSetupForm.JvWizard1FinishButtonClick(Sender: TObject);
begin
  Close;
end;

function TMainSetupForm.md5(fname: string): string;
var
  IdMD5: TIdHashMessageDigest5;
  fs   : TFileStream;
begin
  fs := NIL;
  if not FileExists(fname) then
    exit;

  IdMD5 := TIdHashMessageDigest5.Create;
  try
    fs    := TFileStream.Create(fname, fmOpenRead + fmShareDenyWrite);
    Result := LowerCase( IdMD5.HashStreamAsHex(fs));
  finally
    fs.Free;
  end;
  IdMD5.Free;
end;

function TMainSetupForm.progress(name: string): TListItem;
begin
  Result := LV.Items.Add;

  Result.Caption := name;
  Result.SubItems.Add('einfügen');
  LV.Selected   := Result;
end;

procedure TMainSetupForm.SearchGDSEnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
var
  list : TStringList;
  i    : integer;
  fname: string;
  found: boolean;
begin

  SearchGDS.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkCancel];
  // search gds32.dll
  Memo1.Lines.Clear;
  List := TStringList.Create;
  list.StrictDelimiter := true;
  list.Delimiter := ';';
  list.DelimitedText := GetEnvironmentVariable('PATH');
  list.Sort;
  found := false;
  for i := 0 to pred(list.Count) do
  begin
    if trim(list[i]) = '' then
      Continue;

    fname :=  TPath.Combine(list[i], 'fbclient.dll');
    if FileExists(fname) then
    begin
      found := true;
      Memo1.Lines.Add('ok  :'+List[i]);
    end
    else
      Memo1.Lines.Add('fail:'+List[i]);
  end;
  if found then
  begin
    SearchGDS.Subtitle.font.Color := clGreen;
    SearchGDS.Subtitle.Text := SearchGDS.Subtitle.Text + sLineBreak+'Erfolgreich!';
    SearchGDS.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkNext, TJvWizardButtonKind.bkCancel];
  end
  else
  begin
      SearchGDS.Subtitle.Font.Color := clRed;
      SearchGDS.Subtitle.Text := SearchGDS.Subtitle.Text + sLineBreak+'Nicht gefunden!';
  end;

  list.Free;
end;

procedure TMainSetupForm.ServerInfoEnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
var
  drv : string;
  arr : TStringDynArray;
  s   : string;
begin
  drv := ExtractFileDrive(edDatabase.Text);
  arr := TDirectory.GetLogicalDrives;
  ComboBox1.Items.Clear;
  for s in arr do
    ComboBox1.Items.Add(s);
  ComboBox1.Text := 'c:\';

  setLength(arr, 0);
  edDatabase.Hint := combineDrivePath(ComboBox1.Text, edDatabase.Text);
  edDatabase.ShowHint := true;

  ServerInfo.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkCancel];
end;

procedure TMainSetupForm.SicherheitEnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
var
  s : string;
  IdMD5: TIdHashMessageDigest5;
begin
  s := m_ini.ReadString('secret', 'name', '');
  if s = '' then begin
    IdMD5 := TIdHashMessageDigest5.Create;
    LabeledEdit2.Text := IdMD5.HashStringAsHex(CreateClassID);
    IdMD5.Free;
  end
  else
    LabeledEdit2.Text := s;
end;

procedure TMainSetupForm.SicherheitExitPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
var
  s : string;
begin
  m_ini.WriteString('secret', 'name', LabeledEdit2.Text);

  s  := THashSHA2.GetHashString( 'admin'+LabeledEdit2.Text+LabeledEdit1.Text);
  SetPwdQry.ParamByName('pwd').AsString := s;
  SetPwdQry.ExecSQL;

  if IBTransaction1.Active then
    IBTransaction1.Commit;

end;

procedure TMainSetupForm.updateLV;
begin
  LV.Invalidate;
  Application.ProcessMessages;
end;

end.
