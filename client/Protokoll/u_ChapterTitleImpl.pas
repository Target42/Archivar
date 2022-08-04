unit u_ChapterTitleImpl;

interface

uses
  i_chapter, xsd_chapter, System.Classes, data.db, System.Generics.Collections,
  m_protocol;

type
  TChapterTitleImpl = class(TInterfacedObject, IChapterTitle)
    private
      m_proto   : IProtocol;
      m_owner   : IChapterTitleList;
      m_loader  : TProtocolMod;

      FNr       : integer;
      FText     : string;
      FID       : integer;
      FModified : boolean;
      m_xCp     : IXMLChapter;
      m_root    : IChapter;
      m_stamp   : TDateTime;

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

      function getProto : IProtocol;

      procedure setOwner;
      procedure refreshList;
      function GetTimeStamp: TDateTime;
      procedure SetTimeStamp(const Value: TDateTime);

    public
      constructor create(owner : IChapterTitleList; loader: TProtocolMod; proto : IProtocol);
      Destructor Destroy; override;

      procedure up;
      procedure down;

      function FullTitle : string;

      procedure buildTree;

      procedure loadFromDataSet( data, beData : TDataSet );

      procedure release;
  end;

implementation

uses
  System.SysUtils,
  u_ChapterImpl, i_beschluss;


procedure TChapterTitleImpl.buildTree;
begin

end;

constructor TChapterTitleImpl.create(owner : IChapterTitleList; loader: TProtocolMod; proto : IProtocol);
begin
  m_proto   := proto;
  m_loader  := loader;
  m_xCp     := NewChapter;
  m_owner   := owner;
  FNr       := 0;
  FModified := false;
  m_root    := TChapterImpl.create(NIL, m_loader, self);
  m_list    := TList<IChapter>.create;
  m_stamp   := now;
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

procedure TChapterTitleImpl.loadFromDataSet(data, beData: TDataSet);
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
  procedure loadBE( cp :IChapter );
  var
    be : IBeschluss;
  begin
      beData.Filter := 'CT_ID = '+IntToStr( cp.ID);
      beData.Filtered := true;
      beData.First;
      while not beData.Eof do
      begin
        be := cp.Votes.newBeschluss;
        be.loadFromDataSet(beData);
        beData.Next;
      end;
      beData.Filtered :=  false;
  end;

begin
  list := TList<IChapter>.create;

  m_root.Childs.clear;


  data.First;
  while not data.Eof do
  begin
    cp            := TChapterImpl.create(NIL, m_loader, self);
    cp.load(data);

    loadBE( cp );

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

function TChapterTitleImpl.getProto: IProtocol;
begin
  Result := m_proto;
end;

function TChapterTitleImpl.getRoot: IChapter;
begin
  Result := m_root;
end;

function TChapterTitleImpl.getText: string;
begin
  Result := FText;
end;

function TChapterTitleImpl.GetTimeStamp: TDateTime;
begin
  result := m_stamp;
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
  m_proto := NIL;
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
      root.Childs.Items[i].Parent := root;
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

procedure TChapterTitleImpl.SetTimeStamp(const Value: TDateTime);
begin
  m_stamp := value;
end;

procedure TChapterTitleImpl.up;
begin
  m_owner.up(self);
  FModified := true;
  refreshList;
end;



end.
