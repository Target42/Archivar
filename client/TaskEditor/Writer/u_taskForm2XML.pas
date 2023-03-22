unit u_taskForm2XML;

interface

uses
  i_taskEdit, xsd_TaskData, System.Generics.Collections, System.Classes,
  u_template;

type
  TTaskForm2XML = class
    public
    const
      Attrib_Names : Array[0..8] of string =
      ('Titel', 'Gestartet', 'Termin', 'Erfasst', 'Status',
       'Antragsteller', 'Kommentar',
       'Template', 'Gremium' );
    private
      m_xList: IXMLList;
      m_attribs : TStringList;

      procedure saveAttribs;
      procedure loadAttribs;

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

      procedure fillData( form : ITaskForm; xList : IXMLList );

      function  save( name : string; form : ITaskForm ) : Boolean; overload;
      function  save( st : TStream; form : ITaskForm ) : boolean; overload;

      function  getXML(form : ITaskForm ) : IXMLList; overload;
      function  getXML( st : TStream ) : IXMLList; overload;

      function setAttribute( name, value : string ) : boolean;
      procedure createTestAttributes(te : TTemplate );
  end;

implementation

uses
  System.SysUtils, Xml.XMLIntf, Xml.XMLDoc, u_templateCache, m_glob_client;

{ TTaskForm2XML }

constructor TTaskForm2XML.create;
begin
  m_attribs := TStringList.Create;
end;

procedure TTaskForm2XML.createTestAttributes( te : TTemplate );
begin
  self.setAttribute('Titel',          'Titel');
  self.setAttribute('Gestartet',      DateTimeToStr(now));
  self.setAttribute('Termin',         DateTimeToStr(now+7));
  self.setAttribute('Erfasst',        'Jone Doe');
  self.setAttribute('Status',         'Gelesen');
  self.setAttribute('Antragsteller',  'Fantomas');
  self.setAttribute('Kommentar',      'Kommentar');
  self.setAttribute('Template',       te.name );
  self.setAttribute('Gremium',        GM.GremiumName(-1));
end;

destructor TTaskForm2XML.Destroy;
begin
  m_attribs.Free;
  inherited;
end;

procedure TTaskForm2XML.doLoad(form: ITaskForm);
begin
  fillData( form, m_xList );
end;

procedure TTaskForm2XML.fillData(form: ITaskForm; xList: IXMLList);
var
  i   : integer;
  xf  : IXMLField;
  ctrl: ITaskCtrl;
begin
  if not Assigned(xList) then
    exit;

  for i := 0 to pred( xList.Values.Count) do
  begin
    xf := xList.Values.Field[i];
    ctrl := NIL;
    if xf.HasAttribute('ctrlclid') then begin
      ctrl := form.Base.findCtrlByCLID(xf.Ctrlclid);
    end else if xf.HasAttribute('field') then begin
      ctrl := form.Base.findCtrlByField(xf.Field);
    end;

    if Assigned(ctrl) then
      ctrl.Data := xf.Value;
  end;

  for i := 0 to pred(xList.Tables.Count) do
  begin
    loadTable(xList.Tables[i], form );
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

function TTaskForm2XML.getXML(st: TStream): IXMLList;
var
  xml: IXMLDocument;
begin
  try
    xml := NewXMLDocument;
    xml.LoadFromStream(st);
    Result := xml.GetDocBinding('List', TXMLList, TargetNamespace) as IXMLList;
    loadAttribs;
  except
    Result := NewList;
  end;
end;

function TTaskForm2XML.getXML(form : ITaskForm ): IXMLList;
begin
  m_xList := NewList;

  m_xList.Clid := form.CLID;
  m_xList.Taskclid := form.Owner.CLID;

  saveAttribs;

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
  loadAttribs;
  doLoad( form);
end;

procedure TTaskForm2XML.load(st: TStream; form: ITaskForm);
begin
  m_xList := getXML( st );
  loadAttribs;
  doLoad( form);
end;

procedure TTaskForm2XML.loadAttribs;
var
  i : integer;
  xfld : IXMLField;
begin
  if Assigned(m_xList) and Assigned(m_xList.Attributes) then begin
    for i := 0 to pred(m_xList.Attributes.Count) do begin
      xfld := m_xList.Attributes.Field[i];
      setAttribute(xfld.Field, xfld.Value);
    end;
  end;
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

procedure TTaskForm2XML.saveAttribs;
var
  i     : integer;
  xfld  : IXMLField;
  text  : string;
  rem   : IXMLNode;
begin
  for i := 0 to pred(m_attribs.Count) do begin
    text := m_attribs.Names[i];
    if SameText(text, 'Template') or SameTExt(text, 'Typ') then begin
      rem := m_xList.OwnerDocument.CreateNode('Diesen Werte nicht ändern', ntComment);
      m_xList.Attributes.ChildNodes.Add(rem);
    end;

    xfld := m_xList.Attributes.Add;
    xfld.Field := text;
    xfld.Value := m_attribs.ValueFromIndex[i];
  end;
end;

function TTaskForm2XML.save(name: string; form: ITaskForm): Boolean;
begin
  Result := false;
  m_xList := NewList;

  m_xList.Clid := form.CLID;
  m_xList.Taskclid := form.Owner.CLID;

  saveAttribs;

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
      xField.Value := ctrl.Data;
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

function TTaskForm2XML.setAttribute(name, value: string): boolean;
var
  i   : integer;
begin
  Result := true;
  for i := low(Attrib_Names) to High(Attrib_Names) do begin
    Result := SameText( name, Attrib_Names[i]);
    if Result then begin
      break;
    end;
  end;

  if Result then
    m_attribs.Values[name] := value;
end;

end.
