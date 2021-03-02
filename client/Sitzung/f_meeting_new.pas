unit f_meeting_new;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBCtrls, Data.DB, Datasnap.DBClient, Datasnap.DSConnect, Vcl.Mask,
  u_gremium, Vcl.ComCtrls, JvExComCtrls, JvDateTimePicker, JvDBDateTimePicker,
  i_chapter, Vcl.Buttons, System.JSON, VirtualTrees, fr_editForm, fr_to;

type
  TMeetingForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    DSProviderConnection1: TDSProviderConnection;
    ElTab: TClientDataSet;
    ElSrc: TDataSource;
    LabeledEdit1: TLabeledEdit;
    ProtoQry: TClientDataSet;
    ProcolSrc: TDataSource;
    Label1: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    JvDBDateTimePicker1: TJvDBDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    EditFrame1: TEditFrame;
    TOFrame1: TTOFrame;
    procedure FormCreate(Sender: TObject);
    procedure ElTabBeforePost(DataSet: TDataSet);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ProtoQryAfterScroll(DataSet: TDataSet);
    procedure BaseFrame1AbortBtnClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
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
  public
    property Gremium  : TGremium read GetGremiumID write SetGremiumID;
    property EL_ID    : integer read m_el_id write setELID;
  end;

var
  MeetingForm: TMeetingForm;

function newMeeting( gr_id : integer ) : integer;

implementation

uses
  m_glob_client, system.DateUtils, u_stub, u_json, System.Generics.Collections;

{$R *.dfm}

function newMeeting( gr_id : integer ) : integer;
var
  client  : TdsMeeingClient;
  req     : TJSONObject;
  res     : TJSONObject;
begin
  Result := -1;

  req    := TJSONObject.Create;
  JReplace( req, 'grid', gr_id);

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
  if EditFrame1.changed then
  begin
    st := ElTab.CreateBlobStream(ElTab.FieldByName('EL_DATA'),bmWrite);
    EditFrame1.saveToStream(st);
  end;

  ELtab.Post;

  id := ELtab.FieldByName('EL_ID').AsInteger;

  if ELtab.UpdatesPending then
    ElTab.ApplyUpdates(0);

  SendUpdate( id );

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
  ElTab.Open;

  if m_el_id < 1 then
  begin
    ElTab.Append;
    ElTab.FieldByName('EL_DATUM').AsDateTime := now + 7;
  end
  else
  begin
    if ElTab.Locate('EL_ID', VarArrayOf([m_el_id]), []) then
    begin
      ELTab.Edit;
      st := ElTab.CreateBlobStream(ElTab.FieldByName('EL_DATA'), bmRead);
      EditFrame1.loadFromStream(st);
      st.Free;

      gr := GM.getGremium(ElTab.FieldByName('GR_ID').AsInteger);
      if Assigned(gr) then
        self.SetGremiumID( gr );
      updateTo;
    end;
  end;

  BaseFrame1.OKBtn.Enabled := ( ElTab.FieldByName('PR_ID').AsInteger > 0 );
end;

procedure TMeetingForm.SetGremiumID(const Value: TGremium);
begin
  m_gr := value;

  LabeledEdit1.Text := m_gr.Name;

  ProtoQry.ParamByName('GR_ID').AsInteger := m_gr.ID;
  ProtoQry.ParamByName('status').AsString := 'E';
  ProtoQry.Open;

  if ElTab.FieldByName('PR_ID').AsInteger = 0 then
  begin
    if ProtoQry.RecordCount > 0 then
    begin
      TOFrame1.PR_ID                        := ProtoQry.FieldByName('PR_ID').AsInteger;
      ElTab.FieldByName('PR_ID').AsInteger  := ProtoQry.FieldByName('PR_ID').AsInteger;
    end;
  end;
  BaseFrame1.OKBtn.Enabled := ( ElTab.FieldByName('PR_ID').AsInteger > 0 );
end;

procedure TMeetingForm.updateTo;
begin
  TOFrame1.PR_ID := ProtoQry.FieldByName('PR_ID').AsInteger;
  TOFrame1.updateContent;
end;

end.

