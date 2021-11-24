unit f_taglist;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.StdCtrls;

type
  TTagListForm = class(TForm)
    LB: TListBox;
    BaseFrame1: TBaseFrame;
  private
    function GetSelected: string;
    procedure SetSelected(const Value: string);
    { Private-Deklarationen }
  public
    property Selected: string read GetSelected write SetSelected;
  end;

var
  TagListForm: TTagListForm;

implementation

{$R *.dfm}

{ TTagListForm }

function TTagListForm.GetSelected: string;
var
  i : integer;
begin
  Result := '';
  for i := 0 to pred(LB.Items.Count) do begin
    if LB.Selected[i] then
      Result := Result + LB.Items.Strings[i]+' ';
  end;
end;

procedure TTagListForm.SetSelected(const Value: string);
var
  list : TStringList;
  i    : integer;
  inx  : integer;
begin
  list := TStringList.Create;
  list.DelimitedText := value;
  for i := 0 to pred(list.Count) do begin
    inx := LB.Items.IndexOf(list[i]);
    if inx <> -1  then
      LB.Selected[inx] := true;
  end;
  list.Free;
end;

end.
