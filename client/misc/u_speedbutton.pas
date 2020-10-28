unit u_speedbutton;

interface

uses
  System.Classes;

procedure updateSeedBtn( cmp : TComponent ; id : integer );

implementation

uses
  Vcl.Buttons, Vcl.ActnList;

procedure updateSeedBtn( cmp : TComponent ; id : integer );
var
  i : integer;
  sp: TSpeedButton;
  s : string;
begin
  if cmp is TSpeedButton then
  begin
    sp := cmp as TSpeedButton;
    if sp.Tag = id then
    begin
      sp.Caption := '';
      sp.ShowHint := true;
      if Assigned(sp.Action) then
        s := (sp.Action as TAction ).hint;

       sp.Hint := s;
    end;
  end;
  for i := 0 to pred(cmp.ComponentCount) do
    updateSeedBtn(cmp.Components[i], id);
end;

end.
