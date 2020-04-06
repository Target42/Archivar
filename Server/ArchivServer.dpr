program ArchivServer;

{$ifdef DEBUG}
  {$APPTYPE CONSOLE}
{$endif}


{$R *.RES}

uses
  Vcl.SvcMgr,
  ds_admin in 'ds_admin.pas' {AdminMod: TDSServerModule},
  ServerContainerUnit1 in 'ServerContainerUnit1.pas' {ServerContainer1: TService},
  System.SysUtils {ServerContainer1: TService},
  m_glob_server in 'm_glob_server.pas' {GM: TDataModule},
  m_db in 'm_db.pas' {DBMod: TDataModule},
  ds_Gremium in 'ds_Gremium.pas' {dsGremium: TDSServerModule},
  ds_person in 'ds_person.pas' {dsPerson: TDSServerModule},
  ds_taks in 'ds_taks.pas' {dsTask: TDSServerModule},
  ds_einstellung in 'ds_einstellung.pas' {dsEinstellung: TDSServerModule},
  ds_file in 'ds_file.pas' {dsFile: TDSServerModule},
  ds_misc in 'ds_misc.pas' {dsMisc: TDSServerModule},
  u_json in '..\misc\u_json.pas',
  u_Konst in '..\misc\u_Konst.pas',
  u_lockInfo in '..\misc\u_lockInfo.pas',
  m_lockMod in 'm_lockMod.pas' {LockMod: TDataModule},
  ds_protocol in 'ds_protocol.pas' {dsProtocol: TDSServerModule},
  ds_image in 'ds_image.pas' {dsImage: TDSServerModule},
  u_berTypes in '..\misc\u_berTypes.pas',
  ds_chapter in 'ds_chapter.pas' {dsChapter: TDSServerModule};

var
  MyDummyBoolean : Boolean;

begin
{$ifdef DEBUG}
//  Application;
  try
    ReportMemoryLeaksOnShutdown := true;
    // In debug mode the server acts as a console application.
    WriteLn('MyServiceApp DEBUG mode. Press enter to exit.');

    // Create the TService descendant manually.
    ServerContainer1 := TServerContainer1.Create(nil);

    // Simulate service start.
    ServerContainer1.ServiceStart(ServerContainer1, MyDummyBoolean);

    // Keep the console box running (ServerContainer1 code runs in the background)
    ReadLn;

    // On exit, destroy the service object.
    FreeAndNil(ServerContainer1);
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
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
{$endif}
end.

