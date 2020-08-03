unit f_datafields;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, fr_base, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  JvBaseDlg, JvBrowseFolder;

type
  TDataFieldForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    DATab: TClientDataSet;
    DASrc: TDataSource;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    OpenDialog1: TOpenDialog;
    JvBrowseForFolderDialog1: TJvBrowseForFolderDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
  public
    { Public-Deklarationen }
  end;

var
  DataFieldForm: TDataFieldForm;

implementation

uses
  System.IOUtils, m_glob_client, f_datafield_edit, Xml.XMLIntf, xsd_DataField;

var
  DatafieldEditform : TDatafieldEditform;
{$R *.dfm}

procedure TDataFieldForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  if DATab.UpdatesPending then
    DATab.ApplyUpdates(-1);
end;

procedure TDataFieldForm.BitBtn1Click(Sender: TObject);
begin
  try
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);
    DATab.Append;
    DatafieldEditform.IsGlobal := true;
    DatafieldEditform.DataSet := DATab;
    if DatafieldEditform.ShowModal = mrOk then
    begin
      DATab.Post;
    end
    else
      DATab.Cancel;
  finally
    DatafieldEditform.free;
  end;
end;

procedure TDataFieldForm.BitBtn2Click(Sender: TObject);
begin
  if DATab.IsEmpty then
    exit;

  try
    Application.CreateForm(TDatafieldEditform, DatafieldEditform);
    DATab.Edit;
    DatafieldEditform.IsGlobal := true;
    DatafieldEditform.DataSet := DATab;
    if DatafieldEditform.ShowModal = mrOk then
      DATab.Post
    else
      DATab.Cancel;
  finally
    DatafieldEditform.free;
  end;
end;

procedure TDataFieldForm.BitBtn3Click(Sender: TObject);
begin
  if DATab.IsEmpty then
    exit;
  if (MessageDlg('Soll das Datenfeld "'+DATab.FieldByName('DA_NAME').AsString+
      '" wirklich gelöscht werden?', mtConfirmation, [mbYes, mbNo], 0) in [mrYes, mrNo, mrNone]) then
  begin
    DATab.Delete;
  end;
end;

procedure TDataFieldForm.BitBtn4Click(Sender: TObject);
var
  bs   : TStream;
  fs   : TFileStream;
  fname: string;
  path : string;
begin
  DBGrid1.Enabled := false;
  path := TPath.Combine(GM.ExportDir, 'datafields');
  JvBrowseForFolderDialog1.Directory := path;
  if not JvBrowseForFolderDialog1.Execute then
    exit;
  path := JvBrowseForFolderDialog1.Directory;
  ForceDirectories( path );
  DATab.First;
  while not DATab.Eof do
  begin
    fname := TPath.combine( path, DATab.FieldByName('DA_NAME').AsString+'.xml');
    try
      fs    := TFileStream.Create(fname, fmCreate + fmShareExclusive);
      bs := DATab.CreateBlobStream(DATab.FieldByName('DA_PROPS'), bmRead );
      fs.CopyFrom(bs, bs.Size);
    finally
      bs.Free;
      fs.Free;
    end;
    DATab.Next;
  end;
  DBGrid1.Enabled := true;
end;

procedure TDataFieldForm.BitBtn5Click(Sender: TObject);
var
  path  : string;
  i     : integer;
  st    : TStream;
  xml   : IXMLDataField;
  ok, fail, ex : integer;
begin
  path := TPath.Combine(GM.ExportDir, 'datafields');
  OpenDialog1.InitialDir := path;
  if OpenDialog1.Execute then begin
    ok    := 0;
    ex    := 0;
    fail  := 0;

    for i := 0 to pred(OpenDialog1.Files.Count) do
      begin
        try
          xml := LoadDataField(OpenDialog1.Files.Strings[i]);
          if not DATab.Locate('DA_CLID', VarArrayOf([xml.Clid]), []) then
          begin
            DATab.Append;
            DATab.FieldByName('DA_ID').AsInteger  := GM.autoInc('gen_da_id');
            DATab.FieldByName('DA_NAME').AsString := xml.Name;
            DATab.FieldByName('DA_TYPE').AsString := xml.Datatype;
            DATab.FieldByName('DA_REM').AsString  := xml.Text;
            DATab.FieldByName('DA_CLID').AsString := xml.Clid;

            st := DATab.CreateBlobStream(DATab.FieldByName('DA_PROPS'), bmWrite);
            xml.OwnerDocument.SaveToStream(st);
            st.Free;
            DATab.Post;
            inc(ok);
          end
          else
            Inc(ex);
        except
          begin
            if DATab.State <> dsBrowse then
              DATab.Cancel;
            Inc(fail);
          end;
        end;
      end;
      ShowMessage(Format('Es wurden %d von %d importiert'+sLineBreak+
                         'bei %d traten Fehler auf'+sLineBreak+
                         'und %d waren schon in der Datenbank',
                         [ok, OpenDialog1.Files.Count, fail, ex]));
  end;
end;

procedure TDataFieldForm.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn2.Click;
end;

procedure TDataFieldForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  DATab.Open;
end;

procedure TDataFieldForm.FormDestroy(Sender: TObject);
begin
  if DATab.UpdatesPending then
    DATab.CancelUpdates;

  DATab.Close;
end;

end.
