unit f_storages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.ComCtrls, Vcl.StdCtrls, System.Generics.Collections,
  Vcl.Buttons;

type
  TStoragesForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    STTab: TClientDataSet;
    GroupBox1: TGroupBox;
    LV: TListView;
    CountFolderQry: TClientDataSet;
    CountFilesQry: TClientDataSet;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    MemoryQry: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
  type
    TDataRec = class
      public
        type
          TDataType = (dtStorage, dtGremium, dtPerson);
      private
        FDataType: TDataType;
        FID: integer;
        FName: string;
        FFolder: integer;
        FFiles: integer;
        Fsize: int64;
        FSID: integer;
      public
        constructor Create;
        Destructor Destroy; override;

        property DataType : TDataType   read FDataType  write FDataType;
        property ID       : integer     read FID        write FID;
        property SID      : integer     read FSID       write FSID;
        property Name     : string      read FName      write FName;
        property Folder   : integer     read FFolder    write FFolder;
        property Files    : integer     read FFiles     write FFiles;
        property size     : int64       read Fsize      write Fsize;
    end;
  private
    m_list : TList<TDataRec>;
    m_grp_st : integer;
    procedure updateStorages;
    procedure updateGremien;
    procedure updateUser;

    procedure countFolder( d : TDataRec );
    procedure countFiles( d : TDataRec );

    procedure addItem( d : TDataRec; grpID : integer );
  public
    { Public-Deklarationen }
  end;

var
  StoragesForm: TStoragesForm;

implementation

uses
  m_glob_client, u_gremium, System.UITypes, System.JSON, u_json, u_stub;

{$R *.dfm}

procedure TStoragesForm.addItem(d: TDataRec; grpID: integer);
var
  item : TListItem;
begin
  item          := LV.Items.Add;
  item.GroupID  := grpID;
  item.Data     := d;
  item.Caption  := d.Name;
  item.SubItems.Add(IntToStr(d.Folder));
  item.SubItems.Add(IntToStr(d.Files));
  item.SubItems.Add('');
end;

procedure TStoragesForm.BitBtn1Click(Sender: TObject);
var
  name : string;
  client : TdsStorageClient;
  req, res : TJSONObject;
  p : TDataRec;
begin
  if not InputQuery('Neue Ablage', 'Name', name) then exit;

  client := TdsStorageClient.Create(GM.SQLConnection1.DBXConnection);
  try
    req := TJSONObject.Create;
    JReplace( req, 'name', name);
    res := client.newStorage(req);
    if JBool(res, 'result') then begin
      p := TDataRec.Create;
      m_list.Add(p);

      p.Name  := JString( res,  'name');
      p.ID    := JInt( res,     'id');
      p.SID   := JInt( res,     'drid');

      countFolder( p );
      CountFiles(p);
      addItem( p, m_grp_st);
    end else
      ShowResult( res );
  finally
    client.Free;
  end;
end;

procedure TStoragesForm.BitBtn2Click(Sender: TObject);
var
  req, res : TJSONObject;
  client   : TdsStorageClient;
  name     : string;
  p        : TDataRec;
begin
  if not Assigned(LV.Selected) then
    exit;

  if not LV.Selected.GroupID = m_grp_st then begin
    ShowMessage('Nur allgemeine Ablagen können umbekannt werden!');
    exit;
  end;

  name := LV.Selected.Caption;
  if not InputQuery('Neue Ablage', 'Name', name) then
    exit;

  client := TdsStorageClient.Create(GM.SQLConnection1.DBXConnection);
  try
    p := TDataRec(LV.Selected.Data);
    req := TJSONObject.Create;
    JReplace( req, 'name', name);
    JReplace( req, 'id', p.ID);

    res := client.renameStorage(req);
    if JBool(res, 'result') then begin
      p.Name := JString( res, 'name');
      LV.Selected.Caption := p.Name;
    end else
      ShowResult( res );
  finally
    client.Free;
  end;
end;

procedure TStoragesForm.BitBtn3Click(Sender: TObject);
var
  i : integer;
  p : TDataRec;
begin
  for i := 0 to pred(LV.Items.Count) do begin
    p := TDataRec(LV.Items.Item[i].Data);

    MemoryQry.ParamByName('grp').AsInteger := p.SID;
    MemoryQry.Open;
    p.size  := MemoryQry.FieldByName('sum').AsLargeInt;
    MemoryQry.Close;

    LV.Items.Item[i].SubItems.Strings[2] :=  gm.calcSize( p.size );
  end;
end;

procedure TStoragesForm.countfiles(d: TDataRec);
begin
  CountFilesQry.ParamByName('grp').AsInteger := d.SID;
  CountFilesQry.Open;
  d.Files := CountFilesQry.FieldByName('count').AsInteger;
  CountFilesQry.Close;
end;

procedure TStoragesForm.countFolder(d: TDataRec);
begin
  CountFolderQry.ParamByName('grp').AsInteger := d.SID;
  CountFolderQry.Open;
  d.Folder := CountFolderQry.FieldByName('count').AsInteger;
  CountFolderQry.Close;
end;

procedure TStoragesForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_list := TList<TDataRec>.create;

  Screen.Cursor := crSqlWait;
  updateStorages;
  updateGremien;
  updateUser;
  Screen.Cursor := crDefault;

end;

{ TStoragesForm.TDataRec }

constructor TStoragesForm.TDataRec.Create;
begin
  FID     := 0;
  FSID    := 0;
  FFolder := 0;
  FFiles  := 0;
  Fsize   := 0;
end;

destructor TStoragesForm.TDataRec.Destroy;
begin

  inherited;
end;

procedure TStoragesForm.FormDestroy(Sender: TObject);
var
  d : TDataRec;
begin
  for d in m_list do
    d.Free;
  m_list.Free;
end;

procedure TStoragesForm.updateGremien;
var
  grp : TListGroup;
  d   : TDataRec;
  gr  : TGremium;
begin
  grp := LV.Groups.Add;
  grp.Header := 'Gremien';
  grp.State  := [lgsCollapsed, lgsCollapsible];

  for gr in GM.Gremien do begin
    d := TDataRec.Create;
    m_list.Add(d);
    d.ID    := gr.ID;
    d.Name  := GR.Name;
    d.SID   := gr.StorageID;

    countFolder( d );
    countFiles(d);
    addItem(d, grp.ID);
  end;
end;

procedure TStoragesForm.updateStorages;
var
  grp : TListGroup;
  d   : TDataRec;
begin
  grp := LV.Groups.Add;
  grp.Header := 'Ablagen';
  grp.State  := [lgsCollapsed, lgsCollapsible];
  m_grp_st := grp.ID;

  with STTab do begin
    Open;
    while not eof do begin
      d := TDataRec.Create;
      m_list.Add(d);
      d.ID    := FieldByName('ST_ID').AsInteger;
      d.Name  := FieldByName('ST_NAME').AsString;
      d.SID   := FieldByName('DR_ID').AsInteger;

      countFolder( d );
      countFiles(d);

      addItem(d, grp.ID);

      next;
    end;
    close;
  end;
end;

procedure TStoragesForm.updateUser;
var
  grp : TListGroup;
  d   : TDataRec;
  obj :  TJSONObject;
  row : TJSONObject;
  arr : TJSONArray;
  i   : integer;
begin
  grp := LV.Groups.Add;
  grp.Header := 'Benutzer';
  grp.State  := [lgsCollapsed, lgsCollapsible];

  obj := gm.getUserList;
  arr := JArray(obj, 'user');
  if not Assigned(arr) then
    exit;

  for i := 0 to pred(arr.Count) do begin
    d := TDataRec.Create;
    row := getRow( arr, i);

    m_list.Add(d);
    d.ID    := JInt(row, 'id');

    d.Name  := trim(JString(row, 'vorname')+' '+JString(row, 'name')+ ' ('+JString(row, 'dept')+')');
    d.SID   := JInt(row, 'drid');

    countFolder( d );
    countFiles(d);
    addItem(d, grp.ID);
  end;
  if Assigned(obj) then
    obj.Free;
end;

end.
