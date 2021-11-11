unit f_template_new;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, u_stub, Vcl.ComCtrls,
  System.JSON;

type
  TTemplateNewForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    TETab: TClientDataSet;
    TESrc: TDataSource;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBLookupListBox1: TDBLookupListBox;
    TYTab: TClientDataSet;
    TYSrc: TDataSource;
    LV: TListView;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TETabBeforePost(DataSet: TDataSet);
    procedure TETabNewRecord(DataSet: TDataSet);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure LVClick(Sender: TObject);
  private
    m_id : integer;
    m_cl : TdsTemplateClient;
    procedure setTEID( value : integer );
    procedure loadSysTemplates;
  public
    property TE_ID : integer read m_id write setTEID;
  end;

var
  TemplateNewForm: TTemplateNewForm;

implementation

uses
  m_glob_client, System.Win.ComObj, u_json;

{$R *.dfm}

{ TTemplateNewForm }

procedure TTemplateNewForm.BaseFrame1OKBtnClick(Sender: TObject);
begin

  if DBCheckBox1.Checked then begin
    if not Assigned(lv.Selected) then begin
      ShowMessage('Es muss eine Vorlage ausgewählt werden!');
      exit;
    end else begin
      if SameText(LV.Selected.SubItems.Strings[0], 'ja') then begin
        ShowMessage('Diese Vorlage existiert schon');
        exit;
      end;
    end;
  end else if VarIsNull(DBLookupListBox1.KeyValue) then begin
    ShowMessage('Es muss ein Aufgabentyp ausgewählt werden!');
    exit;
  end;

  if DBCheckBox1.Checked then begin
    TETab.FieldByName('TE_CLID').AsString     := LV.Selected.SubItems.Strings[1];
  end;

  try
    TETab.Post;

    if TETab.UpdatesPending then
      TETab.ApplyUpdates(0);

    m_id := TETab.FieldByName('TE_ID').AsInteger;
    ModalResult := mrOk;
  except
    begin
      ShowMessage('Diese Vorlage existiert schon!');
      if TETab.UpdatesPending then
        TETab.CancelUpdates;
      ModalResult := mrCancel;
    end;
  end;
end;

procedure TTemplateNewForm.DBCheckBox1Click(Sender: TObject);
begin
  if DBCheckBox1.Checked then begin
    TETab.FieldByName('TY_ID').Clear;
    DBLookupListBox1.Enabled  := false;
    DBLookupListBox1.Visible  := false;
    LV.Visible                := true;
    DBEdit1.Enabled           := false;
  end
  else begin
    DBLookupListBox1.Enabled  := true;
    DBLookupListBox1.Visible  := true;
    LV.Visible                := false;
    DBEdit1.Enabled           := true;
  end;
end;

procedure TTemplateNewForm.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  BaseFrame1.OKBtn.Enabled := DBEdit1.Text <> '';
end;

procedure TTemplateNewForm.FormCreate(Sender: TObject);
begin
   DSProviderConnection1.SQLConnection := GM.SQLConnection1;
   m_id := -1;
   m_cl := TdsTemplateClient.Create(GM.SQLConnection1.DBXConnection);
   TYTab.Open;

   loadSystemplates;
end;

procedure TTemplateNewForm.FormDestroy(Sender: TObject);
begin
  if TETab.State <> dsBrowse then
    TETab.Cancel;

  if TETab.UpdatesPending then
    TETab.CancelUpdates;
  TETab.Close;
  m_cl.free;
end;

procedure TTemplateNewForm.loadSysTemplates;
var
  client  : TdsTemplateClient;
  res     : TJSONObject;
  arr     : TJSONArray;
  row     : TJSONObject;
  i       : integer;
  item    : TListItem;
begin
  client := TdsTemplateClient.Create(GM.SQLConnection1.DBXConnection);
  try
    res := client.getSysTemplates;
    if Assigned(res) then begin
      arr := JArray( res, 'templates');
      if Assigned(arr) then begin
        for i := 0 to pred(arr.Count) do begin
          row := getRow(arr, i);
          item:= LV.Items.Add;

          item.Caption := JString(row, 'name');
          if JBool(row, 'exists') then
            item.SubItems.Add('Ja')
          else
            item.SubItems.Add('Nein');
          item.SubItems.Add(JString(row, 'clid'));
        end;
      end;
    end;
  except

  end;
  client.Free;
end;

procedure TTemplateNewForm.LVClick(Sender: TObject);
begin
  if not Assigned(LV.Selected) then
    exit;
  TETab.FieldByName('TE_NAME').AsString := LV.Selected.Caption;
  BaseFrame1.OKBtn.Enabled := true;
end;

procedure TTemplateNewForm.setTEID(value: integer);
begin
  m_id := value;

  TETab.Open;
  if m_id = -1 then begin
    TETab.Append;
    DBCheckBox1.Visible := true;
  end else begin
    if TETab.Locate('TE_ID', VarArrayOf([m_id]), []) then
      TETab.Edit;
  end;
end;

procedure TTemplateNewForm.TETabBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('TE_ID').AsInteger = 0 then
    DataSet.FieldByName('TE_ID').AsInteger := GM.autoInc('gen_te_id');
end;

procedure TTemplateNewForm.TETabNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('TE_SYSTEM').AsString   := 'F';
  DataSet.FieldByName('TE_CLID').AsString     := CreateClassID;
  DataSet.FieldByName('TE_STATE').AsString    := 'E';
  DataSet.FieldByName('TE_VERSION').AsInteger := 1;
end;

end.
