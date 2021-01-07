unit u_renderer;

interface

uses
  m_taskLoader, i_chapter, SHDocVw, i_beschluss, m_html;

type
  TProtocolRenderer = class
    private
      m_html    : THtmlMod;
      FLoader   : TTaskLoaderMod;
      FProtocol : IProtocol;
      FCLID: string;
    public
      constructor create;
      Destructor Destroy; override;

      property Loader: TTaskLoaderMod read FLoader write FLoader;
      property CLID: string read FCLID write FCLID;

      procedure renderStart;
      procedure renderProtocol( proto : IProtocol );
      procedure renderChapterTitle( ct : IChapterTitle );
      procedure renderChapter( cp : IChapter );
      procedure renderBeschluss( be : IBeschluss );

      function  Show( web : TWebBrowser ) : string;

  end;

implementation

uses
  System.Win.ComObj;

{ TProtocolRenderer }

constructor TProtocolRenderer.create;
begin
  m_html    := THtmlMod.Create(NIL);
  FProtocol := NIL;
  FLoader   := NIL;
  FCLID     := CreateClassID;
end;

destructor TProtocolRenderer.Destroy;
begin
  m_html.Free;
  inherited;
end;

procedure TProtocolRenderer.renderBeschluss(be: IBeschluss);
begin
  if FLoader.SysLoad('{1C0F5A8C-2510-4D1C-BF21-C5D8604DAE28}') then
  begin
    m_html.TaskContainer  := FLoader.TaskContainer;
    m_html.TaskData       := be.Data;
    m_html.TaskStyle      := FLoader.TaskStyle;

    m_html.AddToStack;
  end;
end;

procedure TProtocolRenderer.renderChapter(cp: IChapter);
var
  i     : integer;
begin
  if cp.TAID = 0 then
  begin
    if cp.Numbering then
      m_html.AddTitleToStack( cp.fullTitle, cp.level)
    else
      m_html.AddTextToStack(cp.fullTitle);
    m_html.AddTextToStack(cp.Rem);
  end
  else
  begin
    if FLoader.load(cp.TAID) then
    begin
      m_html.TaskContainer  := FLoader.TaskContainer;
      m_html.TaskStyle      := FLoader.TaskStyle;
      m_html.TaskData       := FLoader.TaskData;
      m_html.Title          := cp.fullTitle;
      if cp.Numbering then
        m_html.AddTitleToStack( cp.fullTitle, cp.level)
      else
        m_html.AddTextToStack(cp.fullTitle);

      m_html.AddToStack;
      for i := 0 to pred( cp.Votes.Count ) do
        renderBeschluss( cp.Votes.Item[i] );
    end;
  end;
  for i := 0 to pred(cp.Childs.Count) do
      renderChapter(cp.Childs.Items[i]);
end;

procedure TProtocolRenderer.renderChapterTitle(ct: IChapterTitle);
  procedure ShowChilds( childs : IChapterList );
  var
    i : integer;
  begin
    for i := 0 to pred(childs.Count) do
    begin
      renderChapter( childs.Items[i] );
    end;
  end;
begin
  m_html.AddTitleToStack(ct.FullTitle, 1);
  ShowChilds( ct.Root.Childs);
end;

procedure TProtocolRenderer.renderProtocol(proto: IProtocol);
var
  i : integer;
begin
  for i := 0 to pred(proto.Chapter.Count) do
    renderChapterTitle(proto.Chapter.Items[i]);
end;

procedure TProtocolRenderer.renderStart;
begin
  m_html.openStack(FCLID);
end;

function  TProtocolRenderer.Show(web: TWebBrowser) : string;
begin
  Result := m_html.showStack(web);
end;

end.
