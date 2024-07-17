unit u_pluginManager;

interface

uses
  i_plugin, System.Generics.Collections, Vcl.Menus, System.Classes;

type
  TPlugin = class;

  TPluginManager = class
  private
    m_data : IPluginData;
    m_list : TList<TPlugin>;
    m_path : string;
    FMenuRoot: TMenuItem;
    m_plgCounter : integer;
    procedure PluginExec(Sender: TObject);
    procedure clearPlugins;
    procedure scan( path : string );
    function addPlugin : TPlugin;
    procedure addMenuentry( plg : TPlugin );
  public
    constructor create;
    Destructor Destroy; override;

    property MenuRoot: TMenuItem read FMenuRoot write FMenuRoot;
    property Items : TList<TPlugin> read m_list;

    procedure CheckPlugins;
    procedure loadAll;
    procedure unloadAll;

    function getByFileName( fileName : string ) : TPlugin;
    function unloadByFileName( fileName : string ) : boolean;
    function load(fileName : string ) : boolean;
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
      FID: integer;
    public

    constructor create;
    Destructor Destroy; override;

    property ID: integer read FID write FID;
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
  u_stub, m_glob_client, u_json, System.JSON, Vcl.Dialogs;

{ TPluginManager }



procedure TPluginManager.addMenuentry(plg: TPlugin);
var
  item  : TMenuItem;
  i     : integer;
  list  : TStringList;
begin
  if not Assigned(FMenuRoot) then
    exit;

  item  := TMenuItem.Create(FMenuRoot);
  FMenuRoot.Add(item);
  plg.MenuEntry := item;

  item.Caption  := plg.PluginName;
  item.Tag      := plg.ID;
  item.OnClick  := PluginExec;

  // sortienren
  list := TStringList.Create;
  try
    for i := 0 to FMenuRoot.Count - 1 do
    begin
      list.AddObject(FMenuRoot.Items[i].Caption, FMenuRoot.Items[i]);
    end;
    list.Sort;
    for i := 0 to list.Count - 1 do
      TMenuItem(list.Objects[i]).MenuIndex := i;
  finally
    list.Free;
  end;
end;

function TPluginManager.addPlugin: TPlugin;
begin
  Result := TPlugin.create;
  inc(m_plgCounter);
  Result.ID := m_plgCounter;
  m_list.Add(Result);
end;

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
          plg := addPlugin;
          plg.FileName := fname;
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
  m_plgCounter := 0;
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

function TPluginManager.getByFileName(fileName: string): TPlugin;
var
  plg : TPlugin;
begin
  Result := NIL;
  for plg in m_list do begin
    if SameText( FileName, ExtractFileName(plg.FileName)) then begin
      Result := plg;
      break;
    end;
  end;

end;

function TPluginManager.load(fileName: string): boolean;
var
  plg : TPlugin;
begin
  Result := false;

  plg := getByFileName(ExtractFileName(FileName));
  if not Assigned(plg) then begin

    try
      plg := addPlugin;
      plg.FileName := FileName;
      plg.load(m_data);

      addMenuentry(plg);

    except
      on e : exception do begin
        m_list.Remove(plg);
        plg.Free;
      end;
    end;

  end;
end;

procedure TPluginManager.loadAll;
var
  plg : TPlugin;
  i   : integer;
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
  for plg in m_list do begin
    addMenuentry(plg);
  end;

  Screen.Cursor := crDefault;
  CodeSite.ExitMethod(Self, 'loadAll');
end;

procedure TPluginManager.PluginExec(Sender: TObject);
var
  plg : TPlugin;
begin
  if not ( Sender is TMenuItem) then exit;

  for plg in m_list do begin
    if plg.id =  ( Sender as TMenuItem).Tag then begin
      plg.execute;
      break;
    end;
  end;
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
    inc(m_plgCounter);
    plg.ID := m_plgCounter;
    plg.FileName := arr[i];
    m_list.Add(plg);
  end;
  SetLength(arr, 0);
  CodeSite.ExitMethod(Self, 'scan');
end;

procedure TPluginManager.unloadAll;
var
  plg : TPlugin;
begin
  for plg in m_list do begin
//    plg.unload;
    plg.Free;
  end;
  m_list.Clear;
end;

function TPluginManager.unloadByFileName(fileName: string): boolean;
var
  plg : TPlugin;
begin
  Result := false;
  for plg in m_list do begin
    if SameText( FileName, ExtractFileName(plg.FileName)) then begin
      m_list.Remove(plg);
//      plg.unload;
      plg.Free;
      Result := true;
      break;
    end;
  end;
end;

{ TPlugin }

constructor TPlugin.create;
begin
  m_pif       := NIL;
  m_hnd       := 0;
  FLoaded     := false;
  FMenuEntry  := NIL;
  FID         := 0;
end;

destructor TPlugin.Destroy;
begin
  inherited;
  if m_hnd <> 0 then
    Unload;
end;

procedure TPlugin.execute;
begin
  if Assigned(m_pif) then begin
    m_pif.Execute;
  end;
end;

function TPlugin.load(data : IPluginData): boolean;
var
  p  : function : IPlugin; stdcall;
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

          m_pif := p;
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

//  m_pif.closeAllForms;

  if Assigned(FMenuEntry) and Assigned(FMenuEntry.Parent) then begin
    FMenuEntry.Parent.Remove(FMenuEntry)
  end;
  FMenuEntry  := NIL;
  FPluginName := '';

  m_pif := NIL;
  if Assigned(m_release) then
    m_release;

  if m_hnd <> 0 then
    UnloadPackage(m_hnd);
  m_hnd := 0;

end;

initialization


end.
