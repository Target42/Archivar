unit fr_file;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.StdCtrls, JvComponentBase, JvDragDrop, Vcl.Buttons;

type
  TFileFrame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    ListFilesQry: TClientDataSet;
    LitFilesSrc: TDataSource;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    JvDragDrop1: TJvDragDrop;
    OpenDialog1: TOpenDialog;
    Button1: TBitBtn;
    Button2: TBitBtn;
    Button3: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure JvDragDrop1Drop(Sender: TObject; Pos: TPoint; Value: TStrings);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    m_id : integer;
    procedure setID( value : integer );
    procedure showUploadForm( list : TStrings );
    function GetRO: boolean;
    procedure SetRO(const Value: boolean);
  public
    property ID : integer write setID;
    property RO: boolean read GetRO write SetRO;
    procedure release;
  end;

implementation

uses
  m_glob_client, f_uploadForm, System.Generics.Collections, u_stub;

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
  i : integer;
  mark : TBookmark;
  s : string;
begin
  for i := 0 to pred(DBGrid1.SelectedRows.Count) do
  begin
     mark := DBGrid1.SelectedRows.Items[i];
     ListFilesQry.GotoBookmark(mark);
     s := s + ListFilesQry.FieldByName('FI_NAME').AsString  +sLineBreak;
  end;
  ShowMessage(s);
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

procedure TFileFrame.release;
begin
  ListFilesQry.Close;
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
