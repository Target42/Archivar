unit u_TaskDataField2XML;

interface

uses
  i_datafields, xsd_task;


type
  TaskDataField2XML = class
  private
  public
    constructor create;
    Destructor Destroy; override;

    function xml2DataField( xdf : IXMLDataField) : IDataField;
    procedure DataField2XML( df : IDataField; xdf : IXMLDataField );
  end;
implementation

uses
  u_DataFieldImpl;

{ TaskDataField2XML }


constructor TaskDataField2XML.create;
begin

end;

procedure TaskDataField2XML.DataField2XML(df: IDataField; xdf : IXMLDataField);
var
  ch  : IXMLDataField;
  xp  : IXMLProperty_;
  p   :  IProperty;
  i   : integer;
begin

  xdf.Name      := df.Name;
  xdf.Datatype  := df.Typ;
  xdf.Clid      := df.CLID;
  xdf.IsGlobal  := df.isGlobal;
  xdf.Required  := df.Required;
  xdf.Text      := df.Rem;

  for i := 0 to pred(df.Properties.Count) do
  begin
    p  := df.Properties.Items[i];
    xp := xdf.Properties.Add;

    xp.Name := p.Name;
    xp.Typ  := p.Typ;
    xp.Value:= p.Value;
  end;

  for i := 0 to pred(df.Childs.Count) do
  begin
    ch := xdf.Childs.Add;
    DataField2XML(df.Childs.Items[i], ch);
  end;

end;

destructor TaskDataField2XML.Destroy;
begin

  inherited;
end;

function TaskDataField2XML.xml2DataField(xdf: IXMLDataField): IDataField;
var
  i : integer;
  p : IProperty;
  xp: IXMLProperty_;
  xc: IXMLDataField;
begin
  Result          := TDataField.create;
  Result.Name     := xdf.Name;
  Result.Typ      := xdf.Datatype;
  Result.CLID     := xdf.Clid;
  Result.isGlobal := xdf.IsGlobal;
  Result.Required := xdf.Required;
  Result.Rem      := xdf.Text;

  for i := 0 to pred(xdf.Properties.Count) do
  begin
    xp := xdf.Properties[i];
    p := Result.getPropertyByName(xp.Name);
    if Assigned(p) then
      p.Value := xp.Value;
  end;

  for i := 0 to pred(xdf.Childs.Count) do
  begin
    xc := xdf.Childs[i];
    Result.Childs.add(xml2DataField(xc));
  end;
end;

end.
