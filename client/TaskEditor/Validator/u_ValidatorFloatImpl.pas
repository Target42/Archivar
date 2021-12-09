unit u_ValidatorFloatImpl;

interface

uses
  u_validatorBaseImpl;

type
  TValidatorFloatImpl = class( TValidatorBaseImpl )
    private
      m_min : Double;
      m_max : Double;
      m_def : Double;
    public
      function validateKey( var ch : char ) : boolean; override;
      function validateData( var text : string ) : boolean; override;
      procedure updateProbs; override;

  end;


implementation

uses
  System.SysUtils;

{ TValidatorFloatImpl }

procedure TValidatorFloatImpl.updateProbs;
begin
  inherited;
  m_min := StrToFloatDef( m_df.propertyValue('min'), 0 );
  m_max := StrToFloatDef( m_df.propertyValue('max'), 0 );
  m_def := StrToFloatDef( m_df.propertyValue('Default'), 0 );

end;

function TValidatorFloatImpl.validateData(var text: string): boolean;
var
  val : Double;
begin
  Result := TryStrToFloat(text, val);

  if not Result then
    val := m_def;

  if (m_max <> 0) and ( val > m_max) then begin
    val := m_max;
    Result := false;
  end;

  if (m_min<>0) and ( val < m_min) then begin
    val := m_min;
    Result := false;
  end;
end;

function TValidatorFloatImpl.validateKey(var ch: char): boolean;
begin
  Result := inherited validateKey(ch) or CharInSet(ch, ['0'..'9', '+', '-', '.', ','])
end;

end.
