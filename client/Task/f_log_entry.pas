unit f_log_entry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, fr_base;

type
  TLogEntryform = class(TForm)
    GroupBox2: TGroupBox;
    BaseFrame1: TBaseFrame;
    Memo1: TMemo;
  private
    function GetText: string;
    procedure SetText(const Value: string);
    { Private-Deklarationen }
  public
    property Text: string read GetText write SetText;
  end;

var
  LogEntryform: TLogEntryform;

implementation

{$R *.dfm}

{ TLogEntryform }

function TLogEntryform.GetText: string;
begin
  Result := Memo1.Lines.Text;
end;

procedure TLogEntryform.SetText(const Value: string);
begin
  Memo1.Lines.Text := Value;
end;

end.
