unit f_dairy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls;

type
  TDairyForm = class(TForm)
    StatusBar1: TStatusBar;
    DSProviderConnection1: TDSProviderConnection;
    DITab: TClientDataSet;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    DISrc: TDataSource;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    DITabDI_ID: TAutoIncField;
    DITabPE_ID: TIntegerField;
    DITabDI_STAMP: TSQLTimeStampField;
    DITabDI_CRYPTED: TStringField;
    DITabDI_TEXT: TBlobField;
    DITabDI_TAGS: TStringField;
    DITabCryptText: TStringField;
    GroupBox3: TGroupBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DITabCryptTextGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  DairyForm: TDairyForm;

implementation

uses
  m_glob_client, m_WindowHandler;

{$R *.dfm}

procedure TDairyForm.DITabCryptTextGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := '';
  if Sender.AsString = 'T' then
    Text := 'Ja';
end;

procedure TDairyForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DITab.UpdatesPending then
  DITab.ApplyUpdates(0);
end;

procedure TDairyForm.FormCreate(Sender: TObject);
begin
  WindowHandler.registerForm(self);
  DITab.Open;
end;

procedure TDairyForm.FormDestroy(Sender: TObject);
begin
  WindowHandler.unregisterForm(self);
  DairyForm := NIL;
end;

initialization

  DairyForm := NIL;
end.
