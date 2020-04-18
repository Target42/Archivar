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
    CheckBox1: TCheckBox;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure VEKeyPress(Sender: TObject; var Key: Char);
    procedure VEExit(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
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
  u_DataFieldImpl, m_glob_client, win.comObj, f_tableField_editor,
  u_DataField2XML;

{$R *.dfm}

procedure TDatafieldEditform.BaseFrame1OKBtnClick(Sender: TObject);
var
  st : TStream;
  xw : TDataField2XML;
begin
  m_data.Name := trim(LabeledEdit1.Text);
  m_data.Rem  := LabeledEdit2.Text;
  m_data.Required := CheckBox1.Checked;

  if Assigned(m_tab) then
  begin
    xw :=  TDataField2XML.create;
    m_tab.FieldByName('DA_NAME').AsString := m_data.Name;
    m_tab.FieldByName('DA_TYPE').AsString := m_data.Typ;
    m_tab.FieldByName('DA_REM').AsString := m_data.Rem;

    st := m_tab.CreateBlobStream( m_tab.FieldByName('DA_PROPS'), bmWrite );
    xw.saveToStream(m_data, st);
    xw.Free;
    st.Free;
  end;
end;

procedure TDatafieldEditform.Button1Click(Sender: TObject);
var
  TableFieldEditorForm : TTableFieldEditorForm;
begin
  try
    Application.CreateForm(TTableFieldEditorForm, TableFieldEditorForm);
    TableFieldEditorForm.Root := m_data;
    TableFieldEditorForm.ShowModal;
  finally
    TableFieldEditorForm.free;
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
  if Assigned(m_tab) then
    m_data.Release;
  m_data := NIL;
end;

function TDatafieldEditform.getDataField: IDataField;
begin
  Result := m_data;
end;

procedure TDatafieldEditform.LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key < ' '  then
    exit;

  if key = ' ' then
    key := '_';

 if not CharInSet(key, ['a'..'z', 'A'..'Z', '_', '0'..'9']) then
   Key := #0;
end;

procedure TDatafieldEditform.setDataField(const Value: IDataField);
begin
  m_data := value;

  if not Assigned(m_data) then
    exit;

  m_noChange := true;

  ComboBox1.Text      := '';
  LabeledEdit1.Text   := m_data.Name;
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(m_data.Typ);
  LabeledEdit2.Text   := m_data.Rem;
  CheckBox1.Checked   := m_data.Required;

  setProps;
  if (m_data.isGlobal and not Assigned(m_tab)) or ( ComboBox1.ItemIndex = -1 ) then
  begin
    ComboBox1.Enabled := false;
    CheckBox1.Enabled := false;
  end;

  m_noChange := false;
end;

procedure TDatafieldEditform.setDataSet(dataset: TDataSet);
var
  st : TStream;
  ds : IDataField;
  xw : TDataField2XML;
begin
  m_tab := dataset;
  xw := TDataField2XML.create;

  if m_tab.State = dsInsert then
  begin
    m_tab.FieldByName('DA_ID').AsInteger  := GM.autoInc('GEN_DA_ID');
    m_tab.FieldByName('DA_NAME').AsString := 'NeuesDatenfeld';
    m_tab.FieldByName('DA_TYPE').AsString := 'String';
    m_tab.FieldByName('DA_CLID').AsString := CreateClassID;
  end;

  st := m_tab.CreateBlobStream(m_tab.FieldByName('DA_PROPS'), bmRead );
  ds := xw.loadFromStream(st);

  ds.CLID := m_tab.FieldByName('DA_CLID').AsString;
  ds.Rem  := m_tab.FieldByName('DA_REM').AsString;
  ds.isGlobal := true;

  setDataField(ds);

  xw.Free;
  st.Free;
end;

procedure TDatafieldEditform.setProps;
var
  i   : Integer;
  p   : IProperty;
  ip  : TItemProp;
begin
  VE.Strings.Clear;
  if not Assigned(m_data) then
    exit;

  Button1.Visible := m_data.Typ = 'table';
  VE.Enabled := (not m_data.isGlobal) or (m_data.isGlobal and Assigned(m_tab));

  for i := 0 to pred(m_data.Properties.Count) do
  begin
    p := m_data.Properties.Items[i];
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
