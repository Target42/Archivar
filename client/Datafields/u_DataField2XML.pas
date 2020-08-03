unit u_DataField2XML;

interface

uses
  System.Classes, i_datafields, xsd_DataField;

type
  TDataField2XML = class
  private
    procedure loadXdata( df : IDataField; xdf : IXMLDataField );
    procedure saveXData( df : IDataField; xdf : IXMLDataField );
  public
    constructor create;
    Destructor Destroy; override;

    function loadFromStream( st : TStream ) : IDataField;
    procedure saveToStream( dataField : IDataField ; st  : TStream );
  end;

implementation

uses
  Xml.XMLIntf, Xml.XMLDoc, u_DataFieldImpl;

{ TDataField2XML }

constructor TDataField2XML.create;
begin

end;

destructor TDataField2XML.Destroy;
begin

  inherited;
end;

function TDataField2XML.loadFromStream(st: TStream): IDataField;
var
  xData : IXMLDataField;
  xml   : IXMLDocument;

begin
  xData := NIL;
  xml := NewXMLDocument;
  if Assigned(st) and (st.Size > 0 ) then
  begin
    xml.LoadFromStream(st);
    xData := xml.GetDocBinding('DataField', TXMLDataField, TargetNamespace) as IXMLDataField;
  end;

  if not Assigned(xData) then
  begin
    xData := NewDataField;
    xData.Datatype := 'string';
    xData.IsGlobal := false;
  end;

  Result := TDataField.create;
  loadXdata( Result, xData);
end;

procedure TDataField2XML.loadXdata(df: IDataField; xdf: IXMLDataField);
  var
    i : integer;
    xp : IXMLProperty_;
    p  : IProperty;
    pdf : IDataField;
begin
  df.Name      := xdf.Name;
  df.CLID      := xdf.Clid;
  df.Rem       := xdf.Text;
  df.isGlobal  := xdf.IsGlobal;
  if xdf.HasAttribute('globalname') then
    df.GlobalName := xdf.Globalname;


  df.Typ := xdf.Datatype;

  for i := 0 to pred(xdf.Properties.Count) do
  begin
    xp := xdf.Properties[i];
    p  := df.getPropertyByName(xp.Name);
    if Assigned(p) then
      p.Value := xp.Value;
  end;

  for i := 0 to pred(xdf.Childs.Count) do
  begin
    pdf := df.Childs.newField('xx', 'string');
    loadXdata( pdf, xdf.Childs.DataField[i]);
  end;
end;

procedure TDataField2XML.saveToStream(dataField: IDataField; st: TStream);
var
  xData : IXMLDataField;
begin
  xData           := NewDataField;
  saveXData(dataField, xData);

  xData.OwnerDocument.SaveToStream(st);
end;

procedure TDataField2XML.saveXData(df: IDataField; xdf: IXMLDataField);
  var
    i : integer;
    xp : IXMLProperty_;
    p  : IProperty;
begin
  xdf.Name      := df.Name;
  xdf.Clid      := df.CLID;
  xdf.Datatype  := df.Typ;
  xdf.Text      := df.Rem;
  xdf.IsGlobal  := df.isGlobal;
  xdf.Globalname:= df.GlobalName;
  for i := 0 to pred(df.Properties.Count) do
  begin
    xp := xdf.Properties.Add;
    p  := df.Properties.Items[i];
    xp.Name   := p.Name;
    xp.Typ    := p.Typ;
    xp.Value  := p.Value;
  end;

  for i := 0 to pred(df.Childs.Count) do
  begin
    saveXData(df.Childs.Items[i], xdf.Childs.Add);
  end;


end;

end.
