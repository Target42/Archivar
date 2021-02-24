unit f_meeting_new;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBCtrls, Data.DB, Datasnap.DBClient, Datasnap.DSConnect, Vcl.Mask,
  u_gremium, Vcl.ComCtrls, JvExComCtrls, JvDateTimePicker, JvDBDateTimePicker,
  i_chapter, Vcl.Buttons, System.JSON;

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
    BitBtn1: TBitBtn;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure ElTabBeforePost(DataSet: TDataSet);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    m_gr : TGremium;
    m_proto : IProtocol;

    function GetGremiumID: TGremium;
    procedure SetGremiumID(const Value: TGremium);

    procedure ShowContent( data : TJSONObject );
  public
    property Gremium : TGremium read GetGremiumID write SetGremiumID;
  end;

var
  MeetingForm: TMeetingForm;

implementation

uses
  m_glob_client, system.DateUtils, u_stub, u_json;

{$R *.dfm}

procedure TMeetingForm.BitBtn1Click(Sender: TObject);
var
  client : TdsMeeingClient;
  req    : TJSONObject;
  res    : TJSONObject;
begin
  req := TJSONObject.create;
  JReplace( req, 'prid', ProtoQry.FieldByName('PR_ID').AsInteger);

  client := TdsMeeingClient.Create(GM.SQLConnection1.DBXConnection);
  try
    res := client.GetTree(req);
    ShowContent( res );

  finally
    client.Free;
  end;
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
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  m_gr   := NIL;
  m_proto:= NIL;

  setup;

  ElTab.Open;
  ElTab.Append;
  ElTab.FieldByName('EL_DATUM').AsDateTime := now + 7;
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

procedure TMeetingForm.ShowContent(data: TJSONObject);
var
  line : string;

  procedure add( text : string );
  begin
    Memo2.Lines.Add(text);
  end;

  procedure AddChilds( arr : TJSONArray; pre : string);
  var
    nr  : integer;
    i   : integer;
    p   : string;
    row : TJSONObject;
  begin
    if not Assigned(arr) then
      exit;
    for i := 0 to pred(arr.Count) do
    begin
      row := getRow( arr, i);
      nr := JInt(row, 'nr');

      p := format('%s.%d', [pre, nr]);
      if nr > 0 then
        add(Format('%s %s', [p, JString(row, 'title')]));

      AddChilds(JArray(row, 'childs'), '  '+p);
    end;
  end;

var
  titles  : TJSONArray;
  row     : TJSONObject;
  i       : integer;
  obj     : TJSONObject;
  nr      : integer;
begin
  Memo2.Lines.Clear;
  add( JString( data, 'name'));

  titles := JArray( data, 'titles');
  if not Assigned(titles) then
    exit;

  for i := 0 to pred(titles.Count) do
  begin
    row := getRow( titles, i);
    nr := JInt(row, 'nr');

    line := Format('%d %s', [nr, JString( row, 'title')]);
    add(line);
    obj := JObject( row, 'childs');
    AddChilds( JArray( obj, 'childs'), '  '+IntToStr(nr));
  end;
end;

end.
