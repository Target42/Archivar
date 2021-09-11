unit fr_epub;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Menus;

type
  TePupFrame = class(TFrame)
    EpubTab: TFDMemTable;
    DataSource1: TDataSource;
    EpubTabEP_ID: TAutoIncField;
    EpubTabEP_TITEL: TStringField;
    EpubTabEP_NAME: TStringField;
    EpubTabEP_MD5: TStringField;
    EpubTabEP_GROUP: TStringField;
    EpubTabEP_SUBGROUP: TStringField;
    PopupMenu1: TPopupMenu;
    Download1: TMenuItem;
    N1: TMenuItem;
    Anzeigen1: TMenuItem;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Download1Click(Sender: TObject);
    procedure Anzeigen1Click(Sender: TObject);
  private
    procedure saveTab;
  public
    procedure init;
    procedure release;
  end;

implementation

{$R *.dfm}

uses
  system.IOUtils, m_glob_client, f_downloadEpub, f_epub;

{ TePupFrame }

procedure TePupFrame.Anzeigen1Click(Sender: TObject);
var
  fname : string;
begin
  if EpubTab.IsEmpty then
    exit;

  fname := TPath.combine(GM.ePubHome, EpubTab.FieldByName('ep_name').AsString);
  if FileExists(fname) then
    showEPubFile( fname );
end;

procedure TePupFrame.DBGrid1DblClick(Sender: TObject);
begin
  Anzeigen1.Click;
end;

procedure TePupFrame.Download1Click(Sender: TObject);
begin
  Application.CreateForm(TDownloadEpubform, DownloadEpubform);
  DownloadEpubform.setDataset(EpubTab);
  if DownloadEpubform.ShowModal = mrOk then
    saveTab;
  DownloadEpubform.Free;
end;

procedure TePupFrame.init;
var
  fname : string;
begin
  fname := TPath.Combine(GM.Home, 'books.adb');

  if FileExists( fname ) then
  begin
    EpubTab.LoadFromFile(fname, sfBinary);
  end;
  EpubTab.Open;

end;

procedure TePupFrame.release;
begin
  EpubTab.Close;
end;

procedure TePupFrame.saveTab;
begin
  EpubTab.SaveToFile( TPath.Combine(GM.Home, 'books.adb'), sfBinary );
end;

end.
