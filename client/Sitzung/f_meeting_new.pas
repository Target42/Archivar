unit f_meeting_new;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBCtrls, Data.DB, Datasnap.DBClient, Datasnap.DSConnect, Vcl.Mask,
  u_gremium, Vcl.ComCtrls, JvExComCtrls, JvDateTimePicker, JvDBDateTimePicker,
  i_chapter;

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
    Memo1: TMemo;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ElTabBeforePost(DataSet: TDataSet);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
    m_gr : TGremium;
    m_proto : IProtocol;

    function GetGremiumID: TGremium;
    procedure SetGremiumID(const Value: TGremium);
  public
    property Gremium : TGremium read GetGremiumID write SetGremiumID;
  end;

var
  MeetingForm: TMeetingForm;

implementation

uses
  m_glob_client, system.DateUtils;

{$R *.dfm}

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
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  m_gr   := NIL;
  m_proto:= NIL;

  setup;

  ElTab.Open;
  ElTab.Append;
end;

procedure TMeetingForm.FormDestroy(Sender: TObject);
begin
  if Assigned(m_proto) then
    m_proto.release;
end;

function TMeetingForm.GetGremiumID: TGremium;
begin
  Result := m_gr;
end;

procedure TMeetingForm.SetGremiumID(const Value: TGremium);
begin
  m_gr := value;
  LabeledEdit1.Text := m_gr.Name;

  ProtoQry.ParamByName('GR_ID').AsInteger := m_gr.ID;
  ProtoQry.ParamByName('status').AsString := 'E';
  ProtoQry.Open;
end;

end.
