unit fr_report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  xsd_TaskData, Vcl.ComCtrls, SynEditHighlighter, SynHighlighterXML, SynEdit,
  JvExStdCtrls, JvRichEdit, SynHighlighterHtml, JvExControls, JvXMLBrowser,
  Vcl.OleCtrls, SHDocVw, JvSimpleXml;

type
  TReportFrame = class(TFrame)
    GroupBox1: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    SynEdit1: TSynEdit;
    SynXMLSyn1: TSynXMLSyn;
    TabSheet2: TTabSheet;
    SynEdit2: TSynEdit;
    SynHTMLSyn1: TSynHTMLSyn;
    TabSheet3: TTabSheet;
    WebBrowser1: TWebBrowser;
  private
    m_xList: IXMLList;
  public

    procedure init;
    procedure release;


  end;

implementation

uses
  Xml.XMLDoc;

{$R *.dfm}

{ TReportFrame }

procedure TReportFrame.init;
var
  fname : string;
begin
  fname := 'formdata.xml';

  if FileExists(fname) then
    m_xList := LoadList(fname);
  if Assigned(m_xList) then
  begin
    SynEdit1.Lines.Text := FormatXMLData(m_xList.OwnerDocument.XML.Text);
  end;
end;

procedure TReportFrame.release;
begin
  m_xList := NIL;
end;

end.
