unit f_tableColumns;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, i_datafields, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TTableColumnsForm = class(TForm)
    BaseFrame1: TBaseFrame;
    Panel1: TPanel;
    LV: TListView;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    m_table : IDataField;
    procedure setDataField( value : IDataField );
  public
    property DataField : IDataField read m_table write setDataField;
  end;

var
  TableColumnsForm: TTableColumnsForm;

implementation

uses
  f_table_Column;

{$R *.dfm}

procedure TTableColumnsForm.BitBtn1Click(Sender: TObject);
var
  TableCloumnForm : TTableCloumnForm;
begin
  Application.CreateForm(TTableCloumnForm, TableCloumnForm);
  TableCloumnForm.Table := m_table;
  TableCloumnForm.ShowModal;
  TableCloumnForm.Free;
end;

procedure TTableColumnsForm.FormCreate(Sender: TObject);
begin
  m_table := NIL;
end;

procedure TTableColumnsForm.FormDestroy(Sender: TObject);
begin
  m_table := NIL;
end;

procedure TTableColumnsForm.setDataField(value: IDataField);
begin
  m_table := value;

end;

end.
