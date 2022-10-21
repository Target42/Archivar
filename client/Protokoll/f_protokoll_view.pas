unit f_protokoll_view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls,
  u_renderer, m_taskLoader, i_chapter, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Menus, u_ForceClose;

type
  TProtokollViewForm = class(TForm, IForceClose)
    StatusBar1: TStatusBar;
    WebBrowser1: TWebBrowser;
    PrintDialog1: TPrintDialog;
    MainMenu1: TMainMenu;
    Protokoll1: TMenuItem;
    Drucken1: TMenuItem;
    Speichernals1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Drucken1Click(Sender: TObject);
    procedure Speichernals1Click(Sender: TObject);
  private
    m_id : integer;
    m_proto : IProtocol;

    m_renderer : TProtocolRenderer;
    m_loader   : TTaskLoaderMod;

    function GetID: integer;
    procedure SetID(const Value: integer);
    procedure action( cmd : string );
  public
    property ID: integer read GetID write SetID;
    procedure ForceClose( force : boolean = true );
  end;

var
  ProtokollViewForm: TProtokollViewForm;

implementation

uses
  u_ProtocolImpl, m_WindowHandler, MSHTML;

{$R *.dfm}

{ TProtokollViewForm }

procedure TProtokollViewForm.action(cmd: string);
var
  Doc: IHtmlDocument2;
begin
   Webbrowser1.Document.QueryInterface(IID_IHtmlDocument2, Doc);
   if Doc <> nil then
   begin
     doc.execCommand(cmd, true, null);
   end;
end;

procedure TProtokollViewForm.Drucken1Click(Sender: TObject);
begin
  action('print');
end;

procedure TProtokollViewForm.ForceClose(force: boolean);
begin
  self.close;
end;

procedure TProtokollViewForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TProtokollViewForm.FormCreate(Sender: TObject);
begin
  m_renderer        := TProtocolRenderer.create;
  m_loader          := TTaskLoaderMod.Create(self);
  m_renderer.Loader := m_loader;
  m_id := -1;
end;

procedure TProtokollViewForm.FormDestroy(Sender: TObject);
begin
  WindowHandler.closeProtoclWindow(m_proto.ID);

  if Assigned(m_proto) then
    m_proto.release;

  m_loader.Free;
  m_renderer.Free;
end;

function TProtokollViewForm.GetID: integer;
begin
  Result := m_id;
end;

procedure TProtokollViewForm.SetID(const Value: integer);
begin
  m_id        := value;
  m_proto     := TProtocolImpl.create;
  m_proto.ID  := value;
  if m_proto.load(m_id) then
  begin
    Caption := m_proto.Title;
    m_renderer.renderStart;
    m_renderer.renderProtocol(m_proto);
    m_renderer.Show(WebBrowser1);
  end;
end;

procedure TProtokollViewForm.Speichernals1Click(Sender: TObject);
begin
  action('SaveAs');
end;

end.
