unit fr_file;
{$WARN SYMBOL_DEPRECATED OFF}
interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.ExtCtrls,
  Vcl.StdCtrls, JvComponentBase, JvDragDrop, Vcl.Buttons, JvBaseDlg,
  JvBrowseFolder, FireDAC.UI.Intf, FireDAC.VCLUI.Async, FireDAC.Stan.Intf,
  FireDAC.Comp.UI, Vcl.ComCtrls, VirtualTrees, System.Generics.Collections,
  System.JSON, System.Actions, Vcl.ActnList, Vcl.Menus, Winapi.ActiveX,
  System.ImageList, Vcl.ImgList, DropTarget, DragDrop, DropSource, DragDropFile,
  f_uploadForm, Winapi.Windows, Vcl.AppEvnts;


type
  TFileFrame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    ListFilesQry: TClientDataSet;
    LitFilesSrc: TDataSource;
    OpenDialog1: TOpenDialog;
    JvBrowseForFolderDialog1: TJvBrowseForFolderDialog;
    FDGUIxAsyncExecuteDialog1: TFDGUIxAsyncExecuteDialog;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox1: TGroupBox;
    Button1: TBitBtn;
    Button2: TBitBtn;
    Button3: TBitBtn;
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
    ac_delete: TAction;
    LV: TListView;
    ImageList1: TImageList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    SpeedButton1: TSpeedButton;
    N1: TMenuItem;
    DropEmptyTarget1: TDropEmptyTarget;
    DataFormatAdapterTarget: TDataFormatAdapter;
    Timer1: TTimer;
    DropEmptySource1: TDropEmptySource;
    DataFormatAdapterSource: TDataFormatAdapter;
    ac_copy: TAction;
    ac_paste: TAction;
    procedure Button1Click(Sender: TObject);
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
    procedure ac_deleteExecute(Sender: TObject);
    procedure DBGrid1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure VSTDragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
      var Effect: Integer; var Accept: Boolean);
    procedure VSTDragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
      var ImageIndex: TImageIndex);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DropEmptyTarget1Enter(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure DropEmptyTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure DropEmptySource1AfterDrop(Sender: TObject;
      DragResult: TDragResult; Optimized: Boolean);
    procedure ac_copyExecute(Sender: TObject);
    procedure ac_pasteExecute(Sender: TObject);
    procedure LVMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LVMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
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
    m_curDir  : integer;
    m_tempDir : string;
    m_list    : TList<PTFolderRec>;
    m_root    : PTFolderRec;

    m_inupdate: boolean;

    m_dropFiles  : TStringList;

    procedure addChild( root, child : PTFolderRec );
    function getParent( pid : integer ) : PTFolderRec;

    procedure setID( value : integer );
    procedure showUploadForm( list : TStrings );
    function GetRO: boolean;
    procedure SetRO(const Value: boolean);

    function saveFile( id : integer; fname : string ) : boolean;

    procedure ClearRecList;
    procedure buildTree;
    procedure updateTree;
    procedure updateView;
    procedure updateFiles;

    function getFrame(ctrl : TControl ) : TFileFrame;

    procedure move( req : TJSONObject );

    procedure clearDropList;
    procedure UploadFiles( list : TStrings );

    procedure OnGetStream(Sender: TFileContentsStreamOnDemandClipboardFormat;
      Index: integer; out AStream: IStream);
  public
    procedure prepare;
    property RootID   : integer read m_grid write setID;
    property RO       : boolean read GetRO  write SetRO;
    procedure release;

    function handle_folder_new( const arg : TJSONObject ) : boolean;
    function handle_folder_del( const arg : TJSONObject ) : boolean;
    function handle_folder_ren( const arg : TJSONObject ) : boolean;
    function handle_folder_upd( const arg : TJSONObject ) : boolean;
    function handle_file_lock ( const arg : TJSONObject ) : boolean;

    function getFileList    : TJSONObject;
  end;

implementation

uses
  m_glob_client, u_stub,
  system.IOUtils, System.Win.ComObj, System.Types, ShellApi, u_eventHandler,
  u_Konst, u_json, f_file_info, DragDropFormats;

{$R *.dfm}

{ TFileFrame }

procedure TFileFrame.ac_copyExecute(Sender: TObject);
var
  i: integer;
begin
  TVirtualFileStreamDataFormat(DataFormatAdapterSource.DataFormat).FileNames.Clear;
  for i := 0 to LV.Items.Count-1 do
    if (LV.Items[i].Selected) then
      TVirtualFileStreamDataFormat(DataFormatAdapterSource.DataFormat).
        FileNames.Add(LV.Items[i].Caption);

  // ...and copy data to clipboard.
  DropEmptySource1.CopyToClipboard;
end;

procedure TFileFrame.ac_deleteExecute(Sender: TObject);
var
  ptr : PTFolderRec;
  client : TdsFileClient;
  res, req : TJSONObject;
begin

  if not Assigned(VST.FocusedNode) then exit;

  ptr := PTFolderRec(VST.FocusedNode.GetData);

  if ptr^.id = m_grid then begin
    ShowMessage('Dieser Ordner kann nicht gelöscht werden!');
    exit;
  end;

  client := TdsFileClient.Create( GM.SQLConnection1.DBXConnection);
  try
    req := TJSONObject.Create;

    JReplace( req, 'drid', ptr^.id);
    JReplace( req, 'grid', m_grid);

    res := client.deleteFolder(req);

    ShowResult(res);
  finally
    client.Free;
  end;
end;

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

procedure TFileFrame.ac_pasteExecute(Sender: TObject);
begin
  DropEmptyTarget1.PasteFromClipboard;
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

procedure TFileFrame.BitBtn1Click(Sender: TObject);
begin
  if not Assigned(LV.Selected) then  exit;

  // file info ...
  Application.CreateForm(TFileInfoForm, FileInfoForm);
  FileInfoForm.FileID := integer( LV.Selected.Data);
  FileInfoForm.Showmodal;
  FileInfoForm.free;
end;

procedure TFileFrame.BitBtn2Click(Sender: TObject);
var
  req, res  : TJSONObject;
  arr       : TJSONArray;
  i         : integer;
  client    : TdsFileClient;
begin
  Req := TJSONObject.Create;
  arr := TJSONArray.Create;
  JReplace( req, 'grid', m_grid );
  JReplace( req, 'drid', m_curDir );

  for i := 0 to pred(LV.Items.Count) do begin
    if LV.Items.Item[i].Checked then begin
      arr.AddElement(TJSONNumber.Create(integer( LV.Items.Item[i].Data)));
    end;
  end;
  if (arr.Count = 0) and Assigned(LV.Selected) then
    arr.AddElement(TJSONNumber.Create(integer( LV.Selected.Data)));

  JReplace( req, 'items', arr);

  client := TdsFileClient.Create(GM.SQLConnection1.DBXConnection);
  try
    Res := client.lock(req);
    ShowResult( res, true);
  except

  end;
  client.Free;
end;

procedure TFileFrame.BitBtn3Click(Sender: TObject);
var
  req, res  : TJSONObject;
  arr       : TJSONArray;
  i         : integer;
  client    : TdsFileClient;
begin
  Req := TJSONObject.Create;
  arr := TJSONArray.Create;
  JReplace( req, 'grid', m_grid );
  JReplace( req, 'drid', m_curDir );

  for i := 0 to pred(LV.Items.Count) do begin
    if LV.Items.Item[i].Checked then begin
      arr.AddElement(TJSONNumber.Create(integer( LV.Items.Item[i].Data)));
    end;
  end;
    if (arr.Count = 0) and Assigned(LV.Selected) then
    arr.AddElement(TJSONNumber.Create(integer( LV.Selected.Data)));
  JReplace( req, 'items', arr);

  client := TdsFileClient.Create(GM.SQLConnection1.DBXConnection);
  try
    Res := client.unlock(req);
    ShowResult( res, true);
  except

  end;
  client.Free;
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
var
  i : integer;
  mem : TMemoryStream;
begin
  if ListFilesQry.ReadOnly then
    exit;

  if OpenDialog1.Execute then
  begin
    for i := 0 to pred(OpenDialog1.Files.Count) do begin
      mem := TMemoryStream.Create;
      mem.LoadFromFile(OpenDialog1.Files[i]);
      m_dropFiles.AddObject(OpenDialog1.Files[i], mem)
    end;

    showUploadForm( OpenDialog1.Files );
  end;
end;

procedure TFileFrame.Button2Click(Sender: TObject);
var
  i     : integer;
  path  : string;
  fname : string;

begin
  if not JvBrowseForFolderDialog1.Execute then  exit;
  path := JvBrowseForFolderDialog1.Directory;

  if not ListFilesQry.Active then
    ListFilesQry.Open;

  for i := 0 to pred(LV.Items.Count) do
  begin
    if LV.Items.Item[i].Checked then begin
     fname := TPath.Combine( path, LV.Items.Item[i].Caption );
     if not saveFile( integer(LV.Items.Item[i].Data), fname ) then
       ShowMessage(Format('Die Datei %s konnte nicht heruntergeladen werden!',
       [LV.Items.Item[i].Caption]));
    end;
  end;
  ListFilesQry.close;

  ShellExecute(Handle, 'explore', PWideChar(path), '', '', SW_SHOWNORMAL);
end;

procedure TFileFrame.Button3Click(Sender: TObject);
var
  i : integer;
  client    : TdsFileClient;
  req, res  : TJSONObject;
  arr       : TJSONArray;
begin
  if ListFilesQry.ReadOnly then
    exit;

  req     := TJSONObject.Create;
  arr     := TJSONArray.Create;
  client  := NIL;
  for i := 0 to pred(LV.Items.Count) do
  begin
    if LV.Items.Item[i].Checked then
      arr.AddElement(TJSONNumber.Create(integer(LV.Items.Item[i].Data)));
  end;

  try
    client := TdsFileClient.Create(GM.SQLConnection1.DBXConnection);
    JReplace( req, 'items', arr);;
    Res := client.deleteFile(req);
    ShowResult(res)
  finally
    client.Free;
  end;
  updateFiles;
end;

procedure TFileFrame.clearDropList;
var
  i : integer;
begin
  for i := 0 to pred(m_dropFiles.Count) do begin
    if Assigned(m_dropFiles.Objects[i]) then
      TMemoryStream( m_dropFiles.Objects[i]).Free;
  end;
  m_dropFiles.Clear;
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
  if ListFilesQry.IsEmpty or not Assigned(LV.Selected) then   exit;

  ForceDirectories(m_tempDir);
  fname := TPath.Combine(m_tempDir, LV.Selected.Caption);
  if not saveFile( integer(LV.Selected.Data), fname ) then
    ShowMessage(Format('Die Datei %s konnte nicht heruntergeladen werden!',
    [LV.Selected.Caption]))
  else
    ShellExecute(Handle, 'open', PWideChar(fname), '', '', SW_SHOWNORMAL);
end;

procedure TFileFrame.DBGrid1DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  frm : TFileFrame;
  obj : TJSONObject;
begin
  //
  if Source is TListView then begin
    frm := getFrame( Source as TControl);
    obj := frm.getFileList;
    if Assigned(obj) then
      JReplace( obj, 'dest', m_curDir );
    move( obj );
  end;
  if Sender is TVirtualStringTree then begin
    ShowMessage('Sender = VST');
  end;
end;

procedure TFileFrame.DBGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := Assigned(VST.FocusedNode) and (Sender <> Source );
end;

procedure TFileFrame.DropEmptySource1AfterDrop(Sender: TObject;
  DragResult: TDragResult; Optimized: Boolean);
begin
  //
end;

procedure TFileFrame.DropEmptyTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  Buffer    : array of byte;
  i         : integer;
  Stream    : IStream;
  StatStg   : TStatStg;
  Size      : FixedUInt;
  st        : TStream;
const
  MaxBufferSize = 32*1024; // 32Kb
begin
  // Transfer the file names and contents from the data format.
  if (TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames.Count > 0) then
  begin
    try
      for i := 0 to TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames.Count-1 do
      begin
        Stream := TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileContentsClipboardFormat.GetStream(i);
        if (Stream <> nil) then
        begin
          Stream.Stat(StatStg, STATFLAG_NONAME);
          Stream.Seek(0, STREAM_SEEK_SET, PULargeinteger(nil)^);

          st    := TMemoryStream.Create;
          m_dropFiles.AddObject(TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames[i], st);
          SetLength(buffer, MaxBufferSize );
          repeat
            Stream.Read(@Buffer[0], MaxBufferSize, @Size);
            st.Write(buffer[0], Size);
          until Size <> MaxBufferSize;
        end;
        Stream := NIL;
      end;
    finally

    end;
    showUploadForm(m_dropFiles);
//    UploadFiles(m_dropFiles);
  end;
end;

procedure TFileFrame.DropEmptyTarget1Enter(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
begin
  with TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat) do
    if not(FileContentsClipboardFormat.HasValidFormats(DropEmptyTarget1.DataObject) and
      (AnsiFileGroupDescriptorClipboardFormat.HasValidFormats(DropEmptyTarget1.DataObject) or
       UnicodeFileGroupDescriptorClipboardFormat.HasValidFormats(DropEmptyTarget1.DataObject))) then
      Effect := DROPEFFECT_NONE;
end;

function TFileFrame.getFileList: TJSONObject;
var
  i   : integer;
  arr : TJSONArray;
begin
  Result := TJSONObject.Create;
  JReplace( Result, 'type', 'files');
  JReplace( Result, 'src', m_curDir );
  arr := TJSONArray.Create;
  for i := 0 to pred(LV.Items.Count) do begin
    if LV.Items.Item[i].Checked then
      arr.AddElement( TJSONNumber.Create(integer(LV.Items.Item[i].Data)));
  end;
  if (arr.Count = 0) and Assigned(LV.Selected) then
    arr.AddElement( TJSONNumber.Create(integer(LV.Selected.Data)));

  JReplace( Result, 'items', arr);
end;

function TFileFrame.getFrame(ctrl: TControl): TFileFrame;
begin
  Result := NIL;
  while assigned(ctrl) do begin
    if ctrl is TFileFrame then begin
      Result := ctrl as TFileFrame;
      break;
    end;
    ctrl := ctrl.Parent;
  end;
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

function TFileFrame.handle_file_lock(const arg: TJSONObject): boolean;
var
  list   : TList<Integer>;
  locked : boolean;
  i      : integer;
begin
  Result := false;
  if (m_grid <> JInt( arg, 'grid')) or (m_curDir <> JInt(arg, 'drid')) then
    exit;

  locked  := SameText(JString( arg, 'cmd'), 'lock');
  list    := JArrayToInteger( JArray(arg, 'items'));
  for i := 0 to pred(LV.Items.Count) do begin
    if list.IndexOf(Integer(LV.Items.Item[i].Data)) > -1 then begin
      if locked then
        LV.Items.Item[i].SubItems.Strings[4] := 'Ja'
      else
        LV.Items.Item[i].SubItems.Strings[4] := '';
      LV.Items.Item[i].Checked := false;
    end;
  end;
  list.Free;

  Result  := true;
end;

function TFileFrame.handle_folder_del(const arg: TJSONObject): boolean;
var
  grp : integer;
begin
  Result := false;
  grp := JInt( arg, 'grid');
  if m_grid <> grp then
    exit;

  updateTree;

  Result := true;
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
  ptr^.next := nil;
  ptr^.child:= nil;

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

function TFileFrame.handle_folder_upd(const arg: TJSONObject): boolean;
var
  grp : integer;
begin
  Result := false;
  grp := JInt( arg, 'grid');
  if m_grid <> grp then
    exit;
  if SameText(JString(arg, 'type'), 'files') then begin
    updateFiles;
  end else begin
    updateTree;
  end;
  Result := true;

end;

procedure TFileFrame.LVMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  if (LV.SelCount > 0) and
    (LV.GetHitTestInfoAt(X, Y) * [htOnItem, htOnIcon, htOnLabel, htOnStateIcon] <> []) and
    (DragDetectPlus(LV.Handle, Point(X,Y))) then
  begin
    // Transfer the file names to the data format. The content will be extracted
    // by the target on-demand.
    TVirtualFileStreamDataFormat(DataFormatAdapterSource.DataFormat).FileNames.Clear;
    for i := 0 to LV.Items.Count-1 do
      if (LV.Items[i].checked) then
        TVirtualFileStreamDataFormat(DataFormatAdapterSource.DataFormat).
          FileNames.Add(LV.Items[i].Caption);

    // ...and let it rip!
    DropEmptySource1.Execute;
  end;
end;

procedure TFileFrame.LVMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (LV.GetHitTestInfoAt(X, Y) * [htOnItem, htOnIcon, htOnLabel, htOnStateIcon] <> []) then
    Screen.Cursor := crHandPoint
  else
    Screen.Cursor := crDefault;
end;

procedure TFileFrame.move(req: TJSONObject);
var
  res : TJSONObject;
  client : TdsFileClient;
begin
  client := TdsFileClient.Create(GM.SQLConnection1.DBXConnection);
  try
    res := client.move(req);
    ShowResult(res);
  finally
    client.Free;
  end;

end;

procedure TFileFrame.OnGetStream(
  Sender: TFileContentsStreamOnDemandClipboardFormat; Index: integer;
  out AStream: IStream);
var
  Stream: TStream;
  i: integer;
  SelIndex: integer;
  id : integer;
  Found: boolean;
begin
  // This event handler is called by TFileContentsStreamOnDemandClipboardFormat
  // when the drop target requests data from the drop source (that's us).
  Stream := TMemoryStream.Create;
  if not ListFilesQry.Active then
    ListFilesQry.Open;

  try
    AStream := nil;
    // Find the listview item which corresponds to the requested data item.
    SelIndex := 0;
    Found := False;
    for i := 0 to LV.Items.Count-1 do
      if (LV.Items[i].checked) then
      begin
        if (SelIndex = Index) then
        begin
          // Get the data stored in the listview item and...
          id := integer(LV.Items[i].Data);
          if not ListFilesQry.Locate('FI_ID', VarArrayOf([id]), []) then
            exit;

          Stream := ListFilesQry.CreateBlobStream(ListFilesQry.FieldByName('FI_DATA'), bmRead);
          Found := True;
          break;
        end;
        inc(SelIndex);
      end;
    if (not Found) then
      exit;

    AStream := TFixedStreamAdapter.Create(Stream, soOwned);
  except
    Stream.Free;
    raise;
  end;
  ListFilesQry.Close;
end;

procedure TFileFrame.prepare;
begin
  (DataFormatAdapterSource.DataFormat as TVirtualFileStreamDataFormat).OnGetStream := OnGetStream;

  m_tempDir :=  TPath.Combine(TPath.GetTempPath, createClassID );
  m_list    := TList<PTFolderRec>.create;
  m_root    := NIL;
  m_curDir  := -1;
  vst.NodeDataSize := sizeof(TFolderRec);
  m_inupdate:= false;
  m_dropFiles := TStringList.Create;

  EventHandler.Register( self, handle_folder_new,   BRD_FOLDER_NEW );
  EventHandler.Register( self, handle_folder_del,   BRD_FOLDER_DEL );
  EventHandler.Register( self, handle_folder_ren,   BRD_FOLDER_REN );
  EventHandler.Register( self, handle_folder_upd,   BRD_FOLDER_UPDATE );
  EventHandler.Register( self, handle_file_lock,    BRD_FILE_LOCK);

  SpeedButton1.Caption := '';
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
        system.sysUtils.DeleteFile(arr[i]);
      except

      end;
    end;
    setLength(arr, 0 );
  end;
  ClearRecList;
  m_list.free;
  clearDropList;
  m_dropFiles.Free;

  DropEmptySource1.FlushClipboard;
end;

function TFileFrame.saveFile(id : integer; fname: string): boolean;
var
  src, dest : TSTream;
begin
  Result := false;
  if not ListFilesQry.Locate('FI_ID', VarArrayOf([id]), []) then
    exit;
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
begin
  m_grid := value;

  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  updateTree;
end;

procedure TFileFrame.SetRO(const Value: boolean);
begin
  ListFilesQry.ReadOnly   := value;
  GroupBox1.Enabled       := not Value;
end;

procedure TFileFrame.showUploadForm(list: TStrings);

begin
  if not Assigned(VST.FocusedNode) then begin
    clearDropList;
    exit;
  end;

  Application.CreateForm(TUploadForm, UploadForm);

  UploadForm.Dr_ID := PTFolderRec(VST.FocusedNode.GetData)^.id;
  UploadForm.AssignFiles( m_dropFiles );

  if UploadForm.ShowModal = mrOk then begin
    updateFiles;
  end;
  UploadForm.Free;

  clearDropList;
end;

procedure TFileFrame.updateFiles;
var
  item  : TListItem;
  size  : Int64;

begin
  Screen.Cursor := crSQLWait;
  LV.Items.BeginUpdate;
  LV.Items.Clear;
  with ListFilesQry do begin
    if Active then
      close;
    Open;
    first;
    while not eof do begin
      size := FieldByName('FI_SIZE').AsLargeInt;

      item := LV.Items.Add;
      item.Caption  := FieldByName('FI_NAME').AsString;
      item.SubItems.Add(GM.calcSize(size));
      item.SubItems.Add(FormatDateTime('dd.mm.yyyy', FieldByName('FI_TODELETE').AsDateTime));
      item.SubItems.Add(FieldByName('FI_VERSION').AsString);
      item.SubItems.Add(FieldByName('FI_CREATED_BY').AsString);
      if FieldByName('FI_LOCKED').AsString = 'T' then
        item.SubItems.Add('Ja')
      else
        item.SubItems.Add('');
      item.Data := Pointer(FieldByName('FI_ID').AsInteger);

      next;
      Application.ProcessMessages;
    end;
    close;
  end;
  LV.Items.EndUpdate;
  Screen.Cursor := crDefault;
end;

procedure TFileFrame.updateTree;
var
  ptr : PTFolderRec;
begin
  Screen.Cursor := crSQLWait;
  ClearRecList;

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

    if (ptr^.pid = ptr^.id) and( ptr^.id <> m_grid) then
      ptr^.pid := m_grid;

    if ptr^.pid =0 then
      m_root := ptr;

    ListFolder.Next;
  end;
  ListFolder.Close;

  buildTree;
  if Assigned(m_root) then
    m_root.Name := 'Root';
  updateView;

  Screen.Cursor := crDefault;
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
  if m_inupdate or not Assigned(m_root) then exit;

  m_inupdate := true;

  try
    id := -1;
    if Assigned(VST.FocusedNode) then
      id := PTFolderRec(VST.FocusedNode.GetData)^.id;

    VST.Clear;
    ptr := vst.AddChild( NIL);
    clone( PTFolderRec(ptr.GetData), m_root);
    addChild( ptr, m_root.child);

    vst.FullExpand;
    if not Assigned(vst.FocusedNode) then
      vst.FocusedNode := vst.GetFirst();

  finally
    m_inupdate := false;
  end;

  VSTChange(VST, vst.FocusedNode);

end;

procedure TFileFrame.UploadFiles(list: TStrings);
var
  client  : TdsFileClient;
  i       : integer;
  req     : TJSONObject;
  fs      : TStream;
begin
  client := TdsFileClient.Create(GM.SQLConnection1.DBXConnection);
  for i := 0 to pred(list.Count) do begin

    fs := list.Objects[i] as TStream;
    req := TJSONObject.Create;
    JReplace( req, 'fname',     ExtractFileName(list[i]));
    JReplace( req, 'todelete',  6);
    JReplace( req, 'type',      '');
    JReplace( req, 'drid',      m_curDir );
    JReplace( req, 'size',      fs.Size );

    client.upload(req, fs);
  end;
  client.free;
  list.Clear;

  updateFiles;
end;

procedure TFileFrame.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  ptr : PTFolderRec;
begin
  m_curDir := -1;
  if not Assigned(Node) then  exit;

  ptr := PTFolderRec(node.GetData);

  ListFilesQry.ParamByName('DR_ID').AsInteger := ptr^.id;

  UpdateFiles;

  m_curDir := ptr^.id;
end;

procedure TFileFrame.VSTDragDrop(Sender: TBaseVirtualTree; Source: TObject;
  DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
  Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  frm : TFileFrame;
  obj : TJSONObject;

  function getNode: PVirtualNode;
  begin
    Result := (Sender as TVirtualStringTree).GetNodeAt(pt);
    if not Assigned(Result) then
      Result := (Sender as TVirtualStringTree).GetFirst;
  end;

  procedure handleListView;
  var
    node : PVirtualNode;
    data : PTFolderRec;
  begin
    frm  := getFrame( source as TControl);
    obj  := frm.getFileList;
    node := getNode;
    data := PTFolderRec(node.GetData);
    JReplace( obj, 'dest', data^.id);
    move( obj );
  end;
  procedure handleTree;
  var
    node : PVirtualNode;
  begin
    obj  := TJSONObject.Create;
    JReplace( obj, 'type', 'folder');

    node := getNode;
    if Assigned(node) then begin
      JReplace( obj, 'dest', PTFolderRec(node.GetData).id);
      JReplace( obj, 'destgrp', m_grid );

      node := (Source as TVirtualStringTree).FocusedNode;
      frm  := getFrame( source as TControl);
      if Assigned(node) and Assigned(frm) then begin
        JReplace( obj, 'src', PTFolderRec(node.GetData).id);
        JReplace( obj, 'srcgrp', frm.RootID );

        move(obj);
      end;
    end;
  end;
begin
  if source is TListView then begin
    handleListView;
  end else if Source is TVirtualStringTree then
    handleTree;
end;

procedure TFileFrame.VSTDragOver(Sender: TBaseVirtualTree; Source: TObject;
  Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
  var Effect: Integer; var Accept: Boolean);
var
  DestNode  : PVirtualNode;
  SrcNode   : PVirtualNode;

  function isChild(node : PVirtualNode) : boolean;
  var
    ptr : PVirtualNode;
  begin
    Result := destNode = node;
    if not Result then begin
      ptr := (Source as TVirtualStringTree).GetFirstChild(node);
      while Assigned(ptr) do begin
        Result := isChild(ptr);
        ptr := (Source as TVirtualStringTree).GetNextSibling(ptr);
      end;
    end;
  end;

begin
  Accept := ( source is TListView);

  srcNode  := NIL;
  destNode := (Sender as TVirtualStringTree).GetNodeAt(Pt);
  if Assigned(Source) and ( source is TVirtualStringTree) then
    srcNode  := (Source as TVirtualStringTree).FocusedNode;

  if Source = Sender then begin
    Accept := (srcNode <> DestNode) and not isChild(srcNode);

    if Assigned(DestNode) and Assigned(SrcNode) then
      Accept := PTFolderRec(SrcNode.GetData)^.pid <>
                PTFolderRec(DestNode.GetData)^.id;
  end else if (Source is TVirtualStringTree) then begin
    Accept := ( source <> Sender );
    if Assigned(SrcNode) then
      Accept := PTFolderRec(SrcNode.GetData)^.pid <> 0;
  end;
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
    1 : e.CellText := FormatDateTime('dd.mm.yyyy hh:nn',  ptr^.Stamp);
  end;
end;

procedure TFileFrame.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex);
begin
  if (Kind in [ikNormal, ikSelected] ) then begin
    if Column > 0 then exit;

    if vsExpanded in node.States then
      ImageIndex := 1
    else
      ImageIndex := 0;
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
