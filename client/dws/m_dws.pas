unit m_dws;

interface

uses
  System.SysUtils, System.Classes, dwsComp, xsd_TaskData, dwsErrors,
  i_taskEdit, dwsExprs;

type

  TDwsMod = class(TDataModule)
    DelphiWebScript1: TDelphiWebScript;
    dwsUnit1: TdwsUnit;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure dwsUnit1FunctionsScriptParamCVountEval(info: TProgramInfo);
    procedure dwsUnit1FunctionsScriptParamEval(info: TProgramInfo);
  private
    m_script : TStringList;
    m_params : TStringList;
    m_xList  : IXMLList;
    m_style  : ITaskStyle;

    function getScript: String;
    procedure setScript(const Value: String);
    function hasError( msgs:TdwsMessageList): boolean;
  public
    property Data      : IXMLList read m_xList write m_xList;
    property TaskStyle : ITaskStyle read m_style write m_style;

    property Params : TStringList read m_params;
    property Script : String read getScript write setScript;

    function compile : boolean;
    function run : string;
  end;

var
  DwsMod: TDwsMod;

implementation

uses
  Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TDwsMod.compile: boolean;
var
  prog : IdwsProgram;
begin
  prog   := DelphiWebScript1.Compile(m_script.Text);

  if (prog.Msgs.Count>0) then
  begin
    ShowMessage(prog.Msgs.AsInfo);
  end;
  Result := hasError(prog.Msgs);
end;

procedure TDwsMod.DataModuleCreate(Sender: TObject);
begin
  m_script := TStringList.Create;
  m_params := TStringList.Create;

  m_xList  := NewList;
  m_style  := NIL;
end;

procedure TDwsMod.DataModuleDestroy(Sender: TObject);
begin
  m_xList := NIL;
  m_style := NIL;

  m_script.Free;
  m_params.Free;
end;

procedure TDwsMod.dwsUnit1FunctionsScriptParamCVountEval(info: TProgramInfo);
begin
  info.ResultAsInteger := m_params.Count;
end;

procedure TDwsMod.dwsUnit1FunctionsScriptParamEval(info: TProgramInfo);
var
  inx : integer;
begin
  inx := info.ParamAsInteger[0];
  if (inx>=0) and ( inx < m_params.Count)  then
    info.ResultAsString := m_params[inx]
  else
    info.ResultAsString := 'ScriptParam out of range : '+IntToStr(inx);
end;

function TDwsMod.getScript: String;
begin
  Result := m_script.Text;
end;

function TDwsMod.hasError(msgs: TdwsMessageList): boolean;
var
  i : integer;
begin
  Result := false;
  for i := 0 to pred(msgs.Count) do
  begin
    Result := Result or msgs.Msgs[i].IsError;
  end;

end;

function TDwsMod.run: string;
var prog : IdwsProgram;
    exec : IdwsProgramExecution;
begin
  prog := DelphiWebScript1.Compile(m_script.Text);

  if ( hasError( prog.Msgs) = true ) then
  begin
    ShowMessage(prog.Msgs.AsInfo);
    exit;
  end;

  exec := prog.Execute;
  Result := exec.Result.ToString;
end;

procedure TDwsMod.setScript(const Value: String);
begin
  m_script.Text := value;
end;

end.
