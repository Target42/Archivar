unit fr_propertyEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit,
  Vcl.ExtCtrls, i_taskEdit, i_datafields;

type
  TPropertyChanged = procedure of object;

type
  TPropertyFrame = class(TFrame)
    VE: TValueListEditor;
    procedure VEKeyPress(Sender: TObject; var Key: Char);
    procedure VEExit(Sender: TObject);
    procedure VEEditButtonClick(Sender: TObject);
    procedure VEStringsChange(Sender: TObject);


  private
    m_ctrl        : ITaskCtrl;
    m_data        : IDataFieldList;
    m_pchanged    : TPropertyChanged;
    m_updateFlag  : boolean;

    procedure setCrtl( value : ITaskCtrl );
    procedure setDataFields( value : IDataFieldList );

    procedure doInform(event : TDataListChangeType; value : IDataField);

    procedure CheckFields(val : string );
    procedure setProperty( ctrl: ITaskCtrl; name, value : string );
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

procedure TPropertyFrame.CheckFields(val : string );
var
  s     : string;
  df    : IDataField;
  p     : IProperty;
  i     : integer;
  ctrl  : ITaskCtrl;
begin
  df := m_ctrl.DataField;
  if Assigned(df) then
  begin
    if SameText(df.Typ, 'linktable') then
    begin
      p := df.getPropertyByName('tablename');
      if Assigned(p) then
      begin
        s:= p.Value;
        df := df.Owner.getByName(s);
      end;
      if m_ctrl.Childs.Count = 0  then
      begin
        for i:= 0 to pred(df.Childs.Count) do
        begin
          ctrl := m_ctrl.NewChild('TTableField');
          setProperty(ctrl, 'Header', df.Childs.Items[i].Name);
          setProperty(ctrl, 'Width', '100');
          setProperty( ctrl, 'Datafield', df.Childs.Items[i].Name);
          ctrl.DataField := df.Childs.Items[i];
        end;
      end;
    end;
  end;
end;

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
  m_updateFlag := false;
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

procedure TPropertyFrame.setProperty(ctrl : ITaskCtrl; name, value: string);
var
  p : ITaskCtrlProp;
begin
  p := ctrl.getPropertyByName(name);
  if Assigned(p) then
    p.Value := value;
end;

procedure TPropertyFrame.updateProps;
var
  i   : Integer;
  p   : ITaskCtrlProp;
  ip  : TItemProp;
begin
  m_updateFlag := true;
  VE.Strings.Clear;

  if not Assigned(m_ctrl) then
  begin
    m_updateFlag := false;
    exit;
  end;

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

      if p.hasEditor then
      begin
        ip.EditStyle := esEllipsis;
        ip.ReadOnly := true;
        VE.Values[ p.Name ] := '(...)';
      end;
    end;
  end;
  m_updateFlag := false;
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

procedure TPropertyFrame.VEStringsChange(Sender: TObject);
var
  p   : ITaskCtrlProp;
  key, val : string;
begin
  if m_updateFlag then
    exit;

  key := VE.Keys[ VE.Row];
  val := VE.Values[key];

  p := Ctrl.getPropertyByName(key);
  if Assigned(p) then
  begin
    if not p.hasEditor then
      p.Value := val;
    if SameText( p.Typ, 'TaskDataField') then
      CheckFields(val);
  end;

  if (m_ctrl.Typ = ctTable) or ( m_ctrl.Typ = ctTableField) then
    m_ctrl.updateControl;
  if SameText(key, 'name') and Assigned(m_pchanged) then
    m_pchanged;

end;

end.
