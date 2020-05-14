unit f_selectList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, fr_base;

type
  TSelectListform = class(TForm)
    BaseFrame1: TBaseFrame;
    ListBox1: TListBox;
    Panel1: TPanel;
    Edit1: TEdit;
    procedure ListBox1Click(Sender: TObject);
  private
    function GetSelected: string;
    procedure SetSelected(const Value: string);
    { Private-Deklarationen }
  public
    property Selected: string read GetSelected write SetSelected;
  end;

var
  SelectListform: TSelectListform;

implementation

{$R *.dfm}

function TSelectListform.GetSelected: string;
begin
  Result := Trim(Edit1.Text);

  if Result = '' then
  begin
    if ListBox1.ItemIndex <> -1 then
      Result := ListBox1.Items.Strings[ListBox1.ItemIndex];
  end;
end;

procedure TSelectListform.ListBox1Click(Sender: TObject);
begin
  Edit1.Text := '';
  if ListBox1.ItemIndex = -1 then
    exit;
  Edit1.Text := ListBox1.Items.Strings[ ListBox1.ItemIndex];
end;

procedure TSelectListform.SetSelected(const Value: string);
begin
  ListBox1.ItemIndex := ListBox1.Items.IndexOf(value);
  Edit1.Text := value;
end;

end.
