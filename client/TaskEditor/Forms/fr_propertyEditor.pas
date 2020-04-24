unit fr_propertyEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit,
  Vcl.ExtCtrls, i_taskEdit, Vcl.StdCtrls, i_datafields;

type
  TPropertyChanged = procedure of object;

type
  TPropertyFrame = class(TFrame)
    VE: TValueListEditor;
    procedure VEKeyPress(Sender: TObject; var Key: Char);
    procedure VEExit(Sender: TObject);
    procedure VEEditButtonClick(Sender: TObject);


  private
    m_ctrl : ITaskCtrl;
    m_data : IDataFieldList;
    m_pchanged : TPropertyChanged;

    procedure setCrtl( value : ITaskCtrl );
    procedure setDataFields( value : IDataFieldList );

    procedure doInform(event : TDataListChangeType; value : IDataField);
  public
    property DataFields : IDataFieldList write setDataFields;
    property Ctrl : ITaskCtrl read m_ctrl write setCrtl;
    property PropertyChanged : TPropertyChanged read m_pchanged write m_pchanged;

    procedure init;
    procedure release;

    procedure updateProps;
  end;

implementation


{$R *.dfm}

{ TFrame1 }

procedure TPropertyFrame.doInform(event: TDataListChangeType;
  value: IDataField);
begin
  updateProps;
end;


procedure TPropertyFrame.init;
begin
  m_ctrl := NIL;
  m_data := NIL;
  m_pchanged := NIL;
end;

procedure TPropertyFrame.release;
begin
  if Assigned(m_data) then
    m_data.UnregisterListener(doInform);
end;

procedure TPropertyFrame.setCrtl(value: ITaskCtrl);
begin
  m_ctrl := value;

  updateProps;
end;

procedure TPropertyFrame.setDataFields(value: IDataFieldList);
begin
  if Assigned(m_data) then
    m_data.UnregisterListener(doInform);

  m_data := value;
  m_data.RegisterListener(doInform);

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
      end
      else if p.hasEditor then
      begin
        ip.EditStyle := esEllipsis;
        ip.ReadOnly := true;
        VE.Values[ p.Name ] := '(...)';
      end;
    end;
  end;
end;

procedure TPropertyFrame.VEEditButtonClick(Sender: TObject);
var
  row  : Integer;
  key  : string;
  p    : ITaskCtrlProp;
begin
  if not Assigned(m_ctrl) then
    exit;

  row := VE.Row;
  key := VE.Keys[row];
  p := m_ctrl.getPropertyByName(key);
  if  Assigned(p) then
  begin
    p.ShowEditor;
    VE.Cells[1,row] := '(...)';
  end;

  if SameText(key, 'name') and Assigned(m_pchanged) then
    m_pchanged;
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
    if not p.hasEditor then
    begin
      p.Value := val;
      VE.Cells[1,row] := p.Value;
    end;
  end;
  if SameText(key, 'name') and Assigned(m_pchanged) then
    m_pchanged;
end;

procedure TPropertyFrame.VEKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    VEExit(Sender);
  end;
end;

end.
