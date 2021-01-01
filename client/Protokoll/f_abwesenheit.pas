unit f_abwesenheit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, fr_base, i_chapter;

type
  TAbwesenForm = class(TForm)
    BaseFrame1: TBaseFrame;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox2: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
    m_stauts : TTeilnehmerStatus;

    function GetGrund: String;
    procedure SetGrund(const Value: String);
    function GetStatus: TTeilnehmerStatus;
    procedure SetStatus(const Value: TTeilnehmerStatus);
    { Private-Deklarationen }
  public
    property Grund: String read GetGrund write SetGrund;
    property Status: TTeilnehmerStatus read GetStatus write SetStatus;
  end;

var
  AbwesenForm: TAbwesenForm;

implementation


{$R *.dfm}

{ TAbwesenForm }

procedure TAbwesenForm.FormCreate(Sender: TObject);
begin
  FillTeilnehmerStatusList(ComboBox2.Items);
  ComboBox2.ItemIndex  := 0;
end;

function TAbwesenForm.GetGrund: String;
begin
  Result := Trim(ComboBox1.Text);
  if (Result = '') and ( ComboBox1.ItemIndex <> -1 ) then
    Result := ComboBox1.Items.Strings[ComboBox1.ItemIndex];
end;

function TAbwesenForm.GetStatus: TTeilnehmerStatus;
begin
  Result := tsUnbekannt;
  if ComboBox2.ItemIndex > -1 then
  begin
    Result := TTeilnehmerStatus(ComboBox2.Items.Objects[ComboBox2.ItemIndex]);
  end;
end;

procedure TAbwesenForm.SetGrund(const Value: String);
var
  inx : integer;
begin
  inx := ComboBox1.Items.IndexOf(value);
  if inx <> -1 then
    ComboBox1.ItemIndex := inx
  else
    ComboBox1.Text := value;

end;

procedure TAbwesenForm.SetStatus(const Value: TTeilnehmerStatus);
var
  i : integer;
begin
  m_stauts := value;
  for i := 0 to pred(ComboBox2.Items.Count) do
  begin
    if TTeilnehmerStatus(ComboBox2.Items.Objects[i]) = m_stauts then
    begin
      ComboBox2.ItemIndex := i;
      break;
    end;

  end;

end;

end.
