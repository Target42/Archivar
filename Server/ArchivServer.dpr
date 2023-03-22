program ArchivServer;

{$ifdef DEBUG}
  {$APPTYPE CONSOLE}
{$endif}


{$R *.RES}

{$R *.dres}

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
  ds_file in 'ds_file.pas' {dsFile: TDSServerModule},
  ds_misc in 'ds_misc.pas' {dsMisc: TDSServerModule},
  u_json in '..\misc\u_json.pas',
  u_Konst in '..\misc\u_Konst.pas',
  u_lockInfo in '..\misc\u_lockInfo.pas',
  m_lockMod in 'm_lockMod.pas' {LockMod: TDataModule},
  ds_protocol in 'ds_protocol.pas' {dsProtocol: TDSServerModule},
  ds_image in 'ds_image.pas' {dsImage: TDSServerModule},
  u_berTypes in '..\misc\u_berTypes.pas',
  ds_chapter in 'ds_chapter.pas' {dsChapter: TDSServerModule},
  ds_taskEdit in 'ds_taskEdit.pas' {dsTaskEdit: TDSServerModule},
  ds_template in 'ds_template.pas' {dsTemplate: TDSServerModule},
  ds_taskView in 'ds_taskView.pas' {dsTaskView: TDSServerModule},
  ds_textblock in 'ds_textblock.pas' {dsTextBlock: TDSServerModule},
  ds_fileCache in 'ds_fileCache.pas' {dsFileCache: TDSServerModule},
  ds_epub in 'ds_epub.pas' {dsEpub: TDSServerModule},
  ds_meeting in 'ds_meeting.pas' {dsMeeing: TDSServerModule},
  u_tree in 'u_tree.pas',
  u_teilnehmer in '..\misc\u_teilnehmer.pas',
  i_user in 'User\i_user.pas',
  u_TServerUserImpl in 'User\u_TServerUserImpl.pas',
  u_TOnlineUserServerImpl in 'User\u_TOnlineUserServerImpl.pas',
  ds_sitzung in 'ds_sitzung.pas' {dsSitzung: TDSServerModule},
  m_hell in 'hell\m_hell.pas' {HellMod: TDataModule},
  u_meeting in 'hell\u_meeting.pas',
  ds_updater in 'ds_updater.pas' {dsUpdater: TDSServerModule},
  u_vote in 'hell\u_vote.pas',
  ds_stamm in 'ds_stamm.pas' {StammMod: TDSServerModule},
  u_broadcastMsg in 'u_broadcastMsg.pas',
  ds_pki in 'ds_pki.pas' {dsPKI: TDSServerModule},
  ds_dairy in 'ds_dairy.pas' {dsDairy: TDSServerModule},
  u_folder in 'u_folder.pas',
  ds_storage in 'ds_storage.pas' {dsStorage: TDSServerModule},
  u_serverTimer in 'u_serverTimer.pas',
  m_http in 'm_http.pas' {HttpMod: TDataModule},
  u_ini in 'u_ini.pas',
  m_del_files in 'm_del_files.pas' {DeleteFilesMod: TDataModule},
  m_mail in '..\misc\m_mail.pas' {MailMod: TDataModule},
  ds_plugin in 'ds_plugin.pas' {TdsPlugin: TDSServerModule},
  ds_import in 'ds_import.pas' {DSImport: TDSServerModule};

var
  MyDummyBoolean  : Boolean;
  s               : string;

begin
{$ifdef DEBUG}
//  Application;
  try
    ReportMemoryLeaksOnShutdown := true;
    // In debug mode the server acts as a console application.
    WriteLn('Archivserver DEBUG mode');
    Writeln('q = quit');
    writeln('o = user online');
    writeln('s = sessions');
    writeln('l = start logging');


    // Create the TService descendant manually.
    ServerContainer1 := TServerContainer1.Create(nil);

    // Simulate service start.
    ServerContainer1.ServiceStart(ServerContainer1, MyDummyBoolean);

    // Keep the console box running (ServerContainer1 code runs in the background)
    repeat
      ReadLn(s);
      s := trim(s);

      if s = 'o' then ServerContainer1.dumpOnlineUser;
      if s = 's' then ServerContainer1.dumpSessions;
      if s = 'l' then begin
        Writeln('start logging');
        ServerContainer1.startLogging;
      end;

    until s = 'q';

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

