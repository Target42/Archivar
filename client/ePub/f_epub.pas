unit f_epub;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_ePub, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw;

type
  Tepubform = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    TV: TTreeView;
    WebBrowser1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TVChange(Sender: TObject; Node: TTreeNode);
  private
    m_pub : ePub;

    procedure createIndex;
    function GetFileName: string;
    procedure SetFileName(const Value: string);
  public
    property FileName: string read GetFileName write SetFileName;
  end;

var
  epubform: Tepubform;
// D:\git\multi\Setup\Bibo\BJNR000130972.epub
implementation

uses
  u_navpoint, system.IOUtils;

{$R *.dfm}

procedure Tepubform.createIndex;
  procedure add( root : TTreeNode ; nav : NavPoint );
  var
    sub : TTreeNode;
    i   : integer;
  begin
    sub := TV.Items.AddChildObject( root, nav.Title, nav);
    for i := 0 to pred(nav.Childs.Count) do
      add(sub, nav.Childs[i]);
  end;
begin
  TV.Items.BeginUpdate;
  TV.Items.Clear;

  if Assigned(m_pub.Root) then
    Add(NIL, m_pub.Root);

  if TV.Items.Count >0 then
    TV.Items.Item[0].Expand(true);


  TV.Items.EndUpdate;
end;

procedure Tepubform.FormCreate(Sender: TObject);
begin
  m_pub := NIL;
end;

procedure Tepubform.FormDestroy(Sender: TObject);
begin
  m_pub.free;
end;

function Tepubform.GetFileName: string;
begin
  Result := m_pub.FileName;
end;

procedure Tepubform.SetFileName(const Value: string);
begin
  m_pub := ePub.create;
  m_pub.setFileName(value);
  Caption := m_pub.Title;
  createIndex;
  if TV.Items.Count > 0 then
  begin
    TV.Selected := TV.Items.GetFirstNode;
  end;

end;

procedure Tepubform.TVChange(Sender: TObject; Node: TTreeNode);
var
  nav : NavPoint;
  fname : string;
begin
  if not Assigned(tv.Selected) or not Assigned(m_pub) then
    exit;

  nav := NavPoint(tv.Selected.Data);
  if Assigned(nav) then
  begin
    fname := TPath.Combine(m_pub.Home, nav.Content);
    WebBrowser1.Navigate(fname);
  end;
end;

end.
