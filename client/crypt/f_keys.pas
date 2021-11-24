unit f_keys;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TKeysform = class(TForm)
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    GroupBox3: TGroupBox;
    Memo2: TMemo;
    LabeledEdit2: TLabeledEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Keysform: TKeysform;

implementation

uses
  m_crypt;

{$R *.dfm}

procedure TKeysform.BitBtn1Click(Sender: TObject);
begin
  if LabeledEdit1.Text <> LabeledEdit2.Text then begin
    ShowMessage('Die Passworte müssen übereinstimmen!');
    exit;
  end;
  if LabeledEdit1.Text = '' then begin
    ShowMessage('Ein leeres Passwort ist nicht möglich!');
    exit;
  end;
  CryptMod.Password := LabeledEdit1.Text;
  if CryptMod.generateKeys(true) then begin

    if CryptMod.saveKeys then begin
      Memo1.Lines.LoadFromFile(CryptMod.PublicKeyFile);
      Memo2.Lines.LoadFromFile(CryptMod.PrivateKeyFile);
    end
    else
      ShowMessage('die Schlüssel konnten nicht gespeichert werden!');
  end;
end;

procedure TKeysform.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Memo2.Lines.Clear;
end;

end.
