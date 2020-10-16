unit u_ChapterTitleImpl;

interface

uses
  i_chapter, xsd_chapter;

type
  TChapterTitleImpl = class(TInterfacedObject, IChapterTitle)
    private
      m_owner   : IChapterTitleList;
      FNr       : integer;
      FText     : string;
      FID       : integer;
      FModified : boolean;
      m_xCp     : IXMLChapter;

      procedure setID( value : integer );
      function  getID : integer;
      procedure setNr( value : integer );
      function  getNR : integer;
      procedure setText( value : string );
      function  getText : string;
      procedure setModified( value : boolean );
      function  getModified : boolean;
      procedure setChapter( value : IXMLChapter );
      function  getChapter : IXMLChapter;

    public
      constructor create(owner : IChapterTitleList);
      Destructor Destroy; override;

      procedure up;
      procedure down;

      function FullTitle : string;
      procedure release;
  end;

implementation

uses
  System.SysUtils;

constructor TChapterTitleImpl.create(owner : IChapterTitleList);
begin
  m_xCp     := NewChapter;
  m_owner   := owner;
  FNr       := 0;
  FModified := false;
end;

destructor TChapterTitleImpl.Destroy;
begin
  m_xCp     := NIL;
  m_owner   := NIL;

  inherited;
end;

procedure TChapterTitleImpl.down;
begin
  m_owner.down(self);
end;

function TChapterTitleImpl.FullTitle: string;
begin
  Result := Format('%d. %s', [FNr, FText]);
end;

function TChapterTitleImpl.getChapter: IXMLChapter;
begin
  Result := m_xCp;
end;

function TChapterTitleImpl.getID: integer;
begin
  Result := FID;
end;

function TChapterTitleImpl.getModified: boolean;
begin
  Result := FModified;
end;

function TChapterTitleImpl.getNR: integer;
begin
  Result := FNr;
end;

function TChapterTitleImpl.getText: string;
begin
  Result := FText;
end;

procedure TChapterTitleImpl.release;
begin
  m_owner := NIL;
end;

procedure TChapterTitleImpl.setChapter(value: IXMLChapter);
begin
  m_xCp := value;
end;

procedure TChapterTitleImpl.setID(value: integer);
begin
  FID := value;
end;

procedure TChapterTitleImpl.setModified(value: boolean);
begin
  FModified := value;
end;

procedure TChapterTitleImpl.setNr(value: integer);
begin
  FNr := value;
end;

procedure TChapterTitleImpl.setText(value: string);
begin
  FText := value;
end;

procedure TChapterTitleImpl.up;
begin
  m_owner.up(self);
end;

end.
