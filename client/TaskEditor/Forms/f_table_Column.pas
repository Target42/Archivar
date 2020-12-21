unit f_table_Column;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, fr_base,
  i_datafields, i_taskEdit;

type
  TTableCloumnForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    LabeledEdit3: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_table : ITaskCtrl;
    m_ctrl  : ITaskCtrl;
    procedure setTable( value : ITaskCtrl);
    procedure setCtrl( value : ITaskCtrl );
    function  getPropertyValue( name : string ) : string;
    procedure setProperty( name, value : string );
  public
    property Table   : ITaskCtrl read m_table write setTable;
    property Control : ITaskCtrl read m_ctrl write setCtrl;
  end;

var
  TableCloumnForm: TTableCloumnForm;

implementation

{$R *.dfm}

{ TTableCloumnForm }

procedure TTableCloumnForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  name : string;
begin
  if not Assigned(m_ctrl) then
    m_ctrl := m_table.NewChild('TTableField');

  setProperty('Header', Trim(LabeledEdit1.Text));
  setProperty('Width', LabeledEdit2.Text );

  name := '' ;
  if ComboBox1.ItemIndex <> -1 then
  begin
    name := ComboBox1.Items.Strings[ComboBox1.ItemIndex];
  end;

  setProperty( 'Datafield', name);
  m_ctrl.DataField := m_ctrl.Parent.DataField.Childs.getByName(name);
end;

procedure TTableCloumnForm.FormCreate(Sender: TObject);
begin
  m_table := NIL;
  m_ctrl  := NIL;
end;

procedure TTableCloumnForm.FormDestroy(Sender: TObject);
begin
  m_table := NIL;
  m_ctrl  := NIL;
end;

function TTableCloumnForm.getPropertyValue(name: string): string;
var
  p : ITaskCtrlProp;
begin
  Result := '';
  if Assigned(m_ctrl) then
  begin
    p := m_ctrl.getPropertyByName(name);
    if  Assigned(p) then
    begin
      Result := p.Value;
    end;
  end;
end;

procedure TTableCloumnForm.setCtrl(value: ITaskCtrl);
begin
  m_ctrl := value;

  if Assigned(m_ctrl) then
  begin
    LabeledEdit1.Text   := getPropertyValue('Header');
    LabeledEdit2.Text   := getPropertyValue('Width');
    ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(getPropertyValue('Datafield'));
  end;
end;

procedure TTableCloumnForm.setProperty(name, value: string);
var
  p : ITaskCtrlProp;
begin
  p := m_ctrl.getPropertyByName(name);
  if Assigned(p) then
    p.Value := value;
end;

procedure TTableCloumnForm.setTable(value: ITaskCtrl);
var
  i     : integer;
  p     : IProperty;
  s     : string;
  df    :IDataField;

begin
  m_table := value;

  LabeledEdit3.Text := m_table.DataField.Name;
  ComboBox1.Text := '';

  if SameTExt(m_table.DataField.Typ, 'linktable')  then
  begin
    p := m_table.DataField.getPropertyByName('tablename');
    if Assigned(p) then
    begin
      s:= p.Value;
      df := m_table.DataField.Owner.getByName(s);
    end;

  end
  else
    df := m_table.DataField;

  for i := 0 to pred(df.Childs.Count) do
  begin
    ComboBox1.Items.AddObject(df.Childs.Items[i].Name, TObject(i));
  end;

  ComboBox1.Items.AddObject('', TObject(-1));
end;

end.
