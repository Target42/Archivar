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
    BitBtn4: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
  private
    m_table : ITaskCtrl;
    m_df    : IDataField;
    procedure setTable( value : ITaskCtrl );

    procedure updateView;
    function  getPropertyValue( ctrl : ITaskCtrl; name : string ) : string;
    procedure setPropertyValue(ctrl : ITaskCtrl; name, value: string);

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

procedure TTableColumnsForm.BitBtn3Click(Sender: TObject);
var
  ctrl: ITaskCtrl;
  i   : integer;
begin
  if not Assigned(LV.Selected) then
    exit;
  ctrl := ITaskCtrl(LV.Selected.Data);
  for i := 0 to pred(m_table.Childs.Count) do
  begin
    if m_table.Childs.Items[i] = ctrl then
    begin
      m_table.Childs.Delete(i);
      ctrl.release;
      break;
    end;
  end;
  updateView;
end;

procedure TTableColumnsForm.BitBtn4Click(Sender: TObject);
var
  i : integer;
  ctrl: ITaskCtrl;
begin
  if not Assigned(m_table) or  not Assigned(m_df) then
    exit;

  for i := 0 to pred(m_df.Childs.Count) do
  begin
    ctrl := m_table.findCtrl(m_df.Childs.Items[i].Name);
    if not Assigned( ctrl ) then
    begin
      ctrl := m_table.NewChild('TTableField');
      setPropertyValue(ctrl, 'Header',    m_df.Childs.Items[i].Name);
      setPropertyValue(ctrl, 'Width',     '100' );
      setPropertyValue(ctrl, 'Datafield',m_df.Childs.Items[i].Name);
      ctrl.DataField := m_df.Childs.Items[i];
    end;
  end;
  updateView;
end;

procedure TTableColumnsForm.FormCreate(Sender: TObject);
begin
  m_table := NIL;
  m_df    := NIL;
end;

procedure TTableColumnsForm.FormDestroy(Sender: TObject);
begin
  m_table := NIL;
  m_df    := NIL;
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

procedure TTableColumnsForm.LVDblClick(Sender: TObject);
begin
  BitBtn2.Click;
end;

procedure TTableColumnsForm.setPropertyValue(ctrl: ITaskCtrl; name,
  value: string);
var
  p : ITaskCtrlProp;
begin
  p := ctrl.getPropertyByName(name);
  if Assigned(p) then
    p.Value := value;
end;

procedure TTableColumnsForm.setTable(value: ITaskCtrl);
var
  p     : IProperty;
begin
  m_table := value;

  if SameTExt(m_table.DataField.Typ, 'linktable')  then
  begin
    p := m_table.DataField.getPropertyByName('tablename');
    if Assigned(p) then
      m_df := m_table.DataField.Owner.getByName(p.Value);
  end
  else
    m_df := m_table.DataField;

  updateView;
end;

procedure TTableColumnsForm.SpeedButton1Click(Sender: TObject);
var
  ctrl : ITaskCtrl;
begin
  if not Assigned(LV.Selected) then  exit;

  ctrl := ITaskCtrl(LV.Selected.Data);
  ctrl.up;

  updateView;
end;

procedure TTableColumnsForm.SpeedButton2Click(Sender: TObject);
var
  ctrl : ITaskCtrl;
begin
  if not Assigned(LV.Selected) then  exit;

  ctrl := ITaskCtrl(LV.Selected.Data);
  ctrl.down;

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

  LV.Items.BeginUpdate;
  if Assigned(LV.Selected) then
    old := ITaskCtrl(LV.Selected.Data);

  LV.Items.Clear;
  len := LV.Canvas.TextWidth( LV.Columns[0].Caption) + 8;

  for i := 0 to pred(m_table.Childs.Count) do
  begin
    item := LV.Items.Add;
    ctrl := m_table.Childs.Items[i];

    item.Data    := ctrl;
    item.Caption := getPropertyValue(ctrl, 'Header');
    item.SubItems.Add( getPropertyValue(ctrl, 'Width'));
    item.SubItems.Add( getPropertyValue(ctrl, 'DataField'));

    w := LV.Canvas.TextWidth(item.Caption) +8;
    if w > len then
      len := w;
    if old = ctrl then
      LV.Selected := item;

  end;
  LV.Columns[0].Width := len;
  LV.Items.EndUpdate;
end;

end.
