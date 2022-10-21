unit f_keys;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TKeysform = class(TForm)
    GroupBox2: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    BitBtn1: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    Memo2: TMemo;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Keysform: TKeysform;

procedure ShowKeysform;

implementation

uses
  m_crypt, u_stub, m_glob_client, System.JSON, u_json, System.UITypes;

procedure ShowKeysform;
begin
  if not CryptMod.hasKeysLoaded then begin
    if CryptMod.hasKeyFiles and not CryptMod.loadKeys then begin
      // Unload key's
      CryptMod.clearKeys;
      CryptMod.Password := '';
      ShowMessage('Fehler bei dem Entschlüsseln des privaten Schlüssels');
    end else begin
      Application.CreateForm(TKeysform, Keysform);
      Keysform.ShowModal;
      Keysform.free;
    end;
  end;
end;

{$R *.dfm}

procedure TKeysform.BitBtn1Click(Sender: TObject);
var
  pki  : TdsPKIClient;
  pub  : TStream;
  priv : TStream;
  res  : TJSONObject;
  s    : string;
begin
  s := 'Soll ein neues Schlüsselpaar erzeugt werden?';
  if not (MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    exit;

  if LabeledEdit1.Text <> LabeledEdit2.Text then begin
    ShowMessage('Die Passworte müssen übereinstimmen!');
    exit;
  end;
  if LabeledEdit1.Text = '' then begin
    ShowMessage('Ein leeres Passwort ist nicht möglich!');
    exit;
  end;

  CryptMod.Password := LabeledEdit1.Text;
  try
    if CryptMod.generateKeys(true) then begin

      if CryptMod.saveKeys then begin
        Memo1.Lines.LoadFromFile(CryptMod.PublicKeyFile);
        Memo2.Lines.LoadFromFile(CryptMod.PrivateKeyFile);

        pki  := TdsPKIClient.Create(GM.SQLConnection1.DBXConnection);
        pub  := TMemoryStream.Create;
        priv := TMemoryStream.Create;
        try
          (pub as TMemoryStream).LoadFromFile(CryptMod.PublicKeyFile);
          pub.Position := 0;

          (priv as TMemoryStream).LoadFromFile(CryptMod.PrivateKeyFile);
          priv.Position := 0;
          res := pki.uploadKeys( GM.UserName, pub, priv);

          ShowResult( res );
        except
          on e : exception do begin
            ShowMessage( e.ToString );
          end;
        end;
        pki.Free;
      end
      else
        ShowMessage('die Schlüssel konnten nicht gespeichert werden!');
    end;
  except
  on e : exception do
    ShowMessage( e.ToString );
  end;
end;

procedure TKeysform.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Memo2.Lines.Clear;

  if CryptMod.hasKeysLoaded then begin
    if FileExists(CryptMod.PublicKeyFile) then
      Memo1.Lines.LoadFromFile(CryptMod.PublicKeyFile);

    if FileExists(CryptMod.PrivateKeyFile) then
      Memo2.Lines.LoadFromFile(CryptMod.PrivateKeyFile);
  end;
end;

end.
