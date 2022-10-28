program guard;

{$ifdef DEBUG}
  {$APPTYPE CONSOLE}
{$endif}

uses
  Vcl.SvcMgr,
  u_ArchivarGuard in 'u_ArchivarGuard.pas' {ArchivarGuard: TService},
  System.SysUtils {ArchivarGuard: TService};

{$R *.RES}

var
  MyDummyBoolean  : Boolean;
  s               : string;
begin
{$ifdef DEBUG}
//  Application;
  try
    ReportMemoryLeaksOnShutdown := true;
    // Create the TService descendant manually.
    ArchivarGuard := TArchivarGuard.Create(nil);

    // Simulate service start.
    ArchivarGuard.ServiceStart(ArchivarGuard, MyDummyBoolean);

    // Keep the console box running (ServerContainer1 code runs in the background)
    repeat
      ReadLn(s);
      s := trim(s);
    until s = 'q';

    // On exit, destroy the service object.
    FreeAndNil(ArchivarGuard);
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      WriteLn('Press enter to exit.');
      ReadLn;
    end;
  end;
{$else}
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TArchivarGuard, ArchivarGuard);
  Application.Run;
{$endif}
end.
