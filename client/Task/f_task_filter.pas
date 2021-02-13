unit f_task_filter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, fr_base;

type
  TTaskFilterForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LB: TCheckListBox;
    procedure FormCreate(Sender: TObject);
  private
    function GetFilter: integer;
    procedure SetFilter(const Value: integer);
    { Private-Deklarationen }
  public
    property Filter: integer read GetFilter write SetFilter;
  end;

var
  TaskFilterForm: TTaskFilterForm;

implementation

uses
  u_Konst;

{$R *.dfm}

procedure TTaskFilterForm.FormCreate(Sender: TObject);
begin
  FillFlagslist(LB.Items);
end;

function TTaskFilterForm.GetFilter: integer;
var
  i : integer;
begin
  Result := 0;
  for i := 0 to pred(LB.Count) do
  begin
    if LB.Checked[i] then
    begin
      Result := Result or integer( Lb.Items.Objects[i]);
    end;
  end;
end;

procedure TTaskFilterForm.SetFilter(const Value: integer);
var
  i : integer;
begin
  for i := 0 to pred(LB.Count) do
  begin
    LB.Checked[i] := (integer( Lb.Items.Objects[i]) and value) > 0 ;
  end;
end;

end.
