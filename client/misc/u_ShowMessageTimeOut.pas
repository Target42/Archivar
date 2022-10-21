unit u_ShowMessageTimeOut;

interface

uses
  Windows, Messages;

procedure ShowMessageTimeout( caption, text : string; timeout : integer = 10 );

function MessageBoxTimeOut(hWnd: HWND; lpText: PChar; lpCaption: PChar;
                           uType: UINT; wLanguageId: WORD; dwMilliseconds: DWORD): Integer; stdcall;
function MessageBoxTimeOutA(hWnd: HWND; lpText: PChar; lpCaption: PChar;
                            uType: UINT; wLanguageId: WORD; dwMilliseconds: DWORD): Integer; stdcall;

function MessageBoxTimeOutW(hWnd: HWND; lpText: PWideChar; lpCaption: PWideChar;
                            uType: UINT; wLanguageId: WORD; dwMilliseconds: DWORD): Integer; stdcall;

implementation

uses
  Vcl.Forms;

const

  MB_TIMEDOUT = 32000;

function MessageBoxTimeOut;  external user32 name 'MessageBoxTimeoutW';
function MessageBoxTimeOutA; external user32 name 'MessageBoxTimeoutA';
function MessageBoxTimeOutW; external user32 name 'MessageBoxTimeoutW';

procedure ShowMessageTimeout( caption, text : string; timeout : integer = 10 );

var
//  iResult: Integer;
  iFlags: Integer;
begin
  iFlags := MB_OK or MB_SETFOREGROUND or MB_SYSTEMMODAL or MB_ICONERROR;

  MessageBoxTimeoutW(Application.Handle,
    PWideChar(text),
    PWideChar(caption),
    iFlags,
    0,
    timeout * 1000);

end;


end.
