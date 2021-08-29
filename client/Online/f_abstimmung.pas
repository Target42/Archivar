unit f_abstimmung;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, u_stub,
  System.JSON, Vcl.StdCtrls, System.Generics.Collections, System.ImageList,
  Vcl.ImgList, Vcl.Buttons;

type
  TVoteFunc = procedure( vote : integer ) of Object;

  TAbstimmungsForm = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    LV: TListView;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    FCanClose: boolean;

    m_user  : TJSONObject;
    m_votes : TDictionary<integer, integer>;
    m_users : TDictionary<integer, TListItem>;
    FdoVote: TVoteFunc;
    FBEID: integer;

    procedure setGroup( id, code : integer );
  public
    property CanClose   : boolean           read FCanClose    write FCanClose;

    property BEID: integer read FBEID write FBEID;

    property doVote: TVoteFunc read FdoVote write FdoVote;

    function handle_voteStart(const arg : TJSONObject ) : boolean;
    function handle_voteStop(const arg : TJSONObject ) : boolean;
    function handle_vote(const arg : TJSONObject ) : boolean;
  end;

var
  AbstimmungsForm: TAbstimmungsForm;

implementation

uses
  u_json, m_glob_client, u_Konst;

{$R *.dfm}

procedure TAbstimmungsForm.BitBtn1Click(Sender: TObject);
begin
  if Assigned(FdoVote) then
    FdoVote(VOTE_YES );
end;

procedure TAbstimmungsForm.BitBtn2Click(Sender: TObject);
begin
  if Assigned(FdoVote) then
    FdoVote(VOTE_NO );
end;

procedure TAbstimmungsForm.BitBtn3Click(Sender: TObject);
begin
  if Assigned(FdoVote) then
    FdoVote(VOTE_CONTAIN );
end;

procedure TAbstimmungsForm.BitBtn4Click(Sender: TObject);
begin
  if Assigned(FdoVote) then
    FdoVote(VOTE_NOT_DONE );
end;

procedure TAbstimmungsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
  if FCanClose then
    Action := caFree;

  if Assigned(m_user) then
    FreeAndNil(m_user);
end;

procedure TAbstimmungsForm.FormCreate(Sender: TObject);
begin
  FCanClose := false;
  FdoVote   := NIL;

  m_votes   := TDictionary<integer, integer>.create;
  m_user    := GM.getUserList;
  m_users   := TDictionary<integer, TListItem>.create;
end;

procedure TAbstimmungsForm.FormDestroy(Sender: TObject);
begin
  m_votes.Free;
  m_user.Free;
  m_users.Free;

  AbstimmungsForm := NIL;
end;

function TAbstimmungsForm.handle_vote(const arg: TJSONObject): boolean;
var
   obj : TJSONObject;
begin
  obj := JObject( arg, 'vote');
  setGroup( JInt( obj, 'usid'), JInt(obj, 'vote'));

  Result := true;
end;

function TAbstimmungsForm.handle_voteStart(const arg: TJSONObject): boolean;
var
  arr : TJSONArray;

  function findRow( id : integer ) : TJSONObject;
  var
    obj : TJSONObject;
    i   : integer;
  begin
    Result := NIL;
    for i := 0 to pred(arr.Count) do begin
      obj := getRow(arr, i);
      if JInt( obj, 'id') = id  then begin
        Result := obj;
        break;
      end;
    end;
  end;

  procedure addUser( obj : TJSONObject; id : integer );
  var
    item : TListItem;
  begin
    item          := LV.Items.Add;
    item.Data     := Pointer(id);
    item.Caption  := JString( obj, 'name');
    item.GroupID  := VOTE_NOT_DONE;
    item.SubItems.Add(JString(obj, 'vorname'));
    item.SubItems.Add(JString(obj, 'dept'));

    m_votes.AddOrSetValue(id, VOTE_NOT_DONE);
    m_users.AddOrSetValue(id, item);

    setGroup( id, VOTE_NOT_DONE );
  end;
var
  ids : TList<integer>;
  id  : integer;
  row : TJSONObject;
  data: TJSONObject;
begin
  data := JObject(arg, 'data');

  FBEID := JInt( data, 'beid');

  arr := JArray( m_user, 'user' );
  ids := getIntNumbers( data, 'user');
  for id in ids do begin
    row := findRow(id);
    if Assigned(row) then
      adduser(row, id);
  end;
  ids.Free;

  Result := true;
end;

function TAbstimmungsForm.handle_voteStop(const arg: TJSONObject): boolean;
var
  ids : TList<integer>;

  procedure addValues( code : integer );
  var
    id   : Integer;
  begin
    for id in ids do begin
      m_votes.AddOrSetValue(id, code);
      setGroup( id, code );
    end;
    ids.Free;
  end;

begin
  Result    := true;
  FCanClose := true;

  ids := getIntNumbers( arg, 'ja');
  addValues( VOTE_YES);

  ids := getIntNumbers( arg, 'nein');
  addValues( VOTE_NO);

  ids := getIntNumbers( arg, 'ja');
  addValues( VOTE_YES);

  ids := getIntNumbers( arg, 'na');
  addValues( VOTE_NOT_DONE);

  ids := getIntNumbers( arg, 'en');
  addValues( VOTE_CONTAIN);

  Result := true;
 end;

procedure TAbstimmungsForm.setGroup(id, code: integer);
begin
  if m_users.ContainsKey(id) then begin
    case code of
      VOTE_YES      : m_users[id].GroupID := 1;
      VOTE_NO       : m_users[id].GroupID := 2;
      VOTE_CONTAIN  : m_users[id].GroupID := 3;
      VOTE_NOT_DONE : m_users[id].GroupID := 4;
    end;
  end;
end;

end.
