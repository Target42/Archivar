unit u_protocoll2XML;

interface

uses
  i_chapter, xsd_TaskData;

type
  Protocoll2XML = class
    private
      m_proto : IProtocol;
      m_data  : IXMLList;

      procedure addField( name, value : string );
      procedure AddTabField( tab : IXMLTable; name, value : string );

      function addTable( name : string ) : IXMLTable;
      procedure addList( list : ITeilnehmerListe );

      procedure addRow( tab : IXMLTable; name, vorname, abteilung : string);

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

procedure Protocoll2XML.addList(list: ITeilnehmerListe);
var
  tab : IXMLTable;
begin
  tab := addTable('TEILNEHMER');
end;

procedure Protocoll2XML.addRow(tab: IXMLTable; name, vorname,
  abteilung: string);
var
  row : IXMLRow;
begin
  row := tab.Rows.Add;
  row.Add(name);
  row.Add(vorname);
  row.Add(abteilung);
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

function Protocoll2XML.addTable(name: string): IXMLTable;
begin
  Result := m_data.Tables.Add;

  addTabField(Result, 'Name',     'NAME');
  addTabField(Result, 'Vorname',  'VORNAME');
  addTabField(Result, 'Abteilung','ABTEILUNG');

end;

constructor Protocoll2XML.create;
begin

end;

destructor Protocoll2XML.Destroy;
begin

  inherited;
end;

function Protocoll2XML.xml(proto: IProtocol): IXMLList;
begin
  m_data  := NewList;
  m_proto := proto;

  addField( 'TITEL', m_proto.Title);
  addField( 'DATUM', FormatDateTime('dd.MM.YYYY',m_proto.Date));


  Result  := m_data;
end;

end.
