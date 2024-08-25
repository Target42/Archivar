unit f_epub_show;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, fr_epub, Vcl.ComCtrls;

type
  TePubShowForm = class(TForm)
    ePupFrame1: TePupFrame;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  ePubShowForm: TePubShowForm;

procedure ShowEpubList;

implementation

{$R *.dfm}

procedure ShowEpubList;
begin
  try
  Application.CreateForm(TePubShowForm, ePubShowForm);
  ePubShowForm.ShowModal;
  finally
    ePubShowForm.Free;
  end;
end;

procedure TePubShowForm.FormCreate(Sender: TObject);
begin
  ePupFrame1.init;
end;

procedure TePubShowForm.FormDestroy(Sender: TObject);
begin
  ePupFrame1.release;
end;

end.
