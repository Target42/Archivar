unit f_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvWizard, Data.DB, IBX.IBDatabase,
  JvExControls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  IBX.IBScript, IBX.IBCustomDataSet, IBX.IBTable, IBX.IBQuery, xsd_StoreLimits,
  Inifiles;

type
  TMainSetupForm = class(TForm)
    StatusBar1: TStatusBar;
    JvWizard1: TJvWizard;
    IBDatabase1: TIBDatabase;
    WelcomePage: TJvWizardWelcomePage;
    SearchGDS: TJvWizardInteriorPage;
    ServerInfo: TJvWizardInteriorPage;
    Memo1: TMemo;
    edHostname: TLabeledEdit;
    edDatabase: TLabeledEdit;
    edDBUser: TLabeledEdit;
    edDBPwd: TLabeledEdit;
    btnCreate: TBitBtn;
    IBTransaction1: TIBTransaction;
    IBScript1: TIBScript;
    InitData: TJvWizardInteriorPage;
    Panel1: TPanel;
    LV: TListView;
    BitBtn1: TBitBtn;
    PITab: TIBTable;
    AutoIncQry: TIBQuery;
    TYTab: TIBTable;
    FDTab: TIBTable;
    GRTab: TIBTable;
    DATab: TIBTable;
    esDSServer: TLabeledEdit;
    TETab: TIBTable;
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
  private
    m_home  : string;
    m_ini   : TiniFile;

    procedure importImages;
    procedure importTaskTypes;
    procedure importDelTimes;
    procedure importDataTypes;
    procedure importGremium;
    procedure importTasks;

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
  xsd_Betriebsrat, xsd_DataField;

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

  InitData.VisibleButtons := [TJvWizardButtonKind.bkFinish];
end;

procedure TMainSetupForm.btnCreateClick(Sender: TObject);
var
  db    : TIBDatabase;
  dbok  : boolean;
  fname : string;
begin
  db := TIBDatabase.Create(NIL);
  dbok := false;
  try
    db.DatabaseName := edHostname.Text+':'+edDatabase.Text;
    db.ServerType   := 'IBServer';
    db.SQLDialect   := 3;
    db.Params.Clear;
    db.Params.Add('USER "'+edDBUser.Text+'"');
    db.Params.Add('PASSWORD "'+edDBPwd.Text+'"');
    db.Params.Add('PAGE_SIZE 4096');
    db.LoginPrompt := false;
    Screen.Cursor := crSQLWait;
    db.CreateDatabase;
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
  IBDatabase1.DatabaseName := edHostname.Text+':'+edDatabase.Text;
  IBDatabase1.Params.Clear;
  IBDatabase1.Params.Values['user_name'] := edDBUser.Text;
  IBDatabase1.Params.Values['password']  := edDBPwd.Text;
  fname := TPath.Combine(m_home, 'crebas.sql');

  if not FileExists(fname) then begin
    ShowMessage('Das Datenbankscript wurde nicht gefunden');
    exit;
  end;
  IBScript1.Script.LoadFromFile(fname);
  Screen.Cursor := crSQLWait;
  try
    IBDatabase1.Open;
    IBScript1.ExecuteScript;
    if IBTransaction1.InTransaction then
      IBTransaction1.Commit;

    Screen.Cursor := crDefault;
    ShowMessage('Die Datenbankstruktur wurde angelegt');
    ServerInfo.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkNext, TJvWizardButtonKind.bkCancel];

    m_ini.WriteString('DB', 'host', edHostname.Text);
    m_ini.WriteString('DB', 'db',   edDatabase.Text);
    m_ini.WriteString('DB', 'user',  edDBUser.Text);
    m_ini.WriteString('DB', 'pwd',  edDBPwd.Text);

    m_ini.WriteString('DS', 'port', esDSServer.Text);
  except
    on e : exception do
    begin
     Screen.Cursor := crDefault;
     ShowMessage(e.ToString);
    end;
  end;
  IBDatabase1.Close;
end;

procedure TMainSetupForm.FormCreate(Sender: TObject);
begin
  m_home := TPath.Combine(ExtractFileDir(Application.ExeName), 'InitialData');
  DeleteFile('d:\db\ARCHIVAR.GDB');
  m_ini   := TiniFile.Create(TPath.Combine(ExtractFileDir(Application.ExeName), 'server.dat'));
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
  item := LV.Items.Add;
  item.Caption := 'Datenfelder';
  item.SubItems.Add('einf�gen');

  path := TPath.Combine(m_home, 'Datafields');
  fi := TDirectory.GetFiles(path, '*.xml');
  DATab.Open;
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
  end;
  DATab.Close;
  item.SubItems.Strings[0] := 'Abgeschlossen';
end;

procedure TMainSetupForm.importDelTimes;
var
  item  : TListItem;
  fname : string;
  xml   : IXMLStoreLimits;
  i     : integer;
begin
  item := LV.Items.Add;
  item.Caption := 'L�schfristen';
  item.SubItems.Add('einf�gen');

  fname := TPath.Combine(m_home, 'StoreLimits.xml');
  xml   := LoadStoreLimits(fname);

  FDTab.Open;
  for i := 0 to pred(xml.Count) do
  begin
    FDTab.Append;
    FDTab.FieldByName('FD_ID').Asinteger      := AutoInc('gen_fd_id');
    FDTab.FieldByName('FD_NAME').AsString     := xml.Limit[i].Name;
    FDTab.FieldByName('FD_MONATE').AsInteger  := xml.Limit[i].Monate;
    FDTab.FieldByName('FD_TEXT').AsString     := xml.Limit[i].Rem;
    FDTab.Post;
  end;
  FDTab.Close;


  item.SubItems.Strings[0] := 'Abgeschlossen';
end;

procedure TMainSetupForm.importGremium;
var
  item  : TListItem;
  fname : string;
  i     : integer;
  xml   : IXMLBER;
begin
  item := LV.Items.Add;
  item.Caption := 'Gremium';
  item.SubItems.Add('einf�gen');
  fname := TPath.Combine(m_home, 'gremium.xml');
  xml   := LoadBER(fname);
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
  end;

  GRTab.Close;

  item.SubItems.Strings[0] := 'Abgeschlossen';
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
  item := LV.Items.Add;
  item.Caption := 'Bilder';
  item.SubItems.Add('einf�gen');

  PITab.Open;
  path := TPath.Combine(m_home, 'images');
  fi := TDirectory.GetFiles(path, '*.png');
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
  end;
  PITab.Close;
  SetLength(fi, 0);
  item.SubItems.Strings[0] := 'Abgeschlossen';
end;

procedure TMainSetupForm.importTasks;
var
  item : TListItem;
  path : string;
  fi : TStringDynArray;
  i  : integer;
  bs : TStream;
  st : TStream;
begin
  exit;
  item := LV.Items.Add;
  item.Caption := 'Tasks';
  item.SubItems.Add('einf�gen');

  TETab.Open;
  path := TPath.Combine(m_home, 'Templates');
  fi := TDirectory.GetFiles(path, '*.task');
  for i := 0 to Length(fi)-1 do
  begin

    TETab.Append;
    TETab.FieldByName('TE_ID').AsInteger := AutoInc('gen_TE_id');
    TETab.FieldByName('TE_NAME').AsString:= ExtractFileName(fi[i]);
    TETab.FieldByName('TE_SYSTEM').AsString := '';
    TETab.FieldByName('TE_TAGS').AsString := '';
    TETab.FieldByName('TE_SHORT').AsString := '';
    TETab.FieldByName('TE_STATE').AsString := '';
    TETab.FieldByName('TE_VERISON').AsString := '';
    TETab.FieldByName('TE_CLID').AsString := '';
    st := TFileStream.Create(fi[i], fmOpenRead + fmShareDenyNone);
    bs := TETab.CreateBlobStream(TETab.FieldByName('TE_DATA'), bmWrite );
    bs.CopyFrom(st, st.Size);
    bs.Free;
    st.Free;

    TETab.Post;
  end;
  TETab.Close;
  SetLength(fi, 0);
  item.SubItems.Strings[0] := 'Abgeschlossen';
end;

procedure TMainSetupForm.importTaskTypes;
var
  item : TListItem;
  xml  : IXMLTaskTypes;
  fname: string;
  i    : integer;
begin
  item := LV.Items.Add;
  item.Caption := 'Aufgabentypen';
  item.SubItems.Add('einf�gen');
  fname := TPath.Combine(m_home, 'TaskTypes.xml');
  xml := LoadTaskTypes(fname);

  TYTab.Open;
  for i := 0 to pred(xml.Count) do
  begin
    TYTab.Append;
    TYTab.FieldByName('TY_ID').AsInteger    := AutoInc('gen_ty_id');
    TYTab.FieldByName('TY_NAME').AsString   := xml.TaskType[i].Name;
    TYTab.FieldByName('TY_TAGE').AsInteger  := xml.TaskType[i].Tage;
    TYTab.post;
  end;
  TYTab.close;
  item.SubItems.Strings[0] := 'Abgeschlossen';
end;

procedure TMainSetupForm.InitDataEnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
  InitData.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkCancel];
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

    fname :=  TPath.Combine(list[i], 'gds32.dll');
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
begin
  ServerInfo.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkCancel];
end;

end.