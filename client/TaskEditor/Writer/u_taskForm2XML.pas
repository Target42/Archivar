unit u_taskForm2XML;

interface

uses
  i_taskEdit, xsd_TaskData, System.Classes;

type
  TTaskForm2XML = class
    private
      m_xList: IXMLList;

      procedure SaveControl( ctrl : ITaskCtrl );
      procedure SaveTable( ctrl : ITaskCtrl );

      procedure doLoad( form : ITaskForm);
      procedure loadTable( xTab : IXMLTable; form : ITaskForm);

    public
      constructor create;
      Destructor Destroy; override;

      procedure fromText( text : string; form : ITaskForm );
      procedure load( name : string; form : ITaskForm ); overload;
      procedure load( st : TStream ; form : ITaskForm ); overload;

      function  save( name : string; form : ITaskForm ) : Boolean; overload;
      function  save( st : TStream; form : ITaskForm ) : boolean; overload;

      function  getXML(form : ITaskForm ) : IXMLList;
  end;

implementation

uses
  System.Generics.Collections, System.SysUtils, Xml.XMLIntf, Xml.XMLDoc;

{ TTaskForm2XML }

constructor TTaskForm2XML.create;
begin

end;

destructor TTaskForm2XML.Destroy;
begin

  inherited;
end;

procedure TTaskForm2XML.doLoad(form: ITaskForm);
var
  i   : integer;
  xf  : IXMLField;
  ctrl: ITaskCtrl;
begin
  for i := 0 to pred( m_xList.Values.Count) do
  begin
    xf := m_xList.Values.Field[i];
    ctrl := form.Base.findCtrlByCLID(xf.Ctrlclid);
    if Assigned(ctrl) then
      ctrl.setData(xf.Value);
  end;
  for i := 0 to pred(m_xList.Tables.Count) do
  begin
    loadTable(m_xList.Tables[i], form );
  end;
end;

procedure TTaskForm2XML.fromText(text: string; form: ITaskForm);
var
  xml : IXMLDocument;
begin
  try
    xml := NewXMLDocument;
    xml.XML.Text := UTF8Encode(text);
    m_xList := xml.GetDocBinding('List', TXMLList, TargetNamespace) as IXMLList;
  except
    m_xList := NewList;
  end;
  doLoad( form);
end;

function TTaskForm2XML.getXML(form : ITaskForm ): IXMLList;
begin
  m_xList := NewList;

  m_xList.Clid := form.CLID;
  m_xList.Taskclid := form.Owner.CLID;

  if Assigned(form) then
  begin
    SaveControl( form.Base );
  end;
  Result := m_xList;
end;

procedure TTaskForm2XML.load(name: string; form: ITaskForm);
begin
  try
    m_xList := LoadList(name);
  except
    m_xList := NewList;
  end;
  doLoad( form);
end;

procedure TTaskForm2XML.load(st: TStream; form: ITaskForm);
var
  xml: IXMLDocument;
begin
  try
    xml := NewXMLDocument;
    xml.LoadFromStream(st);
    m_xlist := xml.GetDocBinding('List', TXMLList, TargetNamespace) as IXMLList;
  except
    m_xList := NewList;
  end;
  doLoad( form);
end;

procedure TTaskForm2XML.loadTable(xTab: IXMLTable; form : ITaskForm);
var
  ctrl : ITaskCtrl;
  row, col : integer;
  xr : IXMLRow;
  dataFieldMap : TDictionary<integer, integer>;

  procedure buildMap;
  var
    i, j : integer;
    np : integeR;
  begin
    for i := 0 to pred(xTab.Header.Count) do
    begin
      np := -1;
      for j := 0 to pred(ctrl.Childs.Count) do
      begin
        if SameText( xTab.Header[i].Ctrlclid, ctrl.Childs[j].CLID) then
        begin
          np := j;
          break;
        end;
      end;
      dataFieldMap.Add(i, np);
    end;
  end;
begin
  ctrl := form.Base.findCtrlByCLID(xTab.Ctrlclid);
  if not Assigned(ctrl) then
    exit;

//  if xtab.Header.Count <> ctrl.TableCtrlIF.ColCount then
//    exit;

  dataFieldMap := TDictionary<integer, integer>.create;

  buildMap;

  ctrl.TableCtrlIF.RowCount := xTab.Rows.Count;
  for row :=0 to pred(xTab.Rows.Count) do
  begin
    xr := xTab.Rows.Row[row];
    for col := 0 to pred(xr.Count) do
    begin
      ctrl.TableCtrlIF.Cell[row+1, dataFieldMap[col]+1] := xr.Value[col];
    end;
  end;
  dataFieldMap.Free;
end;

function TTaskForm2XML.save(st: TStream; form: ITaskForm): boolean;
begin
  Result := false;
  m_xList := NewList;

  m_xList.Clid := form.CLID;
  m_xList.Taskclid := form.Owner.CLID;

  if Assigned(form) then
  begin
    SaveControl( form.Base );
  end;
  try
    m_xList.OwnerDocument.SaveToStream(st);
    Result := st.Size <> 0 ;
  except

  end;
end;

function TTaskForm2XML.save(name: string; form: ITaskForm): Boolean;
begin
  Result := false;
  m_xList := NewList;

  m_xList.Clid := form.CLID;
  m_xList.Taskclid := form.Owner.CLID;

  if Assigned(form) then
  begin
    SaveControl( form.Base );
  end;
  try
    m_xList.OwnerDocument.SaveToFile(name);
    Result := true;
  except

  end;
end;

procedure TTaskForm2XML.SaveControl(ctrl: ITaskCtrl);
var
  i : integer;
  xField : IXMLField;
  n, v :string;
begin
  if Assigned( ctrl.TableCtrlIF) then
    SaveTable(ctrl)
  else
  begin
    if ctrl.containData then
    begin
      xField := m_xList.Values.Add;
      xField.Ctrlclid   := ctrl.CLID;
      xField.Field      := '';
      xField.Fieldclid  := '';

      if Assigned( ctrl.DataField) then
      begin
        xField.Field      := ctrl.DataField.Name;
        xField.Fieldclid  := ctrl.DataField.CLID;
      end;
      ctrl.getData(n, v);
      xField.Value := v;
    end;
    for i := 0 to pred(ctrl.Childs.Count) do
      SaveControl(ctrl.Childs[i]);
  end;
end;

procedure TTaskForm2XML.SaveTable(ctrl: ITaskCtrl);
var
  xTab : IXMLTable;
  y    : integer;

  procedure addHeader;
  var
    i : integer;
    xf: IXMLField;
    f : ITaskCtrl;
  begin
    for i := 0 to pred(ctrl.Childs.Count) do
    begin
      xf := xTab.Header.Add;
      f  := ctrl.Childs[i];

      xf.Header     := f.propertyValue('Header');
      xf.Width      := StrToInt(f.propertyValue('Width'));
      xf.Field      := '';
      xf.Fieldclid  := '';
      if Assigned(f.DataField) then
      begin
        xf.Field      := f.DataField.Name;
        xf.Fieldclid  := f.DataField.CLID;
      end;
      xf.Ctrlclid := f.CLID;
    end;
  end;
  procedure writeRow;
  var
    xr : IXMLRow;
    x  : integer;
  begin
    xr := xTab.Rows.Add;
    for x := 1 to ctrl.TableCtrlIF.ColCount do
    begin
      xr.Add(ctrl.TableCtrlIF.Cell[y, x] );
    end;
  end;
begin
  if not Assigned(ctrl.DataField) then
    exit;

  xTab := m_xList.Tables.Add;
  xTab.Ctrlclid := ctrl.CLID;
  xTab.Field      := '';
  xTab.Fieldclid  := '';
  if Assigned(ctrl.DataField) then
  begin
    xTab.Field      := ctrl.DataField.Name;
    xTab.Fieldclid  := ctrl.DataField.CLID;
  end;

  addHeader;
  for y := 1 to pred(ctrl.TableCtrlIF.RowCount) do
  begin
    writeRow;
  end;
end;

end.
