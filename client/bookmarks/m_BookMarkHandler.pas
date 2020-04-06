unit m_BookMarkHandler;

interface

uses
  System.SysUtils, System.Classes, u_bookmarkList;

type
  TBookMarkHandler = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_bookmarks : TBookmarkList;
  public
    property Bookmarks : TBookmarkList read m_bookmarks;
  end;

var
  BookMarkHandler: TBookMarkHandler;

implementation

uses
  m_glob_client;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TBookMarkHandler.DataModuleCreate(Sender: TObject);
begin
  m_bookmarks := TBookmarkList.create;
  m_bookmarks.load(GM.Home);
end;

procedure TBookMarkHandler.DataModuleDestroy(Sender: TObject);
begin
  m_bookmarks.save(GM.Home);
  FreeAndNil(m_bookmarks);
end;

end.
