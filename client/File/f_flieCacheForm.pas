unit f_flieCacheForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, m_glob_client;

type
  TFileCacheForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LV: TListView;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    function lockDocument( fc_id, us_id : integer; showResult : boolean = true ) : boolean;
    function unlocDocument( fc_id, us_id : integer; showResult : boolean = true ) : boolean;

    procedure updateList(Sender : TObject );
  public
    { Public-Deklarationen }
  end;

var
  FileCacheForm: TFileCacheForm;

implementation

uses
  m_fileCache, f_fileuploadform, u_stub, System.JSON, u_json, system.IOUtils,
  f_web_editor;

{$R *.dfm}

{ TFileCacheForm }

procedure TFileCacheForm.BitBtn1Click(Sender: TObject);
var
  name, cache : string;
  i           : integer;
begin
  if not Assigned(lv.Selected) then
    exit;

  name  := LV.Selected.Caption;
  for i := 0 to pred(LV.Groups.Count) do begin
    if LV.Groups.Items[i].GroupID = LV.Selected.GroupID then begin
      cache := LV.Groups.Items[i].Header;
      break;
    end;
  end;
  if (name <> '') and (cache <> '') then begin
    FileCacheMod.deleteFile(cache, name);
  end;
end;

procedure TFileCacheForm.BitBtn2Click(Sender: TObject);
var
  i     : integer;
  fname : string;
  ptr   : TFileCacheMod.TPEntry;
  localChanged : boolean;
begin
  localChanged  := false;
  ptr           := NIL;
  if Assigned(LV.Selected) then begin
    ptr   := TFileCacheMod.TPEntry(LV.Selected.Data);
    fname := TPath.Combine(GM.Cache, format('%s\%s', [ptr^.cache, ptr^.name]));
    localChanged  := ptr^.md5 <> GM.md5(fname);
  end;

  if not localChanged then begin
    Application.CreateForm(TFileUploadForm, FileUploadForm);

    for i := 0 to pred(FileCacheMod.Files.Count) do begin
      if FileUploadForm.Dirs.IndexOf(FileCacheMod.Files.Items[i].cache) = -1  then
        FileUploadForm.Dirs.Add(FileCacheMod.Files.Items[i].cache);
    end;

    try
      FileUploadForm.ShowModal;
    finally
      FileUploadForm.Free;
    end;
  end else begin
    // upload local ..
    if Assigned(ptr) then
      FileCacheMod.upload(ptr^.cache, ptr^.name,fname);
  end;

end;

procedure TFileCacheForm.BitBtn3Click(Sender: TObject);
var
  ptr     : TFileCacheMod.TPEntry;
begin
  if not Assigned(LV.Selected) then
    exit;

  ptr := TFileCacheMod.TPEntry( LV.Selected.Data );
  lockDocument(ptr^.id, GM.UserID );
end;

procedure TFileCacheForm.BitBtn4Click(Sender: TObject);
var
  ptr     : TFileCacheMod.TPEntry;
begin
  if not Assigned(LV.Selected) then
    exit;

  ptr := TFileCacheMod.TPEntry( LV.Selected.Data );
  unlocDocument( ptr^.id, GM.UserID);
end;

procedure TFileCacheForm.BitBtn5Click(Sender: TObject);
var
  ptr: TFileCacheMod.TPEntry;
  fname: string;
begin
  if not Assigned(LV.Selected) then
    exit;

  ptr := TFileCacheMod.TPEntry(LV.Selected.Data);

  Application.CreateForm(TWebEditorForm, WebEditorForm);
  if not WebEditorForm.canEdit(ptr^.name) then
  begin
    ShowMessage
      ('Das Dokument kann mit dem internen Editor nioht bearbeitet werden.');
    WebEditorForm.Free;

    exit;
  end;

  fname := FileCacheMod.getFile(ptr^.cache, ptr^.name);

  try
    if lockDocument(ptr^.id, GM.UserID, false) then
    begin
      WebEditorForm.FileName := fname;
      if WebEditorForm.ShowModal = mrOk then
      begin
        FileCacheMod.upload(ptr^.cache, ptr^.name, fname);
      end;
      unlocDocument(ptr^.id, GM.UserID, false);
    end
    else
      ShowMessage('Das Dokument konnte nicht gesperrt werden!');
  except

  end;
  WebEditorForm.Free;

end;

procedure TFileCacheForm.FormCreate(Sender: TObject);
begin
  FileCacheMod.Listner := updateList;
end;

procedure TFileCacheForm.FormDestroy(Sender: TObject);
begin
  FileCacheMod.Listner := NIL;
end;

function TFileCacheForm.lockDocument(fc_id, us_id: integer;
  showResult: boolean): boolean;
var
  client  : TdsFileCacheClient;
  req     : TJSONObject;
  res     : TJSONObject;
begin
  Result := false;
  try
    req := TJSONObject.Create;
    JReplace( req, 'fcid', fc_id);
    JReplace( req, 'usid', us_id );
    client := TdsFileCacheClient.Create(GM.SQLConnection1.DBXConnection);
    res := client.Lock(req);
    if showResult then
      m_glob_client.ShowResult( res );
    Result := JBool( res, 'result', false);
    client.Free;
  except

  end;
end;

function TFileCacheForm.unlocDocument(fc_id, us_id: integer;
  showResult: boolean): boolean;
var
  client  : TdsFileCacheClient;
  req     : TJSONObject;
  res     : TJSONObject;
begin
  Result := false;

  try
    req := TJSONObject.Create;
    JReplace( req, 'fcid', fc_id);
    JReplace( req, 'usid', us_id );
    client := TdsFileCacheClient.Create(GM.SQLConnection1.DBXConnection);
    res := client.unlock(req);
    if showResult then
      m_glob_client.ShowResult( res );
    Result := JBool( res, 'result', false);
    client.Free;
  except

  end;

end;

procedure TFileCacheForm.updateList(Sender : TObject );
  function getGroup( name : string ) : integer;
  var
    i : integer;
    grp : TListGroup;
  begin
    grp     := NIL;
    for i := 0 to pred(LV.Groups.Count) do begin
      if SameText(LV.Groups.Items[i].Header, name) then begin
        grp := LV.Groups.Items[i];
        break;
      end;
    end;

    if not Assigned(grp) then begin
      grp := LV.Groups.Add;
      grp.Header := name;
      grp.GroupID := Lv.Groups.Count;
    end;

    Result := grp.GroupID;
  end;
var
  i, j  : integer;
  item  : TlistItem;
  fname : string;
  max   : integer;
  len   : integer;
begin
  LV.Items.BeginUpdate;
  LV.Groups.Clear;
  LV.Items.Clear;
  for i := 0 to pred(FileCacheMod.Files.Count) do begin

    fname := TPath.Combine(GM.Cache, Format('%s\%s',
      [FileCacheMod.Files.Items[i].cache, FileCacheMod.Files.Items[i].name ]));

    item          := LV.Items.Add;
    item.Caption  := FileCacheMod.Files.Items[i].name;
    item.SubItems.add( FileCacheMod.Files.Items[i].ts);

    if FileCacheMod.Files.Items[i].md5 <> GM.md5(fname) then
      item.SubItems.add( 'Ja')
    else
      item.SubItems.add( '' );

    item.SubItems.add( FileCacheMod.Files.Items[i].user );
    item.SubItems.add( FileCacheMod.Files.Items[i].tl );
    item.GroupID  := getGroup(FileCacheMod.Files.Items[i].cache);

    item.Data     := FileCacheMod.Files.Items[i];
  end;

  for i := 0 to pred(LV.Columns.Count) do begin
    max := LV.Canvas.TextWidth(LV.Columns.Items[i].Caption);
    for j := 0 to pred(LV.Items.Count) do begin
      if i = 0 then
        len := LV.Canvas.TextWidth(LV.Items.Item[j].Caption)
      else
        len := LV.Canvas.TextWidth(LV.Items.Item[j].SubItems.Strings[i-1]);
      if len > max then
        max := len;
    end;
    LV.Columns.Items[i].Width := max + 16;
  end;

  LV.Items.EndUpdate;
end;

end.
