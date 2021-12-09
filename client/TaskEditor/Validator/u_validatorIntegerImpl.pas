unit u_validatorIntegerImpl;

interface

uses
  u_validatorBaseImpl;

type
  TValidatorIntegerImpl = class( TValidatorBaseImpl )
    private
      m_min : integer;
      m_max : integer;
      m_def : integer;
    public
      function validateKey( var ch : char ) : boolean; override;
      function validateData( var text : string ) : boolean; override;
      procedure updateProbs; override;

  end;

implementation

uses
  System.SysUtils;

{ TValidatorIntegerImpl }

procedure TValidatorIntegerImpl.updateProbs;
begin
  m_min := StrToIntDef( m_df.propertyValue('min'), 0 );
  m_max := StrToIntDef( m_df.propertyValue('max'), 0 );
  m_def := StrToIntDef( m_df.propertyValue('Default'), 0 );
end;

function TValidatorIntegerImpl.validateData(var text: string): boolean;
var
  val : integer;
begin
  Result := TryStrToInt(text, val);

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

function TValidatorIntegerImpl.validateKey(var ch: char): boolean;
begin
  Result := inherited validateKey(ch) or CharInSet(ch, ['0'..'9', '+', '-'])
end;

end.
