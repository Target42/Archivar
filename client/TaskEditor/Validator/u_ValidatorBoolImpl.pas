unit u_ValidatorBoolImpl;

interface

uses
  u_validatorBaseImpl;

type
  TValidatorBoolImpl = class( TValidatorBaseImpl )
    private
    public
      function validateKey( var ch : char ) : boolean; override;
      function validateData( var text : string ) : boolean; override;
  end;


implementation

uses
  System.SysUtils;

{ TValidatorBoolImpl }

function TValidatorBoolImpl.validateData(var text: string): boolean;
begin
  Result := SameText( text, 'ja') or SameText(text, 'nein');

  if not Result then begin
    if UpperCase(text) = 'J' then
      text := 'Ja'
    else if UpperCase(text) = 'N' then
      text := 'Nein'
    else
      text := 'Nein';
  end;
  Result := SameText( text, 'ja') or SameText(text, 'nein');
end;

function TValidatorBoolImpl.validateKey(var ch: char): boolean;
begin
  Result := inherited validateKey(ch) or CharInSet(ch, ['j', 'J', 'n', 'N']);
  if not Result then
    ch := #0;
end;

end.
