unit u_helper;

interface

function bool2Str( value : boolean ) : string;
function str2bool( value : string ) :  boolean;
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
end.
