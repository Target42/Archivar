unit f_fileuploadform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  fr_base;

type
  TFileUploadForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LabeledEdit1: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    FileOpenDialog1: TFileOpenDialog;
    Label1: TLabel;
    ComboBox1: TComboBox;
    procedure SpeedButton1Click(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    function GetFileName: string;
    procedure SetFileName(const Value: string);
    function GetCache: string;
    procedure SetCache(const Value: string);
    function getDirs : TStrings;
  public
    property FileName: string read GetFileName write SetFileName;
    property Cache: string read GetCache write SetCache;
    property Dirs : TStrings read getDirs;
  end;

var
  FileUploadForm: TFileUploadForm;

implementation

uses
  m_fileCache, system.uitypes;

{$R *.dfm}

procedure TFileUploadForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  name, cache : string;
begin
  name := Trim(LabeledEdit1.Text);
  cache:= Trim(ComboBox1.Text);

  if not FileExists(name) then begin
    ShowMessage('Die Datei wurde nicht gefunden!');
    exit;
  end;
  if cache = '' then begin
    ShowMessage('Es muss ein Verzeichniss angegeben werden!');
    exit;
  end;
  if (MessageDlg(format('Soll die Datei:'+#13+#10+'%s'+#13+
    #10+'in Verzeichnis:'+#13+#10+'%s'+#13+#10+'hochgelanden werden?',
    [ExtractFileName(name), cache]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
      FileCacheMod.upload(cache,ExtractFileName(name), name);
      ModalResult := mrOk;
  end;
end;

procedure TFileUploadForm.FormActivate(Sender: TObject);
begin
  if (ComboBox1.ItemIndex = -1) and ( ComboBox1.Items.Count > 0 ) then
    ComboBox1.ItemIndex := 0;
end;

function TFileUploadForm.GetCache: string;
begin
  Result := Trim(ComboBox1.Text);
end;

function TFileUploadForm.getDirs: TStrings;
begin
  Result := ComboBox1.Items;
end;

function TFileUploadForm.GetFileName: string;
begin
  Result := trim(LabeledEdit1.Text);
end;

procedure TFileUploadForm.SetCache(const Value: string);
begin
  ComboBox1.Text := value;
end;

procedure TFileUploadForm.SetFileName(const Value: string);
begin
  LabeledEdit1.Text := value;
end;

procedure TFileUploadForm.SpeedButton1Click(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
    LabeledEdit1.Text := FileOpenDialog1.FileName;
end;

end.
