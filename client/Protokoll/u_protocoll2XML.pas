unit u_protocoll2XML;

interface

uses
  i_chapter, xsd_TaskData, u_teilnehmer;

type
  Protocoll2XML = class
    private
      m_proto : IProtocol;
      m_data  : IXMLList;

      procedure addField( name, value : string );
      procedure AddTabField( tab : IXMLTable; name, value : string );

      function  addTable( name : string; list : ITeilnehmerListe; status : TTeilnehmerStatus) : IXMLTable; overload;
      function  addTable( name : string; list : IBesucherListe) : IXMLTable; overload;
    public
      constructor create;
      Destructor Destroy; override;

      function xml( proto : IProtocol ): IXMLList;

  end;

implementation

uses
  System.SysUtils;

{ Protocoll2XML }

procedure Protocoll2XML.addField(name, value: string);
var
  xField : IXMLField;
begin
  xField := m_data.Values.Add;
  xField.Field := name;
  xField.Value := value;
end;

procedure Protocoll2XML.AddTabField(tab : IXMLTable;name, value: string);
var
  xField : IXMLField;
begin
  xField := tab.Header.Add;
  xField.Header := name;
  xField.Width  := 100;
  xField.Field  := value;
end;

function Protocoll2XML.addTable(name: string; list: IBesucherListe): IXMLTable;
var
  i : integer;
  row : IXMLRow;
begin
  Result        := m_data.Tables.Add;
  Result.Field  := name;

  addTabField(Result, 'Name',     'NAME');
  addTabField(Result, 'Vorname',  'VORNAME');
  addTabField(Result, 'Abteilung','ABTEILUNG');

  for i := 0 to pred(list.Count) do
  begin
    row := Result.Rows.Add;
    row.Add(list.Item[i].Name);
    row.Add(list.Item[i].Vorname);
    row.Add(list.Item[i].Abteilung);
  end;
end;

function Protocoll2XML.addTable(name: string; list : ITeilnehmerListe;status : TTeilnehmerStatus): IXMLTable;
var
  i : integer;
  row : IXMLRow;
begin
  Result        := m_data.Tables.Add;
  Result.Field  := name;

  addTabField(Result, 'Name',     'NAME');
  addTabField(Result, 'Vorname',  'VORNAME');
  addTabField(Result, 'Abteilung','ABTEILUNG');

  for i := 0 to pred(list.Count) do
  begin
    if list.Item[i].Status = status then
    begin
      row := Result.Rows.Add;
      row.Add(list.Item[i].Name);
      row.Add(list.Item[i].Vorname);
      row.Add(list.Item[i].Abteilung);
    end;
  end;

end;

constructor Protocoll2XML.create;
begin
  m_proto := NIL;
  m_data  := NIL;

end;

destructor Protocoll2XML.Destroy;
begin
  m_proto := NIL;
  m_data  := NIL;

  inherited;
end;

function Protocoll2XML.xml(proto: IProtocol): IXMLList;
begin
  m_data  := NewList;
  m_proto := proto;

  addField( 'TITEL',        m_proto.Title);
  addField( 'DATUM',        FormatDateTime('dd.MM.YYYY',m_proto.Date));
  addField( 'START_DATUM',  FormatDateTime('dd.MM.YYYY',m_proto.Start));
  addField( 'START_ZEIT',   FormatDateTime('hh:mm' ,m_proto.Start));
  addField( 'ENDE_DATUM',   FormatDateTime('dd.MM.YYYY',m_proto.Ende));
  addField( 'ENDE_ZEIT',    FormatDateTime('hh:mm',m_proto.Ende));
  addField( 'NR',           IntToStr(m_proto.Nr));

  addTable( 'TEILNEHMER',     m_proto.Teilnehmer, tsAnwesend);
  addTable( 'ENTSCHULDIGT',   m_proto.Teilnehmer, tsEntschuldigt);
  addTable( 'UNENTSCHULDIGT', m_proto.Teilnehmer, tsUnentschuldigt);
  addTable( 'BESUCHER',       m_proto.Besucher);

  Result  := m_data;
end;

end.

