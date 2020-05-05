unit fr_report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  xsd_TaskData, Vcl.ComCtrls, SynEditHighlighter, SynHighlighterXML, SynEdit,
  JvExStdCtrls, JvRichEdit, SynHighlighterHtml, JvExControls, JvXMLBrowser,
  Vcl.OleCtrls, SHDocVw, JvSimpleXml, i_taskEdit, Vcl.Menus, Vcl.ExtCtrls;

type
  TReportFrame = class(TFrame)
    GroupBox1: TGroupBox;
    PageControl1: TPageControl;
    SynXMLSyn1: TSynXMLSyn;
    TabSheet2: TTabSheet;
    SynEdit2: TSynEdit;
    SynHTMLSyn1: TSynHTMLSyn;
    TabSheet3: TTabSheet;
    WebBrowser1: TWebBrowser;
    PopupMenu1: TPopupMenu;
    Feldhinzufgen1: TMenuItem;
    Panel1: TPanel;
    Button1: TButton;
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    m_xList: IXMLList;
    m_task : ITask;
    m_Path : string;
    m_form : ITaskForm;
    procedure setTask( value : ITask );
    procedure addFieldName1Click(Sender: TObject);

  public

    procedure init;
    procedure release;

    property Task : ITask read m_task write setTask;
    property Form : ITaskForm read m_form write m_form;

    procedure doNewForm( frm : ITaskForm );
  end;

implementation

uses
  Xml.XMLDoc, i_datafields, m_glob_client, System.IOUtils, m_html,
  u_taskForm2XML;

{$R *.dfm}

{ TReportFrame }

procedure TReportFrame.addFieldName1Click(Sender: TObject);
begin
  SynEdit2.SelText := ( Sender as TMenuItem).Caption;
end;

procedure TReportFrame.Button1Click(Sender: TObject);
var
  HtmlMod : THtmlMod;
  writer : TTaskForm2XML;
begin
  if not Assigned(m_form) then
  begin
    ShowMessage('Es ist kein Formular aktiv!');
    exit;
  end;

  writer := TTaskForm2XML.create;
  m_xList := writer.getXML(m_form);
  writer.Free;

  Application.CreateForm(THtmlMod, HtmlMod);
  try
    HtmlMod.HTMLDoc.Assign(SynEdit2.Lines);
    HtmlMod.TaskData := m_xList;
    HtmlMod.SaveToFile(m_path+'index.html');
  finally
    HtmlMod.Free;
  end;
  WebBrowser1.Navigate('http://localhost:42424/B967F35E-FFAE-481A-9664-2C7621FDEB18/index.html');
end;

procedure TReportFrame.doNewForm(frm: ITaskForm);
begin
  m_form := frm;
end;

procedure TReportFrame.init;
var
  fname : string;
  procedure writeIndex;
  var list : TStringList;
  begin
    list:= TStringList.Create;
    list.Add('<!doctype html>');
    list.Add('<html>');
    list.Add('  <head>');
    list.Add('  <meta charset="utf-8">');
    list.Add('  </head>');
    list.Add('  <body>');
    list.Add('  Hallo Welt');
    list.Add(' </body>');
    list.Add('</html>');
    list.SaveToFile(m_path+'index.html');
    list.Free;
  end;
begin
  m_form := NIL;
  m_Path := TPath.combine(GM.wwwHome, 'B967F35E-FFAE-481A-9664-2C7621FDEB18\');
  ForceDirectories(m_Path);
  writeIndex;

  fname := 'formdata.xml';

  fname := 'template.html';
  if FileExists(fname) then
  begin
    SynEdit2.Lines.LoadFromFile(fname);
  end;
end;

procedure TReportFrame.PopupMenu1Popup(Sender: TObject);
var
  i, j : integer;
  item : TMenuItem;
  sub  : TMenuItem;
  df   : IDataField;
begin
  Feldhinzufgen1.Clear;

  if not Assigned(m_task) then
    exit;

  for i := 0 to pred(m_task.Fields.Count) do
  begin
    df := m_task.Fields.Items[i];
    item := TMenuItem.Create(Feldhinzufgen1);

    item.Caption := df.Name;
    if df.Childs.Count = 0 then
      item.OnClick := self.addFieldName1Click;
    Feldhinzufgen1.Add(item);
    if df.Childs.Count > 0 then
    begin
      sub := TMenuItem.Create(item);
      sub.Caption := df.Name;
      sub.OnClick := self.addFieldName1Click;
      item.Add(sub);
      for j := 0 to pred(df.Childs.Count)  do
      begin
        sub := TMenuItem.Create(item);
        sub.Caption := df.Name+'.'+df.Childs.Items[j].Name;
        sub.OnClick := self.addFieldName1Click;
        item.Add(sub);
      end;
    end;
  end;
end;

procedure TReportFrame.release;
begin
  m_xList := NIL;
  m_form  := NIL;
  m_task  := NIL;
  SynEdit2.Lines.SaveToFile('template.html');
end;

procedure TReportFrame.setTask(value: ITask);
begin
  m_task := value;
end;

end.
