unit f_textblock_preview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, fr_editForm;

type
  TTextBlockPreviewForm = class(TForm)
    StatusBar1: TStatusBar;
    EditFrame1: TEditFrame;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    function GetText: string;
    procedure SetText(const Value: string);
  public
    property Text: string read GetText write SetText;

  end;

var
  TextBlockPreviewForm: TTextBlockPreviewForm;

implementation



{$R *.dfm}

procedure TTextBlockPreviewForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
end;


function TTextBlockPreviewForm.GetText: string;
begin
  Result := EditFrame1.Text;
end;

procedure TTextBlockPreviewForm.SetText(const Value: string);
begin
  EditFrame1.Text := value;
end;

end.
