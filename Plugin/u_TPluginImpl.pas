unit u_TPluginImpl;

interface

uses
  i_plugin, Vcl.Forms, Data.SqlExpr;

type
  TPluginImpl = class(TInterfacedObject, IPlugin )
    private
    protected
      m_oldApp : TApplication;
      m_data : IPluginData;

      function getPluginName : string; virtual;
    public
      constructor create;
      Destructor Destroy; override;

      property Data : IPluginData read m_data;

      procedure config( data : IPluginData );
      procedure release;

      procedure Execute; virtual;

  end;

implementation


{ TPluginImpl }

procedure TPluginImpl.config(data: IPluginData);
begin
  m_data := data;
//  Application := m_data.App;
end;

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


procedure TPluginImpl.release;
begin
end;


end.
