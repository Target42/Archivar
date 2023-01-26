unit u_pluginManager;

interface

uses
  i_plugin, System.Generics.Collections, Vcl.Menus;

type
  TPlugin = class;
  TPluginManager = class
  private
    m_data : IPluginData;
    m_list : TList<TPlugin>;
    m_path : string;
    FMenuRoot: TMenuItem;
    procedure PluginExec(Sender: TObject);
    procedure clearPlugins;
    procedure scan( path : string );
  public
    constructor create;
    Destructor Destroy; override;

    property MenuRoot: TMenuItem read FMenuRoot write FMenuRoot;
    property Items : TList<TPlugin> read m_list;

    procedure CheckPlugins;
    procedure loadAll;
    procedure unloadAll;
  end;

  TPlugin = class
    private
      type
        Releasefunc = procedure; stdcall;
    private
      m_pif       : IPlugin;
      m_hnd       : HModule;
      m_release   : Releasefunc;

      FFileName   : string;
      FPluginName : string;
      FLoaded     : boolean;
      FMenuEntry: TMenuItem;

    public

    constructor create;
    Destructor Destroy; override;

    property MenuEntry: TMenuItem read FMenuEntry write FMenuEntry;
    property FileName: string read FFileName write FFileName;
    property PluginName: string read FPluginName write FPluginName;
    property Loaded : boolean read FLoaded;

    function load( data : IPluginData ) : boolean;
    procedure unload;

    procedure execute;
  end;


implementation

uses
  system.SysUtils, Winapi.Windows, System.IOUtils, System.Types, Vcl.Forms,
  System.UITypes, System.Generics.Defaults, CodeSiteLogging, u_PluginData,
  u_stub, m_glob_client, u_json, System.JSON, System.Classes, Vcl.Dialogs;

{ TPluginManager }

procedure TPluginManager.CheckPlugins;
var
  client  : TTdsPluginClient;

  function CheckMd5( data : TJSONObject) : boolean;
  var
    fname : string;
    md5   : string;
    org   : string;
  begin
    Result := false;
    org    := JString(data, 'md5');
    fname  := TPath.Combine(m_path, JString(data, 'filename'));
    if not FileExists(fname) then exit;

    md5 := GM.md5(fname);
    Result := md5 = org;
  end;

  procedure Download( data : TJSONObject);
  var
    Req   : TJSONObject;
    st    : TStream;
    fname : string;
  begin
    fname := TPath.Combine(m_path, JString(data, 'filename'));

    req := TJSONObject.Create;
    JReplace(Req, 'id', JInt( data, 'id'));

    st := client.download(req);

    if Assigned(st) then
      GM.download(fname, st);
  end;

var
  data    : TJSONObject;
  arr     : TJSONArray;
  row     : TJSONObject;
  i       : integer;
  fname   : string;
  plg     : TPlugin;
  state   : string;
begin
  CodeSite.EnterMethod(Self, 'CheckPlugins');
  m_path := TPath.Combine(ExtractFilePath(paramStr(0)), 'Plugins');

  client := TTdsPluginClient.Create(GM.SQLConnection1.DBXConnection);
  data   := client.getList;

  arr := JArray(data, 'items');
  if Assigned(arr) then begin
    for i := 0 to pred(arr.Count) do begin
      row := getRow(arr, i);
      fname := TPath.Combine( m_path, JString(row, 'filename'));

      state := JString(row, 'state');

      if (state = 'A') and (not checkMd5( row )) then
        Download( row )
      else if not FileExists(fname) and (state = 'E') then
        Download( row );

      if FileExists(fname) and ((state = 'A')or (state = 'E') )then begin
          plg := TPlugin.create;
          plg.FileName := fname;
          m_list.Add(plg);
      end;
    end;
  end;

  client.Free;
  CodeSite.ExitMethod(Self, 'CheckPlugins');
end;

procedure TPluginManager.clearPlugins;
var
  i   : integer;
begin
  for I := 0 to pred(m_list.Count) do begin
    m_list[i].Free;
  end;
  m_list.Clear;
end;

constructor TPluginManager.create;
begin
  m_list :=TList<TPlugin>.create;
  m_data := TPluginDataImpl.create;
end;

destructor TPluginManager.Destroy;
var
  plg : TPlugin;
begin
  for plg in m_list do
    plg.Free;
  m_list.Free;
  m_data := NIL;

  inherited;
end;

procedure TPluginManager.loadAll;
var
  plg : TPlugin;
  i   : integer;
  item: TMenuItem;
begin
  if m_list.Count > 0 then exit;

  CodeSite.EnterMethod(Self, 'loadAll');
  Screen.Cursor := crHourGlass;

  CheckPlugins;

  for plg in m_list do begin
    plg.load(m_data);
  end;
  for i := pred(m_list.Count) downto 0 do begin
    if not m_list[i].Loaded then begin
      m_list[i].Free;
      m_list.Delete(i);
    end;
  end;

  m_list.Sort(
    TComparer<TPlugin>.Construct(
    function(const Left, Right: TPlugin): Integer
    begin
      Result := CompareText(left.PluginName, right.PluginName);
    end
    )
  );

  // mit dem Menü verbinden
  for i := 0 to pred(m_list.Count) do begin
    plg := m_list[i];

    item  := TMenuItem.Create(FMenuRoot);
    FMenuRoot.Add(item);
    plg.MenuEntry := item;

    item.Caption  := plg.PluginName;
    item.Tag      := i;
    item.OnClick := PluginExec;
  end;


  Screen.Cursor := crDefault;
  CodeSite.ExitMethod(Self, 'loadAll');
end;

procedure TPluginManager.PluginExec(Sender: TObject);
begin
  if not ( Sender is TMenuItem) then exit;

  m_list.Items[( Sender as TMenuItem).Tag].execute;

end;

procedure TPluginManager.scan(path: string);
var
  arr : TStringDynArray;
  i   : integer;
  plg : TPlugin;
begin
  CodeSite.EnterMethod(Self, 'scan');
  clearPlugins;
  arr := TDirectory.GetFiles(path, '*.bpl');

  for i := low(arr) to High(arr) do begin
    plg := TPlugin.create;
    plg.FileName := arr[i];
    m_list.Add(plg);
  end;
  SetLength(arr, 0);
  CodeSite.ExitMethod(Self, 'scan');
end;

procedure TPluginManager.unloadAll;
var
  plg : TPlugin;
  i   : integer;
begin
  for i :=0 to pred(m_list.Count) do begin
    plg := m_list[i];
{    if Assigned(plg.MenuEntry) then begin
      FMenuRoot.Remove(plg.MenuEntry);
      plg.MenuEntry.Free;
    end;}
    plg.unload;
    plg.Free;
  end;
  m_list.Clear;
end;

{ TPlugin }

constructor TPlugin.create;
begin
  m_pif   := NIL;
  m_hnd   := 0;
  FLoaded := false;
  FMenuEntry := NIL;
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

function TPlugin.load(data : IPluginData): boolean;
var
  p  : function(ptr : pointer) : IPlugin; stdcall;
  funcName : function : pchar; stdcall;
  r  : procedure; stdcall;
  msg : string;
begin
  CodeSite.EnterMethod(Self, 'load');
  Result := false;
  if FileExists(FFileName) then begin
    try
      msg := FFileName+#10#13;
      m_hnd := LoadPackage(FFileName);
      if m_hnd <> 0 then begin
        @funcName := GetProcAddress(m_hnd, PChar('getPluginName'));
        if Assigned(funcName) then begin
          FPluginName := funcName;
        end else
          FPluginName := 'Unbekanntes Plugin';

        @p := GetProcAddress(m_hnd, PChar('getPIF'));
        if Assigned(p) then begin

          m_pif := p(Application);
          m_pif.config(data);

          FLoaded := true;
          Result  := true;

          CodeSite.Send(FPluginName);
        end else
          msg := msg + 'getPif not found'#10#13;

        @r := GetProcAddress(m_hnd, PChar('release'));
        if Assigned(r) then begin
          m_release := r;
        end else begin
          Result := false;
          msg := msg + 'release not found'#10#13;
        end;
      end;
    except
      on e : exception do begin
        msg := msg + e.toString;
        ShowMessage( msg );
      end;
    end;
  end;
  CodeSite.ExitMethod(Self, 'load');
end;

procedure TPlugin.unload;
begin
  FMenuEntry := NIL;
  FPluginName := '';

  m_pif := NIL;
  if Assigned(m_release) then
    m_release;

  if m_hnd <> 0 then
    UnloadPackage(m_hnd);
  m_hnd := 0;
end;

end.
