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
  u_ITaskType in 'misc\u_ITaskType.pas',
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
  f_chapterEdit in 'Protokoll\f_chapterEdit.pas' {ChapterEditForm},
  fr_taskList2 in 'Task\fr_taskList2.pas' {TaskList2Frame: TFrame},
  u_taskEntry in 'Task\u_taskEntry.pas',
  f_chapter_content in 'Protokoll\f_chapter_content.pas' {ChapterContentForm},
  f_datafields in 'Datafields\f_datafields.pas' {DataFieldForm},
  f_datafield_edit in 'Datafields\f_datafield_edit.pas' {DatafieldEditform},
  i_datafields in 'Datafields\i_datafields.pas',
  u_PropertyImpl in 'Datafields\u_PropertyImpl.pas',
  u_DataFieldImpl in 'Datafields\u_DataFieldImpl.pas',
  u_DataFieldLislImpl in 'Datafields\u_DataFieldLislImpl.pas',
  f_taskEditor in 'TaskEditor\f_taskEditor.pas' {TaksEditorForm},
  i_taskEdit in 'TaskEditor\i_taskEdit.pas',
  u_TaskImpl in 'TaskEditor\u_TaskImpl.pas',
  f_tableField_editor in 'TaskEditor\f_tableField_editor.pas' {TableFieldEditorForm},
  xsd_DataField in '..\misc\xsd_DataField.pas',
  u_DataField2XML in 'Datafields\u_DataField2XML.pas',
  u_TaskDataField2XML in 'TaskEditor\u_TaskDataField2XML.pas',
  u_Task2XML in 'TaskEditor\u_Task2XML.pas',
  fr_Formeditor in 'TaskEditor\fr_Formeditor.pas' {EditorFrame: TFrame},
  u_TaskFormImpl in 'TaskEditor\u_TaskFormImpl.pas',
  u_TaskCtrlImpl in 'TaskEditor\u_TaskCtrlImpl.pas',
  u_TaskCtrlPropImpl in 'TaskEditor\u_TaskCtrlPropImpl.pas',
  fr_propertyEditor in 'TaskEditor\fr_propertyEditor.pas' {PropertyFrame: TFrame},
  xsd_Task in '..\misc\xsd_Task.pas',
  u_TaskControlFactory in 'TaskEditor\u_TaskControlFactory.pas',
  u_TaskCtrlLabel in 'TaskEditor\controls\u_TaskCtrlLabel.pas',
  u_TaskCtrlEdit in 'TaskEditor\controls\u_TaskCtrlEdit.pas',
  u_TaskCtrlGroupBox in 'TaskEditor\controls\u_TaskCtrlGroupBox.pas',
  u_TaskCtrlLabeledEdit in 'TaskEditor\controls\u_TaskCtrlLabeledEdit.pas',
  u_TaskCtrlTable in 'TaskEditor\controls\u_TaskCtrlTable.pas',
  u_TaskCtrlComboBox in 'TaskEditor\controls\u_TaskCtrlComboBox.pas',
  u_typeHelper in 'TaskEditor\u_typeHelper.pas';

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
  Application.CreateForm(TTaksEditorForm, TaksEditorForm);
  Application.Run;
end.
