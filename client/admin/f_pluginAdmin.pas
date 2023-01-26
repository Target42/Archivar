unit f_pluginAdmin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_stub, Vcl.ComCtrls, Vcl.StdCtrls,
  System.JSON, Vcl.Buttons;

type
  TPluginAdmin = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    LV: TListView;
    BitBtn1: TBitBtn;
    FileOpenDialog1: TFileOpenDialog;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    m_client : TTdsPluginClient;
    m_data   : TJSONObject;
    procedure UpdateAll;
    procedure UpdateData;
    procedure UpdateView;

    procedure changeStatus( id : integer; status : string );
  public
    { Public-Deklarationen }
  end;

var
  PluginAdmin: TPluginAdmin;

implementation

uses
  m_glob_client, u_json;



{$R *.dfm}

procedure TPluginAdmin.BitBtn1Click(Sender: TObject);
  function getName : string;
  var
    hnd : HModule;
    funcName : function : pchar; stdcall;
  begin
    Result := '';
    hnd := LoadPackage(FileOpenDialog1.FileName);
    if hnd <> 0 then begin
      @funcName := GetProcAddress(hnd, PChar('getPluginName'));
      if Assigned(funcName) then begin
        Result := funcName;
      end;
      UnloadPackage(hnd);
    end;
  end;
var
  pname : string;
  md5   : string;
  msg   : string;
  req   : TJSONObject;
  res   : TJSONObject;
  st    : TStream;
begin
  if FileOpenDialog1.Execute then begin
    md5 := GM.md5(FileOpenDialog1.FileName);
    pName := getName;
    msg := Format('Soll das Plugin:'#10#13'%s'#10#13' aus %s geladen werden?',
    [pName, ExtractFileName(FileOpenDialog1.FileName)]);

    if (MessageDlg(msg, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
      req := TJSONObject.Create;
      JReplace(req, 'name', pName);
      JReplace(req, 'filename', ExtractFileName(FileOpenDialog1.FileName));

      st := TFileStream.Create(FileOpenDialog1.FileName, fmOpenRead + fmShareDenyNone);

      Screen.Cursor := crHourGlass;
      try
        res := m_client.upload(req, st);
      except
        res := NIL;
      end;
      Screen.Cursor := crDefault;

      UpdateAll;
      ShowResult(res);
    end;
  end;
end;

procedure TPluginAdmin.BitBtn2Click(Sender: TObject);
var
  row : TJSONObject;
begin
  if not Assigned(LV.Selected) then exit;

  row := LV.Selected.Data;
  changeStatus(JInt(row, 'id'), 'A');
end;

procedure TPluginAdmin.BitBtn3Click(Sender: TObject);
var
  row : TJSONObject;
begin
  if not Assigned(LV.Selected) then exit;

  row := LV.Selected.Data;
  changeStatus(JInt(row, 'id'), 'E');
end;

procedure TPluginAdmin.BitBtn4Click(Sender: TObject);
var
  row : TJSONObject;
begin
  if not Assigned(LV.Selected) then exit;

  row := LV.Selected.Data;
  changeStatus(JInt(row, 'id'), 'D');
end;

procedure TPluginAdmin.changeStatus(id : integer; status: string);
var
  req, res : TJSONObject;
begin
  req := TJSONObject.Create;
  JReplace( req, 'id', id);
  JReplace( req, 'state',status);

  res := m_client.setStatus( req);

  updateAll;

  ShowResult(res);
end;

procedure TPluginAdmin.FormCreate(Sender: TObject);
begin
  m_client := TTdsPluginClient.Create(GM.SQLConnection1.DBXConnection);

  UpdateAll;
end;

procedure TPluginAdmin.FormDestroy(Sender: TObject);
begin
  m_client.Free;
  if Assigned(m_data) then
    FreeAndNil(m_data);
end;

procedure TPluginAdmin.UpdateAll;
begin
  UpdateData;
  UpdateView;
end;

procedure TPluginAdmin.UpdateData;
begin
  Screen.Cursor := crHourGlass;
  try
    m_data := m_client.getList.Clone as TJSONObject;
  except
    m_data := NIL;
  end;
  Screen.Cursor := crDefault;
end;

procedure TPluginAdmin.UpdateView;
var
  arr : TJSONArray;
  row : TJSONObject;
  i   : integer;
  item: TListItem;
  state : string;
begin
  if not Assigned(m_data) then exit;


  LV.Items.BeginUpdate;
  LV.Items.Clear;
  arr  := JArray(m_data, 'items');

  if Assigned(arr) then begin
    for i := 0 to pred(arr.Count) do begin
      row  := getRow(arr, i);
      item := LV.Items.Add;
      item.Data := row;
      item.Caption := JString( row, 'name');
      item.SubItems.Add( JString( row, 'filename'));
      state := JString( row, 'state');
      if state = 'A' then item.SubItems.Add( 'Aktiv' )
      else if state = 'D' then item.SubItems.Add( 'Deaktiv' );
    end;
  end;
  LV.Items.EndUpdate;
end;

end.
