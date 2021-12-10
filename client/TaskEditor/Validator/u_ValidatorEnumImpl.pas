unit u_ValidatorEnumImpl;

interface
uses
  u_validatorBaseImpl, i_datafields, System.SysUtils, System.Classes;

type
  TValidatorEnumImpl = class( TValidatorBaseImpl )
    private
      m_values    : TStringList;
      m_ownValues : boolean;
      m_default   : string;
    public
      constructor create( df : IDataField );
      Destructor Destroy; override;

      function validateKey( var ch : char ) : boolean; override;
      function validateData( var text : string ) : boolean; override;
      procedure updateProbs; override;

  end;

implementation

{ TValidatorEnumImpl }

constructor TValidatorEnumImpl.create(df: IDataField);
begin
  inherited create(df);

  m_values    := TStringList.Create;
  m_values.StrictDelimiter := true;
  m_values.Delimiter := ';';
end;

destructor TValidatorEnumImpl.Destroy;
begin
  m_values.Free;
  inherited;
end;

procedure TValidatorEnumImpl.updateProbs;
begin
  inherited;
  m_values.DelimitedText := m_df.propertyValue('Values');
  m_default   := m_df.propertyValue('default');
  m_ownValues := SameText(m_df.propertyValue('Eigene Werte'), 'ja') or SameText(m_df.propertyValue('Eigene Werte'), 'true');
end;

function TValidatorEnumImpl.validateData(var text: string): boolean;
begin
  if m_ownValues then
    Result := true
  else begin
    Result := m_values.IndexOf(text) <> -1;
    if not Result then
      text := m_default;
  end;
end;

function TValidatorEnumImpl.validateKey(var ch: char): boolean;
begin
  Result := true;
end;

end.
