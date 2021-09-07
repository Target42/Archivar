unit f_image_preview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TImagePreviewform = class(TForm)
    Image1: TImage;
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  ImagePreviewform: TImagePreviewform;

implementation

{$R *.dfm}

procedure TImagePreviewform.FormDestroy(Sender: TObject);
begin
  ImagePreviewform := NIL;
end;

end.
