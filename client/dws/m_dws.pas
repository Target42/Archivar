unit m_dws;

interface

uses
  System.SysUtils, System.Classes, dwsComp, xsd_TaskData, dwsErrors,
  i_taskEdit, dwsExprs, Xml.XMLIntf, Web.HTTPApp, Web.HTTPProd;

type
  TXmlContainer = class
  private
    m_xml : IXMLNode;
  public
    constructor create( xml : IXMLNode );
    property XML : IXMLNode read m_xml write m_xml;
    Destructor Destroy; override;
  end;

  TDwsMod = class(TDataModule)
    DelphiWebScript1: TDelphiWebScript;
    dwsUnit1: TdwsUnit;
    XMLDump: TPageProducer;
    DumpTable: TPageProducer;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure dwsUnit1FunctionsScriptParamCVountEval(info: TProgramInfo);
    procedure dwsUnit1FunctionsScriptParamEval(info: TProgramInfo);
    procedure dwsUnit1FunctionshasFieldEval(info: TProgramInfo);
    procedure dwsUnit1FunctionsgetFieldStrEval(info: TProgramInfo);
    procedure dwsUnit1FunctionsgetFieldIntEval(info: TProgramInfo);
    procedure dwsUnit1FunctionsgetTableEval(info: TProgramInfo);
    procedure dwsUnit1ClassesTTableMethodsgetTableHeaderEval(Info: TProgramInfo;
      ExtObject: TObject);
    procedure dwsUnit1ClassesTTableMethodsRowsEval(Info: TProgramInfo;
      ExtObject: TObject);
    procedure dwsUnit1ClassesTTableMethodsColsEval(Info: TProgramInfo;
      ExtObject: TObject);
    procedure dwsUnit1ClassesTTableMethodsCellEval(Info: TProgramInfo;
      ExtObject: TObject);
    procedure dwsUnit1ClassesTTableHeaderMethodsCountEval(Info: TProgramInfo;
      ExtObject: TObject);
    procedure dwsUnit1ClassesTTableHeaderMethodsCaptionEval(Info: TProgramInfo;
      ExtObject: TObject);
    procedure dwsUnit1ClassesTTableHeaderMethodsWidthEval(Info: TProgramInfo;
      ExtObject: TObject);
    procedure dwsUnit1ClassesTTableHeaderMethodsNamesEval(Info: TProgramInfo;
      ExtObject: TObject);
    procedure dwsUnit1FunctionsprintXMLEval(info: TProgramInfo);
    procedure XMLDumpHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure DumpTableHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
  private
    m_script : TStringList;
    m_params : TStringList;
    m_xList  : IXMLList;
    m_xTable : IXMLTable;
    m_style  : ITaskStyle;
    m_msgText: string;

    function addDataRows : string;
    function headerText : string;
    function rowsText : string;

    function getScript: String;
    procedure setScript(const Value: String);
    function hasError( msgs:TdwsMessageList): boolean;
    function getField( name : string ) : IXMLField;
    function getHeaderField( name : string; header : IXMLHeader ) : IXMLField;
  public
    property Data      : IXMLList read m_xList write m_xList;
    property TaskStyle : ITaskStyle read m_style write m_style;

    property Params : TStringList read m_params;
    property Script : String read getScript write setScript;

    property MsgText : string read m_msgText;

    function compile : boolean;
    function run : string;
  end;

var
  DwsMod: TDwsMod;

implementation

uses
  Vcl.Dialogs, System.StrUtils, dwsUtils, Xml.XMLDoc;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TDwsMod.addDataRows: string;
var
  i : integer;
  fmt : string;
begin
  fmt := '<tr><td>%s</td><td>%s</td></tr>'+sLineBreak;

  Result := '';
  for i := 0 to pred(m_xList.Values.Count) do
  begin

    Result := Result + Format(fmt, [m_xList.Values.Field[i].Field,
      ReplaceStr( m_xList.Values.Field[i].Value, #$A, '<br>')]);
  end;
end;

function TDwsMod.compile: boolean;
var
  prog : IdwsProgram;
begin
  m_msgText := '';
  prog   := DelphiWebScript1.Compile(m_script.Text);

  m_msgText := prog.Msgs.AsInfo;
  Result := hasError(prog.Msgs);
end;

procedure TDwsMod.DataModuleCreate(Sender: TObject);
begin
  m_script := TStringList.Create;
  m_params := TStringList.Create;

  m_xList  := NewList;
  m_style  := NIL;
end;

procedure TDwsMod.DataModuleDestroy(Sender: TObject);
begin
  m_xList := NIL;
  m_style := NIL;

  m_script.Free;
  m_params.Free;
end;

procedure TDwsMod.DumpTableHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  cmd : string;
begin
  cmd := LowerCase(TagString);

  if cmd = 'tablename' then
    ReplaceText := m_xTable.Field
  else if cmd = 'header' then
    ReplaceText := headerText
  else if cmd = 'rows' then
    ReplaceText := rowsText;

end;

procedure TDwsMod.dwsUnit1ClassesTTableHeaderMethodsCaptionEval(
  Info: TProgramInfo; ExtObject: TObject);
var
  f : IXMLField;
begin
  if not ( ExtObject is TXmlContainer) then
    exit;

  f := getHeaderField( info.ParamAsString[0], ((ExtObject as TXmlContainer).XML as IXMLHeader));
  if Assigned(f) then
    info.ResultAsString := f.Header;
end;

procedure TDwsMod.dwsUnit1ClassesTTableHeaderMethodsCountEval(
  Info: TProgramInfo; ExtObject: TObject);
begin
  if not ( ExtObject is TXmlContainer) then
    exit;
  info.ResultAsInteger := ((ExtObject as TXmlContainer).XML as IXMLHeader).Count;
end;

procedure TDwsMod.dwsUnit1ClassesTTableHeaderMethodsNamesEval(
  Info: TProgramInfo; ExtObject: TObject);
var
  i : integer;
  arr : TStringDynArray;
  xHeader : IXMLHeader;
begin
  if not ( ExtObject is TXmlContainer) then
    exit;
  xHeader := (ExtObject as TXmlContainer).XML as IXMLHeader;
  Info.ResultAsStringArray := arr;

  SetLength(arr, xHeader.Count);
  for i := 0 to pred(xHeader.Count) do
    arr[i] := xHeader.Field[i].Field;

  info.ResultAsStringArray := arr;
end;

procedure TDwsMod.dwsUnit1ClassesTTableHeaderMethodsWidthEval(
  Info: TProgramInfo; ExtObject: TObject);
var
  f : IXMLField;
begin
  if not ( ExtObject is TXmlContainer) then
    exit;

  f := getHeaderField( info.ParamAsString[0], ((ExtObject as TXmlContainer).XML as IXMLHeader));
  if Assigned(f) then
    info.ResultAsInteger := f.Width;
end;

procedure TDwsMod.dwsUnit1ClassesTTableMethodsCellEval(Info: TProgramInfo;
  ExtObject: TObject);
var
  row, col : integer;
  xRows : IXMLRows;
  xRow  : IXMLRow;
begin

  row := Info.ParamAsInteger[0];
  col := Info.ParamAsInteger[1];
  if not ( ExtObject is TXmlContainer) then
    exit;

  try
    xRows := ((ExtObject as TXmlContainer).XML as IXMLTable).Rows;
    xRow  := xRows.Row[ row ];
    info.ResultAsString := xRow.Value[col];
  except
    info.ResultAsString := 'Exception Cells!';
  end;
end;

procedure TDwsMod.dwsUnit1ClassesTTableMethodsColsEval(Info: TProgramInfo;
  ExtObject: TObject);
begin
  if not ( ExtObject is TXmlContainer) then
    exit;

  info.ResultAsInteger := ((ExtObject as TXmlContainer).XML as IXMLTable).Header.Count;
end;

procedure TDwsMod.dwsUnit1ClassesTTableMethodsgetTableHeaderEval(
  Info: TProgramInfo; ExtObject: TObject);
var
  xml : TXmlContainer;
begin
  if not ( ExtObject is TXmlContainer) then
    exit;

  xml := TXmlContainer.create( ((ExtObject as TXmlContainer).XML as IXMLTable).Header);
  info.ResultAsVariant := Info.Vars['TTableHeader'].GetConstructor('create', xml).Call;
end;

procedure TDwsMod.dwsUnit1ClassesTTableMethodsRowsEval(Info: TProgramInfo;
  ExtObject: TObject);
begin
  if not ( ExtObject is TXmlContainer) then
    exit;

  info.ResultAsInteger := ((ExtObject as TXmlContainer).XML as IXMLTable).Rows.Count;
end;

procedure TDwsMod.dwsUnit1FunctionsgetFieldIntEval(info: TProgramInfo);
var
  fi : IXMLField;
  val : Integer;
begin
  fi :=  getField(info.ParamAsString[0]);
  val := 0;
  if Assigned(fi) then
  begin
    TryStrToInt(fi.Value, val);
  end;
  info.ResultAsInteger := val;
end;

procedure TDwsMod.dwsUnit1FunctionsgetFieldStrEval(info: TProgramInfo);
var
  fi : IXMLField;
begin
  fi :=  getField(info.ParamAsString[0]);
  if Assigned(fi) then
    info.ResultAsString := ReplaceText( fi.Value, #$A, '<br>' );
end;

procedure TDwsMod.dwsUnit1FunctionsgetTableEval(info: TProgramInfo);
var
  i : integer;
  xml : TXmlContainer;
begin
  xml := NIL;
  for i := 0 to pred(m_xList.Tables.Count) do
  begin
    if SameText(info.ParamAsString[0], m_xList.Tables.Table[i].Field) then
    begin
      xml := TXmlContainer.create(m_xList.Tables.Table[i]);
      break;
    end;
  end;
  info.ResultAsVariant := Info.Vars['TTable'].GetConstructor('create', xml).Call;
end;

procedure TDwsMod.dwsUnit1FunctionshasFieldEval(info: TProgramInfo);
begin
  info.ResultAsBoolean := Assigned(getField( info.ParamAsString[0] ));
end;

procedure TDwsMod.dwsUnit1FunctionsprintXMLEval(info: TProgramInfo);
begin
  info.ResultAsString := XMLDump.Content;
end;

procedure TDwsMod.dwsUnit1FunctionsScriptParamCVountEval(info: TProgramInfo);
begin
  info.ResultAsInteger := m_params.Count;
end;

procedure TDwsMod.dwsUnit1FunctionsScriptParamEval(info: TProgramInfo);
var
  inx : integer;
begin
  inx := info.ParamAsInteger[0];
  if (inx>=0) and ( inx < m_params.Count)  then
    info.ResultAsString := m_params[inx]
  else
    info.ResultAsString := 'ScriptParam out of range : '+IntToStr(inx);
end;

function TDwsMod.getField(name: string): IXMLField;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(m_xList.Values.Count) do
  begin
    if SameText(name, m_xList.Values.Field[i].Field) then
    begin
      Result := m_xList.Values.Field[i];
      break;
    end;
  end;
end;

function TDwsMod.getHeaderField(name: string; header: IXMLHeader): IXMLField;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred( header.Count) do
    begin
      if SameText(name, header.Field[i].Field) then
      begin
        Result := header.Field[i];
        break;
      end;
    end;
end;

function TDwsMod.getScript: String;
begin
  Result := m_script.Text;
end;

function TDwsMod.hasError(msgs: TdwsMessageList): boolean;
var
  i : integer;
begin
  Result := false;
  for i := 0 to pred(msgs.Count) do
  begin
    Result := Result or msgs.Msgs[i].IsError;
  end;

end;

function TDwsMod.headerText: string;
var
  i : integer;
  fmt : string;
begin
  Result := '';
  fmt := '<th>%s<br>%s</th>';
  for i := 0 to pred(m_xTable.Header.Count) do
    Result := Result + Format( fmt, [ m_xTable.Header.Field[i].Header,
     m_xTable.Header.Field[i].Field]);
end;

function TDwsMod.rowsText: string;
var
  i, j : integer;
begin
  Result := '';
  for i := 0 to pred(m_xTable.Rows.Count) do begin
    Result := Result + '<tr>';
    for j := 0 to pred(m_xTable.Rows.Row[i].Count) do begin
      Result := Result + '<td>'+m_xTable.Rows.Row[i].Value[j]+'</td>';
    end;
    Result := Result + '</tr>'+sLineBreak;
  end;
end;

function TDwsMod.run: string;
var prog : IdwsProgram;
    exec : IdwsProgramExecution;
begin
  prog := DelphiWebScript1.Compile(m_script.Text);

  if ( hasError( prog.Msgs) = true ) then
  begin
    ShowMessage(prog.Msgs.AsInfo);
    exit;
  end;

  exec := prog.Execute;
  Result := exec.Result.ToString;
end;

procedure TDwsMod.setScript(const Value: String);
begin
  m_script.Text := value;
end;

procedure TDwsMod.XMLDumpHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  cmd : string;
  i   : integer;
begin
  cmd := LowerCase(TagString);

  if cmd = 'datarows' then
    ReplaceText := addDataRows
  else if cmd = 'tables' then begin
    for i := 0 to pred(m_xList.Tables.Count) do begin
      m_xTable := m_xList.Tables.Table[i];
      ReplaceText := ReplaceText + DumpTable.Content;
    end;
    m_xTable := NIL;
  end;
end;

{ TXmlContainer }

constructor TXmlContainer.create(xml: IXMLNode);
begin
  m_xml := xml;
end;

destructor TXmlContainer.Destroy;
begin
  m_xml := NIL;
  inherited;
end;

end.