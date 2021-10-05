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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    procedure updateList(Sender : TObject );
  public
    { Public-Deklarationen }
  end;

var
  FileCacheForm: TFileCacheForm;

implementation

uses
  m_fileCache, f_fileuploadform, u_stub, System.JSON, u_json;

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
  i : integer;
begin
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

end;

procedure TFileCacheForm.BitBtn3Click(Sender: TObject);
var
  client  : TdsFileCacheClient;
  ptr     : TFileCacheMod.TPEntry;
  req     : TJSONObject;
  res     : TJSONObject;
begin
  if not Assigned(LV.Selected) then
    exit;

  ptr := TFileCacheMod.TPEntry( LV.Selected.Data );

  try
    req := TJSONObject.Create;
    JReplace( req, 'fcid', ptr^.id);
    client := TdsFileCacheClient.Create(GM.SQLConnection1.DBXConnection);
    res := client.Lock(req);
    ShowResult( res );
    client.Free;

  except

  end;

end;

procedure TFileCacheForm.BitBtn4Click(Sender: TObject);
var
  client  : TdsFileCacheClient;
  ptr     : TFileCacheMod.TPEntry;
  req     : TJSONObject;
  res     : TJSONObject;
begin
  if not Assigned(LV.Selected) then
    exit;

  ptr := TFileCacheMod.TPEntry( LV.Selected.Data );

  try
    req := TJSONObject.Create;
    JReplace( req, 'fcid', ptr^.id);
    client := TdsFileCacheClient.Create(GM.SQLConnection1.DBXConnection);
    res := client.unlock(req);
    ShowResult( res );
    client.Free;
  except

  end;

end;

procedure TFileCacheForm.FormCreate(Sender: TObject);
begin
  FileCacheMod.Listner := updateList;
end;

procedure TFileCacheForm.FormDestroy(Sender: TObject);
begin
  FileCacheMod.Listner := NIL;
end;

procedure TFileCacheForm.updateList(Sender : TObject );
  function getGroup( name : string ) : integer;
  var
    i : integer;
    grp : TListGroup;
  begin
    Result  := 0;

    for i := 0 to pred(LV.Groups.Count) do begin
      if SameText(LV.Groups.Items[i].Header, name) then begin
        grp := LV.Groups.Items[i];
        break;
      end;
    end;

    if Result = 0 then begin
      grp := LV.Groups.Add;
      grp.Header := name;
      grp.GroupID := Lv.Groups.Count;
    end;

    Result := grp.GroupID;
  end;
var
  i : integer;
  item : TlistItem;
begin
  LV.Items.BeginUpdate;
  LV.Groups.Clear;
  LV.Items.Clear;
  for i := 0 to pred(FileCacheMod.Files.Count) do begin
    item          := LV.Items.Add;
    item.Caption  := FileCacheMod.Files.Items[i].name;
    item.SubItems.add( FileCacheMod.Files.Items[i].ts);
    item.SubItems.add( FileCacheMod.Files.Items[i].user );
    item.SubItems.add( FileCacheMod.Files.Items[i].tl );
    item.GroupID  := getGroup(FileCacheMod.Files.Items[i].cache);

    item.Data     := FileCacheMod.Files.Items[i];
  end;
  LV.Items.EndUpdate;
end;

end.
