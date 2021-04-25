unit f_meeting_new;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBCtrls, Data.DB, Datasnap.DBClient, Datasnap.DSConnect, Vcl.Mask,
  u_gremium, Vcl.ComCtrls, JvExComCtrls, JvDateTimePicker, JvDBDateTimePicker,
  i_chapter, Vcl.Buttons, System.JSON, VirtualTrees, fr_editForm, fr_to,
  Vcl.Grids, Vcl.DBGrids;

type
  TMeetingForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    DSProviderConnection1: TDSProviderConnection;
    ElTab: TClientDataSet;
    ElSrc: TDataSource;
    LabeledEdit1: TLabeledEdit;
    ProtoQry: TClientDataSet;
    ProcolSrc: TDataSource;
    Label1: TLabel;
    JvDBDateTimePicker1: TJvDBDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    PRTab: TClientDataSet;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    TOFrame1: TTOFrame;
    GroupBox3: TGroupBox;
    EditFrame1: TEditFrame;
    Splitter1: TSplitter;
    TNQry: TClientDataSet;
    TNQryTN_STATUS_STR: TStringField;
    TabSheet3: TTabSheet;
    DBGrid2: TDBGrid;
    TGQry: TClientDataSet;
    TGSrc: TDataSource;
    DBEdit1: TDBEdit;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ComboBox3: TComboBox;
    LV: TListView;
    Panel1: TPanel;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    BitBtn2: TBitBtn;
    TNQryPR_ID: TIntegerField;
    TNQryTN_ID: TIntegerField;
    TNQryTN_NAME: TWideStringField;
    TNQryTN_VORNAME: TWideStringField;
    TNQryTN_DEPARTMENT: TWideStringField;
    TNQryTN_ROLLE: TWideStringField;
    TNQryTN_STATUS: TIntegerField;
    TNQryPE_ID: TIntegerField;
    TNQryTN_GRUND: TWideStringField;
    TNQryTN_READ: TDateTimeField;
    Panel2: TPanel;
    DBNavigator1: TDBNavigator;
    OptTnQry: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure ElTabBeforePost(DataSet: TDataSet);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure TNQryTN_STATUS_STRGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure ElTabReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure TGQryBeforePost(DataSet: TDataSet);
  private
    { Private-Deklarationen }
    m_el_id     : integer;
    m_pr_id     : integer;
    m_gr        : TGremium;
    m_proto     : IProtocol;
    m_readOnly  : boolean;

    procedure SetGremiumID(const Value: TGremium);

    procedure SendUpdate;
    procedure setELID( value : integer );
    procedure updateTo;
    procedure changeStatus;

    function execStatus( req : TJSONObject ) : boolean;

    procedure setReadOnly( flag :Boolean );
    function GetReadOnly: boolean;
  public
    property EL_ID    : integer   read m_el_id        write setELID;
    property ReadOnly : boolean   read GetReadOnly    write SetReadOnly;

  end;

var
  MeetingForm: TMeetingForm;

function newMeeting( gr_id, pr_id : integer ) : integer;
function DeleteMeeting( id : integer ) : boolean;
function invite( id : integer ) : boolean;

implementation

uses
  m_glob_client, system.DateUtils, u_stub, u_json, System.Generics.Collections,
  f_abwesenheit, u_teilnehmer, f_meeting_person;

{$R *.dfm}

function newMeeting( gr_id, pr_id : integer ) : integer;
var
  client  : TdsMeeingClient;
  req     : TJSONObject;
  res     : TJSONObject;
begin
  Result := -1;

  req    := TJSONObject.Create;
  JReplace( req, 'grid', gr_id);
  JReplace( req, 'prid', pr_id);

  client := TdsMeeingClient.Create(GM.SQLConnection1.DBXConnection);
  try
    res  := client.newMeeting( req );
    Result := JInt(res, 'id');
    if Result < 1 then
      ShowMessage(JString( res, 'text'));

    client.Free;
  except

  end;
end;

function DeleteMeeting( id : integer ) : boolean;
var
  client  : TdsMeeingClient;
  req     : TJSONObject;
  res     : TJSONObject;
begin
  Result := false;

  req    := TJSONObject.Create;
  JReplace( req, 'id', id);

  client := TdsMeeingClient.Create(GM.SQLConnection1.DBXConnection);
  try
    res  := client.deleteMeeting(req);
    Result := JBool( res, 'result');
    if not Result then
      ShowMessage(JString( res, 'text'));

    client.Free;
  except

  end;
end;

function invite( id : integer ) : boolean;
var
  client  : TdsMeeingClient;
  req     : TJSONObject;
  res     : TJSONObject;
begin
  Result := false;

  req    := TJSONObject.Create;
  JReplace( req, 'id', id);

  client := TdsMeeingClient.Create(GM.SQLConnection1.DBXConnection);
  try
    res  := client.invite(req);
    Result := JBool( res, 'result');
    if not Result then
      ShowMessage(JString( res, 'text'));

    client.Free;
  except

  end;
end;

procedure TMeetingForm.BaseFrame1AbortBtnClick(Sender: TObject);
begin
  ElTab.Cancel;

  if ElTab.UpdatesPending then
    ElTab.CancelUpdates;
end;

procedure TMeetingForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  st  : TStream;
  changed : boolean;
begin
  if EditFrame1.Modified and not ElTab.ReadOnly then
  begin
    st := ElTab.CreateBlobStream(ElTab.FieldByName('EL_DATA'),bmWrite);
    EditFrame1.saveToStream(st);
    st.Free;
  end;
  changed := ElTab.Modified;
  ELtab.Post;

  if ELtab.UpdatesPending then
    ElTab.ApplyUpdates(0);

  if changed then
    SendUpdate;

  PostMessage( Application.MainFormHandle, msgUpdateMeetings, 0, 0);
end;

procedure TMeetingForm.BitBtn1Click(Sender: TObject);
var
  req   : TJSONObject;
  val   : integer;
  grund : string;
  state : integer;
begin
  if (RadioButton2.Checked) and (ComboBox3.ItemIndex = -1 ) then
  begin
    ShowMessage('Bitte einen konkreten Grund auswählen.');
    exit;
  end;

  if TNQry.Locate('PE_ID', VarArrayOf([GM.UserID]), [] ) then
  begin
    grund := '';
    Req := TJSONObject.Create;

    JReplace( req, 'prid', m_pr_id );
    JReplace( req, 'tnid', TNQryTN_ID.Value );
    JReplace( req, 'elid', m_el_id);
    JReplace( req, 'peid', GM.UserID);

    if RadioButton1.Checked then
      state := integer(tsZugesagt)
    else
    begin
      grund := ComboBox3.Items.Strings[ComboBox3.ItemIndex];
      val   := integer( ComboBox3.Items.Objects[ComboBox3.ItemIndex] );
      if val = 0 then
        state := integer(tsEntschuldigt)
      else
        state := integer(tsUnentschuldigt);
    end;
    JReplace( req, 'state', state);
    JReplace( req, 'grund', grund );
    execStatus( req );
    ShowMessage('Telnahemstatus geändert!');

    updateTo;

    PostMessage( Application.MainFormHandle, msgUpdateMeetings, 0, 0);
  end
  else
    ShowMessage('Sie sind kein Teilnehmer dieser Sitzung!');
end;

procedure TMeetingForm.BitBtn2Click(Sender: TObject);
begin
  Application.CreateForm(TMeetingPersonForm, MeetingPersonForm);
  MeetingPersonForm.PR_ID := m_pr_id;

  MeetingPersonForm.open(TNQry, OptTnQry);

  MeetingPersonForm.showModal;
  MeetingPersonForm.free;
end;

procedure TMeetingForm.changeStatus;
var
  req     : TJSONObject;
begin
  if ElTab.ReadOnly then
    exit;

  req := TJSONObject.Create;
  JReplace( req, 'prid', m_pr_id );
  JReplace( req, 'peid', GM.UserID );

  execStatus(req);
end;

procedure TMeetingForm.ComboBox1Change(Sender: TObject);
var
  i : integer;
begin
  ComboBox2.Items.Clear;

  for i := ComboBox1.ItemIndex to pred(ComboBox1.Items.Count) do
    ComboBox2.Items.Add(ComboBox1.Items.Strings[i]);

  if ComboBox2.Items.Count >= 2 then
    ComboBox2.ItemIndex := 1
  else if ComboBox2.Items.Count >0 then
    ComboBox2.ItemIndex := 0;
end;

procedure TMeetingForm.ElTabBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('EL_ID').AsInteger = 0 then
    DataSet.FieldByName('EL_ID').AsInteger := GM.autoInc('gen_el_id');
end;

procedure TMeetingForm.ElTabReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  ShowMessage(e.ToString);
end;

function TMeetingForm.execStatus(req: TJSONObject) : boolean;
var
  client : TdsMeeingClient;
  res    : TJSONObject;
begin
  client := TdsMeeingClient.Create(GM.SQLConnection1.DBXConnection);
  try
    res := client.changeStatus(req);
    Result := ShowResult( res );
  finally
    client.Free;
  end;
end;

procedure TMeetingForm.FormCreate(Sender: TObject);

  procedure setup;
  var
    ti  : TDateTime;
    i   : integer;
    off : integer;
    m   : integer;
    inx : integer;
  begin
    m   := MinutesBetween(0.0, time);
    ti  := 0.0;
    off := 0;
    inx := -1;
    for i := 1 to 24*2  do
    begin
      ComboBox1.Items.Add(FormatDateTime('hh:mm', ti));

      if (inx = -1) and ( off >= m) then
        inx := ComboBox1.Items.Count-1;

      inc(off, 30 );
      ti := IncMinute(0.0, off )
    end;
    if inx <> -1 then
      ComboBox1.ItemIndex := inx;
    ComboBox1Change(Sender);
  end;

begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  DSProviderConnection1.Open;

  PageControl1.ActivePage := TabSheet1;

  TOFrame1.init;
  TOFrame1.Connection := GM.SQLConnection1.DBXConnection;

  m_el_id     := 0;
  m_pr_id     := 0;
  m_readOnly  := false;
  m_gr        := NIL;
  m_proto     := NIL;

  setup;

  RadioButton1.Checked := true;
  BaseFrame1.OKBtn.Enabled := false;
end;

procedure TMeetingForm.FormDestroy(Sender: TObject);
begin
  if ElTab.UpdatesPending then
    ElTab.CancelUpdates;

  if Assigned(m_proto) then
    m_proto.release;
  TOFrame1.release;
end;

function TMeetingForm.GetReadOnly: boolean;
begin
  Result := m_readOnly;
end;

procedure TMeetingForm.RadioButton1Click(Sender: TObject);
begin
  ComboBox3.Text := '';
  ComboBox3.Items.Clear;
end;

procedure TMeetingForm.RadioButton2Click(Sender: TObject);
begin
  ComboBox3.Items.AddObject('Urlaub',    NIL);
  ComboBox3.Items.AddObject('Schulung',  NIL);
  ComboBox3.Items.AddObject('Krankheit', NIL);

  ComboBox3.Items.AddObject('Private',  TObject(1));
  ComboBox3.Items.AddObject('Unbekannt', TObject(1));
end;

procedure TMeetingForm.SendUpdate;
var
  client : TdsMeeingClient;
  req    : TJSONObject;
  res    : TJSONObject;
begin
  req    := TJSONObject.Create;

  JReplace( req, 'elid',  ELtab.FieldByName('EL_ID').AsInteger);
  JReplace( Req, 'prid',  m_pr_id);

  client := TdsMeeingClient.Create(GM.SQLConnection1.DBXConnection);
  try
    res := client.Sendmail( req );
    if not JBool(res, 'result') then
      ShowMessage( JString( res, 'text', 'Sendupdate: no info'));
  finally
    client.Free;
  end;
end;

procedure TMeetingForm.setELID(value: integer);
var
  st  : TStream;
  gr  : TGremium;
begin
  m_el_id := value;

  BaseFrame1.OKBtn.Enabled := false;

  if m_el_id >0  then
  begin
    ElTab.Open;

    if ElTab.Locate('EL_ID', VarArrayOf([m_el_id]), []) then
    begin
      self.ReadOnly := SameText( ElTab.FieldByName('EL_STATUS').AsString, 'c') or
          (ElTab.FieldByName('PE_ID').AsInteger <> GM.UserID);
      if not ElTab.ReadOnly then
      begin
        ELTab.Edit;

      end;
      m_pr_id := ElTab.FieldByName('PR_ID').AsInteger;

      st := ElTab.CreateBlobStream(ElTab.FieldByName('EL_DATA'), bmRead);
      EditFrame1.loadFromStream(st);
      st.Free;

      gr := GM.getGremium(ElTab.FieldByName('GR_ID').AsInteger);
      if Assigned(gr) then
        self.SetGremiumID( gr );


      updateTo;
      changeStatus;

      GroupBox4.Visible := SameText( ElTab.FieldByName('EL_STATUS').AsString, 'O');
      BaseFrame1.OKBtn.Enabled := ( m_pr_id > 0 );
    end;
  end;
end;

procedure TMeetingForm.SetGremiumID(const Value: TGremium);
begin
  m_gr := value;

  LabeledEdit1.Text := m_gr.Name;

  ProtoQry.Close;
  ProtoQry.ParamByName('ID').AsInteger := m_pr_id;
  ProtoQry.Open;
  if ProtoQry.IsEmpty then
    ShowMessage('Das Protokoll wurde nicht gefunden!');

  setReadOnly( m_readOnly );

  BaseFrame1.OKBtn.Enabled := ( m_pr_id > 0 );
end;

procedure TMeetingForm.setReadOnly(flag: Boolean);
begin
  if ElTab.FieldByName('PE_ID').AsInteger <> GM.UserID then
    flag := true;

  if flag then
  begin
    if ElTab.State <> dsBrowse then
      ElTab.Cancel;

    if ElTab.UpdatesPending then
      ElTab.Cancel;

    ElTab.ReadOnly      := true;
  end
  else
  begin
    ElTab.ReadOnly := false;
    if ElTab.State = dsBrowse then
      elTab.Edit;
  end;

  Panel2.Visible      := not flag;
  EditFrame1.ReadOnly := flag;
  BitBtn2.Visible     := not flag;
end;

procedure TMeetingForm.TGQryBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('TG_ID').IsNull then
  begin
    DataSet.FieldByName('TG_ID').AsInteger := GM.autoInc('gen_tg_id');
    DataSet.FieldByName('PR_ID').AsInteger := m_pr_id;
  end;
end;

procedure TMeetingForm.TNQryTN_STATUS_STRGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := TeilnehmerStatusToString( TTeilnehmerStatus(TNQryTN_STATUS.Value) );
end;

procedure TMeetingForm.updateTo;
var
  item    : TListItem;
  counter : array[0..3] of integer;
  i       : integer;

  procedure setGrp( id : integer );
  begin
    item.GroupID := id;
    counter[id] := counter[id] +1;
  end;
begin
  TOFrame1.PR_ID := m_pr_id;
  TOFrame1.updateContent;

  OptTnQry.Close;
  OptTnQry.ParamByName('PR_ID').AsInteger := m_pr_id;
  OptTnQry.Open;

  TNQry.Close;
  TNQry.ParamByName('PR_ID').AsInteger  := m_pr_id;
  TNQry.Open;

  LV.Items.BeginUpdate;
  LV.Items.Clear;

  for i := low(counter) to high(counter) do
    counter[i] := 0;

  while not TNQry.Eof do
  begin
    item := LV.Items.Add;
    case TTeilnehmerStatus(TNQryTN_STATUS.Value) of
      tsZugesagt      : setGrp(0);
      tsEntschuldigt  : setGrp(1);
      tsUnentschuldigt: setGrp(2);
      else
        setGrp(3);
    end;
    item.Caption := TNQryTN_NAME.Value;
    item.SubItems.Add(TNQryTN_VORNAME.Value);
    item.SubItems.Add(TNQryTN_ROLLE.Value );
    item.SubItems.Add(TNQryTN_DEPARTMENT.Value);
    item.SubItems.Add(TNQryTN_GRUND.Value );
    item.SubItems.Add(TNQryTN_READ.AsString );
    TNQry.Next;
  end;
  for i := low(counter) to high(counter) do
    LV.Groups.Items[i].Footer := LV.Groups.Items[i].Header +': '+IntToStr(Counter[i]);
  LV.Items.EndUpdate;

  LabeledEdit2.Text := IntToStr( counter[0]);
  LabeledEdit3.Text := IntToStr( counter[1]);
  LabeledEdit4.Text := IntToStr( counter[2]);
  LabeledEdit5.Text := IntToStr( counter[3]);

  TGQry.Close;
  TGQry.ParamByName('PR_ID').AsInteger := m_pr_id;
  TGQry.Open;
end;

end.

