unit u_renderer;

interface

uses
  m_taskLoader, i_chapter, SHDocVw, i_beschluss, m_html, xsd_TaskData,
  u_protocoll2XML, i_taskEdit;

type
  TProtocolRenderer = class
    private
      m_html    : THtmlMod;
      m_data    : IXMLList;
      m_frame   : ITaskContainer;
      FLoader   : TTaskLoaderMod;
      FProtocol : IProtocol;
      FCLID: string;
    public
      constructor create;
      Destructor Destroy; override;

      property Loader: TTaskLoaderMod read FLoader write FLoader;
      property CLID: string read FCLID write FCLID;
      property ProtocolData : IXMLList read m_data write m_data;

      procedure renderStart;
      procedure renderProtocol( proto : IProtocol );
      procedure renderChapterTitle( ct : IChapterTitle );
      procedure renderChapter( cp : IChapter; renderBe : boolean = true );
      procedure renderBeschluss( be : IBeschluss );

      function  Show( web : TWebBrowser ) : string;

  end;

implementation

uses
  System.Win.ComObj;

{ TProtocolRenderer }

// html body : {183C11C4-9864-451F-AFB2-05B10CC44D62}

constructor TProtocolRenderer.create;
begin
  m_html    := THtmlMod.Create(NIL);
  FProtocol := NIL;
  FLoader   := NIL;
  FCLID     := CreateClassID;
  m_data    := NIL;
  m_frame   := NIL;
end;

destructor TProtocolRenderer.Destroy;
begin
  if Assigned(m_frame) then
    m_frame.release;
  m_frame := NIL;

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

    FLoader.clearData;
  end;
end;

procedure TProtocolRenderer.renderChapter(cp: IChapter; renderBe : boolean);
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
      FLoader.clearData;
    end;
  end;
  // Beschlüsse
  if renderBe then begin
  for i := 0 to pred( cp.Votes.Count ) do
    renderBeschluss( cp.Votes.Item[i] );
  end;
  // childs
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
  p2x : Protocoll2XML;
begin

  p2x := Protocoll2XML.create;
  if FLoader.SysLoad('{183C11C4-9864-451F-AFB2-05B10CC44D62}') then
  begin
    // store this task container until rendering end ....
    m_frame := FLoader.TaskContainer;
    m_html.setFrameData( m_frame, FLoader.TaskStyle, p2x.xml(proto));
  end;
  p2x.Free;

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
  m_html.clearFrameData;
end;

end.
