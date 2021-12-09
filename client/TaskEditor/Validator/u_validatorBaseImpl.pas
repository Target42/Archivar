unit u_validatorBaseImpl;

interface
uses
  i_taskEdit,i_datafields, System.UITypes;

type
  TValidatorBaseImpl = class( TInterfacedObject, IValidator )
    protected
      m_df        : IDataField;
    public
      constructor create( df : IDataField );
      Destructor Destroy; override;

      function validateKey( var ch : char ) : boolean; virtual;
      function validateData( var text : string ) : boolean; virtual;

      procedure updateProbs; virtual;

      procedure release; virtual;

  end;

implementation

uses
  System.SysUtils;

{ TValidatorBaseImpl }

constructor TValidatorBaseImpl.create(df: IDataField);
begin
  m_df := df;
  updateProbs;
end;

destructor TValidatorBaseImpl.Destroy;
begin
  m_df := NIL;
  inherited;
end;

procedure TValidatorBaseImpl.release;
begin
  m_df := NIL;
end;

procedure TValidatorBaseImpl.updateProbs;
begin

end;

function TValidatorBaseImpl.validateData(var text: string): boolean;
begin
  Result := true;
end;

function TValidatorBaseImpl.validateKey(var ch: char): boolean;
begin
  Result := charInSet(ch, [#1..#31]);
end;

end.
