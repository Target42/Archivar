unit f_table_Column;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, fr_base,
  i_datafields;

type
  TTableCloumnForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_table : IDataField;
    procedure setTable( value : IDataField);
  public
    property Table : IDataField read m_table write setTable;
  end;

var
  TableCloumnForm: TTableCloumnForm;

implementation

{$R *.dfm}

{ TTableCloumnForm }

procedure TTableCloumnForm.FormCreate(Sender: TObject);
begin
  m_table := NIL;
end;

procedure TTableCloumnForm.FormDestroy(Sender: TObject);
begin
  m_table := NIL;
end;

procedure TTableCloumnForm.setTable(value: IDataField);
var
  i : integer;
begin
  m_table := value;
  ComboBox1.Text := '';
  for i := 0 to pred(m_table.Childs.Count) do
  begin
    ComboBox1.Items.AddObject(m_table.Childs.Items[i].Name, TObject(i));
  end;
  ComboBox1.Items.AddObject('', TObject(-1));

end;

end.
