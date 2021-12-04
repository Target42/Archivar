unit fr_file;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.StdCtrls, JvComponentBase, JvDragDrop, Vcl.Buttons, JvBaseDlg,
  JvBrowseFolder, FireDAC.UI.Intf, FireDAC.VCLUI.Async, FireDAC.Stan.Intf,
  FireDAC.Comp.UI;

type
  TFileFrame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    ListFilesQry: TClientDataSet;
    LitFilesSrc: TDataSource;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    JvDragDrop1: TJvDragDrop;
    OpenDialog1: TOpenDialog;
    Button1: TBitBtn;
    Button2: TBitBtn;
    Button3: TBitBtn;
    JvBrowseForFolderDialog1: TJvBrowseForFolderDialog;
    FDGUIxAsyncExecuteDialog1: TFDGUIxAsyncExecuteDialog;
    procedure Button1Click(Sender: TObject);
    procedure JvDragDrop1Drop(Sender: TObject; Pos: TPoint; Value: TStrings);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DBGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    m_id : integer;
    m_tempDir : string;
    procedure setID( value : integer );
    procedure showUploadForm( list : TStrings );
    function GetRO: boolean;
    procedure SetRO(const Value: boolean);
    function saveFile( fname : string ) : boolean;
  public
    procedure prepare;
    property ID : integer write setID;
    property RO: boolean read GetRO write SetRO;
    procedure release;
  end;

implementation

uses
  m_glob_client, f_uploadForm, System.Generics.Collections, u_stub,
  system.IOUtils, System.Win.ComObj, System.Types, ShellApi;

{$R *.dfm}

{ TFileFrame }

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
      client.deleteFile(m_id, del[i]);
  finally
    client.Free;
  end;
  del.Free;
  ListFilesQry.Refresh;
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
  Accept := true;
end;

function TFileFrame.GetRO: boolean;
begin
  Result := ListFilesQry.ReadOnly;
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
end;

procedure TFileFrame.release;
var
  arr : TStringDynArray;
  i   : integer;
begin
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
begin
  m_id := value;

  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  ListFilesQry.ParamByName('TA_ID').AsInteger := m_id;
  ListFilesQry.Open;
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
    Application.CreateForm(TUploadForm, UploadForm);
    UploadForm.TA_ID := m_id;
    UploadForm.List := list;
    if UploadForm.ShowModal = mrOk then
      ListFilesQry.Refresh;
    UploadForm.Free;
end;


end.
