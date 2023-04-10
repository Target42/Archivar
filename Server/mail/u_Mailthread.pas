unit u_Mailthread;

interface

uses
  System.Classes, System.Generics.Collections, i_mail;

type
  MailThread = class(TThread)
  private
    m_konten : TThreadList<IMail>;
    FIntervall: UInt64;
  protected
    procedure Execute; override;
  public
    constructor create;
    procedure setKonten( value : TThreadList<IMail> );
    property Intervall: UInt64 read FIntervall write FIntervall;

  end;

implementation

uses
  Winapi.Windows;


{ MailThread }

constructor MailThread.create;
begin
  inherited create(true);
  FIntervall := 5 * 60;
end;

procedure MailThread.Execute;
var
  event : THandle;
  list  : TList<IMail>;
  mail  : IMail;
  start : UInt64;
begin
  event := CreateEvent( NIL, false, false, '' );

  start := GetTickCount64 - (FIntervall * 1000);
  repeat
    WaitForSingleObject( event, 250 );
    if self.Terminated then break;
    if (GetTickCount64 - start) >= (FIntervall * 1000 ) then begin
      list := m_konten.LockList;
      try
        for mail in list do
          mail.update;
      finally
        m_konten.UnlockList;
      end;
      start := GetTickCount64;
    end;
  until self.Terminated;

  CloseHandle(event);
end;

procedure MailThread.setKonten(value: TThreadList<IMail>);
begin
  m_konten := value;
end;

end.
