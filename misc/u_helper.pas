unit u_helper;

interface

uses
  Vcl.StdCtrls;

function bool2Str( value : boolean ) : string;
function str2bool( value : string ) :  boolean;

function getOldObject( list : TListBox ) :pointer;
procedure selectItem( list : TListBox; obj : pointer );

implementation

uses
  System.SysUtils;

function bool2Str( value : boolean ) : string;
begin
  if value then
    Result := 'true'
  else
    Result := 'false';

end;

function str2bool( value : string ) :  boolean;
begin
  Result := SameText( value, 'true' );
end;

procedure selectItem( list : TListBox; obj : pointer );
var
  i : integer;
begin
  for i := 0 to pred(list.Items.Count) do
  begin
    if list.Items.Objects[i] = obj then
    begin
      list.ItemIndex := i;
      break;
    end;
  end;
end;

function getOldObject( list : TListBox ) : pointer;
begin
  Result := NIL;
  if list.ItemIndex <> -1 then
    Result := list.Items.Objects[ list.ItemIndex];
end;

end.

