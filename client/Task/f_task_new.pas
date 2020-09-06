unit f_task_new;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, fr_base, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.Mask, JvExComCtrls, JvDateTimePicker, JvDBDateTimePicker, JvWizard,
  JvExControls;

type
  TTaskform = class(TForm)
    DSProviderConnection1: TDSProviderConnection;
    TaskTypes: TClientDataSet;
    Task: TClientDataSet;
    TaskSrc: TDataSource;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    JvDBDateTimePicker1: TJvDBDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    JvDBDateTimePicker2: TJvDBDateTimePicker;
    Label7: TLabel;
    LV: TListView;
    JvWizard1: TJvWizard;
    AufgabenTypen: TJvWizardInteriorPage;
    Gremium: TJvWizardInteriorPage;
    LVType: TListView;
    Template: TJvWizardInteriorPage;
    Details1: TJvWizardInteriorPage;
    TEQry: TClientDataSet;
    TEView: TListView;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure JvDBDateTimePicker1Change(Sender: TObject);
    procedure LVTypeClick(Sender: TObject);
    procedure GremiumEnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure LVClick(Sender: TObject);
    procedure TemplateEnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure TEViewClick(Sender: TObject);
    procedure Details1FinishButtonClick(Sender: TObject; var Stop: Boolean);
    procedure Details1EnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
  private
    m_id   : integer;
    m_grid : integer;
    procedure setID( value : integer );

    procedure setGRID( value : integer );
    function  getGRID : integer;
  public
    property ID : integer read m_id write setID;
    property GRID : integer read getGRID write setGRID;
  end;

var
  Taskform: TTaskform;

implementation

uses
  m_glob_client, u_stub, f_taskEdit, m_WindowHandler, Win.ComObj, u_gremium,
  System.DateUtils, u_berTypes;

{$R *.dfm}

procedure TTaskform.Details1EnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
var
  val : integer;
begin
  Edit1.Text := LVType.Selected.SubItems.Strings[0];

  val := 7;
  TryStrToInt(Edit1.Text, val);
  Task.FieldByName('TA_TERMIN').AsDateTime  := IncDay( JvDBDateTimePicker1.DateTime, val );
  Edit1.Text := IntToStr( val );

  Details1.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkCancel, TJvWizardButtonKind.bkFinish];
end;

procedure TTaskform.Details1FinishButtonClick(Sender: TObject;
  var Stop: Boolean);
var
   client       : TdsTaskClient;
   tyid         : integer;
   gr           : TGremium;
begin
  if not Assigned(LV.Selected) then
    exit;

  client := NIL;
  tyid := Task.FieldByName('TY_ID').AsInteger;
  if tyid = 0 then begin
    tyid := integer(LVType.Selected.Data);
  end;

  if m_id = 0 then
  begin
    try
      m_id   := GM.autoInc('gen_ta_id');
      Task.FieldByName('TA_ID').AsInteger := m_id;
      Task.FieldByName('TA_STARTED').AsDateTime := JvDBDateTimePicker1.DateTime;
      Task.FieldByName('TA_TERMIN').AsDateTime  := JvDBDateTimePicker2.DateTime;
      Task.FieldByName('TE_ID').AsInteger       := integer(TEView.Selected.Data);
    finally
    end;
  end;

  Task.FieldByName('TY_ID').AsInteger := tyid;
  Task.Post;
  Task.ApplyUpdates(0);

  gr := TGremium(LV.Selected.Data);
  m_grid := gr.ID;
  try
    client := TdsTaskClient.Create(GM.SQLConnection1.DBXConnection);
    client.AssignGremium(m_grid, m_id, 'O');
  finally
    client.Free;
  end;

  GM.LockDocument( m_id, integer(ltTask));
  WindowHandler.openTaskWindow(m_id, integer(ltTask), false);
end;

procedure TTaskform.FormCreate(Sender: TObject);
var
  i : integer;
  gr : TGremium;
  item : TListItem;
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  LV.Items.BeginUpdate;
  for i := 0 to pred(GM.Gremien.Count) do
  begin
    gr := GM.Gremien.Items[i];
    item := LV.Items.Add;
    item.caption := gr.ShortName;
    Item.SubItems.Add(gr.Name);
    item.data :=  gr;
  end;
  LV.Items.EndUpdate;

  TaskTypes.Open;
  LVType.Items.BeginUpdate;
  while not TaskTypes.Eof do
  begin
    item := LVType.items.add;
    item.Caption := TaskTypes.FieldByName('TY_NAME').AsString;
    item.SubItems.Add(TaskTypes.FieldByName('TY_TAGE').AsString);
    item.Data := pointer( TaskTypes.FieldByName('TY_ID').AsInteger );
    TaskTypes.Next;
  end;
  LVType.Items.EndUpdate;
  TaskTypes.Close;

  AufgabenTypen.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkCancel];
end;

procedure TTaskform.FormDestroy(Sender: TObject);
begin
  try
    if Task.State <> dsBrowse then
      Task.Cancel
  except

  end;
  Task.Close;
end;

function TTaskform.getGRID: integer;
begin
  Result := 0;
  if not Assigned(LV.Selected) then
    exit;
  Result := TGremium(LV.Selected.Data).ID;
end;

procedure TTaskform.GremiumEnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
  if not Assigned(LV.Selected) then
    Gremium.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkCancel]
  else
    Gremium.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkNext, TJvWizardButtonKind.bkCancel]
end;

procedure TTaskform.JvDBDateTimePicker1Change(Sender: TObject);
var
  val : integer;
begin
  val := 0;

  if Assigned(LVType.Selected) then
    val := integer( LVType.Selected.Data);

  Task.FieldByName('TA_TERMIN').AsDateTime :=
    Task.FieldByName('TA_STARTED').AsDateTime + val;
end;

procedure TTaskform.LVClick(Sender: TObject);
begin
  Gremium.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkNext, TJvWizardButtonKind.bkCancel];
end;

procedure TTaskform.LVTypeClick(Sender: TObject);
begin
  if Assigned(LVType.Selected) then
   AufgabenTypen.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkNext, TJvWizardButtonKind.bkCancel];

end;

procedure TTaskform.setGRID(value: integer);
var
  i : integer;
  gr : TGremium;
begin
  for i := 0 to pred(LV.Items.Count) do
  begin
    gr := TGremium(LV.Items.Item[i].Data);
    if gr.ID = value then
    begin
      LV.Selected := LV.Items.Item[i];
      LV.Selected.MakeVisible(false);
      break;
    end;
  end;

end;

procedure TTaskform.setID(value: integer);
var
  opts : TLocateOptions;
begin
  m_id := value;
  Task.Open;
  if m_id > 0 then
  begin
    if Task.Locate('TA_ID', VarArrayOf([m_id]), opts) then
      Task.Edit
    else
      Task.Append;
  end
  else
    Task.Append;

  if Task.State = dsInsert then
  begin
    Task.FieldByName('TA_ID').AsInteger := 0;
    Task.FieldByName('TA_CLID').AsString := CreateClassID;
  end;

  Task.FieldByName('TA_CREATED_BY').AsString := GM.Name+', '+GM.Vorname;
  Task.FieldByName('TA_STARTED').AsDateTime := NOW;

  JvDBDateTimePicker1Change(NIL);
end;

procedure TTaskform.TemplateEnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
var
  item : TListItem;
begin
  Template.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkCancel];
  TEView.Items.BeginUpdate;
  TEView.Items.Clear;

  TEQry.ParamByName('id').AsInteger := Integer( LVType.Selected.Data );
  TEQry.Open;
  while not TEQry.Eof do
  begin
    item := TEView.Items.Add;
    item.Caption := TEQry.FieldByName('TE_NAME').AsString;
    item.Data := Pointer(integer( TEQry.FieldByName('TE_ID').AsInteger ));
    TEQry.Next;
  end;
  TEQry.Close;
  TEView.Items.EndUpdate;
end;

procedure TTaskform.TEViewClick(Sender: TObject);
begin
  if Assigned(TEView.Selected) then
    Template.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkNext, TJvWizardButtonKind.bkCancel];
end;

end.
