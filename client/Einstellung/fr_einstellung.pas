unit fr_einstellung;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, fr_task_head, u_ITask, Vcl.StdCtrls,
  fr_editForm, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, xsd_data,
  u_addInfo, Vcl.ComCtrls;

type
  TEinstellungsframe = class(TFrame, ITask)
    DSProviderConnection1: TDSProviderConnection;
    TaskTab: TClientDataSet;
    TaskSrc: TDataSource;
    TaskHeaderFrame1: TTaskHeaderFrame;
    EditFrame1: TEditFrame;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit1: TDBEdit;
    EinstellungTab: TClientDataSet;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    ESSrc: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure TaskHeaderFrame1DBEdit1Change(Sender: TObject);
  private
    m_ta_id : integer;
    m_es_id : integer;
    m_changed : boolean;
    m_info    : TAddinfo;
    m_ro      : boolean;

    procedure setID( value : integer );
    function  getID : integer;

    procedure saveRem;
    procedure setRO( value : boolean );
    function  getRO : boolean;

  public
    property ID : integer read getID write setID;

    procedure Post;
    procedure cancel;
    function changed : boolean;
    procedure release;
    procedure fillBookMark;
  end;

implementation

uses
  m_glob_client, u_stub, Xml.XMLDoc, Xml.XMLIntf, u_bookmark,
  m_BookMarkHandler, u_berTypes;

{$R *.dfm}

{ TEinstellungsframe }

procedure TEinstellungsframe.cancel;
begin
  TaskTab.Cancel;
  EinstellungTab.Cancel;
end;

function TEinstellungsframe.changed: boolean;
begin
  Result := m_changed or EditFrame1.changed or TaskTab.Modified;
end;

procedure TEinstellungsframe.fillBookMark;
var
  mark : TBookmark;
begin
  mark := BookMarkHandler.Bookmarks.newBookmark(TaskTab.FieldByName('TA_CLID').AsString);
  mark.ID         := TaskTab.FieldByName('TA_ID').AsInteger;
  mark.Titel      := TaskTab.FieldByName('TA_NAME').AsString;
  mark.Group      := 'Einstellung';
  mark.Internal   := false;
  mark.TypeID     := integer(dstEinstellung);
  mark.DocType    := dtTask;
 PostMessage( Application.MainFormHandle, msgNewBookMark, 0, 0 );
end;

function TEinstellungsframe.getID: integer;
begin
  Result := m_ta_id;
end;

function TEinstellungsframe.getRO: boolean;
begin
  Result := m_ro;
end;

procedure TEinstellungsframe.Post;
begin
  saveRem;

  if (EinstellungTab.State = dsInsert) or ( EinstellungTab.State = dsEdit) then
    EinstellungTab.Post;

  if (TaskTab.State = dsInsert) or ( TaskTab.State = dsEdit) then
    TaskTab.Post;

  if EinstellungTab.UpdatesPending then
    EinstellungTab.ApplyUpdates(-1);

  if TaskTab.UpdatesPending then
    TaskTab.ApplyUpdates(-1);

end;

procedure TEinstellungsframe.release;
begin
  m_info.Free;
end;

procedure TEinstellungsframe.saveRem;
begin
  if EditFrame1.changed then
  begin
    m_info.Addinfo.Rem := EditFrame1.getText;
    m_info.saveToclientBlob(EinstellungTab, 'es_data');
  end;
end;

procedure TEinstellungsframe.setID(value: integer);
var
  opts   : TLocateOptions;
  client : TdsEinstellungClient;
begin
  PageControl1.ActivePage := TabSheet1;
  m_ta_id := value;
  m_es_id := 3;
  m_info := TAddinfo.Create;

  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  client := NIL;
  try
    client := TdsEinstellungClient.Create(GM.SQLConnection1.DBXConnection);
    m_es_id := client.getDataID(m_ta_id);
  finally
    client.Free;
  end;

  if m_es_id < 1 then
  begin
    TaskHeaderFrame1.Enabled := false;
    TabSheet1.Enabled := false;
    TabSheet2.Enabled := false;
  end
  else
  begin
    TaskTab.Open;
    EinstellungTab.Open;
    TaskTab.Locate('TA_ID', VarArrayOf([m_ta_id]), opts);
    TaskHeaderFrame1.DataSource := TaskSrc;
    DBEdit1.SetFocus;

    m_info.loadFromClientBlob(EinstellungTab, 'es_data');
    EditFrame1.setText(m_info.Addinfo.Rem);

  end;

  m_changed := false;
end;

procedure TEinstellungsframe.setRO(value: boolean);
begin
  m_ro := value;
  if not m_ro then
  begin
    TaskHeaderFrame1.Enabled := true;
    if TaskTab.FieldByName('TA_ID').AsInteger = m_ta_id then
    begin
      TaskTab.ReadOnly := false;
      TaskTab.Refresh;
      TaskTab.Edit;

      EinstellungTab.ReadOnly := false;
      EinstellungTab.Refresh;
      EinstellungTab.Edit;

    end
    else
    begin
      m_ro := true;
    end;
  end;

  if m_ro then
  begin
    if TaskTab.State = dsEdit then
    begin
      TaskTab.Cancel;
      TaskTab.CancelUpdates;
    end;
    if EinstellungTab.State = dsEdit then
    begin
      TaskTab.Cancel;
      TaskTab.CancelUpdates;
    end;
    TaskTab.ReadOnly := true;
    EinstellungTab.ReadOnly := false;
    TaskHeaderFrame1.Enabled := False;
  end;
end;

procedure TEinstellungsframe.TaskHeaderFrame1DBEdit1Change(Sender: TObject);
begin
  m_changed := true;
end;

end.
