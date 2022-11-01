unit f_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvWizard, Data.DB,
  JvExControls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  xsd_StoreLimits,
  Inifiles, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Comp.Script, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.DataSet,
  FireDAC.Comp.BatchMove.Text, Vcl.DBGrids, Vcl.DBCtrls,
  IdBaseComponent, IdCustomTCPServer, IdTCPServer, IdContext,
  Vcl.Imaging.pngimage, IdIOHandler, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdHTTP,
  IdCustomHTTPServer, IdHTTPServer, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  IdIOHandlerSocket, IdTCPConnection, IdTCPClient, IdServerIOHandler,
  IdComponent, Vcl.Grids;

type
  TMainSetupForm = class(TForm)
    StatusBar1: TStatusBar;
    JvWizard1: TJvWizard;
    WelcomePage: TJvWizardWelcomePage;
    SearchGDS: TJvWizardInteriorPage;
    ServerInfo: TJvWizardInteriorPage;
    InitData: TJvWizardInteriorPage;
    Panel1: TPanel;
    LV: TListView;
    BitBtn1: TBitBtn;
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
    SetPwdQry: TFDQuery;
    HCTab: TFDTable;
    EPTab: TFDTable;
    ProgressBar1: TProgressBar;
    TBTab: TFDTable;
    FCTab: TFDTable;
    DRTab: TFDTable;
    Import: TJvWizardInteriorPage;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    FDBatchMoveTextReader1: TFDBatchMoveTextReader;
    FDMemTable1PE_NET: TStringField;
    FDMemTable1PE_NAME: TStringField;
    FDMemTable1PE_VORNAME: TStringField;
    FDMemTable1PE_DEPARTMENT: TStringField;
    FDMemTable1PE_MAIL: TStringField;
    FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter;
    FDBatchMove1: TFDBatchMove;
    CheckBox1: TCheckBox;
    Button1: TButton;
    FileOpenDialog1: TFileOpenDialog;
    DBNavigator1: TDBNavigator;
    Button2: TButton;
    PETab: TFDTable;
    Panel3: TPanel;
    BitBtn2: TBitBtn;
    LinkLabel1: TLinkLabel;
    LinkLabel2: TLinkLabel;
    GroupBox1: TGroupBox;
    edHostname: TLabeledEdit;
    ComboBox1: TComboBox;
    Label1: TLabel;
    edDatabase: TLabeledEdit;
    edDBPwd: TLabeledEdit;
    edDBUser: TLabeledEdit;
    btnCreate: TBitBtn;
    GroupBox2: TGroupBox;
    esDSServer: TLabeledEdit;
    Label2: TLabel;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    BitBtn3: TBitBtn;
    LabeledEdit5: TLabeledEdit;
    GroupBox3: TGroupBox;
    Splitter1: TSplitter;
    DBGrid2: TDBGrid;
    GrSrc: TDataSource;
    GRPATab: TFDTable;
    IdTCPServer1: TIdTCPServer;
    Image1: TImage;
    RE: TRichEdit;
    GroupBox4: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    GroupBox5: TGroupBox;
    LabeledEdit6: TLabeledEdit;
    IdHTTPServer1: TIdHTTPServer;
    IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    BitBtn4: TBitBtn;
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
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure LinkLabel1LinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure ImportEnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure BitBtn3Click(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure ServerInfoExitPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure BitBtn4Click(Sender: TObject);
    procedure IdServerIOHandlerSSLOpenSSL1GetPassword(var Password: string);
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

    function getNewDir : integer;
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
  System.Zip, Xml.XMLIntf, Xml.XMLDoc, System.JSON, u_json, ShellApi,
  system.UITypes;

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
  importDelTimes;
  importTextblock;
  importFileCache;
  importWWW;
  importEPub;

  importGremium;
  importTaskTypes;

  importDataTypes;
  importTasks;

  InitData.VisibleButtons := [TJvWizardButtonKind.bkNext, TJvWizardButtonKind.bkFinish];
end;

procedure TMainSetupForm.BitBtn2Click(Sender: TObject);
var
  list : TStringList;
  i    : integer;
  fname: string;
  found: boolean;
  procedure AddColoredString(AText: string; AColor: TColor);
  begin
    AText := AText + #13;
    with RE do
    begin
      SelStart := Length(Text);
      SelAttributes.Color := AColor;
      SelText := AText;
    end;
  end;
begin
  SearchGDS.Subtitle.Text := 'Suche fbclient.dll';
  SearchGDS.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkCancel];
  // search gds32.dll
  RE.Lines.Clear;
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
      AddColoredString('ok  :'+List[i], clGreen);
    end
    else
      AddColoredString('fail:'+List[i], clRed);
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

procedure TMainSetupForm.BitBtn3Click(Sender: TObject);
var
  msg : string;
  function testPort( port : integer ) : boolean;
  var
    srv : TIdTCPServer;
  begin
    Result := (port = 0 );
    srv := TIdTCPServer.Create(self);
    srv.OnExecute := self.IdTCPServer1Execute;

    try
      if not Result then begin
        srv.DefaultPort := port;
        srv.Active := true;
        Result := srv.Active;
      end;
    except
      begin
        msg := msg + IntToStr(port)+#13;
      end;
    end;
    srv.Active := false;
    srv.Free;
  end;
var
  flag : boolean;
begin
  msg := 'Folgende Ports werden benutzt:'#13;

  screen.Cursor := crHourGlass;
  flag := testport( StrToIntDef( esDSServer.Text, 0 ));
  flag := testport( StrToIntDef( LabeledEdit3.Text, 0 )) and flag;
  flag := testport( StrToIntDef( LabeledEdit4.Text, 0 )) and flag;
  flag := testport( StrToIntDef( LabeledEdit5.Text, 0 )) and flag;
  screen.Cursor := crDefault;

  if not flag then
    ShowMessage( msg )
  else
    showMessage('Test erfolgreich');
end;

procedure TMainSetupForm.BitBtn4Click(Sender: TObject);
var
  url, res : string;
begin
  IdServerIOHandlerSSLOpenSSL1.SSLOptions.CertFile      := ExpandFileName(LabeledEdit6.Text);
  IdServerIOHandlerSSLOpenSSL1.SSLOptions.KeyFile       := ExpandFileName(LabeledEdit7.Text);
  IdServerIOHandlerSSLOpenSSL1.SSLOptions.RootCertFile  := ExpandFileName(LabeledEdit8.Text);
  IdHTTPServer1.DefaultPort := StrToIntDef(LabeledEdit4.Text, 0 );

  if IdHTTPServer1.DefaultPort <> 0 then begin

    url := Format('https://localhost:%d/index.html', [IdHTTPServer1.DefaultPort]);
    try
      IdHTTPServer1.Active := true;
      res := IdHTTP1.Get(url);
      ShowMessage( res );
    except
      on e : exception do begin
        ShowMessage( e.ToString );
      end;
    end;
    IdHTTPServer1.Active := false;

  end else
    ShowMessage('HTTPS ist deaktiviert!');
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

  except
    on e : exception do
    begin
     Screen.Cursor := crDefault;
     ShowMessage(e.ToString);
    end;
  end;
  ArchivarConnection.Close;
end;

procedure TMainSetupForm.Button1Click(Sender: TObject);
begin
  FileOpenDialog1.DefaultFolder := ExtractFilePath(TPath.Combine(m_home, 'InitialData'));

  if FileOpenDialog1.Execute then begin
    FDMemTable1.EmptyDataSet;
    FDBatchMoveTextReader1.DataDef.WithFieldNames := CheckBox1.Checked;
    FDBatchMoveTextReader1.FileName := FileOpenDialog1.FileName;
    FDBatchMove1.GuessFormat;
    FDBatchMove1.Execute;
  end;
end;

procedure TMainSetupForm.Button2Click(Sender: TObject);
var
  s  : string;
  id : integer;
begin
  s := format('Sollen diese Personen dem Gremium:'#13'%s'#13'zugewiesen werden?', [GRTab.FieldByName('GR_NAME').AsString]);
  if not (MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    exit;

  if IBTransaction1.Active then
    IBTransaction1.Commit;

  id := GRTab.FieldByName('GR_ID').AsInteger;

  FDMemTable1.DisableControls;
  try
  PETab.Open;
  GRPATab.Open;
  FDMemTable1.First;
  while not FDMemTable1.Eof do begin
    PETab.Append;
    PETab.FieldByName('PE_ID').AsInteger        := AutoInc('gen_pe_id');
    PETab.FieldByName('DR_ID').AsInteger        := getNewDir;
    PETab.FieldByName('PE_NAME').AsString       := FDMemTable1.FieldByName('PE_NAME').AsString;
    PETab.FieldByName('PE_VORNAME').AsString    := FDMemTable1.FieldByName('PE_VORNAME').AsString;
    PETab.FieldByName('PE_NET').AsString        := FDMemTable1.FieldByName('PE_NET').AsString;
    PETab.FieldByName('PE_MAIL').AsString       := FDMemTable1.FieldByName('PE_MAIL').AsString;
    PETab.FieldByName('PE_DEPARTMENT').AsString := FDMemTable1.FieldByName('PE_DEPARTMENT').AsString;
    PETab.FieldByName('PE_ROLS').AsString       := 'user';
    PETab.Post;

    GRPATab.Append;
    GRPATab.FieldByName('GR_ID').AsInteger      := id;
    GRPATab.FieldByName('PE_ID').AsInteger      := PETab.FieldByName('PE_ID').AsInteger;
    GRPATab.Post;
    FDMemTable1.Next;
  end;
  FDMemTable1.EmptyDataSet;
  PETab.Close;
  GRPATab.Close;
  except
    IBTransaction1.Rollback;
  end;
  FDMemTable1.EnableControls;

  if IBTransaction1.Active then
    IBTransaction1.Commit;

  Import.VisibleButtons := [TJvWizardButtonKind.bkFinish];
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
  m_ini   := TiniFile.Create(TPath.Combine(ExtractFileDir(Application.ExeName), 'ArchivServer.exe.ini'));

//  JvWizard1.ActivePage := Sicherheit;
end;

procedure TMainSetupForm.FormDestroy(Sender: TObject);
begin
  m_ini.Free;
end;

function TMainSetupForm.getNewDir: integer;
begin
  Result := AutoInc('gen_dr_id');

  DRTab.Open;
  DRTab.Append;
  DRTab.FieldByName('DR_ID').AsInteger    := Result;
  DRTab.FieldByName('DR_GROUP').AsInteger := Result;
  DRTab.Post;
  DRTab.Close;

end;

procedure TMainSetupForm.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  AResponseInfo.ContentText := 'ok';
end;

procedure TMainSetupForm.IdServerIOHandlerSSLOpenSSL1GetPassword(
  var Password: string);
begin
  Password := LabeledEdit9.Text;
end;

procedure TMainSetupForm.IdTCPServer1Execute(AContext: TIdContext);
begin
  //
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

procedure TMainSetupForm.ImportEnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
  GRTab.Open;

  Panel2.Enabled := not GRTab.IsEmpty;
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
    TYTab.FieldByName('TY_ID').AsInteger    := xml.TaskType[i].Id;
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

procedure TMainSetupForm.LinkLabel1LinkClick(Sender: TObject;
  const Link: string; LinkType: TSysLinkType);
begin
  ShellExecute(Handle, 'open', PWideChar(link), '', '', SW_SHOWNORMAL);
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
  Result := LV.Items.Insert(0);

  Result.Caption := name;
  Result.SubItems.Add('einfügen');
  LV.Selected   := Result;
end;

procedure TMainSetupForm.SearchGDSEnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
  BitBtn2.Click;
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

procedure TMainSetupForm.ServerInfoExitPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
  // ini daten schreiben
  m_ini.WriteString('DS', 'port',         esDSServer.Text);
  m_ini.WriteString('DS', 'httpport',     LabeledEdit3.Text);
  m_ini.WriteString('DS', 'httpsport',    LabeledEdit4.Text);

  m_ini.WriteString('dnl', 'port',        LabeledEdit5.Text);
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

  m_ini.WriteString('ssl', 'crt',     ExpandFileName(LabeledEdit6.Text));
  m_ini.WriteString('ssl', 'key',     ExpandFileName(LabeledEdit7.Text));
  m_ini.WriteString('ssl', 'rootcrt', ExpandFileName(LabeledEdit8.Text));
  m_ini.WriteString('ssl', 'password',LabeledEdit9.Text);


  s  := THashSHA2.GetHashString( 'admin'+LabeledEdit2.Text+LabeledEdit1.Text);
  try
    SetPwdQry.ParamByName('pwd').AsString := s;
    SetPwdQry.ParamByName('drid').AsInteger := getNewDir;
    SetPwdQry.ExecSQL;
  except
    on e : exception do begin
      ShowMessage( e.ToString);
      IBTransaction1.Rollback;
    end;
  end;

  if IBTransaction1.Active then
    IBTransaction1.Commit;

end;

procedure TMainSetupForm.updateLV;
begin
  LV.Invalidate;
  Application.ProcessMessages;
end;

end.
