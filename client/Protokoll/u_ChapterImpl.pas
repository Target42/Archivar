unit u_ChapterImpl;

interface

uses
  i_chapter, xsd_chapter, System.Classes, i_beschluss, m_protocol, Data.DB;

type
    TChapterImpl = class( TInterfacedObject, IChapter )
    private
      m_loader    : TProtocolMod;
      m_owner     : IChapterTitle;
      m_childs    : IChapterList;
      m_parent    : IChapter;
      FName       : string;
      FID         : integer;
      FPID        : integer;
      FNr         : integer;
      FNumbering  : boolean;
      FTAID       : integer;
      FData       : Pointer;
      FRem        : String;
      m_modified  : boolean;
      m_xData     : IXMLChapter;
      m_pos       : integer;
      m_votes     : IBeschlussListe;
      m_stamp     : TDateTime;


      procedure setModified(  value : boolean );
      procedure setParent(    value : IChapter);
      procedure setName(      value : string );
      procedure SetID(        value : integer);
      procedure setPID(       value : integer );
      procedure SetNr(        value : integer );
      procedure SetNumbering( value : boolean );
      procedure setTAID(      value : integer );
      procedure setData(      value : pointer );
      procedure setRem(       value : string );
      procedure setxData(     value : IXMLChapter);
      procedure setPos(       value : integer );
      procedure SetTimeStamp(const Value: TDateTime);

      function getModified  : boolean;
      function getParent    : IChapter;
      function getName      : string;
      function getID        : integer;
      function getPID       : integer;
      function getNr        : integer;
      function getNumbering : boolean ;
      function getTAID      : integer;
      function getData      : pointer;
      function getRem       : string;
      function getChilds    : IChapterList;
      function getxData     : IXMLChapter;
      function getPos       : integer;
      function getVotes     : IBeschlussListe;
      function GetTimeStamp : TDateTime;


    public
      constructor create(parent : IChapter; loader: TProtocolMod; owner : IChapterTitle);
      Destructor Destroy; override;

      procedure clearModified;
      function isModified : boolean;

      procedure up;
      procedure down;

      procedure add( cp : IChapter );
      procedure remove( cp : IChapter );

      function newChapter : IChapter;
      function findChapter( id : integer ) : IChapter;

      function fullTitle: string;
      procedure reindex;

      function hasID( id : integer ) : Boolean;
      function level : integer;

      function save( data : TDataSet ) : boolean;
      function load( data : TDataSet ) : boolean;

      procedure release;
  end;

implementation

uses
  System.SysUtils, u_ChapterListImpl, u_BeschlussListeImpl, m_glob_client,
  System.Variants;

procedure TChapterImpl.add(cp: IChapter);
begin
  if cp = IChapter(self) then
    exit;

  m_childs.add(cp);

  cp.Parent  := self;
  cp.PID    := self.getPID;

 m_childs.renumber;
end;

procedure TChapterImpl.clearModified;
var
  i : integer;
begin
  m_modified := false;
  for i := 0 to pred(m_childs.Count) do
    m_childs.Items[i].clearModified;
end;

constructor TChapterImpl.create(parent : IChapter; loader: TProtocolMod; owner : IChapterTitle);
begin
  m_loader  := loader;
  m_childs  := TChapterListImpl.create;
  m_votes   := TBeschlussListeImpl.create(m_loader, self);
  m_parent  := parent;
  m_owner   := owner;
  FID       := 0;
  FPID      := 0;
  FNr       := 0;
  FTAID     := 0;
  FNumbering:= true;
  FName     := 'Titel';
  FData     := NIL;
  m_stamp   := now;
  m_modified := false;
end;

destructor TChapterImpl.Destroy;
begin
  m_childs := NIL;
  inherited;
end;

procedure TChapterImpl.down;
begin
  m_parent.Childs.down(self);
  m_modified    := true;
end;

function TChapterImpl.findChapter(id: integer): IChapter;
var
  i : integer;
begin
  Result := NIL;
  if FID = id then
    Result := self;
  if not Assigned(Result) then begin
    for i := 0 to pred(m_childs.Count) do begin
      Result := m_childs.Items[i].findChapter(id);
      if Assigned(Result) then
        break;
    end;
  end;
end;

function TChapterImpl.fullTitle: string;
var
  cp : IChapter;
begin
  Result := '';
  if FNumbering then
  begin
    cp := self;
    while Assigned(cp) do
    begin
      if cp.Numbering then
        Result := IntToStr( cp.getNr ) +'.'+Result;
      cp := cp.Parent;
    end;
    Result := Result + ' ';

  end;
  Result := Result + FName;

  if FTAID <> 0 then
    Result := Result + Format(' (%d)', [FTAID]);

end;

function TChapterImpl.getChilds: IChapterList;
begin
  Result := m_childs;
end;

function TChapterImpl.getData: pointer;
begin
  Result := FData;
end;

function TChapterImpl.getID: integer;
begin
  Result := FID;
end;

function TChapterImpl.getModified: boolean;
begin
  Result := m_modified;
end;

function TChapterImpl.getName: string;
begin
  Result := FName;
end;

function TChapterImpl.getNr: integer;
begin
  Result := FNr;
end;

function TChapterImpl.getNumbering: boolean;
begin
  Result := FNumbering;
end;

function TChapterImpl.getParent: IChapter;
begin
  Result := m_parent;
end;

function TChapterImpl.getPID: integer;
begin
  Result := FPID;
end;

function TChapterImpl.getPos: integer;
begin
  Result := m_pos;
end;

function TChapterImpl.getRem: string;
begin
  Result := FRem;
end;

function TChapterImpl.getTAID: integer;
begin
  Result := FTAID;
end;

function TChapterImpl.GetTimeStamp: TDateTime;
begin
  Result := m_stamp;
end;

function TChapterImpl.getVotes: IBeschlussListe;
begin
  Result := m_votes;
end;

function TChapterImpl.getxData: IXMLChapter;
begin
  Result := m_xData;
end;

function TChapterImpl.hasID(id: integer): Boolean;
var
  i : integer;
begin
  Result := (FTAID = id);
  if not Result then
  begin
    for i := 0 to pred(m_childs.Count) do
    begin
      Result := m_childs.Items[i].hasID(id);
      if Result then
        break;
    end;
  end;
end;

function TChapterImpl.isModified: boolean;
  function checkChilds( list : IChapterList ) : Boolean;
  var
    i : integer;
  begin
    Result := false;
    for i := 0 to pred(list.Count) do
    begin
      Result := list.Items[i].isModified;
      if Result then
        break;
    end;
  end;
begin
  Result := m_modified;

  if not Result then
  begin
    Result := checkChilds(m_childs);
  end;

end;

function TChapterImpl.level: integer;
var
  ptr : IChapter;
begin
  Result := 0;

  ptr := self;
  while Assigned(ptr) do
  begin
    ptr := ptr.Parent;
    inc(Result);
  end;
end;

function TChapterImpl.load(data: TDataSet): boolean;
begin
  try
    setID(         data.FieldByName('CT_ID').AsInteger);
    setPID(        data.FieldByName('CT_PARENT').AsInteger);
    setName(       data.FieldByName('CT_TITLE').AsString);
    setNr(         data.FieldByName('CT_NUMBER').AsInteger);
    setTAID(       data.FieldByName('TA_ID').AsInteger);
    setPos(        data.FieldByName('CT_POS').AsInteger);
    setRem(        data.FieldByName('CT_DATA').AsString);
    setTimeStamp(  data.FieldByName('CT_CREATED').AsDateTime);
    setNumbering(  getNr <> -1 );

    Result := true;
  except
    Result := false;
  end;

end;

function TChapterImpl.newChapter: IChapter;
begin
  Result := TChapterImpl.create(self, m_loader, m_owner);
  add(Result);
  m_childs.renumber;
end;

procedure TChapterImpl.reindex;
var
  inx : integer;

  procedure indexChilds( root : IChapter; pid : integer );
  var
    i : integer;
  begin
    Inc(inx);
    root.pos  := inx;
    root.PID  := pid;
    for i := 0 to pred(root.Childs.Count) do
    begin
      indexChilds(root.Childs.Items[i], root.ID);
    end;
  end;
begin
  inx := -1;

  indexChilds(self, 0);
end;

procedure TChapterImpl.release;
var
  i : integer;
begin
  m_owner := NIL;

  for i := 0 to pred(m_childs.Count) do
    m_childs.Items[i].release;
  m_childs.clear;
  m_votes.Release;
end;

procedure TChapterImpl.remove(cp: IChapter);
begin
  m_childs.remove(cp);
  cp.Parent := NIL;
end;

function TChapterImpl.save(data: TDataSet): boolean;
var
  i : integer;
begin
  try
    if m_modified then begin
      if FID = 0 then
      begin
        FID := GM.autoInc('GEN_CT_ID');

        data.Append;
        data.FieldByName('CP_ID').AsInteger       := m_owner.ID;  //m_ct.ID;
        data.FieldByName('CT_ID').AsInteger       := FID;
        data.FieldByName('CT_CREATED').AsDateTime := now;
      end
      else
      begin
        if data.Locate('CT_ID', VarArrayOf([FID]), []) then
          data.Edit
        else
          raise Exception.Create('Chapter not Found');
      end;

      data.FieldByName('ct_parent').AsInteger := FPID;
      data.FieldByName('CT_NUMBER').AsInteger := FNr;
      data.FieldByName('CT_TITLE').AsString   := FName;
      data.FieldByName('CT_POS').AsInteger    := m_pos;
      data.FieldByName('CT_DATA').AsString    := FRem;

      if FTAID <> 0 then
        data.FieldByName('TA_ID').AsInteger     := FTAID
      else
        data.FieldByName('TA_ID').Clear;
      data.Post;
    end;
    Result := true;
    for i := 0 to pred(m_childs.Count) do
      Result := m_childs.Items[i].save(data) and Result;
  except
    Result := false;
  end;
end;

procedure TChapterImpl.setData(value: pointer);
begin
  if value <> FData then begin
    FData := value;
    setModified(true);
  end;
end;

procedure TChapterImpl.SetID(value: integer);
begin
  if value <> FID then begin
    FID := value;
    setModified(true);
  end;
end;

procedure TChapterImpl.setModified(value: boolean);
begin
  m_modified := value;
end;

procedure TChapterImpl.setName(value: string);
begin
  if (value <> FName) then begin
    FName := value;
    setModified(true);
  end;
end;

procedure TChapterImpl.SetNr(value: integer);
begin
  if (value <> FNr) then begin
    FNr := value;
    setModified(true);
  end;
end;

procedure TChapterImpl.SetNumbering(value: boolean);
var
  i : integer;
begin
  if (value <> FNumbering) then begin
    FNumbering := value;

    if Assigned(m_parent) then
    begin
      if FNumbering then
        m_parent.Numbering := true
      else
      begin
        for i := 0 to pred(m_childs.Count) do
          m_childs.Items[i].Numbering := false;
      end;
    end;
    m_childs.renumber;
    setModified(true);
  end;
end;

procedure TChapterImpl.setParent(value: IChapter);
begin
  if (value <> m_parent) then begin
    m_parent := value;
    setModified(true);
  end;
end;

procedure TChapterImpl.setPID(value: integer);
begin
  if (value <> FPID) then begin
    FPID := value;
    setModified(true);
  end;
end;

procedure TChapterImpl.setPos(value: integer);
begin
  if (value <> m_pos) then begin
    m_pos       := value;
    setModified(true);
  end;
end;

procedure TChapterImpl.setRem(value: string);
begin
  if FRem <> value then begin
    FRem := value;
    setModified(true);
  end;
end;

procedure TChapterImpl.setTAID(value: integer);
begin
  if FTAID <> value then begin
    FTAID := value;
    setModified(true);
  end;
end;

procedure TChapterImpl.SetTimeStamp(const Value: TDateTime);
begin
  m_stamp := value;
end;

procedure TChapterImpl.setxData(value: IXMLChapter);
begin
  m_xData := value;
end;

procedure TChapterImpl.up;
begin
  m_parent.Childs.up(self);
  setModified(true);
end;

end.
