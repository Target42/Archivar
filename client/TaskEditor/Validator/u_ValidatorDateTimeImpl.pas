unit u_ValidatorDateTimeImpl;

interface

uses
  u_validatorBaseImpl, i_datafields, System.SysUtils;

type
  TValidatorDateTimeImpl = class( TValidatorBaseImpl )
    private
      m_format  : string;
      m_default : string;
      m_set     : TFormatSettings;
    public
      constructor create( df : IDataField );

      function validateKey( var ch : char ) : boolean; override;
      function validateData( var text : string ) : boolean; override;
      procedure updateProbs; override;

  end;

implementation

{ TValidatorDateTimeImpl }

constructor TValidatorDateTimeImpl.create(df: IDataField);
begin
  inherited create(df);
  m_set := TFormatSettings.Create('de_DE');
end;

procedure TValidatorDateTimeImpl.updateProbs;
begin
  inherited;
  m_format := m_df.propertyValue('format');
  m_default:= m_df.propertyValue('default');

  m_set.TimeSeparator := ':';
  m_set.DateSeparator := '.';

  if m_df.DataType = dtDate then
    m_set.ShortDateFormat := m_format
  else if m_df.DataType = dtTime then
    m_set.ShortDateFormat := m_format;
end;

function TValidatorDateTimeImpl.validateData(var text: string): boolean;
var
  val : TDateTime;
begin
  if m_df.DataType = dtDate then
    Result := TryStrToDate( text, val, m_set )
  else if m_df.DataType = dtTime then
    Result := TryStrToTime( text, val, m_set )
  else
    Result := TryStrToDateTime( text, val, m_set);

  if Result then
    text := FormatDateTime(m_format, StrToDateTime(text));

end;

function TValidatorDateTimeImpl.validateKey(var ch: char): boolean;
begin
  Result := inherited validateKey(ch);

  if m_df.DataType = dtDate then
    Result := Result or CharInSet(ch, ['0'..'9', '.'])
  else if m_df.DataType = dtTime then
    Result := Result or CharInSet(ch, ['0'..'9', ':'])
  else
    Result := Result or CharInSet(ch, ['0'..'9', '.', ':'])
end;

end.
