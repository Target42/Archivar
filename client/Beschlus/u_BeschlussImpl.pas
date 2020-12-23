unit u_BeschlussImpl;

interface

uses
  i_beschluss, u_AbstimmungImpl;

type
  TBeschlussImpl = class(TInterfacedObject, IBeschluss )
    private
      m_text : string;
      m_vote : IAbstimmung;

      procedure setText( value : string );
      function  getText : string;
      function  getAbstimmung : IAbstimmung;
    public
      constructor create;
      destructor Destroy; override;

      procedure Release;
  end;

implementation

{ TBeschlussImpl }

constructor TBeschlussImpl.create;
begin
  m_vote := TAbstimmungImpl.create;
end;

destructor TBeschlussImpl.Destroy;
begin
  m_vote := NIL;
  inherited;
end;

function TBeschlussImpl.getAbstimmung: IAbstimmung;
begin
  Result := m_vote;
end;

function TBeschlussImpl.getText: string;
begin
  Result := m_text;
end;

procedure TBeschlussImpl.Release;
begin
  m_vote.Release;
end;

procedure TBeschlussImpl.setText(value: string);
begin
  m_text := value;
end;

end.
