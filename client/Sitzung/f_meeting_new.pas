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
    GroupBox4: TGroupBox;
    DBGrid1: TDBGrid;
    TNSrc: TDataSource;
    TNQryEL_ID: TIntegerField;
    TNQryPE_ID: TIntegerField;
    TNQryEP_STATUS: TWideStringField;
    TNQryEP_READ: TDateTimeField;
    TNQryPR_ID: TIntegerField;
    TNQryTN_ID: TIntegerField;
    TNQryTN_NAME: TWideStringField;
    TNQryTN_VORNAME: TWideStringField;
    TNQryTN_DEPARTMENT: TWideStringField;
    TNQryTN_ROLLE: TWideStringField;
    TNQryTN_STATUS: TIntegerField;
    TNQryTN_GRUND: TWideStringField;
    TNQryTN_STATUS_STR: TStringField;
    BitBtn1: TBitBtn;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label5: TLabel;
    ComboBox3: TComboBox;
    TabSheet3: TTabSheet;
    DBGrid2: TDBGrid;
    TGQry: TClientDataSet;
    TGSrc: TDataSource;
    DBEdit1: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure ElTabBeforePost(DataSet: TDataSet);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ProtoQryAfterScroll(DataSet: TDataSet);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure TNQryTN_STATUS_STRGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure ElTabReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private-Deklarationen }
    m_el_id : integer;
    m_gr    : TGremium;
    m_proto : IProtocol;

    function GetGremiumID: TGremium;
    procedure SetGremiumID(const Value: TGremium);

    procedure SendUpdate( id : integer );
    procedure setELID( value : integer );
    procedure updateTo;
    procedure changeStatus;

    function execStatus( req : TJSONObject ) : boolean;

    procedure setReadOnly( flag :Boolean );
  public
    property Gremium  : TGremium read GetGremiumID write SetGremiumID;
    property EL_ID    : integer read m_el_id write setELID;
  end;

var
  MeetingForm: TMeetingForm;

function newMeeting( gr_id, pr_id : integer ) : integer;
function DeleteMeeting( id : integer ) : boolean;

implementation

uses
  m_glob_client, system.DateUtils, u_stub, u_json, System.Generics.Collections,
  f_abwesenheit;

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
  id  : integer;
  st  : TStream;
begin

  if EditFrame1.changed and not ElTab.ReadOnly then
  begin
    st := ElTab.CreateBlobStream(ElTab.FieldByName('EL_DATA'),bmWrite);
    EditFrame1.saveToStream(st);
    st.Free;
  end;
  ELtab.Post;

  id := ELtab.FieldByName('EL_ID').AsInteger;

  if ELtab.UpdatesPending then
    ElTab.ApplyUpdates(0);

  SendUpdate( id );
end;

procedure TMeetingForm.BitBtn1Click(Sender: TObject);
var
  req   : TJSONObject;
  val   : integer;
  grund : string;
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
    JReplace( req, 'tnid',  TNQryTN_ID.Value );
    if RadioButton1.Checked then
      JReplace( req, 'state', integer(tsZugesagt) )
    else
    begin
      grund := ComboBox3.Items.Strings[ComboBox3.ItemIndex];
      val   := integer( ComboBox3.Items.Objects[ComboBox3.ItemIndex] );
      if val = 0 then
        JReplace( req, 'state', integer(tsEntschuldigt) )
      else
        JReplace( req, 'state', integer(tsUnentschuldigt) );
    end;
    JReplace( req, 'grund', grund );
    execStatus( req );

    TNQry.Refresh;
  end
  else
    ShowMessage('Sie sind kein Teilnehmer dieser Sitzung!');
end;

procedure TMeetingForm.changeStatus;
var
  req     : TJSONObject;
begin
  if ElTab.ReadOnly then
    exit;

  req := TJSONObject.Create;
  JReplace( req, 'elid', m_el_id);
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

procedure TMeetingForm.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  col : TColor;
begin
  case TTeilnehmerStatus(TNQryTN_STATUS.Value) of
    tsZugesagt      : col := clGreen;
    tsEntschuldigt  : col := clBlue;
    tsUnentschuldigt: col := clRed;
    else
      col := clWindowText;
  end;
  DBGrid1.Canvas.Font.Color:= col;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
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
    Result := JBool(res, 'result');
    if not  Result then
      ShowMessage( JString( res, 'text'));
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
  TOFrame1.init;
  m_el_id := 0;

  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  DSProviderConnection1.Open;

  TOFrame1.Connection := GM.SQLConnection1.DBXConnection;

  m_gr   := NIL;
  m_proto:= NIL;

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

function TMeetingForm.GetGremiumID: TGremium;
begin
  Result := m_gr;
end;

procedure TMeetingForm.ProtoQryAfterScroll(DataSet: TDataSet);
begin
  updateTo;
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

procedure TMeetingForm.SendUpdate(id: integer);
var
  client : TdsMeeingClient;
  req    : TJSONObject;
  res    : TJSONObject;
begin
  req    := TJSONObject.Create;
  JReplace( req, 'id', id);
  JReplace( Req, 'grid', m_gr.ID);

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
      ELTab.ReadOnly := SameText( ElTab.FieldByName('EL_STATUS').AsString, 'c');

      if not ElTab.ReadOnly then
      begin
        ELTab.Edit;
      end;

      st := ElTab.CreateBlobStream(ElTab.FieldByName('EL_DATA'), bmRead);
      EditFrame1.loadFromStream(st);
      st.Free;


      gr := GM.getGremium(ElTab.FieldByName('GR_ID').AsInteger);
      if Assigned(gr) then
        self.SetGremiumID( gr );

      updateTo;

      changeStatus;

      GroupBox4.Enabled := not ElTab.ReadOnly;

      BaseFrame1.OKBtn.Enabled := ( ElTab.FieldByName('PR_ID').AsInteger > 0 );
    end;
  end;
end;

procedure TMeetingForm.SetGremiumID(const Value: TGremium);
begin
  m_gr := value;

  LabeledEdit1.Text := m_gr.Name;

  ProtoQry.ParamByName('GR_ID').AsInteger := m_gr.ID;
  ProtoQry.Open;

  if ElTab.FieldByName('PR_ID').AsInteger = 0 then
  begin
    if ProtoQry.RecordCount > 0 then
    begin
      TOFrame1.PR_ID                        := ProtoQry.FieldByName('PR_ID').AsInteger;
      ElTab.FieldByName('PR_ID').AsInteger  := ProtoQry.FieldByName('PR_ID').AsInteger;
    end;
  end
  else
    ProtoQry.Locate('PR_ID', VarArrayOf([ElTab.FieldByName('PR_ID').AsInteger]), []);

  setReadOnly( ElTab.FieldByName('EL_STATUS').AsString <> 'E' );

  BaseFrame1.OKBtn.Enabled := ( ElTab.FieldByName('PR_ID').AsInteger > 0 );
end;

procedure TMeetingForm.setReadOnly(flag: Boolean);
begin
  EditFrame1.ReadOnly := flag;
end;

procedure TMeetingForm.TNQryTN_STATUS_STRGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := TeilnehmerStatusToString( TTeilnehmerStatus(TNQryTN_STATUS.Value) );
end;

procedure TMeetingForm.updateTo;
begin
  TOFrame1.PR_ID := ProtoQry.FieldByName('PR_ID').AsInteger;
  TOFrame1.updateContent;

  TNQry.Close;
  TNQry.ParamByName('EL_ID').AsInteger  := m_el_id;
  TNQry.ParamByName('PR_ID').AsInteger  := ElTab.FieldByName('PR_ID').AsInteger;
  TNQry.Open;

  TGQry.Close;
  TGQry.ParamByName('PR_ID').AsInteger := ElTab.FieldByName('PR_ID').AsInteger;
  TGQry.Open;

end;

end.

