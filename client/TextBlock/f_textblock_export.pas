unit f_textblock_export;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, JvBaseDlg, JvBrowseFolder, Vcl.Buttons, Vcl.StdCtrls,
  fr_base, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TTextBlockExportForm = class(TForm)
    DSProviderConnection1: TDSProviderConnection;
    TBtab: TClientDataSet;
    TBSrc: TDataSource;
    DBGrid1: TDBGrid;
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    JvBrowseForFolderDialog1: TJvBrowseForFolderDialog;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  TextBlockExportForm: TTextBlockExportForm;

implementation

uses
  m_glob_client, Xml.XMLIntf,xsd_TextBlock, Xml.XMLDoc, System.IOUtils;

{$R *.dfm}

procedure TTextBlockExportForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  i     : integer;
  mark  : TBookmark;
  st    : TStream;
  xml   : IXMLDocument;
  x_block : IXMLBlock;
  fname : string;
begin
  if ForceDirectories(Edit1.Text) then begin
    for i := 0 to pred(DBGrid1.SelectedRows.Count) do begin
      mark := DBGrid1.SelectedRows.Items[i];
      TBtab.GotoBookmark(mark);

      st := TBtab.CreateBlobStream(TBtab.FieldByName('TB_TEXT'), bmRead);
      xml := NewXMLDocument;
      xml.LoadFromStream(st);
      x_block := xml.GetDocBinding('Block', TXMLBlock, TargetNamespace) as IXMLBlock;
      st.Free;

      fname := TPath.Combine(Edit1.Text, TBtab.FieldByName('TB_NAME').AsString+'.xml');
      try
        x_block.OwnerDocument.SaveToFile(fname);
      except

      end;
    end;
  end;
end;

procedure TTextBlockExportForm.BitBtn1Click(Sender: TObject);
begin
  TBtab.DisableControls;
  TBtab.First;
  while not TBtab.Eof do begin
    DBGrid1.SelectedRows.CurrentRowSelected := true;
    TBtab.Next;
  end;
  TBtab.EnableControls;
end;

procedure TTextBlockExportForm.BitBtn2Click(Sender: TObject);
begin
  DBGrid1.SelectedRows.Clear;
end;

procedure TTextBlockExportForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  Edit1.Text := JvBrowseForFolderDialog1.Directory;

  TBtab.Open;
  Edit1.Text :=  TPath.GetDocumentsPath
end;

procedure TTextBlockExportForm.LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
var
  s1, s2 : string;
begin
  if key = #13 then begin
    s1 := Trim(LabeledEdit1.Text);
    s2 := Trim(LabeledEdit2.Text);

    if (s1='') and (s2='') then begin
      TBtab.Filtered := false;
    end else begin
     if (s1<>'') and (s2<>'') then
      TBtab.Filter := Format('upper(TB_NAME) like upper(''%s'') and upper(TB_TAGS) like upper(''%s'')', [s1, s2])
     else if  s1 <> '' then
       TBtab.Filter := Format('upper(TB_NAME) like upper(''%s'')', [s1])
     else
       TBtab.Filter := Format('upper(TB_TAGS) like upper(''%s'')', [s2]);

     TBtab.Filtered := true;
    end;
  end;

end;

procedure TTextBlockExportForm.SpeedButton1Click(Sender: TObject);
begin
  if JvBrowseForFolderDialog1.Execute then
    Edit1.Text := JvBrowseForFolderDialog1.Directory;
end;

end.
