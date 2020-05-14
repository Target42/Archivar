unit f_tableColumns;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, i_datafields, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls, i_taskEdit;

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
    procedure BitBtn2Click(Sender: TObject);
  private
    m_table : ITaskCtrl;
    procedure setTable( value : ITaskCtrl );

    procedure updateView;
    function  getPropertyValue( ctrl : ITaskCtrl; name : string ) : string;
  public
    property Table : ITaskCtrl read m_table write setTable;
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
  if TableCloumnForm.ShowModal = mrOk then
    updateView;
  TableCloumnForm.Free;
end;

procedure TTableColumnsForm.BitBtn2Click(Sender: TObject);
var
  TableCloumnForm : TTableCloumnForm;
begin
  if not Assigned(LV.Selected) then
    exit;

  Application.CreateForm(TTableCloumnForm, TableCloumnForm);
  TableCloumnForm.Table := m_table;
  TableCloumnForm.Control := ITaskCtrl(LV.Selected.Data);

  if TableCloumnForm.ShowModal = mrOk then
    updateView;
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

function TTableColumnsForm.getPropertyValue(ctrl: ITaskCtrl;
  name: string): string;
var
  p : ITaskCtrlProp;
begin
  Result := '';
  if not Assigned(ctrl) then
    exit;
  p := ctrl.getPropertyByName(name);
  if Assigned(p) then
    Result := p.Value;

end;

procedure TTableColumnsForm.setTable(value: ITaskCtrl);
begin
  m_table := value;

  updateView;
end;

procedure TTableColumnsForm.updateView;
var
  old  : ITaskCtrl;
  i    : integer;
  ctrl : ITaskCtrl;
  item : TListItem;
  len, w : integer;
begin
  old := NIL;
  len := LV.Columns[0].Width;
  LV.Items.BeginUpdate;
  if Assigned(LV.Selected) then
    old := ITaskCtrl(LV.Selected.Data);
  LV.Items.Clear;
  w := 0;
  for i := 0 to pred(m_table.Childs.Count) do
  begin
    item := LV.Items.Add;
    ctrl := m_table.Childs.Items[i];

    item.Data := ctrl;
    item.Caption := getPropertyValue(ctrl, 'Header');
    item.SubItems.Add( getPropertyValue(ctrl, 'Width'));
    item.SubItems.Add( getPropertyValue(ctrl, 'DataField'));

    w := LV.Canvas.TextWidth(item.Caption) +8;
    if w > len then
      len := w;
    if old = ctrl then
      LV.Selected := item;

  end;
  LV.Columns[0].Width := w;
  LV.Items.EndUpdate;
end;

end.
