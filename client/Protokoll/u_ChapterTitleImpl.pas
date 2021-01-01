unit u_ChapterTitleImpl;

interface

uses
  i_chapter, xsd_chapter, System.Classes, data.db, System.Generics.Collections,
  m_protocol;

type
  TChapterTitleImpl = class(TInterfacedObject, IChapterTitle)
    private
      m_owner   : IChapterTitleList;
      m_loader  : TProtocolMod;

      FNr       : integer;
      FText     : string;
      FID       : integer;
      FModified : boolean;
      m_xCp     : IXMLChapter;
      m_root    : IChapter;

      m_list    : TList<IChapter>;

      procedure setID( value : integer );
      function  getID : integer;
      procedure setNr( value : integer );
      function  getNR : integer;
      procedure setText( value : string );
      function  getText : string;
      procedure setModified( value : boolean );
      function  getModified : boolean;
      procedure setxChapter( value : IXMLChapter );
      function  getxChapter : IXMLChapter;
      function  getRoot : IChapter;

      function getCount : integer;
      function getItem( inx : integer ) : IChapter;

      procedure setOwner;
      procedure refreshList;
    public
      constructor create(owner : IChapterTitleList; loader: TProtocolMod);
      Destructor Destroy; override;

      procedure up;
      procedure down;

      function FullTitle : string;

      procedure buildTree;

      procedure loadFromDataSet( data : TDataSet );

      procedure release;
  end;

implementation

uses
  System.SysUtils, u_ChapterListImpl,
  u_ChapterImpl, Xml.XMLIntf, Xml.XMLDoc;

procedure TChapterTitleImpl.buildTree;

begin
end;

constructor TChapterTitleImpl.create(owner : IChapterTitleList; loader: TProtocolMod);
begin
  m_loader  := loader;
  m_xCp     := NewChapter;
  m_owner   := owner;
  FNr       := 0;
  FModified := false;
  m_root    := TChapterImpl.create(NIL, m_loader);
  m_list    := TList<IChapter>.create;
end;

destructor TChapterTitleImpl.Destroy;
begin
  m_xCp     := NIL;
  m_root    := NIL;
  m_list.Free;

  inherited;
end;

procedure TChapterTitleImpl.down;
begin
  m_owner.down(self);
  refreshList;
  FModified := true;
end;

function TChapterTitleImpl.FullTitle: string;
begin
  Result := Format('%d. %s', [FNr, FText]);
end;

function TChapterTitleImpl.getxChapter: IXMLChapter;
begin
  Result := m_xCp;
end;

procedure TChapterTitleImpl.loadFromDataSet(data: TDataSet);
var
  list  : TList<IChapter>;
  cp    : IChapter;
  i     : integer;

  procedure addToParent( cp : IChapter );
  var
    j : integer;
  begin
    for j := 0 to pred(list.Count) do
    begin
      if list[j].ID = cp.PID then
      begin
        list[j].add(cp);
        break;
      end;
    end;
  end;
begin
  list := TList<IChapter>.create;

  m_root.Childs.clear;

  data.First;
  while not data.Eof do
  begin
    cp            := TChapterImpl.create(NIL, m_loader);
    cp.ID         := data.FieldByName('CT_ID').AsInteger;
    cp.PID        := data.FieldByName('CT_PARENT').AsInteger;
    cp.Name       := data.FieldByName('CT_TITLE').AsString;
    cp.Nr         := data.FieldByName('CT_NUMBER').AsInteger;
    cp.TAID       := data.FieldByName('TA_ID').AsInteger;
    CP.Pos        := data.FieldByName('CT_POS').AsInteger;
    cp.Rem        := data.FieldByName('CT_DATA').AsString;
    cp.Numbering  := (cp.Nr <> -1 );

    list.Add(cp);

    data.Next;
  end;
  for i := 0 to pred(list.Count) do
    begin
      if list[i].PID = 0 then
        m_root.Childs.add(list[i])
      else
        addToParent(list[i]);
    end;
  setOwner;
  list.Free;
  m_root.Childs.sortPos;
  refreshList;
end;

function TChapterTitleImpl.getCount: integer;
begin
  refreshList;
  Result := m_list.Count;
end;

function TChapterTitleImpl.getID: integer;
begin
  Result := FID;
end;

function TChapterTitleImpl.getItem(inx: integer): IChapter;
begin
  Result := m_list[inx];
end;

function TChapterTitleImpl.getModified: boolean;
begin
  Result := FModified;
end;

function TChapterTitleImpl.getNR: integer;
begin
  Result := FNr;
end;

function TChapterTitleImpl.getRoot: IChapter;
begin
  Result := m_root;
end;

function TChapterTitleImpl.getText: string;
begin
  Result := FText;
end;

procedure TChapterTitleImpl.refreshList;
  procedure add( list : IChapterList );
  var
    i : integer;
  begin
    for i := 0 to pred(list.Count) do
    begin
      m_list.Add(list.Items[i]);
      add(list.Items[i].Childs);
    end;
  end;
begin
  m_list.Clear;
  add(m_root.Childs);
end;

procedure TChapterTitleImpl.release;
begin
  m_owner := NIL;
  m_xCp   := NIL;
  m_root.release;
  m_list.Clear;
end;

procedure TChapterTitleImpl.setxChapter(value: IXMLChapter);
begin
  m_xCp     := value;
  FModified := true;
end;


procedure TChapterTitleImpl.setID(value: integer);
begin
  FID       := value;
  FModified := true;
end;

procedure TChapterTitleImpl.setModified(value: boolean);
begin
  FModified := value;
end;

procedure TChapterTitleImpl.setNr(value: integer);
begin
  FNr       := value;
  m_root.Nr := value;
  FModified := true;
end;

procedure TChapterTitleImpl.setOwner;
  procedure setValue( root : IChapter );
  var
    i : integer;
  begin
    for i := 0 to pred(root.Childs.Count) do
    begin
      root.Childs.Items[i].Owner := root;
      setValue(root.Childs.Items[i]);
    end;
  end;
begin
  setValue( m_root );
  FModified := true;
end;

procedure TChapterTitleImpl.setText(value: string);
begin
  FText     := value;
  FModified := true;
end;

procedure TChapterTitleImpl.up;
begin
  m_owner.up(self);
  FModified := true;
  refreshList;
end;



end.
