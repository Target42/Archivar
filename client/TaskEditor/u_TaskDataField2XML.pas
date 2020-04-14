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
begin

end;

end.
