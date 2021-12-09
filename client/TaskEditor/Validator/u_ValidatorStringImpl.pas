unit u_ValidatorStringImpl;

interface

uses
  i_taskEdit,i_datafields, System.UITypes, u_validatorBaseImpl;

type
  TValidatorStringImpl = class( TValidatorBaseImpl )
    private
      m_maxLength : integer;
      m_readOnly  : boolean;
      m_regEx     : string;
      m_charCase  : TEditCharCase;
    public
      function validateKey( var ch : char ) : boolean; override;
      function validateData( var text : string ) : boolean; override;

      procedure updateProbs; override;

  end;

implementation

uses
  System.SysUtils, u_typeHelper;

{ TValidatorStringImpl }

procedure TValidatorStringImpl.updateProbs;
begin
  try
    m_maxLength := StrToIntDef(m_df.propertyValue('Length'), 0);
    m_readOnly  := SameText( m_df.propertyValue('Readonly'), 'ja') or SameText( m_df.propertyValue('Readonly'), 'true');
    m_regEx     := m_df.propertyValue('RegEx');
    m_charCase  := Text2TEditCharCase(m_df.propertyValue('CharCase'));
  except

  end;
end;

function TValidatorStringImpl.validateData(var text: string) : Boolean;
begin
  Result := true;
  if m_maxLength > 0 then begin
    if length(text) > m_maxLength then begin
      SetLength(text, m_maxLength);
      Result := false;
    end;
  end;
end;

function TValidatorStringImpl.validateKey(var ch: char) : Boolean;
begin
  Result := true;
  if m_readOnly then begin
    ch := #0;
    Result := false;
  end;
end;

end.
