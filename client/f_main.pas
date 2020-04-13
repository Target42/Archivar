unit f_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, System.Actions,
  Vcl.ActnList, Vcl.AppEvnts, fr_gremiumTree, Vcl.ExtCtrls, Vcl.StdCtrls,
  fr_taskList, Vcl.StdActns, u_bookmark, fr_bookmark;

type
  TStatusInx = (stStatus = 0, stLogin, stUser );

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
    GroupBox2: TGroupBox;
    Splitter2: TSplitter;
    TaskListFrame1: TTaskListFrame;
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
  private
    procedure setPanel( id : integer ; text : string );
    procedure loadLogo;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  m_glob_client, f_gremiumForm, f_personen, f_task_new, f_gremiumList,
  f_protokoll, u_stub, System.JSON, u_json, f_protokoll_list, u_gremium, m_BookMarkHandler, m_WindowHandler,
  f_images, System.IOUtils, f_taksListForm, u_berTypes, f_datafields;

{$R *.dfm}

procedure TMainForm.ac_ad_datafieldsExecute(Sender: TObject);
begin
  try
    Application.CreateForm(TDataFieldForm, DataFieldForm);
    DataFieldForm.ShowModal;
  finally
    DataFieldForm.free;
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
  GM.Disconnect;
end;

procedure TMainForm.ac_pr_newExecute(Sender: TObject);
var
  GremiumListForm : TGremiumListForm;
  client          : TdsProtocolClient;
  gr              : TGremium;
  data, req       : TJSONObject;
  prid            : integer;
begin
  Application.CreateForm(TGremiumListForm, GremiumListForm);
  if GremiumListForm.ShowModal = mrOk then
  begin
    gr := GremiumListForm.Gremium;
    if Assigned(gr) then
    begin
      prid := -1;
      client := TdsProtocolClient.Create(GM.SQLConnection1.DBXConnection);
      try
        req := TJSONObject.Create;
        JReplace( req, 'grid', gr.ID );
        JReplace( req, 'short', gr.ShortName);

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
  end;
  GremiumListForm.Free;
end;

procedure TMainForm.ac_pr_openExecute(Sender: TObject);
var
  GremiumListForm : TGremiumListForm;
  gr              : TGremium;
begin
  gr := NIL;

  Application.CreateForm(TGremiumListForm, GremiumListForm);
  if GremiumListForm.ShowModal = mrOk then
  begin
    gr := GremiumListForm.Gremium;
  end;

  if Assigned(gr) then
  begin
    Application.CreateForm(TProtocollListForm, ProtocollListForm);
    ProtocollListForm.GremiumID := gr.ID;
    ProtocollListForm.Caption   := gr.Name;
    if ProtocollListForm.ShowModal = mrOk then
    begin
      WindowHandler.openProtoCclWindow(ProtocollListForm.PR_ID, true);
    end;
    ProtocollListForm.Free;
  end;
  GremiumListForm.Free;
end;

procedure TMainForm.ac_ta_loadExecute(Sender: TObject);
begin
  Application.CreateForm(TGremiumListForm, GremiumListForm);
  if GremiumListForm.ShowModal = mrOk then
  begin
    Application.CreateForm(TTaskListForm, TaskListForm);
    TaskListForm.Gremium := GremiumListForm.Gremium;
    TaskListForm.ShowModal;
    TaskListForm.Free;

  end;
  GremiumListForm.Free;
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

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
  Handled := true;
  case Msg.message of
    msgConnected :
      begin
        ac_prg_connect.Enabled := false;
        ac_prg_discon.Enabled  := true;
        ac_ta_neu.Enabled      := true;
        ac_ta_load.Enabled     := true;
        ac_pr_new.Enabled      := true;
        ac_pr_open.Enabled     := true;

        setPanel(integer(stStatus), 'Verbunden');
        setPanel(integer(stLogin), GM.UserName);
        setPanel(integer(stUser),  GM.Name+', '+GM.Vorname);
        GremiumTreeFrame1.updateTree;
        PageControl1.Visible := true;
        GroupBox2.Visible := true;
        GremiumTreeFrame1.selectFirst;

        BookmarkFrame1.updatebookMarks;
      end;
    msgDisconnected:
      begin
        ac_prg_connect.Enabled := true;
        ac_prg_discon.Enabled  := false;
        ac_ta_neu.Enabled      := false;
        ac_ta_load.Enabled     := false;
        ac_pr_new.Enabled      := false;
        ac_pr_open.Enabled     := false;

        setPanel(integer(stStatus), 'Getrennt');
        setPanel(integer(stLogin), '  ');
        setPanel(integer(stUser), '  ');
        PageControl1.Visible := false;
        GroupBox2.Visible := false;
      end;
    msgStatus:
    begin
      Admin1.Visible := (msg.wParam = 1);
      Admin1.Enabled := (msg.wParam = 1);
    end;
    msgUpdateGr : GremiumTreeFrame1.updateTree;
    msgNewBookMark  : BookmarkFrame1.updatebookMarks;
    msgRemoveBookmark : BookmarkFrame1.removeBookmark( TBookmark(Msg.LParam));
    msgLoadLogo : loadLogo;
    else
      Handled := false;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet1;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  GremiumTreeFrame1.clear;
end;

procedure TMainForm.loadLogo;
var
  fname : string;
begin
  fname := TPath.combine( GM.Images, 'logo.png');
  if FileExists( fname ) then
    Image1.Picture.LoadFromFile(fname);

end;

procedure TMainForm.setPanel(id: integer; text: string);
var
  len : integer;
begin
  len := StatusBar1.Canvas.TextWidth(text) +16;
  StatusBar1.Panels.Items[ id ].Width := len;
  StatusBar1.Panels.Items[ id ].Text := text;
end;


end.
