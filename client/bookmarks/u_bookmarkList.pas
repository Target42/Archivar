unit u_bookmarkList;

interface

uses
  u_bookmark, System.Generics.Collections, System.JSON;

type
  TBookmarkList = class
    private
      m_list : TList<TBookmark>;
      procedure setBookmarks( inx : integer; const mark : TBookmark );
      function  getBookmarks( inx : integer ) : TBookmark;

      procedure setJSON( arr : TJSONArray );
      function  getJSON : TJSONArray;
      function getCount : Integer;
    public
      constructor create;
      Destructor Destroy; override;

      property Items[ inx : integer] : TBookmark read getBookmarks write setBookmarks;
      property Count : integer read getCount;

      procedure load( path : string );
      procedure save( path : string );

     function newBookmark( clid : string ) :  TBookmark;
     function getBookmark( clid : string ) :  TBookmark;
     function emptyBookmark : TBookmark;

     procedure remove( clid :string );
  end;


implementation

uses
  u_json, System.SysUtils, System.IOUtils, Winapi.Windows, Vcl.Forms,
  m_glob_client;

{ TBookmarkList }

constructor TBookmarkList.create;
begin
  m_list := TList<TBookmark>.Create;
end;

destructor TBookmarkList.Destroy;
var
  i : integer;
begin
  for i := 0 to pred(m_list.Count) do
    m_list[i].Free;
  FreeAndNil( m_list);
  inherited;
end;

function TBookmarkList.emptyBookmark: TBookmark;
begin
  Result := TBookmark.create;
  m_list.Add(Result);
end;

function TBookmarkList.getBookmark(clid: string): TBookmark;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(m_list.Count) do
  begin
    if m_list[i].CLID = clid then
    begin
      Result:=m_list[i];
      break;
    end;
  end;
end;

function TBookmarkList.getBookmarks(inx: integer): TBookmark;
begin
  Result := m_list[inx];
end;

function TBookmarkList.getCount: Integer;
begin
  Result := m_list.Count;
end;

function TBookmarkList.getJSON: TJSONArray;
var
  i : integer;
begin
  Result := TJSONArray.Create;
  for i := 0 to pred(m_list.Count) do
    Result.AddElement(m_list[i].getJSON);
end;

procedure TBookmarkList.load(path: string);
var
  obj :  TJSONObject;
  fname : string;
begin
  fname := TPath.Combine( path, 'bookmarks.json');
  if not FileExists(fname) then
    exit;
  obj := loadJSON(fname);
  if not Assigned(obj) then
    exit;
  setJSON( JArray( obj, 'items'));
  obj.Free;
end;

function TBookmarkList.newBookmark(clid: string): TBookmark;
begin
  Result :=getBookmark(clid);

  if not Assigned(Result) then
  begin
   Result := TBookmark.create;
   Result.CLID := clid;
   m_list.Add(Result);
  end;
end;

procedure TBookmarkList.remove(clid: string);
var
  mark : Tbookmark;
  i    : integer;
begin
  mark := NIL;
  for i := 0 to pred(m_list.Count) do
  begin
    if m_list[i].CLID = clid then
    begin
      mark := m_list[i];
      m_list.Delete(i);
      mark.Free;
    end;
  end;
  PostMessage( Application.MainFormHandle, msgRemoveBookmark, 0, LPARAM(mark));
end;

procedure TBookmarkList.save(path: string);
var
  obj : TJSONObject;
  fname : string;
begin
  if m_list.Count = 0 then
    exit;

  fname := TPath.Combine( path, 'bookmarks.json');
  obj   := TJSONObject.Create;
  JReplace( obj, 'items', getJSON);
  saveJSON( obj, fname );
  obj.Free;
end;

procedure TBookmarkList.setBookmarks(inx: integer; const mark: TBookmark);
begin
  m_list[inx] := mark;
end;

procedure TBookmarkList.setJSON(arr: TJSONArray);
var
  i : integer;
  row : TJSONObject;
  mark : TBookmark;
begin
  if not Assigned(arr) then
    exit;
  for i := 0 to pred(arr.Count) do
  begin
    row := getRow(arr, i);
    mark := TBookmark.create;
    m_list.Add(mark);
    mark.setJSON(row);
  end;
end;

end.
