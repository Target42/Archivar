unit fr_bookmark;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, u_bookmark;

type
  TBookmarkFrame = class(TFrame)
    LV: TListView;
    procedure LVDblClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    procedure updatebookMarks;
    procedure removeBookmark( mark : TBookmark );
  end;

implementation

uses
  m_glob_client, m_WindowHandler, m_BookMarkHandler, u_berTypes;

{$R *.dfm}

procedure TBookmarkFrame.LVDblClick(Sender: TObject);
var
  mark : TBookmark;
begin
  if not Assigned(LV.Selected) then
    exit;
  mark := TBookmark(LV.Selected.Data);
  if not GM.isValidTask(mark.ID, mark.DocType) then
  begin
    removeBookmark( mark );
    ShowMessage('Dieses Lesezeichen existiert nicht mehr.');
    BookMarkHandler.Bookmarks.remove(mark.CLID);
    exit;
  end;
  case mark.DocType of
    dtTask      : WindowHandler.openTaskWindow(mark.ID, mark.TypeID, true);
    dtProtokoll : WindowHandler.openProtoCclWindow(mark.ID, true);
  end;
end;

procedure TBookmarkFrame.removeBookmark(mark: TBookmark);
var
  i : integer;
begin
  LV.Items.BeginUpdate;
  for i := 0 to pred(LV.Items.Count) do
    begin
      if LV.Items[i].Data = mark then
      begin
        LV.Items.Delete(i);
        break;
      end;
    end;
  LV.Items.EndUpdate;
end;

procedure TBookmarkFrame.updatebookMarks;
  function grpID( name : string) : integer;
  var
    j : integer;
    grp : TListGroup;
  begin
    Result := -1;
    for j := 0 to pred(LV.Groups.Count) do
    begin
      if LV.Groups.Items[j].Header = name then
      begin
        Result := j;
        break;
      end;
    end;
    if Result = -1 then
    begin
      Result := LV.Groups.Count;
      grp := LV.Groups.Add;
      grp.GroupID := Result;
      grp.Header := name;
      grp.TitleImage := GM.getImageID(name+'.png');
    end;
  end;
var
  i : integer;
  item : TListItem;
  mark : TBookmark;
  s    : string;
  inx  : integer;
begin
  LV.GroupHeaderImages  := GM.ImageList1;
  LV.SmallImages        := GM.ImageList1;

  LV.Items.BeginUpdate;
  LV.Items.Clear;
  for i := 0 to pred(m_BookMarkHandler.BookMarkHandler.Bookmarks.Count) do
  begin
    mark := m_BookMarkHandler.BookMarkHandler.Bookmarks.items[i];
    item := LV.Items.Add;
    item.GroupID := grpID(mark.Group);
    item.Caption := mark.Titel;
    item.Data := mark;

    inx := Pos('_', mark.Titel);
    if inx > 0 then
    begin
      s := copy( mark.Titel, 0, inx);
      item.ImageIndex := GM.GetShortImage(s);
    end;
  end;
  LV.Items.EndUpdate;
end;

end.
