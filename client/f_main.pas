unit f_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, System.Actions,
  Vcl.ActnList, Vcl.AppEvnts, fr_gremiumTree, Vcl.ExtCtrls, Vcl.StdCtrls,
  fr_taskList, Vcl.StdActns, u_bookmark, fr_bookmark, fr_epub, fr_meeting,
  JvCombobox, JvColorCombo, fr_storages, MidasLib, JvExStdCtrls,
  DragDrop, DragDropFile, JvComponentBase, JvBaseDlg, JvBrowseFolder,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, Vcl.Buttons, JvSpeedbar,
  JvExExtCtrls, JvExtComponent, f_mail;

type
  TStatusInx = (stStatus = 0, stHost, stLogin, stUser, stMsg );

type
  TMainForm = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    ac_prg_close: TAction;
    ac_prg_connect: TAction;
    ac_prg_discon: TAction;
    Programm1: TMenuItem;
    ac_prg_set: TAction;
    Einstellungen1: TMenuItem;
    N1: TMenuItem;
    Verbinden1: TMenuItem;
    rennen1: TMenuItem;
    N2: TMenuItem;
    Ende1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Admin1: TMenuItem;
    ac_ad_gremium: TAction;
    Gremium1: TMenuItem;
    ac_ad_person: TAction;
    Mitglieder1: TMenuItem;
    Aufgabe1: TMenuItem;
    ac_ta_neu: TAction;
    Splitter1: TSplitter;
    GremiumTreeFrame1: TGremiumTreeFrame;
    Splitter2: TSplitter;
    Fenster1: TMenuItem;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowTileVertical1: TWindowTileVertical;
    WindowMinimizeAll1: TWindowMinimizeAll;
    WindowArrange1: TWindowArrange;
    Arrange1: TMenuItem;
    Cascade1: TMenuItem;
    MinimizeAll1: TMenuItem;
    ileHorizontally1: TMenuItem;
    ileVertically1: TMenuItem;
    Proptokoll1: TMenuItem;
    ac_pr_new: TAction;
    ac_pr_open: TAction;
    Neu1: TMenuItem;
    Laden1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ac_ad_pics: TAction;
    Bilder1: TMenuItem;
    Image1: TImage;
    BookmarkFrame1: TBookmarkFrame;
    Aufgabe2: TMenuItem;
    Neue2: TMenuItem;
    ac_ta_load: TAction;
    Laden2: TMenuItem;
    ac_ad_datafields: TAction;
    Datenfelder1: TMenuItem;
    N3: TMenuItem;
    ac_ad_templates: TAction;
    ac_ad_template_new: TAction;
    N4: TMenuItem;
    Vorlagen1: TMenuItem;
    NeueVorlage1: TMenuItem;
    Vorlagenbearbeiten1: TMenuItem;
    est1: TMenuItem;
    test21: TMenuItem;
    ac_ad_sys_template: TAction;
    Systemvorlage1: TMenuItem;
    extbausteine1: TMenuItem;
    ac_tb_neu: TAction;
    ac_tb_edit: TAction;
    ac_tb_löschen: TAction;
    Neu2: TMenuItem;
    Bearbeiten1: TMenuItem;
    N5: TMenuItem;
    Lschen1: TMenuItem;
    ac_ad_http: TAction;
    N6: TMenuItem;
    Webserverdateienverwalten1: TMenuItem;
    ac_pr_view: TAction;
    N7: TMenuItem;
    Anzeigen1: TMenuItem;
    N8: TMenuItem;
    ac_ad_epub: TAction;
    ePubmanager1: TMenuItem;
    TabSheet3: TTabSheet;
    ePupFrame1: TePupFrame;
    Sitzungen1: TMenuItem;
    ac_me_new: TAction;
    Neu3: TMenuItem;
    N9: TMenuItem;
    ac_pr_delete: TAction;
    Lschen2: TMenuItem;
    N10: TMenuItem;
    ac_me_edit: TAction;
    ac_me_invite: TAction;
    ac_me_delete: TAction;
    ac_me_end: TAction;
    Bearbeiten2: TMenuItem;
    N11: TMenuItem;
    Einladen1: TMenuItem;
    Abschlieen1: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    Lschen3: TMenuItem;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    GroupBox2: TGroupBox;
    TaskListFrame1: TTaskListFrame;
    TabSheet5: TTabSheet;
    MeetingFrame1: TMeetingFrame;
    ac_me_update: TAction;
    Update1: TMenuItem;
    N14: TMenuItem;
    ac_me_execute: TAction;
    Ausfhren1: TMenuItem;
    ac_pr_abschnitt: TAction;
    Abschnittbearbeiten1: TMenuItem;
    N15: TMenuItem;
    TabSheet6: TTabSheet;
    UserView: TListView;
    Panel1: TPanel;
    JvColorComboBox1: TJvColorComboBox;
    Ansicht1: TMenuItem;
    ac_view_task: TAction;
    ac_view_admin: TAction;
    Verwaltung1: TMenuItem;
    Aufgaben1: TMenuItem;
    ac_ad_tasktype: TAction;
    N16: TMenuItem;
    Aufgabentypen1: TMenuItem;
    Reports1: TMenuItem;
    Tools1: TMenuItem;
    ac_ad_filecache: TAction;
    N17: TMenuItem;
    Dateicache1: TMenuItem;
    ac_to_dms: TAction;
    ac_to_wiki: TAction;
    Dokumentenmanagement1: TMenuItem;
    Wiki1: TMenuItem;
    ac_to_faq: TAction;
    FAQ1: TMenuItem;
    ac_to_disput: TAction;
    Disput1: TMenuItem;
    ac_to_stat: TAction;
    Statistik1: TMenuItem;
    ac_to_import: TAction;
    Import1: TMenuItem;
    ac_to_keys: TAction;
    Schlssel1: TMenuItem;
    ac_tb_export: TAction;
    ac_tb_import: TAction;
    N18: TMenuItem;
    Export1: TMenuItem;
    Import2: TMenuItem;
    ac_to_pdrive: TAction;
    PersnlichDatenablage1: TMenuItem;
    TabSheet7: TTabSheet;
    StoragesFrame1: TStoragesFrame;
    ac_ad_storages: TAction;
    N19: TMenuItem;
    N20: TMenuItem;
    ac_ad_action: TAction;
    Aktionen1: TMenuItem;
    N21: TMenuItem;
    ac_ta_delete: TAction;
    asklschen1: TMenuItem;
    Plugins1: TMenuItem;
    ac_ad_plugin: TAction;
    Plugins2: TMenuItem;
    N22: TMenuItem;
    ac_ta_import: TAction;
    JvBrowseForFolderDialog1: TJvBrowseForFolderDialog;
    N23: TMenuItem;
    Import3: TMenuItem;
    ImageList1: TImageList;
    ac_ad_mail: TAction;
    Mailkonten1: TMenuItem;
    procedure ac_prg_closeExecute(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure ac_prg_disconExecute(Sender: TObject);
    procedure ac_prg_connectExecute(Sender: TObject);
    procedure ac_ad_gremiumExecute(Sender: TObject);
    procedure ac_ad_personExecute(Sender: TObject);
    procedure ac_ta_neuExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ac_pr_newExecute(Sender: TObject);
    procedure ac_pr_openExecute(Sender: TObject);
    procedure ac_ad_picsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ac_ta_loadExecute(Sender: TObject);
    procedure ac_ad_datafieldsExecute(Sender: TObject);
    procedure ac_ad_template_newExecute(Sender: TObject);
    procedure ac_ad_templatesExecute(Sender: TObject);
    procedure est1Click(Sender: TObject);
    procedure ac_ad_sys_templateExecute(Sender: TObject);
    procedure ac_prg_setExecute(Sender: TObject);
    procedure ac_tb_editExecute(Sender: TObject);
    procedure ac_tb_neuExecute(Sender: TObject);
    procedure ac_tb_löschenExecute(Sender: TObject);
    procedure ac_ad_httpExecute(Sender: TObject);
    procedure ac_pr_viewExecute(Sender: TObject);
    procedure ac_ad_epubExecute(Sender: TObject);
    procedure ac_me_newExecute(Sender: TObject);
    procedure ac_me_editExecute(Sender: TObject);
    procedure ac_me_deleteExecute(Sender: TObject);
    procedure ac_me_inviteExecute(Sender: TObject);
    procedure ac_me_updateExecute(Sender: TObject);
    procedure ac_me_executeExecute(Sender: TObject);
    procedure ac_pr_abschnittExecute(Sender: TObject);
    procedure JvColorComboBox1Change(Sender: TObject);
    procedure ac_pr_deleteExecute(Sender: TObject);
    procedure ac_view_taskExecute(Sender: TObject);
    procedure ac_view_adminExecute(Sender: TObject);
    procedure ac_ad_tasktypeExecute(Sender: TObject);
    procedure ac_ad_filecacheExecute(Sender: TObject);
    procedure ac_to_keysExecute(Sender: TObject);
    procedure ac_tb_exportExecute(Sender: TObject);
    procedure ac_tb_importExecute(Sender: TObject);
    procedure ac_to_pdriveExecute(Sender: TObject);
    procedure ac_ad_storagesExecute(Sender: TObject);
    procedure ac_ad_actionExecute(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure ac_ta_deleteExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ac_ad_pluginExecute(Sender: TObject);
    procedure ac_ta_importExecute(Sender: TObject);
    procedure test21Click(Sender: TObject);
    procedure ac_ad_mailExecute(Sender: TObject);
  private
    m_noStatChange : boolean;

    procedure setPanel( id : integer ; text : string );
    procedure loadLogo;

    procedure templateEdit( sys : boolean );
    procedure setGremiumName( id : integer );
    procedure showMeeting( id : integer );
    procedure doMeeting( id : integer );

    procedure UpdateUserView( sender : TObject );
    procedure ParseCmdLine;
  public
    procedure AdminMsg( text : string );
    procedure ApplicationSetMenu( flag : boolean );
  end;

var
  MainForm: TMainForm;

implementation

uses
  m_glob_client, f_gremiumForm, f_personen, f_task_new, f_gremiumList,
  u_stub, System.JSON, u_json, f_protokoll_list, u_gremium, m_WindowHandler,
  f_images, System.IOUtils, f_taksListForm, u_berTypes, f_datafields,
  f_template_new, f_taskEditor, f_select_templateForm, f_bechlus, f_set,
  f_textblock_edit, f_testblock_list, f_webserver_files, f_epub_mngr,
  f_meeting_new, f_meeting_select, f_meeting_proto, f_login,
  system.UITypes, f_protocol_sec, u_onlineUser, f_doMeeting, f_task_type,
  f_flieCacheForm, f_keys, f_textblock_export, f_textblock_import,
  f_storages, f_protokoll_new, f_admin, f_task_delete,
  f_pluginAdmin, f_task_import, m_taskimporter, f_mail_client;

{$R *.dfm}

procedure TMainForm.ac_ad_actionExecute(Sender: TObject);
begin
  ShowAdminform;
end;

procedure TMainForm.ac_ad_datafieldsExecute(Sender: TObject);
begin
  try
    Application.CreateForm(TDataFieldForm, DataFieldForm);
    DataFieldForm.ShowModal;
  finally
    DataFieldForm.free;
  end;
end;

procedure TMainForm.ac_ad_epubExecute(Sender: TObject);
begin
  try
    Application.CreateForm(TepubMngrForm, epubMngrForm);
    epubMngrForm.ShowModal;
  finally
    epubMngrForm.Free;
  end;
end;

procedure TMainForm.ac_ad_filecacheExecute(Sender: TObject);
begin
  try
    Application.CreateForm(TFileCacheForm, FileCacheForm);
    FileCacheForm.ShowModal;
  finally
    FileCacheForm.free;
  end;
end;

procedure TMainForm.ac_ad_gremiumExecute(Sender: TObject);
begin
  try
    Application.CreateForm(TGremiumForm, GremiumForm);
    GremiumForm.ShowModal;
  finally
    GremiumForm.free;
  end;
end;

procedure TMainForm.ac_ad_httpExecute(Sender: TObject);
begin
  try
    Application.CreateForm(TWebServerFilesForm, WebServerFilesForm);
    WebServerFilesForm.ShowModal;
  finally
    WebServerFilesForm.free;
  end;
end;

procedure TMainForm.ac_ad_mailExecute(Sender: TObject);
begin
  doMailSettings;
end;

procedure TMainForm.ac_ad_personExecute(Sender: TObject);
begin
  try
    Application.CreateForm(TPersonenForm, PersonenForm);
    PersonenForm.ShowModal;
  finally
    PersonenForm.free;
  end;
end;

procedure TMainForm.ac_ad_picsExecute(Sender: TObject);
begin
  try
    Application.CreateForm(TImagesForm, ImagesForm);
    ImagesForm.ShowModal;
  finally
    ImagesForm.free;
  end;
end;

procedure TMainForm.ac_ad_pluginExecute(Sender: TObject);
begin
  Application.CreateForm(TPluginAdmin, PluginAdmin);
  PluginAdmin.ShowModal;
  PluginAdmin.free;
end;

procedure TMainForm.ac_ad_storagesExecute(Sender: TObject);
begin
  Application.CreateForm(TStoragesForm, StoragesForm);
  StoragesForm.ShowModal;
  StoragesForm.free;
end;

procedure TMainForm.ac_ad_sys_templateExecute(Sender: TObject);
begin
  templateEdit( true );
end;

procedure TMainForm.ac_ad_tasktypeExecute(Sender: TObject);
begin
  Application.CreateForm(TTaskTypeForm, TaskTypeForm);
  TaskTypeForm.ShowModal;
  TaskTypeForm.Free;
end;

procedure TMainForm.ac_ad_templatesExecute(Sender: TObject);
begin
  templateEdit( false );
end;

procedure TMainForm.ac_ad_template_newExecute(Sender: TObject);
var
  te_id : integer;
  frm  : TTaksEditorForm;
begin
  te_id := -1;
  Application.CreateForm(TTemplateNewForm, TemplateNewForm);
  try
    TemplateNewForm.TE_ID := -1;
    if TemplateNewForm.ShowModal = mrOk then begin
      te_id := TemplateNewForm.TE_ID;
    end;
  finally
    TemplateNewForm.free;
  end;

  if te_id > -1 then begin
    Application.CreateForm(TTaksEditorForm, frm);
    frm.System  := false;
    frm.TEID    := te_id;
    frm.Show;
  end;
end;

procedure TMainForm.ac_me_deleteExecute(Sender: TObject);
begin
  Application.CreateForm(TSelectMeetingForm, SelectMeetingForm);
  if SelectMeetingForm.ShowModal = mrok then
  begin
    if SelectMeetingForm.EL_ID > 0 then
    begin
      if (MessageDlg('Soll die Sitzungseinladung:'+ sLineBreak+
          SelectMeetingForm.Title+sLineBreak+
          'wirklich gelöscht werden?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
        DeleteMeeting( SelectMeetingForm.EL_ID )
    end;
  end;
  SelectMeetingForm.free;

end;

procedure TMainForm.ac_me_editExecute(Sender: TObject);
begin
  Application.CreateForm(TSelectMeetingForm, SelectMeetingForm);
  SelectMeetingForm.Filter := '''E''';
  if SelectMeetingForm.ShowModal = mrok then
  begin
    if SelectMeetingForm.EL_ID > 0 then
    begin
      showMeeting( SelectMeetingForm.EL_ID );
    end;
  end;
  SelectMeetingForm.free;
end;

procedure TMainForm.ac_me_executeExecute(Sender: TObject);
begin
  if Assigned( DoMeetingform ) then begin
    ShowMessage('Es ist noch eine Sitzung aktiv.'+sLineBreak+'Bitte diese Beenden, bevor eine neue begonnen wird!');
    exit;
  end;

  Application.CreateForm(TSelectMeetingForm, SelectMeetingForm);
  SelectMeetingForm.Filter := '''O'', ''R''';
  if SelectMeetingForm.ShowModal = mrok then
  begin
    if SelectMeetingForm.EL_ID > 0 then
    begin
      doMeeting(SelectMeetingForm.EL_ID);
    end;
  end;
  SelectMeetingForm.free;
end;

procedure TMainForm.ac_me_inviteExecute(Sender: TObject);
begin
  Application.CreateForm(TSelectMeetingForm, SelectMeetingForm);
  SelectMeetingForm.Filter := '''E''';
  if SelectMeetingForm.ShowModal = mrok then
  begin
    if SelectMeetingForm.EL_ID > 0 then
    begin
      Application.CreateForm(TMeetingForm, MeetingForm);
      MeetingForm.EL_ID   := SelectMeetingForm.EL_ID;
      if MeetingForm.ShowModal = mrOk then
        invite( MeetingForm.EL_ID );
      MeetingForm.Free;
    end;
  end;
  SelectMeetingForm.free;
end;

procedure TMainForm.ac_me_newExecute(Sender: TObject);
var
  id              : integer;
begin
  id := -1;
  Application.CreateForm(TMeetingProtoForm, MeetingProtoForm);
  if MeetingProtoForm.ShowModal = mrOk then
  begin
    id := newMeeting( MeetingProtoForm.GR_ID, MeetingProtoForm.PR_ID );
  end;
  GremiumListForm.Free;

  if id > 0 then
  begin
    Application.CreateForm(TMeetingForm, MeetingForm);

    MeetingForm.EL_ID   := id;

    MeetingForm.ShowModal;
    MeetingForm.Free;
  end;
end;

procedure TMainForm.ac_me_updateExecute(Sender: TObject);
begin
  Application.CreateForm(TSelectMeetingForm, SelectMeetingForm);
  SelectMeetingForm.Filter := '''O''';
  if SelectMeetingForm.ShowModal = mrok then
  begin
    if SelectMeetingForm.EL_ID > 0 then
    begin
      Application.CreateForm(TMeetingForm, MeetingForm);
      MeetingForm.EL_ID   := SelectMeetingForm.EL_ID;
      MeetingForm.ReadOnly:= false;
      MeetingForm.GroupBox4.Visible := false;

      if MeetingForm.ShowModal = mrOk then
        invite( MeetingForm.EL_ID );
      MeetingForm.Free;
    end;
  end;
  SelectMeetingForm.free;

end;

procedure TMainForm.ac_prg_closeExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ac_prg_connectExecute(Sender: TObject);
begin
  GM.Connect;
end;

procedure TMainForm.ac_prg_disconExecute(Sender: TObject);
begin
  setPanel(integer(stMsg), 'Das Beenden dauert lange bei HTTP');
  GM.Disconnect;
end;

procedure TMainForm.ac_prg_setExecute(Sender: TObject);
begin
  try
    Application.CreateForm(TMySettingsForm, MySettingsForm);
    MySettingsForm.ShowModal;
  finally
    MySettingsForm.free;
  end;
end;

procedure TMainForm.ac_pr_abschnittExecute(Sender: TObject);
begin
  Application.CreateForm(TProtocollListForm, ProtocollListForm);
  if ProtocollListForm.ShowModal = mrOk then
  begin
    Application.CreateForm(TProtocolSectionForm, ProtocolSectionForm);
    ProtocolSectionForm.PRID := ProtocollListForm.PR_ID;
    ProtocolSectionForm.Show;
  end;
  ProtocollListForm.Free;
end;

procedure TMainForm.ac_pr_deleteExecute(Sender: TObject);
var
  s : string;
begin
  Application.CreateForm(TProtocollListForm, ProtocollListForm);
  if ProtocollListForm.ShowModal = mrOk then
  begin
    s := 'Soll das Protokol:'+sLineBreak+
    '"%s"'+sLineBreak+
    'wirklich gelöscht werden?';
    if (MessageDlg(Format(s, [ProtocollListForm.Title]),
      mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      deleteProtocol(ProtocollListForm.pr_id);
    end;
  end;
  ProtocollListForm.Free;
end;

procedure TMainForm.ac_pr_newExecute(Sender: TObject);
var
  client          : TdsProtocolClient;
  gr              : TGremium;
  obj             : TJSONObject;
  data, req       : TJSONObject;
  prid            : integer;
begin
  gr := NIL;
  obj := nil;

  Application.CreateForm(TProtokollNewForm, ProtokollNewForm);
  if ProtokollNewForm.ShowModal = mrok then begin
    if Assigned(ProtokollNewForm.Gremium) then
      gr := ProtokollNewForm.Gremium.clone;
    obj:= ProtokollNewForm.Template;
  end;
  ProtokollNewForm.free;


  if Assigned(gr) then
  begin
    prid := -1;
    client := TdsProtocolClient.Create(GM.SQLConnection1.DBXConnection);
    try
      req := TJSONObject.Create;
      JReplace( req, 'grid', gr.ID );
      JReplace( req, 'short', gr.ShortName);
      if Assigned(obj) then
        JReplace( req, 'template', obj);

      data := client.newProtocol(req);
      prid := JInt( data, 'id', -1);
    except

    end;
    client.Free;

    if prid <> -1 then
    begin
      GM.LockDocument(prid, integer(ltProtokoll));
      WindowHandler.openProtoCclWindow(prid, false);
    end;
  end;

  if Assigned(gr) then
    gr.Free;

  if Assigned(obj) then
    obj.Free;
end;

procedure TMainForm.ac_pr_openExecute(Sender: TObject);
begin
  Application.CreateForm(TProtocollListForm, ProtocollListForm);
  if ProtocollListForm.ShowModal = mrOk then
  begin
    WindowHandler.openProtoCclWindow(ProtocollListForm.PR_ID, true);
  end;
  ProtocollListForm.Free;
end;

procedure TMainForm.ac_pr_viewExecute(Sender: TObject);
begin
  Application.CreateForm(TProtocollListForm, ProtocollListForm);
  if ProtocollListForm.ShowModal = mrOk then
  begin
    WindowHandler.openProtocolView(ProtocollListForm.PR_ID);
  end;
  ProtocollListForm.Free;
end;

procedure TMainForm.ac_ta_deleteExecute(Sender: TObject);
begin
  execTaskDeleteForm;
end;

procedure TMainForm.ac_ta_importExecute(Sender: TObject);
begin
  if JvBrowseForFolderDialog1.Execute then begin
    ImportPath(JvBrowseForFolderDialog1.Directory);
  end;
end;

procedure TMainForm.ac_ta_loadExecute(Sender: TObject);
begin
  Application.CreateForm(TTaskListForm, TaskListForm);
  TaskListForm.ShowModal;
  TaskListForm.Free;
end;

procedure TMainForm.ac_ta_neuExecute(Sender: TObject);
begin
  try
    Application.CreateForm(TTaskform, Taskform);
    Taskform.GRID := GremiumTreeFrame1.GRID;
    Taskform.ID := 0;
    if Taskform.showModal = mrOk then
      PostMessage( Application.MainFormHandle, msgNewTask, 0, 0 );
  finally
      Taskform.free;
  end;
end;

procedure TMainForm.ac_tb_editExecute(Sender: TObject);
var
  id : integer;
begin
  id := -1;
  Application.CreateForm(TTestBlockListForm, TestBlockListForm);

  if TestBlockListForm.ShowModal = mrOk then
    id := TestBlockListForm.id;

  TestBlockListForm.Free;

  if id <> -1  then
  begin
    Application.CreateForm(TTextBlockEditForm, TextBlockEditForm);
    TextBlockEditForm.ID := id;
    TextBlockEditForm.ShowModal;
    TextBlockEditForm.free;
  end;
end;

procedure TMainForm.ac_tb_exportExecute(Sender: TObject);
begin
  Application.CreateForm(TTextBlockExportForm, TextBlockExportForm);
  TextBlockExportForm.ShowModal;
  TextBlockExportForm.free;
end;

procedure TMainForm.ac_tb_importExecute(Sender: TObject);
begin
  Application.CreateForm(TTextblockImportForm, TextblockImportForm);
  TextblockImportForm.ShowModal;
  TextblockImportForm.free;
end;

procedure TMainForm.ac_tb_löschenExecute(Sender: TObject);
begin
  Application.CreateForm(TTestBlockListForm, TestBlockListForm);

  TestBlockListForm.doDelete := true;
  TestBlockListForm.ShowModal;

  TestBlockListForm.Free;
end;

procedure TMainForm.ac_tb_neuExecute(Sender: TObject);
begin
  Application.CreateForm(TTextBlockEditForm, TextBlockEditForm);
  TextBlockEditForm.ID := -1;
  TextBlockEditForm.ShowModal;
  TextBlockEditForm.free;
end;

procedure TMainForm.ac_to_keysExecute(Sender: TObject);
begin
  ShowKeysform;
end;

procedure TMainForm.ac_to_pdriveExecute(Sender: TObject);
begin
  WindowHandler.openStorage(GM.UserFolder, 'Perönliche Ablage');
end;

procedure TMainForm.ac_view_adminExecute(Sender: TObject);
begin
  ac_view_admin.Checked := not ac_view_admin.Checked;

  Splitter1.Visible     := ac_view_admin.Checked;
  PageControl1.Visible  := ac_view_admin.Checked;
end;

procedure TMainForm.ac_view_taskExecute(Sender: TObject);
begin
  ac_view_task.Checked  := not ac_view_task.Checked;
  PageControl2.Visible  := ac_view_task.Checked;
  Splitter2.Visible     := ac_view_task.Checked;
end;

procedure TMainForm.AdminMsg(text: string);
begin
  setPanel(integer(stMsg), text);
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
  procedure showAdmin;
  begin
    ac_view_admin.Checked := false;
    ac_view_task.Checked  := false;

    ac_view_admin.Execute;
    ac_view_task.Execute;
  end;
begin
  Handled := true;
  case Msg.message of
    msgConnected :
      begin
        ApplicationSetMenu( true );

        setPanel(integer(stStatus), 'Verbunden');
        setPanel(integer(stHost),  GM.getHostName);
        setPanel(integer(stLogin), GM.UserName);
        setPanel(integer(stUser),  GM.Name+', '+GM.Vorname);

        GremiumTreeFrame1.updateTree;
        GremiumTreeFrame1.selectFirst;

        BookmarkFrame1.updatebookMarks;
        StoragesFrame1.updateStorages;
        ePupFrame1.init;
      end;
    msgDisconnected:
      begin
        ApplicationSetMenu( false );

        setPanel(integer(stStatus), 'Getrennt');
        setPanel(integer(stHost), '  ');
        setPanel(integer(stLogin), '  ');
        setPanel(integer(stUser), '  ');

        ePupFrame1.release;
      end;
    msgStatus:
      begin
        Admin1.Visible := (msg.wParam = 1);
        Admin1.Enabled := (msg.wParam = 1);
      end;
    msgUpdateGr       : GremiumTreeFrame1.updateTree;
    msgNewBookMark    : BookmarkFrame1.updatebookMarks;
    msgRemoveBookmark : BookmarkFrame1.removeBookmark( TBookmark(Msg.LParam));
    msgLoadLogo       : loadLogo;
    msgUpdateGremium  : setGremiumName( msg.lParam );
    msgEditMeeting    : showMeeting(msg.lParam);
    msgLogin          : ac_prg_connect.Execute;
    msgDoMeeting      : doMeeting(msg.lParam);
    msgMeetingEnd     : showAdmin;
    msgRetryLogin     : ac_prg_connect.Execute;
    msgShowFileCache  : ac_ad_filecache.Execute;
    msgNeedKeys       : ac_to_keys.Execute;
    else
      Handled := false;
  end;
end;

procedure TMainForm.ApplicationSetMenu(flag: boolean);
begin
  Aufgabe1.Visible        := flag;
  Ansicht1.Visible        := flag;
  Reports1.Visible        := flag;
  Tools1.Visible          := flag;

  ac_prg_connect.Enabled  := not flag;
  ac_prg_discon.Enabled   := flag;

  ac_ta_neu.Enabled       := flag;
  ac_ta_load.Enabled      := flag;
  ac_ta_delete.Enabled    := flag;
  ac_ta_import.Enabled    := flag;

  ac_pr_new.Enabled       := flag;
  ac_pr_open.Enabled      := flag;
  ac_pr_view.Enabled      := flag;
  ac_pr_delete.Enabled    := flag;
  ac_pr_abschnitt.Enabled := flag;

  ac_me_new.Enabled       := flag;
  ac_me_edit.Enabled      := flag;
  ac_me_invite.Enabled    := flag;
  ac_me_delete.Enabled    := flag;
  ac_me_end.Enabled       := flag;
  ac_me_update.Enabled    := flag;
  ac_me_execute.Enabled   := flag;

  ac_tb_neu.Enabled       := flag;
  ac_tb_edit.Enabled      := flag;
  ac_tb_löschen.Enabled   := flag;
  ac_tb_export.Enabled    := flag;
  ac_tb_import.Enabled    := flag;

  ac_view_task.Visible    := flag;
  ac_view_admin.Visible   := flag;


  PageControl1.Visible    := flag;
  PageControl2.Visible    := flag;
  Splitter2.Visible       := flag;
  Splitter1.Visible       := flag;

  if not flag then begin
    Admin1.Visible := false;
    Admin1.Enabled := false;
  end;
  Plugins1.Visible        := flag;

end;

procedure TMainForm.doMeeting(id: integer);
begin
  if Assigned( DoMeetingform ) then begin
    ShowMessage('Es ist noch eine Sitzung aktiv.'+sLineBreak+'Bitte diese Beenden, bevor eine neue begonnen wird!');
    exit;
  end;
  ac_view_admin.Checked := true;
  ac_view_admin.Execute;
  ac_view_task.Checked  := true;
  ac_view_task.Execute;

  Application.CreateForm(TDoMeetingform, DoMeetingform);
  DoMeetingform.ELID := id;
  DoMeetingform.Show;
end;

procedure TMainForm.est1Click(Sender: TObject);
begin
  Application.CreateForm(TBeschlusform, Beschlusform);
  Beschlusform.Show;
//  Beschlusform.Free;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if GM.SQLConnection1.Connected then begin
    WindowHandler.closeAll;
    ac_prg_discon.Execute;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  PageControl2.ActivePage := TabSheet4;
  TaskListFrame1.prepare;
  MeetingFrame1.init;
  StoragesFrame1.prepare;

  PageControl1.ActivePage := TabSheet1;

  PostMessage( Application.MainFormHandle, msgLogin, 0, 0 );

  m_noStatChange := true;

  OnlineUser.OnChangeData := UpdateUserView;

  JvColorComboBox1.AddColor( clGreen, 'Online');
  JvColorComboBox1.AddColor( clGray,  'Offline');
  JvColorComboBox1.AddColor( clRed,   'Beschäftigt');

  m_noStatChange := false;

  loadLogo;

  ApplicationSetMenu( false );
  ParseCmdLine;
  GM.Plugins.MenuRoot := Plugins1;

{$ifdef DEBUG}
  est1.Visible   := true;
  test21.Visible := true;
{$else}
  est1.Visible   := false;
  test21.Visible := false;
{$endif}
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  StoragesFrame1.release;
  OnlineUser.OnChangeData := NIL;
  GremiumTreeFrame1.clear;
  TaskListFrame1.shutdown;
  MeetingFrame1.release;
end;

procedure TMainForm.JvColorComboBox1Change(Sender: TObject);
var
  inx : integer;
begin
  inx := JvColorComboBox1.ItemIndex;
  if (inx < 0) or ( m_noStatChange) then
    exit;
  GM.changeStatus(JvColorComboBox1.Items.Strings[inx]);
end;

procedure TMainForm.loadLogo;
var
  fname : string;

  function getMd5 : string;
  var
    mem : TMemoryStream;
  begin
    mem := TMemoryStream.Create;
    Image1.Picture.SaveToStream(mem);
    mem.Position := 0;
    Result := GM.md5(mem);
    mem.Free;
  end;

begin
  fname := TPath.combine( GM.Images, 'logo.png');
  if FileExists( fname ) then begin
    Image1.Picture.LoadFromFile(fname);

    fname := TPath.Combine( ExtractFilePath(ParamStr(0)), 'logo.png');

    if not FileExists( fname) or (gm.md5(fname) <> getmd5 ) then
      Image1.Picture.SaveToFile(fname);
  end else begin
    fname := TPath.Combine( ExtractFilePath(ParamStr(0)), 'logo.png');
    if FileExists( fname ) then
      Image1.Picture.LoadFromFile(fname);
  end;
end;

procedure TMainForm.ParseCmdLine;
begin

end;

procedure TMainForm.setGremiumName(id: integer);
var
  gr : TGremium;
begin
  GroupBox2.Caption := 'Aufgaben';
  if id > 0 then
  begin
    gr := GM.getGremium(id);
    if Assigned(gr) then
    begin
      GroupBox2.Caption := 'Aufgaben : '+gr.Name;
    end;
  end
end;

procedure TMainForm.setPanel(id: integer; text: string);
var
  len : integer;
begin
  len := StatusBar1.Canvas.TextWidth(text) +16;
  StatusBar1.Panels.Items[ id ].Width := len;
  StatusBar1.Panels.Items[ id ].Text := text;
end;

procedure TMainForm.showMeeting(id: integer);
begin
  Application.CreateForm(TMeetingForm, MeetingForm);
  MeetingForm.EL_ID   := id;
  MeetingForm.ShowModal;
  MeetingForm.Free;
end;

procedure TMainForm.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = StatusBar1.Panels[integer(stMsg)] then
  begin
   StatusBar.Canvas.FillRect(Rect);
   StatusBar1.Font.Color := clRed;

   StatusBar1.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top, StatusBar1.Panels[integer(stMsg)].Text);
  end;
end;
procedure TMainForm.templateEdit(sys: boolean);
var
  te_id : integer;
  frm  : TTaksEditorForm;
begin
  te_id := -1;
  try
    Application.CreateForm(TSelectTemplateForm, SelectTemplateForm);
    SelectTemplateForm.Edit := true;
    SelectTemplateForm.Sys  := sys;
    SelectTemplateForm.start;
    if SelectTemplateForm.ShowModal = mrOk then
      te_id := SelectTemplateForm.TE_ID;
  finally
    SelectTemplateForm.free;
  end;

  if te_id <> -1  then begin
    Application.CreateForm(TTaksEditorForm, frm);
    frm.System := sys;
    frm.TEID := te_id;
    frm.Show;
  end;
end;

procedure TMainForm.test21Click(Sender: TObject);
begin
//  showImportForm;
  Application.CreateForm(TMailClientForm, MailClientForm);
end;

procedure TMainForm.UpdateUserView(sender: TObject);
var
  i     : integer;
  item  : TListItem;

begin
  UserView.Clear;
  createGroups(UserView);

  for i := 0 to pred(OnlineUser.Count) do
    begin
      if OnlineUser.Data[i].status <> '' then
      begin
        item := UserView.Items.Add;
        item.GroupID := getOnlineGroupID(OnlineUser.Data[i].status);
        item.Caption := OnlineUser.Data[i].name;
        item.SubItems.Add(OnlineUser.Data[i].vorname);
        item.SubItems.Add(OnlineUser.Data[i].status );
      end;
      if OnlineUser.Data[i].id = GM.UserID then
      begin
        m_noStatChange := true;
        JvColorComboBox1.Text := OnlineUser.Data[i].status;
        m_noStatChange := false
      end;
    end;
end;

end.
