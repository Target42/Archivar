unit f_importStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TSTatusForm = class(TForm)
    Label1: TLabel;
    PathLab: TLabel;
    Label3: TLabel;
    fileLab: TLabel;
    ProgressBar1: TProgressBar;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  STatusForm: TSTatusForm;

implementation

{$R *.dfm}

end.
