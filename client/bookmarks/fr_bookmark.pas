unit fr_bookmark;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, u_bookmark,
  System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TBookmarkFrame = class(TFrame)
    LV: TListView;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    ac_open: TAction;
    ac_delete: TAction;
    ffnen1: TMenuItem;
    N1: TMenuItem;
    Lschen1: TMenuItem;
    procedure LVDblClick(Sender: TObject);
    procedure LVKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LVKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ac_openExecute(Sender: TObject);
    procedure ac_deleteExecute(Sender: TObject);
  private
    m_doEdit : boolean;
  public
    procedure updatebookMarks;
    procedure removeBookmark( mark : TBookmark );
  end;

implementation

uses
  m_glob_client, m_WindowHandler, m_BookMarkHandler, u_berTypes;

{$R *.dfm}

procedure TBookmarkFrame.ac_deleteExecute(Sender: TObject);
var
  mark : TBookmark;
begin
  if not Assigned(LV.Selected) then
    exit;
  mark := TBookmark(LV.Selected.Data);
  BookMarkHandler.Bookmarks.remove(mark.CLID);
  updatebookMarks;
end;

procedure TBookmarkFrame.ac_openExecute(Sender: TObject);
var
  mark : TBookmark;
begin
  if not Assigned(LV.Selected) then
    exit;
  mark := TBookmark(LV.Selected.Data);
  if not GM.isValidTask(mark.ID, mark.DocType) then
  begin
    ShowMessage('Dieses Lesezeichen existiert nicht mehr.');
    BookMarkHandler.Bookmarks.remove(mark.CLID);
    updatebookMarks;
  end else begin
    case mark.DocType of
      dtTask      : WindowHandler.openTaskWindow(mark.ID, mark.TypeID, mark.GremiumID, true);
      dtProtokoll :
       begin
         if m_doEdit then
           WindowHandler.openProtoCclWindow(mark.ID, true)
         else
           WindowHandler.openProtocolView(mark.ID);
       end;
    end;
  end;
end;

procedure TBookmarkFrame.LVDblClick(Sender: TObject);
begin
  ac_open.Execute;
end;

procedure TBookmarkFrame.LVKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  m_doEdit := ssCtrl in Shift;
end;

procedure TBookmarkFrame.LVKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  m_doEdit := false;
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
