unit u_ValidatorFactory;

interface

uses
  i_taskEdit, i_datafields;

type
  TValidatorFactory = class
    private
    public

      constructor create;
      Destructor Destroy; override;

      function Validator( df : IDataField ) : IValidator;
  end;

var
  ValidatorFactory : TValidatorFactory;

implementation

uses
  u_ValidatorStringImpl, u_ValidatorBoolImpl, u_validatorIntegerImpl,
  u_ValidatorFloatImpl, u_ValidatorDateTimeImpl, u_ValidatorEnumImpl;

{ TValidatorFactory }

constructor TValidatorFactory.create;
begin

end;

destructor TValidatorFactory.Destroy;
begin

  inherited;
end;

function TValidatorFactory.Validator(df: IDataField): IValidator;
begin
  Result := NIL;
  if not Assigned(df) then  exit;

  case df.DataType of
    dtUnkown:     Result := NIL;
    dtBool:       Result := TValidatorBoolImpl.create(df);
    dtDate:       Result := TValidatorDateTimeImpl.create(df);
    dtDatetime:   Result := TValidatorDateTimeImpl.create(df);
    dtEnum:       Result := TValidatorEnumImpl.create(df);
    dtFloat:      Result := TValidatorFloatImpl.create(df);
    dtInteger:    Result := TValidatorIntegerImpl.create(df);
    dtString:     Result := TValidatorStringImpl.create(df);
    dtText:       Result := TValidatorStringImpl.create(df);
    dtTime:       Result := TValidatorDateTimeImpl.create(df);
    dtLinktable:  Result := NIL;
    dtTable:      Result := NIL;
    else
      Result := NIL;
  end;


end;

initialization
  ValidatorFactory := TValidatorFactory.create;

finalization
  ValidatorFactory.Free;
end.
