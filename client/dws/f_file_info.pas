unit f_file_info;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, System.JSON, Vcl.ComCtrls;

type
  TFileInfoForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LV: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_fiid : integer;
    m_data : TJSONObject;
    function GetFileID: integer;
    procedure SetFileID(const Value: integer);

    procedure updateView;
  public
    property FileID: integer read GetFileID write SetFileID;
  end;

var
  FileInfoForm: TFileInfoForm;

implementation

uses
  m_glob_client, u_stub, u_json;

{$R *.dfm}

procedure TFileInfoForm.FormCreate(Sender: TObject);
begin
  m_fiid := -1;
  m_data := NIL;
end;

procedure TFileInfoForm.FormDestroy(Sender: TObject);
begin
  if Assigned(m_data) then
    m_data.Free;
end;

function TFileInfoForm.GetFileID: integer;
begin
  Result := m_fiid;
end;

procedure TFileInfoForm.SetFileID(const Value: integer);
var
  client : TdsFileClient;
  req, res : TJSONObject;
begin
  m_fiid := value;

  client := TdsFileClient.Create(GM.SQLConnection1.DBXConnection);
  try
    req := TJSONObject.Create;
    JReplace( req, 'id', m_fiid);

    res := client.getFileInfo(req);
    if Assigned(res) then
      m_data := res.Clone as TJSONObject;
  except

  end;
  client.Free;
  updateView;
end;

procedure TFileInfoForm.updateView;
var
  row   : TJSONObject;
  arr   : TJSONArray;
  i     : integer;
  item  : TListItem;
begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;

  arr := JArray( m_data, 'items');
  if Assigned(arr) then begin
    for i := 0 to pred(arr.Count) do begin
      row   := getRow(arr, i);
      item  := LV.Items.Add;
      item.Data := row;
      item.Caption := JString( row, 'name');
      item.SubItems.Add(IntToStr(JInt(row, 'version')));
      item.SubItems.Add(GM.calcSize(JInt64( row, 'size')));
      item.SubItems.Add(FormatDateTime('dd.mm.yyyy hh:nn:ss', JDouble(row, 'created')));
      item.SubItems.Add(FormatDateTime('dd.mm.yyyy', JDouble(row, 'todelete')));
      item.SubItems.Add(JString( row, 'user'));
    end;
  end;
  LV.Items.EndUpdate;
end;

end.
