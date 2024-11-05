unit u_service;

interface

uses
  System.Classes;

type
  TServiceDetect = class
    private
      m_text : TStringList;
      m_split: TStringList;
      FServiceName: string;
      FLoaded: boolean;
      FStarted: boolean;
      procedure addText( const line : string );
      function run( cmdLine : string ) : integer;
      procedure SplitLine( line : string );
    public
      constructor create;
      Destructor Destroy; override;

      property ServiceName: string read FServiceName write FServiceName;
      property Loaded: boolean read FLoaded;
      property Started: boolean read FStarted;

      function execute : boolean;

  end;

implementation

uses
  JclSysUtils, System.SysUtils;

{ TServiceDetect }

procedure TServiceDetect.addText(const line: string);
begin
  m_text.Add(line);
end;

constructor TServiceDetect.create;
begin
  m_text := TStringList.Create;
  m_split:= TStringList.Create;
  m_split.StrictDelimiter := true;
  m_split.Delimiter := ' ';
end;

destructor TServiceDetect.Destroy;
begin
  m_text.Free;
  m_split.Free;
  inherited;
end;

function TServiceDetect.execute: boolean;
var
  i : integer;
begin
  Result   := false;
  FLoaded  := false;
  FStarted := false;

  run(Format('PowerShell.exe Get-Service "%s"', [FServiceName]));

  for i := 0 to pred(m_text.Count) do
  begin
    SplitLine(m_text[i]);
    if m_split.Count = 3 then
    begin
      if SameText(FServiceName, m_split[1]) then
      begin
        FLoaded := true;
        FStarted := SameText( 'Running', m_split[0]);
        Result := true;
        break;
      end;
    end;
  end;
end;

function TServiceDetect.run(cmdLine: string): integer;
begin
  m_text.Clear;
  Result := JclSysUtils.Execute( cmdLine, addText );
end;

procedure TServiceDetect.SplitLine(line: string);
var
  i : integer;
begin
  m_split.DelimitedText := line;
  for i := pred(m_split.Count) downto 0 do
  begin
    if trim(m_split[i]) = '' then
      m_split.Delete(i);
  end;
end;

end.
