unit u_TPluginImpl;

interface

uses
  i_plugin, Vcl.Forms, Data.SqlExpr;

type
  TPluginImpl = class(TInterfacedObject, IPlugin )
    private
    protected
      m_data   : IPluginData;

      function getData : IPluginData;
    public
      constructor create;
      Destructor Destroy; override;

      property Data : IPluginData read m_data;

      procedure restoreOldApplication;

      procedure config( data : IPluginData ); virtual;

      procedure Execute; virtual;

      procedure PosWindow( owner, form : TForm );
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
end;

destructor TPluginImpl.Destroy;
begin
  inherited;
end;

procedure TPluginImpl.Execute;
begin

end;

function TPluginImpl.getData: IPluginData;
begin
  Result := m_data;
end;

procedure TPluginImpl.PosWindow(owner, form: TForm);
begin
  if not Assigned(owner) or not Assigned(form) then exit;

  if form.Position = poOwnerFormCenter then begin
    form.Position := poDesigned;
    form.Left := Owner.Left + ( owner.Width - form.Width) div 2;
    form.Top  := Owner.Top  + ( owner.Height - form.Height ) div 2;
  end;
end;

procedure TPluginImpl.restoreOldApplication;
begin
  m_data := NIL;
end;

end.
