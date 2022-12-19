unit u_pluginManager;

interface

uses
  i_plugin, System.Generics.Collections;

type
  TPlugin = class;
  TPluginManager = class
  private
    m_list : TList<TPlugin>;
    FItems: TList<TPlugin>;
    procedure SetItems(const Value: TList<TPlugin>);
  public
    constructor create;
    Destructor Destroy; override;

    property Items : TList<TPlugin> read FItems write SetItems;

    procedure scan( path : string );
    procedure loadAll;
  end;

  TPlugin = class
    private
      m_pif       : IPlugin;
      m_hnd       : HModule;
      FFileName   : string;
      FPluginName : string;
      FLoaded     : boolean;
    public

    constructor create;
    Destructor Destroy; override;

    property FileName: string read FFileName write FFileName;
    property PluginName: string read FPluginName write FPluginName;
    property Loaded : boolean read FLoaded;

    function load : boolean;

    procedure execute;
  end;


implementation

uses
  system.SysUtils, Winapi.Windows, System.IOUtils, System.Types, Vcl.Forms,
  System.UITypes, System.Generics.Defaults, CodeSiteLogging;

{ TPluginManager }

constructor TPluginManager.create;
begin
  m_list :=TList<TPlugin>.create;
end;

destructor TPluginManager.Destroy;
var
  plg : TPlugin;
begin
  for plg in m_list do
    plg.Free;
  m_list.Free;

  inherited;
end;

procedure TPluginManager.loadAll;
var
  plg : TPlugin;
begin
  CodeSite.EnterMethod(Self, 'loadAll');
  Screen.Cursor := crHourGlass;

  for plg in m_list do
    plg.load;

  m_list.Sort(
    TComparer<TPlugin>.Construct(
    function(const Left, Right: TPlugin): Integer
    begin
      Result := CompareText(left.PluginName, right.PluginName);
    end
    )
  );

  Screen.Cursor := crDefault;
  CodeSite.ExitMethod(Self, 'loadAll');
end;

procedure TPluginManager.scan(path: string);
var
  arr : TStringDynArray;
  i   : integer;
  plg : TPlugin;
begin
  arr := TDirectory.GetFiles(path, '*.bpl');

  for i := low(arr) to High(arr) do begin
    plg := TPlugin.create;
    plg.FileName := arr[i];
    m_list.Add(plg);
  end;
  SetLength(arr, 0);
end;

procedure TPluginManager.SetItems(const Value: TList<TPlugin>);
begin
  FItems := Value;
end;

{ TPlugin }

constructor TPlugin.create;
begin
  m_pif   := NIL;
  m_hnd   := 0;
  FLoaded := false;
end;

destructor TPlugin.Destroy;
begin

  inherited;
end;

procedure TPlugin.execute;
begin
  if Assigned(m_pif) then
    m_pif.Execute;
end;

function TPlugin.load: boolean;
var
  p  : function : IPlugin; stdcall;
begin
  CodeSite.EnterMethod(Self, 'load');
  Result := false;
  if FileExists(FFileName) then begin
    try
      m_hnd := LoadPackage(FFileName);
      if m_hnd <> 0 then begin
        @p := GetProcAddress(m_hnd, PChar('getPIF'));
        m_pif := p;

        FPluginName := m_pif.PluginName;

        FLoaded := true;
        Result  := true;
        CodeSite.Send(FPluginName);
      end;
    except

    end;
  end;
  CodeSite.ExitMethod(Self, 'load');
end;

end.
