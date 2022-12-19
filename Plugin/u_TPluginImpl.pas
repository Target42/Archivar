unit u_TPluginImpl;

interface

uses
  i_plugin, Vcl.Forms, Data.SqlExpr;

type
  TPluginImpl = class(TInterfacedObject, IPlugin )
    private

    protected
      m_oldApp : TApplication;
      m_app : TApplication;
      m_sql : TSQLConnection;

      function getPluginName : string; virtual;
    public
      constructor create;
      Destructor Destroy; override;

      procedure prepare( App : TApplication; sql : TSQLConnection );
      procedure release;

      procedure Execute; virtual;

  end;

implementation


{ TPluginImpl }

constructor TPluginImpl.create;
begin
  m_oldApp := Application;
end;

destructor TPluginImpl.Destroy;
begin
  Application := m_oldApp;
  inherited;
end;

procedure TPluginImpl.Execute;
begin

end;

function TPluginImpl.getPluginName: string;
begin
  Result := 'Namen ändern!';
end;

procedure TPluginImpl.prepare(App: TApplication; sql: TSQLConnection);
begin
  m_app := App;
  m_sql := sql;
  Application := m_app;
end;

procedure TPluginImpl.release;
begin
end;


end.
