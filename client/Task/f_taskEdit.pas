unit f_taskEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, u_ITaskType, fr_file, System.Actions,
  Vcl.ActnList, Vcl.Menus;

type
  TTaskEditForm = class(TForm)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    FileFrame1: TFileFrame;
    MainMenu1: TMainMenu;
    Dokument1: TMenuItem;
    ActionList1: TActionList;
    ac_bearbeiten: TAction;
    ac_save: TAction;
    Bearbeiten1: TMenuItem;
    ScrollBox1: TScrollBox;
    N1: TMenuItem;
    Lesezeichenerstellen1: TMenuItem;
    ac_unlock: TAction;
    Bearbeitenbeenden1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ac_bearbeitenExecute(Sender: TObject);
    procedure Lesezeichenerstellen1Click(Sender: TObject);
    procedure ac_unlockExecute(Sender: TObject);
  private
    m_ta_id : integer;
    m_ty_id : integeR;
    m_edit  : ITaskType;
    m_ro    : boolean;
    procedure setRO( value : boolean );
    function  getRO : boolean;
  public
    procedure setID( ta_id, ty_id : integer );
    property RO : Boolean read getRO write setRO;
    procedure LockCheck;
  end;

var
  TaskEditForm: TTaskEditForm;

implementation

uses
  fr_einstellung, m_WindowHandler, Vcl.Dialogs, m_glob_client, System.UITypes,
  System.JSON, u_json, u_bookmark, u_berTypes;

{$R *.dfm}

procedure TTaskEditForm.ac_bearbeitenExecute(Sender: TObject);
var
  data : TJSONObject;
  s : string;
begin
  data := GM.LockDocument(m_ta_id, integer(ltTask));

  if JBool( data, 'result') then
  begin
    self.RO := false;
    ShowMessage('Das Dokument kann jetzt bearbeitet werden.');
  end
  else
  begin
    s := 'Das Dokument wird von:'+sLineBreak+
     'Benutzer: '+JString( data, 'user')+sLineBreak+
     'Host : '+JString( data, 'host')+sLineBreak+
     'Zeitpunkt: '+DateTimeToStr(JDouble( data, 'timestamp'))+sLineBreak+
     'bearbeitet';
    ShowMessage(s);
  end;
end;

procedure TTaskEditForm.ac_unlockExecute(Sender: TObject);
var
  data : TJSONObject;
begin
  data := GM.UnlockDocument(m_ta_id, integer(ltTask));
  if JBool( data, 'result') then
    self.RO := true
  else
    ShowMessage(JString(data, 'text'));

end;

procedure TTaskEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TTaskEditForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(m_edit) then
  begin
    if m_edit.changed then
    begin
      case MessageDlg('Die Daten wurden geändert.'+#13+#10+
                      ''+#13+#10+
                      'Änderungen speichern (Ja)'+#13+#10+
                      'Änderungen verwerfen (Nein)'+#13+#10+
                      'Im Dialog bleiben (Abbrechen)'+#13+#10+'',
                       mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
        mrYes :
        begin
          m_edit.Post;
          CanClose := true;
        end;
        mrNo :
        begin
          m_edit.cancel;
          CanClose := true;
        end;
        else
          CanClose := false;
      end;
    end;
  end
  else
    CanClose := true;

end;

procedure TTaskEditForm.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet1;
  m_edit := NIL;
end;

procedure TTaskEditForm.FormDestroy(Sender: TObject);
begin
  if not m_ro then
    GM.UnLockDocument(m_ta_id, integer(ltTask));

  FileFrame1.release;
  if Assigned(m_edit) then
    m_edit.release;
  m_edit := NIL;

  WindowHandler.closeTaskWindow(m_ta_id);
  PostMessage(Application.MainFormHandle, msgFilterTasks, 1, 0);
end;

function TTaskEditForm.getRO: boolean;
begin
  Result := m_ro;
end;

procedure TTaskEditForm.Lesezeichenerstellen1Click(Sender: TObject);
begin
  if Assigned(m_edit) then
    m_edit.fillBookMark;
end;

procedure TTaskEditForm.LockCheck;
var
  data : TJSONObject;
begin
  data := GM.isLocked(m_ta_id, integer(ltTask));
  if JBool( data, 'result') then
  begin
    if not JBool( data, 'self') then
      ShowMessage( JString( data, 'text'));
  end;
end;

procedure TTaskEditForm.setID(ta_id, ty_id: integer);

begin
  m_ta_id := ta_id;
  m_ty_id := ty_id;

  m_edit wird jetzt ein erzeugtes form

  if Assigned(m_edit) then
  begin
    m_edit.ID := ta_id;
  end;
  FileFrame1.ID := ta_id;

end;

procedure TTaskEditForm.setRO(value: boolean);
begin
  m_ro := value;
  if Assigned(m_edit) then
    m_edit.RO := m_ro;
  FileFrame1.RO := m_ro;
end;

end.
