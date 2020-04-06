program Archivar;

uses
  Vcl.Forms,
  JclAppInst,
  f_main in 'f_main.pas' {MainForm},
  m_glob_client in 'm_glob_client.pas' {GM: TDataModule},
  u_stub in 'u_stub.pas',
  f_gremiumForm in 'Gremium\f_gremiumForm.pas' {GremiumForm},
  fr_base in '..\misc\fr_base.pas' {BaseFrame: TFrame},
  u_misc in 'u_misc.pas',
  f_gremium_edit in 'Gremium\f_gremium_edit.pas' {GremiumEditForm},
  f_personen in 'Personen\f_personen.pas' {PersonenForm},
  f_person_edit in 'Personen\f_person_edit.pas' {PersonEditForm},
  f_gremium_MA_form in 'Gremium\f_gremium_MA_form.pas' {GremiumMAForm},
  f_task_new in 'Task\f_task_new.pas' {Taskform},
  fr_file in 'File\fr_file.pas' {FileFrame: TFrame},
  fr_einstellung in 'Einstellung\fr_einstellung.pas' {Einstellungsframe: TFrame},
  fr_task_head in 'Task\fr_task_head.pas' {TaskHeaderFrame: TFrame},
  f_taskEdit in 'Task\f_taskEdit.pas' {TaskEditForm},
  fr_gremiumTree in 'misc\fr_gremiumTree.pas' {GremiumTreeFrame: TFrame},
  u_ITask in 'misc\u_ITask.pas',
  u_gremium in 'Gremium\u_gremium.pas',
  fr_taskList in 'Task\fr_taskList.pas' {TaskListFrame: TFrame},
  m_WindowHandler in 'misc\m_WindowHandler.pas' {WindowHandler: TDataModule},
  fr_editForm in 'misc\fr_editForm.pas' {EditFrame: TFrame},
  u_json in '..\misc\u_json.pas',
  xsd_data in '..\misc\xsd_data.pas',
  u_addInfo in 'misc\u_addInfo.pas',
  f_uploadForm in 'File\f_uploadForm.pas' {UploadForm},
  f_gremiumList in 'Gremium\f_gremiumList.pas' {GremiumListForm},
  u_Konst in '..\misc\u_Konst.pas',
  u_lockInfo in '..\misc\u_lockInfo.pas',
  f_bechlus in 'Beschlus\f_bechlus.pas' {Beschlusform},
  f_protokoll in 'Protokoll\f_protokoll.pas' {ProtokollForm},
  f_protokoll_list in 'Protokoll\f_protokoll_list.pas' {ProtocollListForm},
  u_bookmarkList in 'bookmarks\u_bookmarkList.pas',
  u_bookmark in 'bookmarks\u_bookmark.pas',
  m_BookMarkHandler in 'bookmarks\m_BookMarkHandler.pas' {BookMarkHandler: TDataModule},
  f_images in 'images\f_images.pas' {ImagesForm},
  fr_bookmark in 'bookmarks\fr_bookmark.pas' {BookmarkFrame: TFrame},
  u_berTypes in '..\misc\u_berTypes.pas',
  f_taksListForm in 'Task\f_taksListForm.pas' {TaskListForm},
  xsd_protocol in '..\misc\xsd_protocol.pas',
  f_titel_edit in 'Protokoll\f_titel_edit.pas' {TitelEditform},
  u_titel in 'Protokoll\u_titel.pas',
  fr_chapter in 'Protokoll\fr_chapter.pas' {ChapterFrame: TFrame},
  u_chapter in 'Protokoll\u_chapter.pas',
  xsd_chapter in '..\misc\xsd_chapter.pas',
  f_chapterEdit in 'Protokoll\f_chapterEdit.pas' {ChapterEditForm};

{$R *.res}

begin
{$ifdef RELEASE}
  JclAppInstances.CheckSingleInstance;
{$endif}
  ReportMemoryLeaksOnShutdown := true;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TGM, GM);
  Application.CreateForm(TWindowHandler, WindowHandler);
  Application.CreateForm(TBookMarkHandler, BookMarkHandler);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
