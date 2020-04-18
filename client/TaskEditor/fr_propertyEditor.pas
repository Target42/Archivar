unit fr_propertyEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit,
  Vcl.ExtCtrls, i_taskEdit;

type
  TFrame1 = class(TFrame)
    Panel1: TPanel;
    VE: TValueListEditor;
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

procedure TFrame1.setCrtl(value: ITaskCtrl);
begin
  m_ctrl := value;

  updateProps;
end;

procedure TFrame1.updateProps;
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

end.
