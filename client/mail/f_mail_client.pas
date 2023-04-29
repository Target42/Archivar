unit f_mail_client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.StdCtrls, Vcl.ComCtrls, System.Generics.Collections,
  System.JSON, Vcl.ExtCtrls, VirtualTrees, IdBaseComponent, IdMessage,
  Vcl.Imaging.pngimage, fr_mails, Vcl.OleCtrls, SHDocVw, System.ImageList,
  Vcl.ImgList, DragDrop, DropSource, DragDropFile, Winapi.ActiveX, DropTarget;

type
  TMailClientForm = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    DSProviderConnection1: TDSProviderConnection;
    Accounts: TClientDataSet;
    TV: TTreeView;
    Folder: TClientDataSet;
    Mails: TClientDataSet;
    Panel1: TPanel;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    IdMessage1: TIdMessage;
    Image1: TImage;
    Splitter2: TSplitter;
    MailFrame1: TMailFrame;
    WebBrowser1: TWebBrowser;
    Panel2: TPanel;
    GroupBox3: TGroupBox;
    Splitter3: TSplitter;
    Lv: TListView;
    ImageList1: TImageList;
    DataFormatAdapterSource: TDataFormatAdapter;
    DropEmptySource1: TDropEmptySource;
    DropDummy1: TDropDummy;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    procedure VSTPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure MailFrame1VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure LvMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure LvMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    type
      Account = class
        private
          FName: string;
          FeMail: string;
          FID: integer;
          m_folder : TStringList;
          FData: TJSONObject;
        public
          constructor create;
          Destructor Destroy; override;

          property Name: string read FName write FName;
          property eMail: string read FeMail write FeMail;
          property ID: integer read FID write FID;
          property Folder : TStringList read m_folder;
          property Data: TJSONObject read FData write FData;

          function FullName : string;
      end;
    procedure OnGetStream(Sender: TFileContentsStreamOnDemandClipboardFormat;
      Index: integer; out AStream: IStream);

  private
    m_ext      : TDictionary<string, integer>;
    m_accounts : TList<Account>;
    m_inUpdate : boolean;
    m_tempdir  : string;
    m_files    : TStringList;

    procedure updateTree;
    procedure fillExtDict;
    procedure AddAttachemnts;
  public
    { Public-Deklarationen }
  end;

var
  MailClientForm: TMailClientForm;

implementation

uses
  m_glob_client, u_json, System.Generics.Defaults, System.DateUtils, u_TMail,
  u_mail_decoder, m_fileCache, System.IOUtils, DragDropFormats;

{$R *.dfm}

procedure TMailClientForm.AddAttachemnts;
var
  item : TListItem;
  i    : integer;
  ext  : string;
  inx  : integer;
begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;

  for i := 0 to pred(m_files.Count) do begin
    item := LV.Items.Add;
    item.Data := pointer(i);
    item.Caption := ExtractFileName(m_files[i]);
    inx := 0;
    ext := LowerCase(ExtractFileExt(m_files[i]));
    m_ext.TryGetValue(ext, inx);
    item.ImageIndex := inx;
  end;
  LV.Items.EndUpdate;
end;

procedure TMailClientForm.fillExtDict;
begin
  // text
  m_ext.Add('.txt',   9);
  // Archive
  m_ext.Add('.zip',   1);
  m_ext.Add('.7z',    1);
  m_ext.Add('.rar',   1);
  m_ext.Add('.tar',   1);
  //excel
  m_ext.Add('.csv',   2);
  m_ext.Add('.xlsx',  5);
  m_ext.Add('.xls',   11);
  //images
  m_ext.Add('.png',   7);
  m_ext.Add('.jpg',   4);
  m_ext.Add('.jpeg',  4);
  m_ext.Add('.gif',   3);
  //powerpoint
  m_ext.Add('.ppt',   8);
  m_ext.Add('.pptx',  8);
  //pdf
  m_ext.Add('.pdf',   6);
  //word
  m_ext.Add('.docx',  10);
end;

procedure TMailClientForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMailClientForm.FormCreate(Sender: TObject);
var
  acc : Account;
  procedure unpackImap;
  var
    st : TStream;
    obj : TJSONObject;
    imap : TJSONObject;
  begin
    st := Accounts.CreateBlobStream(Accounts.FieldByName('MAC_DATA'), bmRead);
    obj := loadJSON(st);
    st.Free;
    if Assigned(obj) then begin

      imap := JObject(obj, 'imap');

      acc.eMail := Jstring( imap, 'user');
      acc.Data  := obj;
    end;
  end;
  procedure addFolder;
  begin
    Folder.Filter := 'MAC_ID='+Accounts.FieldByName('MAC_ID').AsString;
    Folder.Filtered := true;
    Folder.First;
    while not Folder.Eof do begin
      if Folder.FieldByName('MAF_ACTIVE').AsString = 'T' then
        acc.Folder.AddPair(Folder.FieldByName('MAF_NAME').AsString, Folder.FieldByName('MAF_ID').AsString);
      Folder.Next;
    end;
  end;
begin
  m_inUpdate        := false;

  m_tempdir := TPath.Combine(TPath.GetTempPath, IntToHex(GetTickCount) );
  ForceDirectories(m_tempdir);

  m_files    := TStringList.Create;
  m_ext := TDictionary<string, integer>.create;
  fillExtDict;

  (DataFormatAdapterSource.DataFormat as TVirtualFileStreamDataFormat).OnGetStream := OnGetStream;

  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_accounts := TList<Account>.create;
  MailFrame1.prepare;

  WebBrowser1.Navigate('about:blank');

  Accounts.Open;
  folder.Open;
  while not Accounts.Eof do begin
    if Accounts.FieldByName('MAC_ACTIVE').AsString = 'T' then begin
      acc := Account.create;
      m_accounts.Add(acc);
      acc.Name := Accounts.FieldByName('MAC_TITLE').AsString;
      acc.ID   :=  Accounts.FieldByName('MAC_ID').AsInteger;
      if Accounts.FieldByName('MAC_TYPE').AsString = 'imap/smtp' then
        UnpackImap;
      addFolder;
    end;
    Accounts.Next;
  end;
  Accounts.Close;
  Folder.Close;

  updateTree;
end;

procedure TMailClientForm.FormDestroy(Sender: TObject);
var
  acc : Account;
begin
  for acc in m_accounts do
    acc.Free;
  m_accounts.Free;

  MailFrame1.release;
  TMailDecoder.clearFiles(m_tempdir);
  m_files.Free;

  DropEmptySource1.FlushClipboard;
end;

procedure TMailClientForm.LvMouseDown(Sender: TObject; Button: TMouseButton;
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
      if (LV.Items[i].Selected) then
        TVirtualFileStreamDataFormat(DataFormatAdapterSource.DataFormat).
          FileNames.Add( m_files[integer(LV.Items[i].Data)]);

    // ...and let it rip!
    DropEmptySource1.Execute;
  end;
end;

procedure TMailClientForm.LvMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (LV.GetHitTestInfoAt(X, Y) * [htOnItem, htOnIcon, htOnLabel, htOnStateIcon] <> []) then
    Screen.Cursor := crHandPoint
  else
    Screen.Cursor := crDefault;
end;

procedure TMailClientForm.MailFrame1VSTChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  mail    : TMail;
  decoder : TMailDecoder;
  index   : string;
  list    : TStringList;
begin
  if m_inUpdate then exit;

  WebBrowser1.Navigate('about:blank');
  LV.Items.Clear;

  mail := MailFrame1.SelectedMail;
  if not Assigned(mail) then exit;

  list := TStringList.Create;
  list.LoadFromFile(FileCacheMod.getFile('mail', 'mail.html'));

  decoder := TMailDecoder.create;
  decoder.Msg := mail.Message;
  index := decoder.UseTemplate(m_tempdir, list.Text);

  WebBrowser1.Navigate(index);
  m_files.Assign(decoder.Attachments);
  AddAttachemnts;
  decoder.Free;
  list.Free;
end;

procedure TMailClientForm.OnGetStream(
  Sender: TFileContentsStreamOnDemandClipboardFormat; Index: integer;
  out AStream: IStream);
var
  Stream: TMemoryStream;
  i: integer;
  SelIndex: integer;
  Found: boolean;
begin
  Stream := TMemoryStream.Create;
  try
    AStream := nil;
    // Find the listview item which corresponds to the requested data item.
    SelIndex := 0;
    Found := False;
    for i := 0 to LV.Items.Count-1 do
      if (LV.Items[i].Selected) then
      begin
        if (SelIndex = Index) then
        begin
          // Get the data stored in the listview item and...
          Stream.LoadFromFile(m_files[integer(LV.Items[i].Data)]);
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
end;

procedure TMailClientForm.TVChange(Sender: TObject; Node: TTreeNode);
var
  Mail : TMail;
  st   : TStream;
begin
  if m_inUpdate then exit;

  MailFrame1.beginUpdate;
  MailFrame1.clearView;
  if Node.Level = 0 then begin
    MailFrame1.endUpdate;
    exit;
  end;

  Mails.Filter := 'MAF_ID='+IntToStr(integer(node.Data));
  Mails.Filtered := true;
  Mails.Open;
  while not Mails.Eof do begin
    mail := MailFrame1.newMail;

    st := Mails.CreateBlobStream(mails.FieldByName('MAM_DATA'), bmRead);
    mail.loadFromStream(st);
    st.Free;
    mail.Kategorie   := mails.FieldByName('MAM_KATEGORIE').AsString;
    mail.Attachments := mails.FieldByName('MAM_ATTACH').AsInteger > 0 ;

    Mails.Next;
  end;
  Mails.Close;

  MailFrame1.endUpdate;
  MailFrame1.MailOrder := moDate;
  MailFrame1.UpdateView;
end;


procedure TMailClientForm.updateTree;
var
  acc  : Account;
  root : TTreeNode;
  list : TStringList;
  id   : integer;

  procedure addSubFolder(root : TTreeNode );
  var
    s : string;
    node : TTreeNode;
    found : boolean;
  begin
    s := list[0];
    list.Delete(0);
    found := false;

    node := root.getFirstChild;
    while Assigned(node) do begin
      if SameText( s, node.Text ) then begin
        found := true;
        addSubFolder( node );
        break;
      end;
      node := node.GetNextChild(node)
    end;
    if not found then begin
      root := TV.Items.AddChild( root, s );
      if list.Count = 0 then begin
        root.Data := pointer(id);
      end else
        addSubFolder(root);
    end;
  end;

  procedure addFolder;
  var
    i : integer;
  begin
    for i := 0 to pred(acc.Folder.Count) do begin
      list.DelimitedText := acc.Folder.Names[i];
      id := StrToint( acc.Folder.ValueFromIndex[i]);
      addSubFolder(root);
    end;
  end;
begin
  m_inUpdate  := true;
  list := TStringList.Create;
  list.StrictDelimiter := true;
  list.Delimiter := '/';

  TV.Items.BeginUpdate;
  TV.Items.Clear;

  for acc in m_accounts do begin
    root := TV.Items.AddChildObject(NIL, acc.FullName, acc);
    AddFolder;
    root.Expand(true);
  end;
  FreeAndNil(list);
  TV.Items.EndUpdate;
  m_inUpdate := false;
end;

procedure TMailClientForm.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
end;

{ TMailClientForm.Account }

constructor TMailClientForm.Account.create;
begin
  m_folder := TStringList.Create;
  FData := NIL;
end;

destructor TMailClientForm.Account.Destroy;
begin
  if Assigned(FData) then
    FreeAndNil(FData);

  m_folder.free;
  inherited;
end;

function TMailClientForm.Account.FullName: string;
begin
  Result := FName;
  if FeMail <> '' then
    Result := Result + '('+FeMail+')';
end;



end.
