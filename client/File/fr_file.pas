unit fr_file;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.StdCtrls, JvComponentBase, JvDragDrop, Vcl.Buttons, JvBaseDlg,
  JvBrowseFolder, FireDAC.UI.Intf, FireDAC.VCLUI.Async, FireDAC.Stan.Intf,
  FireDAC.Comp.UI, Vcl.ComCtrls, VirtualTrees, System.Generics.Collections,
  System.JSON, System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TFileFrame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    ListFilesQry: TClientDataSet;
    LitFilesSrc: TDataSource;
    JvDragDrop1: TJvDragDrop;
    OpenDialog1: TOpenDialog;
    JvBrowseForFolderDialog1: TJvBrowseForFolderDialog;
    FDGUIxAsyncExecuteDialog1: TFDGUIxAsyncExecuteDialog;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox1: TGroupBox;
    Button1: TBitBtn;
    Button2: TBitBtn;
    Button3: TBitBtn;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    GroupBox4: TGroupBox;
    ListFolder: TClientDataSet;
    VST: TVirtualStringTree;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    ac_new_folder: TAction;
    NeuerOrdner1: TMenuItem;
    ac_edit: TAction;
    Bearbeiten1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure JvDragDrop1Drop(Sender: TObject; Pos: TPoint; Value: TStrings);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DBGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure VSTGetCellText(Sender: TCustomVirtualStringTree;
      var E: TVSTGetCellTextEventArgs);
    procedure VSTFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure ac_new_folderExecute(Sender: TObject);
    procedure ac_editExecute(Sender: TObject);
    procedure VSTEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure VSTNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: string);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
  private
    type
      PTFolderRec = ^TFolderRec;
      TFolderRec = record
        Name  : string;
        Stamp : TDateTime;
        id    : integer;
        pid   : integer;
        next  : PTFolderRec;
        child : PTFolderRec;
      end;
  private
    m_grid    : integer;
    m_tempDir : string;
    m_list    : TList<PTFolderRec>;
    m_root    : PTFolderRec;

    procedure addChild( root, child : PTFolderRec );
    function getParent( pid : integer ) : PTFolderRec;

    procedure setID( value : integer );
    procedure showUploadForm( list : TStrings );
    function GetRO: boolean;
    procedure SetRO(const Value: boolean);
    function saveFile( fname : string ) : boolean;

    procedure ClearRecList;
    procedure buildTree;
    procedure updateView;
  public
    procedure prepare;
    property RootID : integer write setID;
    property RO: boolean read GetRO write SetRO;
    procedure release;

    function handle_folder_new( const arg : TJSONObject ) : boolean;
    function handle_folder_del( const arg : TJSONObject ) : boolean;
    function handle_folder_ren( const arg : TJSONObject ) : boolean;
  end;

implementation

uses
  m_glob_client, f_uploadForm, u_stub,
  system.IOUtils, System.Win.ComObj, System.Types, ShellApi, u_eventHandler,
  u_Konst, u_json;

{$R *.dfm}

{ TFileFrame }

procedure TFileFrame.ac_editExecute(Sender: TObject);
begin
  if Assigned(VST.GetFirstSelected()) then
    VST.EditNode(VST.GetFirstSelected, 0);
end;

procedure TFileFrame.ac_new_folderExecute(Sender: TObject);
var
  ptr       : PTFolderRec;
  client    : TdsFileClient;
  req, res  : TJSONObject;
  name      : string;
begin
  if not Assigned(VST.GetFirstSelected()) then exit;

  if not InputQuery('Neuer Ordner', 'Name', name) then exit;

  if trim(name) = '' then begin
    ShowMessage('Der Name darf nicht leer sein!');
    exit;
  end;
  if not TPath.HasValidPathChars(name, false) then begin
    ShowMessage('Der Name enthält ungültige Zeichen!');
    exit;
  end;


  ptr := PTFolderRec(VST.GetFirstSelected.GetData);

  client := TdsFileClient.Create(GM.SQLConnection1.DBXConnection);
  try
     req := TJSONObject.Create;
     JReplace( Req, 'pid', ptr^.id );
     JReplace( Req, 'grp', m_grid );
     JReplace( Req, 'name', name);

     res := client.newFolder(req);
     ShowResult(res);

  finally
    client.Free;
  end;
end;

procedure TFileFrame.addChild(root, child: PTFolderRec);
var
  ptr : PTFolderRec;
begin
  if not Assigned(root) or not Assigned(child) then
    exit;

  if not Assigned(root.child) then
    root.child := child
  else begin
    ptr := root.child;
    while Assigned(ptr^.next) do
      ptr := ptr^.next;
    ptr^.next := child;
  end;
end;

procedure TFileFrame.buildTree;
var
  ptr    : PTFolderRec;
  parent : PTFolderRec;
begin
  for ptr in m_list do begin
    parent := getParent(ptr^.pid);
    if Assigned(parent) then
      addChild(parent, ptr);
  end;
end;

procedure TFileFrame.Button1Click(Sender: TObject);
begin
  if ListFilesQry.ReadOnly then
    exit;
  if OpenDialog1.Execute then
  begin
    showUploadForm( OpenDialog1.Files );
  end;
end;

procedure TFileFrame.Button2Click(Sender: TObject);
var
  i     : integer;
  mark  : TBookmark;
  path  : string;
  fname : string;

begin
  if not JvBrowseForFolderDialog1.Execute then  exit;
  path := JvBrowseForFolderDialog1.Directory;

  for i := 0 to pred(DBGrid1.SelectedRows.Count) do
  begin
     mark := DBGrid1.SelectedRows.Items[i];
     ListFilesQry.GotoBookmark(mark);
     fname := TPath.Combine( path, ListFilesQry.FieldByName('FI_NAME').AsString );
     if not saveFile( fname ) then
       ShowMessage(Format('Die Datei %s konnte nicht heruntergeladen werden!',
       [ListFilesQry.FieldByName('FI_NAME').AsString]));
  end;
  if DBGrid1.SelectedRows.Count > 0 then
    ShellExecute(Handle, 'explore', PWideChar(path), '', '', SW_SHOWNORMAL);
end;

procedure TFileFrame.Button3Click(Sender: TObject);
var
  i : integer;
  del : Tlist<integer>;
  mark : TBookmark;
  client : TdsFileClient;
begin
  if ListFilesQry.ReadOnly then
    exit;

  del := Tlist<integer>.create;
  client := NIL;
   try
    client := TdsFileClient.Create(GM.SQLConnection1.DBXConnection);

    for i := 0 to pred(DBGrid1.SelectedRows.Count) do
    begin
      mark := DBGrid1.SelectedRows.Items[i];
      ListFilesQry.GotoBookmark(mark);
      del.Add( ListFilesQry.FieldByName('FI_ID').AsInteger);
    end;
    DBGrid1.SelectedRows.Clear;

    for i := 0 to pred(del.Count) do
      client.deleteFile(del[i]);
  finally
    client.Free;
  end;
  del.Free;
  ListFilesQry.Refresh;
end;

procedure TFileFrame.ClearRecList;
var
  ptr : PTFolderRec;
begin
  for ptr in m_list do
    dispose(ptr);
  m_list.clear;
end;

procedure TFileFrame.DBGrid1DblClick(Sender: TObject);
var
  fname : string;
begin
  if ListFilesQry.IsEmpty then
    exit;
  ForceDirectories(m_tempDir);
  fname := TPath.Combine(m_tempDir, ListFilesQry.FieldByName('FI_NAME').AsString);
  if not saveFile( fname ) then
    ShowMessage(Format('Die Datei %s konnte nicht heruntergeladen werden!',
    [ListFilesQry.FieldByName('FI_NAME').AsString]))
  else
    ShellExecute(Handle, 'open', PWideChar(fname), '', '', SW_SHOWNORMAL);
end;

procedure TFileFrame.DBGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := Assigned(VST.GetFirstSelected());
end;

function TFileFrame.getParent(pid: integer): PTFolderRec;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(m_list.Count) do begin
    if m_list[i]^.id = pid then begin
      Result := m_list[i];
      break;
    end;
  end;
end;

function TFileFrame.GetRO: boolean;
begin
  Result := ListFilesQry.ReadOnly;
end;

function TFileFrame.handle_folder_del(const arg: TJSONObject): boolean;
begin
  Result := false;
end;

function TFileFrame.handle_folder_new(const arg: TJSONObject): boolean;
var
  grp : integer;
  ptr : PTFolderRec;
  pptr: PTFolderRec;
begin
  Result := false;
  grp := JInt( arg, 'grid');
  if m_grid <> grp then
    exit;

  new(ptr);

  ptr^.Name := JString( arg, 'name');
  ptr^.id   := JInt(    arg, 'id');
  ptr^.pid  := Jint(    arg, 'pid');
  ptr^.Stamp:= JDouble( arg, 'stamp');

  pptr := getParent(ptr^.pid);
  if Assigned(pptr) then begin
    addChild(pptr, ptr);
    m_list.Add(ptr);
  end
  else
    dispose(ptr);

  updateView;
  Result := true;
end;

function TFileFrame.handle_folder_ren(const arg: TJSONObject): boolean;
var
  grp : integer;
  id  : integer;
  ptr : PTFolderRec;
begin
  Result := false;

  grp := JInt( arg, 'grid');
  if m_grid <> grp then
    exit;

  id := JInt( arg, 'id');
  for ptr in m_list do begin
    if ptr^.id = id then begin
      ptr^.Name := JString( arg, 'name');
      break;
    end;
  end;
  UpdateView;
  Result := true;
end;

procedure TFileFrame.JvDragDrop1Drop(Sender: TObject; Pos: TPoint;
  Value: TStrings);
begin
  if ListFilesQry.ReadOnly then
    exit;
  showUploadForm(value);
end;

procedure TFileFrame.prepare;
begin
  m_tempDir :=  TPath.Combine(TPath.GetTempPath, createClassID );
  m_list    := TList<PTFolderRec>.create;
  m_root    := NIL;
  vst.NodeDataSize := sizeof(TFolderRec);

  EventHandler.Register( self, handle_folder_new,   BRD_FOLDER_NEW );
  EventHandler.Register( self, handle_folder_del,   BRD_FOLDER_DEL );
  EventHandler.Register( self, handle_folder_ren,   BRD_FOLDER_REN );
end;

procedure TFileFrame.release;
var
  arr : TStringDynArray;
  i   : integer;
begin
  EventHandler.Unregister(self);
  ListFilesQry.Close;

  if DirectoryExists(m_tempDir) then begin
    arr := TDirectory.GetFiles(m_tempDir);
    for i := low(arr) to high(arr) do begin
      try
        DeleteFile(arr[i]);
      except

      end;
    end;
    setLength(arr, 0 );
  end;
  ClearRecList;
  m_list.free;
end;

function TFileFrame.saveFile(fname: string): boolean;
var
  src, dest : TSTream;
begin
  Result := false;
  Screen.Cursor := crHourGlass;
  src := ListFilesQry.CreateBlobStream(ListFilesQry.FieldByName('FI_DATA'), bmRead);
  try
    dest := TFileStream.Create( fname, fmCreate + fmShareDenyNone);
    dest.CopyFrom(src, -1);
    Result := true;
  except

  end;
  if Assigned(dest) then
    FreeAndNil(dest);

  src.Free;
  Screen.Cursor := crDefault;
end;

procedure TFileFrame.setID(value: integer);
var
  ptr : PTFolderRec;
begin
  m_grid := value;

  Screen.Cursor := crSQLWait;

  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  ListFolder.ParamByName('GRP').AsInteger := m_grid;
  ListFolder.Open;

  while not ListFolder.Eof do begin
    new(ptr);
    m_list.Add(ptr);

    ptr^.Name := ListFolder.FieldByName('DR_NAME').AsString;
    ptr^.Stamp:= ListFolder.FieldByName('DR_STAMP').AsDateTime;
    ptr^.id   := ListFolder.FieldByName('DR_ID').AsInteger;
    ptr^.pid  := ListFolder.FieldByName('DR_PARENT').AsInteger;
    ptr^.next := NIL;
    ptr^.child:= NIL;

    if ptr^.pid =0 then
      m_root := ptr;

    ListFolder.Next;
  end;
  ListFolder.Close;

  buildTree;
  m_root.Name := 'Root';
  updateView;

  Screen.Cursor := crDefault;
end;

procedure TFileFrame.SetRO(const Value: boolean);
begin
  ListFilesQry.ReadOnly  := value;
  JvDragDrop1.AcceptDrag := not Value;
end;

procedure TFileFrame.showUploadForm(list: TStrings);
var
  UploadForm : TUploadForm;
begin
  if not Assigned(VST.GetFirstSelected()) then exit;

  Application.CreateForm(TUploadForm, UploadForm);

  UploadForm.Dr_ID := PTFolderRec(VST.GetFirstSelected.GetData)^.id;

  UploadForm.List := list;
  if UploadForm.ShowModal = mrOk then
    ListFilesQry.Refresh;
  UploadForm.Free;
end;

procedure TFileFrame.updateView;
var
  id : integer;

  procedure clone( dest, src : PTFolderRec );
  begin
    dest^.Name  := src^.Name;
    dest^.Stamp := src^.Stamp;
    dest^.id    := src^.id;
    dest^.pid   := src^.pid;
    dest^.next  := NIL;
    dest^.child := NIL;
  end;
  procedure addChild(root : PVirtualNode; fld :PTFolderRec );
  var
    p   : PTFolderRec;
    ptr : PVirtualNode;
    sub : PVirtualNode;
  begin
    if not Assigned(fld) then
      exit;

    ptr := VST.AddChild(root);
    clone(PTFolderRec(ptr.GetData), fld);
    if fld^.id = id then
      VST.FocusedNode := ptr;


    addChild( ptr, fld.child);
    p := fld.next;
    while Assigned(p) do begin
      sub := VST.AddChild(root);
      clone(PTFolderRec(sub.GetData), p);
      if p^.id = id then
        VST.FocusedNode := sub;
      addChild( sub, p.child);
      p := p.next;
    end;
  end;

var
  ptr : PVirtualNode;
begin
  id := -1;
  if Assigned(VST.FocusedNode) then
    id := PTFolderRec(VST.FocusedNode.GetData)^.id;

  VST.Clear;
  ptr := vst.AddChild( NIL);
  clone( PTFolderRec(ptr.GetData), m_root);
  addChild( ptr, m_root.child);

  vst.FullExpand;
end;

procedure TFileFrame.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  ptr : PTFolderRec;
begin
  if not Assigned(Node) then  exit;

  ptr := PTFolderRec(node.GetData);

  ListFilesQry.Close;
  ListFilesQry.ParamByName('DR_ID').AsInteger := ptr^.id;
  ListFilesQry.Open;

end;

procedure TFileFrame.VSTEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := Column = 0;
end;

procedure TFileFrame.VSTFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  ptr : PTFolderRec;
begin
  ptr := PTFolderRec(Node.GetData);
  SetLength(ptr^.Name, 0);
end;

procedure TFileFrame.VSTGetCellText(Sender: TCustomVirtualStringTree;
  var E: TVSTGetCellTextEventArgs);
var
  ptr : PTFolderRec;
begin

  ptr := PTFolderRec(e.Node.GetData);

  case e.Column of
    0 : e.CellText := ptr^.Name;
    1 : e.CellText := DateTimeToStr(ptr^.Stamp);
  end;
end;

procedure TFileFrame.VSTNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; NewText: string);
var
  client    : TdsFileClient;
  req, res  : TJSONObject;
  ptr       : PTFolderRec;
begin
  if not TPath.HasValidFileNameChars(NewText, false) then begin
    ShowMessage('Es sind ungültige Zeichen enthalten');
    exit;
  end;

  ptr := PTFolderRec(node.GetData);

  client := TdsFileClient.Create(GM.SQLConnection1.DBXConnection);
  try
    Req := TJSONObject.Create;
    JReplace( req, 'id',      ptr^.id);
    JReplace( req, 'grid',    m_grid );
    JReplace( req, 'pid',     ptr^.pid);
    JReplace( req, 'newname', NewText);

    res := client.renameFolder(req);
    ShowResult(res);
  finally
    client.Free;
  end;
end;

end.
