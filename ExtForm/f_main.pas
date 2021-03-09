unit f_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  cm : TComponent;
  st : TStream;
begin
  st := TFileStream.Create('Einstellung.dfm', fmOpenRead + fmShareDenyNone );
  cm := st.ReadComponent(Panel2);
  st.Free;

  if Assigned(cm) and ( cm is TPanel) then
    ( cm as TPanel).Color := Panel1.Color;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  RegisterClass(TPanel);
  RegisterClass(TSPlitter);
  RegisterClass(TGroupBox);
  RegisterClass(TLabeledEdit);
  RegisterClass(TLabel);
  RegisterClass(TComboBox);
  RegisterClass(TMemo);
end;

end.
