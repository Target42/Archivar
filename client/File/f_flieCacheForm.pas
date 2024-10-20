unit f_flieCacheForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, m_glob_client, Vcl.ExtCtrls, VirtualTrees, m_fileCache,
  System.ImageList, Vcl.ImgList, PngImageList, System.Generics.Collections;

type
  TFileCacheForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    VST: TVirtualStringTree;
    PngImageList1: TPngImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure VSTFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
      var ImageIndex: TImageIndex);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
  private
    type
      PTVSTData = ^TVSTData;
      TVSTData = record
        name    : string;
        changed : boolean;
        ptr     : TFileCacheMod.TPEntry;
        imageInx: integer;
      end;
  private
    m_ext : TStringList;
    m_selectedID : integer;
    m_inUpdate : boolean;

    function lockDocument( fc_id, us_id : integer; showResult : boolean = true ) : boolean;
    function unlocDocument( fc_id, us_id : integer; showResult : boolean = true ) : boolean;

    procedure updateList(Sender : TObject );
    procedure updateTreeView;
  public
    { Public-Deklarationen }
  end;

var
  FileCacheForm: TFileCacheForm;

implementation

uses
  f_fileuploadform, u_stub, System.JSON, u_json, system.IOUtils,
  f_web_editor;

{$R *.dfm}

{ TFileCacheForm }

procedure TFileCacheForm.BitBtn1Click(Sender: TObject);
var
  ptr : PTVSTData;
begin
  if not Assigned(VST.FocusedNode) then
    exit;

  ptr := VST.FocusedNode.GetData;
  if not Assigned(ptr) then
    exit;

  FileCacheMod.deleteFile( ptr^.ptr^.cache, ptr^.ptr^.name);
end;

procedure TFileCacheForm.BitBtn2Click(Sender: TObject);
var
  i     : integer;
  fname : string;
  ptr   : PTVSTData;
  localChanged : boolean;

begin
  if not Assigned(VST.FocusedNode) then
    exit;

  ptr := VST.FocusedNode.GetData;
  if not Assigned(ptr) then
    exit;

  fname := TPath.Combine(GM.Cache, format('%s\%s', [ptr^.ptr^.cache, ptr^.ptr^.name]));
  localChanged  := ptr^.ptr^.md5 <> GM.md5(fname);


  if not localChanged then
  begin
    Application.CreateForm(TFileUploadForm, FileUploadForm);

    for i := 0 to pred(FileCacheMod.Files.Count) do
    begin
      if FileUploadForm.Dirs.IndexOf(FileCacheMod.Files.Items[i].cache) = -1  then
        FileUploadForm.Dirs.Add(FileCacheMod.Files.Items[i].cache);
    end;

    try
      FileUploadForm.ShowModal;
    finally
      FileUploadForm.Free;
    end;
  end
  else
  begin
    // upload local ..
    if Assigned(ptr) then
      FileCacheMod.upload(ptr^.ptr^.cache, ptr^.ptr^.name,fname);
  end;

end;

procedure TFileCacheForm.BitBtn3Click(Sender: TObject);
var
  ptr     : PTVSTData;
begin
  if not Assigned(VST.FocusedNode) then
    exit;

  ptr := VST.FocusedNode.GetData;
  if not Assigned(ptr) then
    exit;

  lockDocument(ptr^.ptr^.id, GM.UserID );

end;

procedure TFileCacheForm.BitBtn4Click(Sender: TObject);
var
  ptr     : PTVSTData;
begin
  if not Assigned(VST.FocusedNode) then
    exit;

  ptr := VST.FocusedNode.GetData;
  if not Assigned(ptr) then
    exit;

  unlocDocument( ptr^.ptr^.id, GM.UserID);
end;

procedure TFileCacheForm.BitBtn5Click(Sender: TObject);
var
  ptr     : PTVSTData;
  fname   : string;
begin
  if not Assigned(VST.FocusedNode) then
    exit;

  ptr := VST.FocusedNode.GetData;
  if not Assigned(ptr) then
    exit;

  Application.CreateForm(TWebEditorForm, WebEditorForm);
  if not WebEditorForm.canEdit(ptr^.ptr^.name) then
  begin
    ShowMessage
      ('Das Dokument kann mit dem internen Editor nicht bearbeitet werden.');
    WebEditorForm.Free;

    exit;
  end;

  fname := FileCacheMod.getFile(ptr^.ptr^.cache, ptr^.ptr^.name);

  try
    if lockDocument(ptr^.ptr^.id, GM.UserID, false) then
    begin
      WebEditorForm.FileName := fname;
      if WebEditorForm.ShowModal = mrOk then
      begin
        FileCacheMod.upload(ptr^.ptr^.cache, ptr^.ptr^.name, fname);
      end;
      unlocDocument(ptr^.ptr^.id, GM.UserID, false);
    end
    else
      ShowMessage('Das Dokument konnte nicht gesperrt werden!');
  except

  end;
  WebEditorForm.Free;
end;

procedure TFileCacheForm.FormCreate(Sender: TObject);
begin
  VST.NodeDataSize := sizeof(TVSTData);
  m_ext := TStringList.Create;
  m_ext.StrictDelimiter := true;
  m_ext.Delimiter := ';';
  m_ext.DelimitedText := ';.html;.pas;.py;.txt;.xml;.json;.ini';
  m_selectedID := -1;
  m_inUpdate := false;
  FileCacheMod.Listner := updateList;

end;

procedure TFileCacheForm.FormDestroy(Sender: TObject);
begin
  FileCacheMod.Listner := NIL;
  m_ext.Free;
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
begin
  updateTreeView;
end;


procedure TFileCacheForm.updateTreeView;
var
  list : TStringList;

  function changed( ptr : TFileCacheMod.TPEntry ) : boolean;
  var
    fname : string;
  begin
    fname := TPath.Combine(GM.Cache, Format('%s\%s',
      [ptr.cache, ptr.name ]));
    Result := ptr.md5 <> GM.md5(fname);
  end;

  procedure cleanList;
  var
    i : integer;
  begin
    for i := pred(list.Count) downto 0 do
    begin
      if trim(list[i]) = '' then
        list.Delete(i);
    end;
  end;

  function getNode( path : string ) : PVirtualNode;
  var
    node : PVirtualNode;
    sub : PVirtualNode;
    ptr  : PTVSTData;
  begin
    node := VST.GetFirst;
    list.DelimitedText := path;

    cleanList;

    while list.Count > 0 do
    begin
      sub := VST.GetFirstChild(node);
      while Assigned(sub) do
      begin
        if not Assigned(sub) then
          break;

        ptr := sub.GetData;
        if SameText(ptr^.name, list[0]) then
        begin
          list.Delete(0);
          node := sub;
          break;
        end
        else
          sub := VST.GetNextSibling(sub);
      end;

      if not Assigned(sub) then
      begin
        node := VST.AddChild(node);
        ptr := node.GetData;
        ptr^.name := list[0];
        ptr^.ptr  := NIL;
        ptr^.imageInx := 0;
        list.Delete(0);
      end;
    end;
    Result := node;
  end;

var
  ptr  : PTVSTData;
  node : PVirtualNode;
  sub  : PVirtualNode;
  en   : TFileCacheMod.TPEntry;
  s    : string;
begin
  list := TStringList.Create;
  list.StrictDelimiter := true;
  list.Delimiter := '\';

  VST.BeginUpdate;
  m_inUpdate := true;
  VST.Clear;

  node := VST.AddChild(NIL);
  ptr := node.GetData;
  ptr^.name := 'Root';
  ptr^.ptr  := NIL;

  for en in FileCacheMod.Files do
  begin
    node := getNode(en.cache);
    sub  := VST.AddChild(node);
    ptr  := sub.GetData;

    ptr^.changed := changed(en);
    ptr^.ptr     := en;
    s := LowerCase(ExtractFileExt(en.name));
    ptr^.imageInx := m_ext.IndexOf(s);
  end;

  VST.FullExpand();
  VST.EndUpdate;

  node := VST.GetFirst();
  while Assigned(node) do
  begin
    ptr := node.GetData;

    if Assigned(ptr) and Assigned(ptr^.ptr) and ( ptr^.ptr^.id = m_selectedID) then
    begin
      VSt.FocusedNode := node;
      break;
    end;
    node := VST.GetNext(node);
  end;


  m_inUpdate := false;

  list.Free;
end;

procedure TFileCacheForm.VSTChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  ptr : PTVSTData;
begin
  if not Assigned(node) or m_inUpdate then
    exit;

  ptr := node.GetData;
  if Assigned(ptr) and Assigned(ptr^.ptr) then
    m_selectedID := ptr^.ptr^.id;
end;

procedure TFileCacheForm.VSTFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  ptr : PTVSTData;
begin
  ptr := node.GetData;
  SetLength(ptr^.name, 0);
end;

procedure TFileCacheForm.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex);
var
  ptr : PTVSTData;
begin
  ptr := node.GetData;
  if (Column = 0) and ( kind in [ ikNormal, ikSelected ]) then
  begin
    ImageIndex := ptr^.imageInx;
  end;
end;

procedure TFileCacheForm.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  ptr : PTVSTData;
begin
  ptr := node.GetData;
  CellText := '';

  case Column of
    0 :
    begin
      if not Assigned(ptr^.ptr) then
        CellText := ptr^.name
      else
        CellText := ptr^.ptr^.name;
    end;
    1 : if Assigned(ptr^.ptr) then CellText := ptr^.ptr^.ts;
    2 : if ptr^.changed then CellText := 'Ja';
    3 : if Assigned(ptr^.ptr) then CellText := ptr^.ptr^.tl;
    4 : if Assigned(ptr^.ptr) then CellText := ptr^.ptr^.user;
  end;
end;

end.
