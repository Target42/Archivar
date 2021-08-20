unit u_eventHandler;

interface

uses
  System.JSON, System.SysUtils, System.Generics.Collections;

type
  TEventHandlerFunction = function (const arg : TJSONObject) : boolean of object;
  TEVentHandler = class
    private
      type
        TEntry = class
          private
            FObj      : TObject;
            FCmd      : string;
            FHandler  : TEventHandlerFunction;
            FEnabeld  : boolean;

          public
            constructor create; overload;
            constructor create( obj : TObject; handler : TEventHandlerFunction; cmd : string ); overload;
            Destructor Destroy; override;

            property Obj    : TObject               read FObj     write FObj;
            property Cmd    : string                read FCmd     write FCmd;
            property Handler: TEventHandlerFunction read FHandler write FHandler;
            property Enabled: boolean               read FEnabeld write FEnabeld;

            function execute( const arg : TJSONObject ) : boolean;
        end;
    private
      m_list : TList<TEntry>;
    public
      constructor create;
      Destructor Destroy; override;

      function Register( obj : TObject; handler : TEventHandlerFunction; cmd : string ) : Boolean;
      function Unregister( obj : TObject )                                  : integer; overload;
      function Unregister( obj : TObject; handler : TEventHandlerFunction ) : integer; overload;
      function Unregister( obj : TObject; cmd : string )                    : integer; overload;

      function execute( const arg : TJSONObject ) : boolean;
  end;

var
  EventHandler : TEVentHandler;

implementation

uses
  u_json;

{ TEVentHandler }

constructor TEVentHandler.create;
begin
  m_list := TList<TEntry>.create;
end;

destructor TEVentHandler.Destroy;
var
  en : TEntry;
begin
  inherited;

  for en in m_list do
    en.Free;
  m_list.Free;

end;

function TEVentHandler.execute(const arg: TJSONObject): boolean;
var
  cmd : string;
  en  : TEntry;
begin
  Result := false;
  cmd := lowerCase(Jstring( arg, 'action'));

  for en in m_list do begin
    if SameText( cmd, en.Cmd) then
      Result := en.execute(arg);
  end;
end;

function TEVentHandler.Register(obj: TObject; handler: TEventHandlerFunction;
  cmd: string): Boolean;
var
  found : boolean;
  en    : TEntry;
begin
  Result := false;
  found  := false;
  for en in m_list do begin
    found := (en.Obj = obj) and ( TMethod(handler) = TMethod(handler) ) and SameText( en.Cmd, cmd);
  end;
  if not found then
    m_list.Add(TEntry.create(obj, handler, cmd));
end;

function TEVentHandler.Unregister(obj: TObject): integer;
var
  i : integer;
begin
  Result := 0;
  for i := pred(m_list.Count) downto 0 do begin
    if m_list[i].Obj = obj then begin
      m_list[i].Free;
      m_list.Delete(i);
      inc(Result);
    end;
  end;
end;

function TEVentHandler.Unregister(obj: TObject; handler: TEventHandlerFunction): integer;
var
  i : integer;
begin
  Result := 0;
  for i := pred(m_list.Count) downto 0 do begin
    if (m_list[i].Obj = obj) and ( TMethod(m_list[i].Handler) = TMethod(handler)) then begin
      m_list[i].Free;
      m_list.Delete(i);
      inc(Result);
    end;
  end;
end;
function TEVentHandler.Unregister(obj: TObject; cmd: string): integer;
var
  i : integer;
begin
  Result := 0;
  for i := pred(m_list.Count) downto 0 do begin
    if (m_list[i].Obj = obj) and ( SameText(m_list[i].Cmd, cmd) ) then begin
      m_list[i].Free;
      m_list.Delete(i);
      inc(Result);
    end;
  end;
end;
{ TEVentHandler.TEntry }

constructor TEVentHandler.TEntry.create;
begin
  FObj      := NIL;
  FHandler  := NIL;
  FEnabeld  := false;
end;

constructor TEVentHandler.TEntry.create(obj: TObject; handler :  TEventHandlerFunction; cmd: string);
begin
  FObj      := obj;
  FHandler  := Handler;
  FCmd      := cmd;
  FEnabeld  := true;
end;

destructor TEVentHandler.TEntry.Destroy;
begin

end;

function TEVentHandler.TEntry.execute(const arg: TJSONObject ) : boolean;
begin
  Result := false;
  if  Assigned(FHandler) and FEnabeld then
    Result := FHandler(arg);
end;

initialization
  EventHandler := TEVentHandler.Create;

finalization
  EventHandler.Free;
  EventHandler := NIL;
end.
