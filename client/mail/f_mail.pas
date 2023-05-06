unit f_mail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, m_glob_client, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.CheckLst, Vcl.ComCtrls,
  m_mail, System.JSON;

type
  TMailform = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    Accounts: TClientDataSet;
    Folder: TClientDataSet;
    AccountsMAC_ID: TIntegerField;
    AccountsMAC_TITLE: TStringField;
    AccountsMAC_TYPE: TStringField;
    AccountsMAC_DATA: TBlobField;
    AccountsMAC_ACTIVE: TStringField;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    BitBtn1: TBitBtn;
    DataSource2: TDataSource;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    DBNavigator2: TDBNavigator;
    DBGrid2: TDBGrid;
    FolderMAF_ID: TIntegerField;
    FolderMAC_ID: TIntegerField;
    FolderMAF_NAME: TStringField;
    FolderMAF_ACTIVE: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure AccountsMAC_ACTIVESetText(Sender: TField; const Text: string);
    procedure AccountsMAC_ACTIVEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure AccountsBeforePost(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure AccountsAfterPost(DataSet: TDataSet);
    procedure AccountsNewRecord(DataSet: TDataSet);
    procedure AccountsAfterScroll(DataSet: TDataSet);
    procedure FolderMAF_ACTIVEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FolderMAF_ACTIVESetText(Sender: TField; const Text: string);
  private
    procedure SyncImapFolder( data : TJSONObject);
  public
    { Public-Deklarationen }
  end;

var
  Mailform: TMailform;

procedure doMailSettings;


implementation

uses
  u_json, f_mail_imap;


{$R *.dfm}

procedure doMailSettings;
begin
  try
    Application.CreateForm(TMailform, Mailform);
    Mailform.ShowModal;
  finally
    Mailform.Free;
  end;
end;

procedure TMailform.AccountsAfterPost(DataSet: TDataSet);
var
  bst  : TStream;
  data : TJSONObject;
begin
  if Accounts.IsEmpty then exit;

  bst := Accounts.CreateBlobStream(Accounts.FieldByName('MAC_DATA'), bmRead);
  data := loadJSON(bst);
  bst.Free;

  Folder.DisableControls;
  SyncImapFolder( data );
  Folder.EnableControls;

  data.Free;
end;

procedure TMailform.AccountsAfterScroll(DataSet: TDataSet);
begin
  Folder.Filter := 'MAC_ID='+DataSet.FieldByName('MAC_ID').AsString;
  Folder.Filtered := true;
end;

procedure TMailform.AccountsBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('MAC_ID').IsNull then
    DataSet.FieldByName('MAC_ID').AsInteger := GM.autoInc('gen_mac_id');

  if DataSet.FieldByName('MAC_ACTIVE').IsNull then
    DataSet.FieldByName('MAC_ACTIVE').AsString := 'T';

end;

procedure TMailform.AccountsMAC_ACTIVEGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.AsString = 'T' then
    Text := 'Aktiv'
  else
    Text := 'Inaktiv';
end;

procedure TMailform.AccountsMAC_ACTIVESetText(Sender: TField;
  const Text: string);
begin
  if SameText( text, 'Aktiv') then
    Sender.AsString := 'T'
  else
    Sender.AsString := 'F';
end;

procedure TMailform.AccountsNewRecord(DataSet: TDataSet);
begin
  if DataSet.FieldByName('MAC_ID').IsNull then
    DataSet.FieldByName('MAC_ID').AsInteger := GM.autoInc('gen_mac_id');

  if DataSet.FieldByName('MAC_ACTIVE').IsNull then
    DataSet.FieldByName('MAC_ACTIVE').AsString := 'T';

  if DataSet.FieldByName('MAC_TYPE').IsNull then
    DataSet.FieldByName('MAC_TYPE').AsString := 'imap/smtp';
end;

procedure TMailform.BaseFrame1OKBtnClick(Sender: TObject);
begin
  if Accounts.UpdatesPending  then
    Accounts.ApplyUpdates(0);
  if Folder.UpdatesPending then
    Folder.ApplyUpdates(0);
end;

procedure TMailform.BitBtn1Click(Sender: TObject);
var
  bst : TMemoryStream;
  obj : TJSONObject;
  data: TJSONObject;
begin
  bst := TMemoryStream.Create;
  AccountsMAC_DATA.SaveToStream(bst);
  bst.Position := 0;

  obj := loadJSON(bst);
  try
    Application.CreateForm(TMailimapConfigForm, MailimapConfigForm);

    Folder.First;
    while not Folder.Eof do begin
      if Folder.FieldByName('MAF_ACTIVE').AsString = 'T' then
        MailimapConfigForm.Folder.Add(Folder.FieldByName('MAF_NAME').AsString );
      Folder.Next;

    end;
    MailimapConfigForm.Data := obj;
    if MailimapConfigForm.ShowModal = mrok then begin

      data := MailimapConfigForm.data;
      JReplace(data, 'kontoname', AccountsMAC_TITLE.AsString );
      bst.Clear;
      saveJSON(data, bst);
      AccountsMAC_DATA.LoadFromStream(bst);

      FreeAndNil(data);
    end;
  finally
    MailimapConfigForm.free;
  end;

  if Assigned(obj) then
    FreeAndNil(obj);
  FreeAndNil(bst);
end;

procedure TMailform.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  BitBtn1.Enabled := (Button = nbEdit) or (Button = nbInsert);
  GroupBox2.Enabled  := not BitBtn1.Enabled;
end;

procedure TMailform.FolderMAF_ACTIVEGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.AsString = 'T' then
    Text := 'Aktiv'
  else
    Text := 'Inaktiv';
end;

procedure TMailform.FolderMAF_ACTIVESetText(Sender: TField; const Text: string);
begin
  if SameText( text, 'Aktiv') then
    Sender.AsString := 'T'
  else
    Sender.AsString := 'F';
end;

procedure TMailform.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  Accounts.Open;
  Folder.Open;
end;

procedure TMailform.FormDestroy(Sender: TObject);
begin

  if Accounts.UpdatesPending then
    Accounts.CancelUpdates;
  if Folder.UpdatesPending then
    Folder.CancelUpdates;
end;

procedure TMailform.SyncImapFolder(data : TJSONObject);
var
  folders        : TStringList;
  current        : TStringList;

  procedure fillFolder;
  var
    imap : TJSONObject;
  begin
    imap := JObject( data, 'imap');
    getText( imap, 'folder', folders);
  end;
var
  name : string;
  i, id : integer;
begin
  folders := TStringList.Create;
  current := TStringList.Create;

  id := Accounts.FieldByName('MAC_ID').AsInteger;
  fillFolder;

  folder.First;
  while not folder.Eof do begin
    name := folder.FieldByName('MAF_NAME').AsString;
    current.Add(name);

    Folder.Edit;
    if folders.IndexOf(name) > -1 then
      folder.FieldByName('MAF_ACTIVE').AsString := 'T'
    else
      folder.FieldByName('MAF_ACTIVE').AsString := 'F';
    folder.Post;

    folder.Next;
  end;

  // new Folder ..
  for i := 0 to pred(folders.count) do begin
    if current.IndexOf(folders[i]) = -1  then begin
      Folder.Append;
      Folder.FieldByName('MAC_ID').AsInteger    := id;
      Folder.FieldByName('MAF_ID').AsInteger    := GM.autoInc('gen_MAF_ID');
      Folder.FieldByName('MAF_NAME').AsString   := folders[i];
      Folder.FieldByName('MAF_ACTIVE').AsString := 'T';
      Folder.Post;
    end;
  end;

  folders.Free;
  current.Free;

end;

end.
