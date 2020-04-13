unit f_datafield_edit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.ValEdit, fr_base, Data.DB, i_datafields;

type
  TDatafieldEditform = class(TForm)
    BaseFrame1: TBaseFrame;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    VE: TValueListEditor;
    LabeledEdit1: TLabeledEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    LabeledEdit2: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure VEKeyPress(Sender: TObject; var Key: Char);
    procedure VEExit(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_tab      : TDataSet;
    m_data     : IDataField;
    m_noChange : Boolean;
    procedure setDataSet( dataset :TDataSet );

    function  getDataField : IDataField;
    procedure setDataField(const Value: IDataField);
    procedure setProps;
  public
    property DataSet : TDataSet write setDataSet;
    property DataField : IDataField read getDataField write setDataField;
  end;

var
  DatafieldEditform: TDatafieldEditform;

implementation

uses
  u_DataFieldImpl, m_glob_client, win.comObj;

{$R *.dfm}

procedure TDatafieldEditform.BaseFrame1OKBtnClick(Sender: TObject);
var
  st : TStream;
begin
  m_data.Name := trim(LabeledEdit1.Text);
  m_data.Rem  := LabeledEdit2.Text;

  if Assigned(m_tab) then
  begin
    m_tab.FieldByName('DA_NAME').AsString := m_data.Name;
    m_tab.FieldByName('DA_TYPE').AsString := m_data.Typ;
    m_tab.FieldByName('DA_REM').AsString := m_data.Rem;

    st := m_tab.CreateBlobStream( m_tab.FieldByName('DA_PROPS'), bmWrite );
    m_data.saveToStream(st);
    st.Free;
  end;
end;

procedure TDatafieldEditform.ComboBox1Change(Sender: TObject);
begin
  if m_noChange or not Assigned(m_data) or (ComboBox1.ItemIndex = -1) then
    exit;
  m_data.Typ := ComboBox1.Items.Strings[ ComboBox1.ItemIndex ];
  setProps;
end;

procedure TDatafieldEditform.FormCreate(Sender: TObject);
begin
  m_noChange := true;
  m_data := NIL;
  DataTypeFillList( ComboBox1.Items );
end;

procedure TDatafieldEditform.FormDestroy(Sender: TObject);
begin
  m_data.Release;
  m_data := NIL;
end;

function TDatafieldEditform.getDataField: IDataField;
begin
  Result := m_data;
end;

procedure TDatafieldEditform.setDataField(const Value: IDataField);
begin
  m_data := value;
  if not Assigned(m_data) then
    exit;

  m_noChange := true;

  LabeledEdit1.Text   := m_data.Name;
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(m_data.Typ);
  LabeledEdit2.Text   := m_data.Rem;

  setProps;

  m_noChange := false;
end;

procedure TDatafieldEditform.setDataSet(dataset: TDataSet);
var
  st : TStream;
  ds : IDataField;
begin
  m_tab := dataset;

  if m_tab.State = dsInsert then
  begin
    m_tab.FieldByName('DA_ID').AsInteger  := GM.autoInc('GEN_DA_ID');
    m_tab.FieldByName('DA_NAME').AsString := 'NeuesDatenfeld';
    m_tab.FieldByName('DA_TYPE').AsString := 'String';
    m_tab.FieldByName('DA_CLID').AsString := CreateClassID;
  end;

  ds := TDataField.create( m_tab.FieldByName('DA_NAME').AsString,
    m_tab.FieldByName('DA_TYPE').AsString);

  st := m_tab.CreateBlobStream(m_tab.FieldByName('DA_PROPS'), bmRead );
  ds.loadFromStream(st);

  ds.CLID := m_tab.FieldByName('DA_CLID').AsString;
  ds.Rem  := m_tab.FieldByName('DA_REM').AsString;
  ds.isGlobal := true;

  setDataField(ds);

  st.Free;
end;

procedure TDatafieldEditform.setProps;
var
  i   : Integer;
  p   : IProperty;
  ip  : TItemProp;
begin
  if not Assigned(m_data) then
    exit;

  VE.Strings.Clear;
  for i := 0 to pred(m_data.Items.Count) do
  begin
    p := m_data.Items.Items[i];
    VE.InsertRow(p.Name, p.Value, true);
    ip := VE.ItemProps[p.Name];
    if Assigned(ip) then
    begin
      if p.isList then
      begin
        ip.EditStyle := esPickList;
        p.fillList(ip.PickList);
        ip.ReadOnly := true;
      end;
    end;
  end;
end;

procedure TDatafieldEditform.VEExit(Sender: TObject);
var
  row       : Integer;
  val, key  : string;
  p         : IProperty;
begin
  if not Assigned(m_data) then
    exit;
  row := VE.Row;
  val := VE.Cells[1, row];
  key := VE.Keys[row];
  p := m_data.getPropertyByName(key);
  if  Assigned(p) then
  begin
    p.Value := val;
    VE.Cells[1,row] := p.Value;
  end;
end;

procedure TDatafieldEditform.VEKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    VEExit(Sender);
  end;

end;

end.
