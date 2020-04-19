unit fr_propertyEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit,
  Vcl.ExtCtrls, i_taskEdit, Vcl.StdCtrls;

type
  TPropertyFrame = class(TFrame)
    Panel1: TPanel;
    VE: TValueListEditor;
    ComboBox1: TComboBox;
    Label1: TLabel;
    procedure VEKeyPress(Sender: TObject; var Key: Char);
    procedure VEExit(Sender: TObject);
  private
    m_ctrl : ITaskCtrl;

    procedure setCrtl( value : ITaskCtrl );
    procedure updateProps;
  public
    property Ctrl : ITaskCtrl read m_ctrl write setCrtl;
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TPropertyFrame.setCrtl(value: ITaskCtrl);
begin
  m_ctrl := value;

  updateProps;
end;

procedure TPropertyFrame.updateProps;
var
  i   : Integer;
  p   : ITaskCtrlProp;
  ip  : TItemProp;
begin
  VE.Strings.Clear;

  if not Assigned(m_ctrl) then
    exit;

  for i := 0 to pred(m_ctrl.Props.Count) do
  begin
    p := m_ctrl.Props.Items[i];
    VE.InsertRow(p.Name, p.Value, true);
    ip := VE.ItemProps[p.Name];
    if Assigned(ip) then
    begin
      if p.isList then
      begin
        ip.EditStyle := esPickList;
        p.fillPickList(ip.PickList);
        ip.ReadOnly := true;
      end;
    end;
  end;
end;

procedure TPropertyFrame.VEExit(Sender: TObject);
var
  row       : Integer;
  val, key  : string;
  p         : ITaskCtrlProp;
begin
  if not Assigned(m_ctrl) then
    exit;

  row := VE.Row;
  val := VE.Cells[1, row];
  key := VE.Keys[row];
  p := m_ctrl.getPropertyByName(key);
  if  Assigned(p) then
  begin
    p.Value := val;
    VE.Cells[1,row] := p.Value;
  end;
end;

procedure TPropertyFrame.VEKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    VEExit(Sender);
  end;
end;

end.
