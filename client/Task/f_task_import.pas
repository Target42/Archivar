unit f_task_import;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, SynEdit, Vcl.ExtCtrls,
  SynEditHighlighter, SynHighlighterXML, Vcl.StdCtrls, JvExStdCtrls, JvListBox,
  JvDriveCtrls, JvCombobox;

type
  TTaskImportForm = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    JvDriveCombo1: TJvDriveCombo;
    JvDirectoryListBox1: TJvDirectoryListBox;
    Splitter1: TSplitter;
    SynXMLSyn1: TSynXMLSyn;
    Panel1: TPanel;
    SynEdit1: TSynEdit;
    GroupBox2: TGroupBox;
    Splitter2: TSplitter;
    Panel2: TPanel;
    procedure JvDirectoryListBox1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  TaskImportForm: TTaskImportForm;

procedure showImportForm;

implementation

uses
  system.IOUtils;
{$R *.dfm}

procedure showImportForm;
begin
  Application.CreateForm(TTaskImportForm, TaskImportForm);
  TaskImportForm.ShowModal;
  TaskImportForm.Free;
end;

procedure TTaskImportForm.JvDirectoryListBox1Click(Sender: TObject);
var
  fname : string;
begin
  SynEdit1.Lines.Clear;
  fname := TPath.Combine(JvDirectoryListBox1.Directory, 'data.xml');

  if not FileExists(fname) then exit;

  SynEdit1.Lines.LoadFromFile(fname);
end;

end.
