unit u_BeschlussImpl;

interface

uses
  i_beschluss, u_AbstimmungenImpl;

type
  TBeschlussImpl = class(TInterfacedObject, IBeschluss )
    private
      m_text : string;
      m_list : IAbstimmungen;

      procedure setText( value : string );
      function  getText : string;
      function  getAbstimmungen : IAbstimmungen;
    public
      constructor create;
      destructor Destroy; override;

      procedure Release;
  end;

implementation

{ TBeschlussImpl }

constructor TBeschlussImpl.create;
begin
  m_list := TAbstimmungenImpl.create;
end;

destructor TBeschlussImpl.Destroy;
begin
  m_list := NIL;
  inherited;
end;

function TBeschlussImpl.getAbstimmungen: IAbstimmungen;
begin
  Result := m_list;
end;

function TBeschlussImpl.getText: string;
begin
  Result := m_text;
end;

procedure TBeschlussImpl.Release;
begin
  m_list.Release;
end;

procedure TBeschlussImpl.setText(value: string);
begin
  m_text := value;
end;

end.
