unit f_web_file;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  fr_base;

type
  TWebFileForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LabeledEdit1: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
    FileOpenDialog1: TFileOpenDialog;
    procedure SpeedButton1Click(Sender: TObject);
  private
    function GetDirs: TStrings;
    procedure SetDirs(const Value: TStrings);
    function GetPath: string;
    procedure SetPath(const Value: string);
    function GetFileName: string;
    procedure SetFileName(const Value: string);
    { Private-Deklarationen }
  public
    property Dirs: TStrings read GetDirs write SetDirs;
    property Path: string read GetPath write SetPath;
    property FileName: string read GetFileName write SetFileName;
  end;

var
  WebFileForm: TWebFileForm;

implementation

{$R *.dfm}

function TWebFileForm.GetDirs: TStrings;
begin
  Result := ComboBox1.Items;
end;

function TWebFileForm.GetFileName: string;
begin
  Result := LabeledEdit1.Text;
end;

function TWebFileForm.GetPath: string;
begin
  Result := ComboBox1.Text;
end;

procedure TWebFileForm.SetDirs(const Value: TStrings);
begin
  ComboBox1.Items.Assign(Value);
  ComboBox1.Text := '';
end;

procedure TWebFileForm.SetFileName(const Value: string);
begin
  LabeledEdit1.Text := value;
end;

procedure TWebFileForm.SetPath(const Value: string);
begin
  ComboBox1.Text := value;
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(value);
end;

procedure TWebFileForm.SpeedButton1Click(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
    LabeledEdit1.Text := FileOpenDialog1.FileName;
end;

end.
