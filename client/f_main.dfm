object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Archivar'
  ClientHeight = 674
  ClientWidth = 1110
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  Position = poScreenCenter
  WindowState = wsMaximized
  WindowMenu = Fenster1
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 249
    Top = 0
    Width = 5
    Height = 463
    Color = clYellow
    ParentColor = False
    Visible = False
    ExplicitHeight = 469
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 463
    Width = 1110
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    Color = clYellow
    ParentColor = False
    Visible = False
    ExplicitTop = 469
    ExplicitWidth = 1126
  end
  object Image1: TImage
    Left = 254
    Top = 0
    Width = 856
    Height = 463
    Align = alClient
    Center = True
    ExplicitLeft = 260
    ExplicitTop = -1
    ExplicitWidth = 868
    ExplicitHeight = 466
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 655
    Width = 1110
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Style = psOwnerDraw
        Width = 250
      end>
    OnDrawPanel = StatusBar1DrawPanel
    ExplicitTop = 651
    ExplicitWidth = 1108
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 249
    Height = 463
    ActivePage = TabSheet2
    Align = alLeft
    Images = ImageList1
    MultiLine = True
    TabOrder = 1
    TabPosition = tpLeft
    Visible = False
    object TabSheet1: TTabSheet
      Caption = 'Gremien'
      ImageIndex = 16
      inline GremiumTreeFrame1: TGremiumTreeFrame
        Left = 0
        Top = 0
        Width = 221
        Height = 455
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 221
        ExplicitHeight = 455
        inherited TV: TTreeView
          Width = 221
          Height = 455
          ExplicitWidth = 221
          ExplicitHeight = 455
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Lesezeichen'
      ImageIndex = 34
      inline BookmarkFrame1: TBookmarkFrame
        Left = 0
        Top = 0
        Width = 221
        Height = 455
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 221
        ExplicitHeight = 455
        inherited LV: TListView
          Width = 221
          Height = 455
          ExplicitWidth = 221
          ExplicitHeight = 455
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'B'#252'cher'
      ImageIndex = 23
      inline ePupFrame1: TePupFrame
        Left = 0
        Top = 0
        Width = 221
        Height = 455
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 221
        ExplicitHeight = 455
        inherited GroupBox1: TGroupBox
          Width = 221
          Height = 390
          ExplicitWidth = 221
          ExplicitHeight = 390
          inherited DBGrid1: TDBGrid
            Width = 217
            Height = 373
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
          end
        end
        inherited GroupBox2: TGroupBox
          Top = 390
          Width = 221
          ExplicitTop = 390
          ExplicitWidth = 221
        end
        inherited EpubTab: TFDMemTable
          Left = 16
          Top = 8
        end
        inherited DataSource1: TDataSource
          Left = 72
          Top = 24
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Online'
      ImageIndex = 21
      object UserView: TListView
        Left = 0
        Top = 0
        Width = 221
        Height = 414
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 75
          end
          item
            Caption = 'Vorname'
            Width = 75
          end>
        GridLines = True
        GroupView = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
      object Panel1: TPanel
        Left = 0
        Top = 414
        Width = 221
        Height = 41
        Align = alBottom
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 1
        object JvColorComboBox1: TJvColorComboBox
          Left = 9
          Top = 6
          Width = 121
          Height = 20
          ColorDialogText = 'Custom...'
          DroppedDownWidth = 121
          NewColorText = 'Custom'
          Options = [coText]
          TabOrder = 0
          OnChange = JvColorComboBox1Change
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Ablagen'
      ImageIndex = 26
      inline StoragesFrame1: TStoragesFrame
        Left = 0
        Top = 0
        Width = 221
        Height = 455
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 221
        ExplicitHeight = 455
        inherited LV: TListView
          Width = 221
          Height = 455
          ExplicitWidth = 221
          ExplicitHeight = 455
        end
      end
    end
  end
  object PageControl2: TPageControl
    Left = 0
    Top = 468
    Width = 1110
    Height = 187
    ActivePage = TabSheet4
    Align = alBottom
    Images = ImageList1
    TabOrder = 2
    Visible = False
    object TabSheet4: TTabSheet
      Caption = 'Offene Aufgaben'
      ImageIndex = 33
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 1102
        Height = 158
        Align = alClient
        Caption = 'Aufgaben'
        TabOrder = 0
        inline TaskListFrame1: TTaskListFrame
          Left = 2
          Top = 15
          Width = 1098
          Height = 141
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 2
          ExplicitTop = 15
          ExplicitWidth = 1098
          ExplicitHeight = 141
          inherited LV: TListView
            Width = 1098
            Height = 141
            ExplicitWidth = 1098
            ExplicitHeight = 141
          end
          inherited ActionList1: TActionList
            Left = 176
            Top = 80
          end
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Sitzungstermine'
      ImageIndex = 46
      inline MeetingFrame1: TMeetingFrame
        Left = 0
        Top = 0
        Width = 1102
        Height = 158
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 1102
        ExplicitHeight = 158
        inherited Lv: TListView
          Width = 1102
          Height = 158
          Groups = <
            item
              Header = 'Laufend'
              GroupID = 0
              State = [lgsNormal, lgsCollapsible]
              HeaderAlign = taLeftJustify
              FooterAlign = taLeftJustify
              TitleImage = -1
            end
            item
              Header = 'Geplant'
              GroupID = 1
              State = [lgsNormal, lgsCollapsible]
              HeaderAlign = taLeftJustify
              FooterAlign = taLeftJustify
              TitleImage = -1
            end>
          ExplicitWidth = 1100
          ExplicitHeight = 158
        end
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'L'#246'schwarnung'
      ImageIndex = 7
      inline FilesToDeleteFrame1: TFilesToDeleteFrame
        Left = 0
        Top = 0
        Width = 1102
        Height = 158
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 1102
        ExplicitHeight = 158
        inherited LV: TListView
          Width = 1102
          Height = 158
          ExplicitWidth = 1102
          ExplicitHeight = 158
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 72
    Top = 128
    object Programm1: TMenuItem
      Caption = '&Programm'
      ImageIndex = 36
      object Einstellungen1: TMenuItem
        Action = ac_prg_set
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Verbinden1: TMenuItem
        Action = ac_prg_connect
      end
      object rennen1: TMenuItem
        Action = ac_prg_discon
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Ende1: TMenuItem
        Action = ac_prg_close
      end
    end
    object Aufgabe1: TMenuItem
      Caption = 'Aktionen'
      ImageIndex = 25
      Visible = False
      object Aufgabe2: TMenuItem
        Caption = 'Aufgabe'
        GroupIndex = 200
        ImageIndex = 33
        object Neue2: TMenuItem
          Action = ac_ta_neu
        end
        object Laden2: TMenuItem
          Action = ac_ta_load
        end
        object N10: TMenuItem
          Caption = '-'
        end
        object asklschen1: TMenuItem
          Action = ac_ta_delete
          Enabled = False
        end
        object N23: TMenuItem
          Caption = '-'
        end
        object Import3: TMenuItem
          Action = ac_ta_import
          Enabled = False
        end
      end
      object Proptokoll1: TMenuItem
        Caption = 'Protokoll'
        GroupIndex = 200
        ImageIndex = 34
        object Neu1: TMenuItem
          Action = ac_pr_new
        end
        object Laden1: TMenuItem
          Action = ac_pr_open
        end
        object N7: TMenuItem
          Caption = '-'
        end
        object Anzeigen1: TMenuItem
          Action = ac_pr_view
        end
        object N15: TMenuItem
          Caption = '-'
        end
        object Abschnittbearbeiten1: TMenuItem
          Action = ac_pr_abschnitt
        end
        object N9: TMenuItem
          Caption = '-'
        end
        object Lschen2: TMenuItem
          Action = ac_pr_delete
        end
      end
      object Sitzungen1: TMenuItem
        Caption = 'Sitzung'
        GroupIndex = 200
        ImageIndex = 32
        object Neu3: TMenuItem
          Action = ac_me_new
        end
        object Bearbeiten2: TMenuItem
          Action = ac_me_edit
        end
        object N11: TMenuItem
          Caption = '-'
        end
        object Einladen1: TMenuItem
          Action = ac_me_invite
        end
        object Update1: TMenuItem
          Action = ac_me_update
        end
        object N14: TMenuItem
          Caption = '-'
        end
        object Ausfhren1: TMenuItem
          Action = ac_me_execute
        end
        object N12: TMenuItem
          Caption = '-'
        end
        object Abschlieen1: TMenuItem
          Action = ac_me_end
        end
        object N13: TMenuItem
          Caption = '-'
        end
        object Lschen3: TMenuItem
          Action = ac_me_delete
        end
      end
    end
    object Reports1: TMenuItem
      Caption = 'Reports'
      GroupIndex = 200
      ImageIndex = 37
    end
    object Ansicht1: TMenuItem
      Caption = 'Ansicht'
      GroupIndex = 200
      ImageIndex = 10
      object Verwaltung1: TMenuItem
        Action = ac_view_admin
      end
      object Aufgaben1: TMenuItem
        Action = ac_view_task
      end
      object ePubanzeigen1: TMenuItem
        Action = ac_view_epub
      end
    end
    object Tools1: TMenuItem
      Caption = 'Tools'
      GroupIndex = 200
      ImageIndex = 3
      object Disput1: TMenuItem
        Action = ac_to_disput
      end
      object Dokumentenmanagement1: TMenuItem
        Action = ac_to_dms
      end
      object FAQ1: TMenuItem
        Action = ac_to_faq
      end
      object Import1: TMenuItem
        Action = ac_to_import
      end
      object Mails1: TMenuItem
        Action = ac_mail
      end
      object Statistik1: TMenuItem
        Action = ac_to_stat
      end
      object Wiki1: TMenuItem
        Action = ac_to_wiki
      end
      object Schlssel1: TMenuItem
        Action = ac_to_keys
      end
      object PersnlichDatenablage1: TMenuItem
        Action = ac_to_pdrive
      end
    end
    object Plugins1: TMenuItem
      Caption = 'Plugins'
      GroupIndex = 200
      ImageIndex = 24
    end
    object Admin1: TMenuItem
      Caption = 'Admin'
      GroupIndex = 200
      ImageIndex = 31
      Visible = False
      object Bilder1: TMenuItem
        Action = ac_ad_pics
      end
      object Gremium1: TMenuItem
        Action = ac_ad_gremium
      end
      object Mitglieder1: TMenuItem
        Action = ac_ad_person
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Datenfelder1: TMenuItem
        Action = ac_ad_datafields
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Vorlagen1: TMenuItem
        Caption = 'Aufgabenvorlage'
        ImageIndex = 20
        object NeueVorlage1: TMenuItem
          Action = ac_ad_template_new
        end
        object Vorlagenbearbeiten1: TMenuItem
          Action = ac_ad_templates
        end
        object N8: TMenuItem
          Caption = '-'
        end
        object Systemvorlage1: TMenuItem
          Action = ac_ad_sys_template
        end
        object N16: TMenuItem
          Caption = '-'
        end
        object Aufgabentypen1: TMenuItem
          Action = ac_ad_tasktype
        end
      end
      object extbausteine1: TMenuItem
        Caption = 'Textbausteine'
        ImageIndex = 35
        object Neu2: TMenuItem
          Action = ac_tb_neu
        end
        object Bearbeiten1: TMenuItem
          Action = ac_tb_edit
        end
        object N5: TMenuItem
          Caption = '-'
        end
        object Lschen1: TMenuItem
          Action = ac_tb_löschen
        end
        object N18: TMenuItem
          Caption = '-'
        end
        object Export1: TMenuItem
          Action = ac_tb_export
        end
        object Import2: TMenuItem
          Action = ac_tb_import
        end
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Webserverdateienverwalten1: TMenuItem
        Action = ac_ad_http
      end
      object ePubmanager1: TMenuItem
        Action = ac_ad_epub
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object Dateicache1: TMenuItem
        Action = ac_ad_filecache
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object N19: TMenuItem
        Action = ac_ad_storages
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object Aktionen1: TMenuItem
        Action = ac_ad_action
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object Plugins2: TMenuItem
        Action = ac_ad_plugin
      end
      object Mailkonten1: TMenuItem
        Action = ac_ad_mail
      end
    end
    object Fenster1: TMenuItem
      Caption = 'Fenster'
      GroupIndex = 200
      ImageIndex = 38
      object Arrange1: TMenuItem
        Action = WindowArrange1
      end
      object Cascade1: TMenuItem
        Action = WindowCascade1
      end
      object MinimizeAll1: TMenuItem
        Action = WindowMinimizeAll1
      end
      object ileHorizontally1: TMenuItem
        Action = WindowTileHorizontal1
      end
      object ileVertically1: TMenuItem
        Action = WindowTileVertical1
      end
      object est1: TMenuItem
        Caption = 'Test'
        Visible = False
        OnClick = est1Click
      end
      object test21: TMenuItem
        Caption = 'test2'
        Visible = False
        OnClick = test21Click
      end
    end
    object Hilfe1: TMenuItem
      Caption = 'Hilfe'
      GroupIndex = 200
      ImageIndex = 48
      object Hilfe2: TMenuItem
        Action = ac_hlp_hilfe
        ShortCut = 112
      end
      object Fehlermelden1: TMenuItem
        Action = ac_hlp_fehler
      end
    end
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 152
    Top = 96
    object ac_prg_close: TAction
      Category = 'Program'
      Caption = 'Ende'
      ImageIndex = 0
      OnExecute = ac_prg_closeExecute
    end
    object ac_prg_connect: TAction
      Category = 'Program'
      Caption = 'Verbinden'
      ImageIndex = 1
      ShortCut = 113
      OnExecute = ac_prg_connectExecute
    end
    object ac_prg_discon: TAction
      Category = 'Program'
      Caption = 'Trennen'
      Enabled = False
      ImageIndex = 2
      OnExecute = ac_prg_disconExecute
    end
    object ac_prg_set: TAction
      Category = 'Program'
      Caption = 'Einstellungen'
      ImageIndex = 3
      OnExecute = ac_prg_setExecute
    end
    object ac_ad_gremium: TAction
      Category = 'Admin'
      Caption = 'Gremium'
      ImageIndex = 16
      OnExecute = ac_ad_gremiumExecute
    end
    object ac_ad_person: TAction
      Category = 'Admin'
      Caption = 'Mitglieder'
      ImageIndex = 17
      OnExecute = ac_ad_personExecute
    end
    object ac_ta_neu: TAction
      Category = 'Task'
      Caption = 'Neue'
      Enabled = False
      ImageIndex = 5
      OnExecute = ac_ta_neuExecute
    end
    object WindowCascade1: TWindowCascade
      Category = 'Window'
      Caption = '&Cascade'
      Enabled = False
      Hint = 'Cascade'
      ImageIndex = 42
    end
    object WindowTileHorizontal1: TWindowTileHorizontal
      Category = 'Window'
      Caption = 'Tile &Horizontally'
      Enabled = False
      Hint = 'Tile Horizontal'
      ImageIndex = 40
    end
    object WindowTileVertical1: TWindowTileVertical
      Category = 'Window'
      Caption = '&Tile Vertically'
      Enabled = False
      Hint = 'Tile Vertical'
      ImageIndex = 41
    end
    object WindowMinimizeAll1: TWindowMinimizeAll
      Category = 'Window'
      Caption = '&Minimize All'
      Enabled = False
      Hint = 'Minimize All'
      ImageIndex = 43
    end
    object WindowArrange1: TWindowArrange
      Category = 'Window'
      Caption = '&Arrange'
      Enabled = False
      ImageIndex = 44
    end
    object ac_pr_new: TAction
      Category = 'Protokoll'
      Caption = 'Neu'
      Enabled = False
      ImageIndex = 5
      OnExecute = ac_pr_newExecute
    end
    object ac_pr_open: TAction
      Category = 'Protokoll'
      Caption = 'Bearbeiten'
      Enabled = False
      ImageIndex = 6
      OnExecute = ac_pr_openExecute
    end
    object ac_ad_pics: TAction
      Category = 'Admin'
      Caption = 'Bilder'
      ImageIndex = 18
      OnExecute = ac_ad_picsExecute
    end
    object ac_ta_load: TAction
      Category = 'Task'
      Caption = 'Bearbeiten'
      Enabled = False
      ImageIndex = 6
      OnExecute = ac_ta_loadExecute
    end
    object ac_ad_datafields: TAction
      Category = 'Admin'
      Caption = 'Datenfelder'
      ImageIndex = 19
      OnExecute = ac_ad_datafieldsExecute
    end
    object ac_ad_templates: TAction
      Category = 'Admin'
      Caption = 'Vorlagen bearbeiten'
      ImageIndex = 20
      OnExecute = ac_ad_templatesExecute
    end
    object ac_ad_template_new: TAction
      Category = 'Admin'
      Caption = 'Neue Vorlage'
      ImageIndex = 5
      OnExecute = ac_ad_template_newExecute
    end
    object ac_ad_sys_template: TAction
      Category = 'Admin'
      Caption = 'Systemvorlage'
      ImageIndex = 28
      OnExecute = ac_ad_sys_templateExecute
    end
    object ac_tb_neu: TAction
      Category = 'Textbausteine'
      Caption = 'Neu'
      Enabled = False
      ImageIndex = 5
      OnExecute = ac_tb_neuExecute
    end
    object ac_tb_edit: TAction
      Category = 'Textbausteine'
      Caption = 'Bearbeiten'
      Enabled = False
      ImageIndex = 6
      OnExecute = ac_tb_editExecute
    end
    object ac_tb_löschen: TAction
      Category = 'Textbausteine'
      Caption = 'L'#246'schen'
      Enabled = False
      ImageIndex = 7
      OnExecute = ac_tb_löschenExecute
    end
    object ac_ad_http: TAction
      Category = 'Admin'
      Caption = 'Webserverdateien verwalten'
      ImageIndex = 21
      OnExecute = ac_ad_httpExecute
    end
    object ac_pr_view: TAction
      Category = 'Protokoll'
      Caption = 'Anzeigen'
      Enabled = False
      ImageIndex = 10
      OnExecute = ac_pr_viewExecute
    end
    object ac_ad_epub: TAction
      Category = 'Admin'
      Caption = 'ePub Manager'
      ImageIndex = 23
      OnExecute = ac_ad_epubExecute
    end
    object ac_me_new: TAction
      Category = 'Meeting'
      Caption = 'Neu'
      Enabled = False
      ImageIndex = 5
      OnExecute = ac_me_newExecute
    end
    object ac_pr_delete: TAction
      Category = 'Protokoll'
      Caption = '&L'#246'schen'
      Enabled = False
      ImageIndex = 7
      OnExecute = ac_pr_deleteExecute
    end
    object ac_me_edit: TAction
      Category = 'Meeting'
      Caption = 'Bearbeiten'
      Enabled = False
      ImageIndex = 6
      OnExecute = ac_me_editExecute
    end
    object ac_me_invite: TAction
      Category = 'Meeting'
      Caption = 'Einladen'
      Enabled = False
      ImageIndex = 11
      OnExecute = ac_me_inviteExecute
    end
    object ac_me_delete: TAction
      Category = 'Meeting'
      Caption = '&L'#246'schen'
      Enabled = False
      ImageIndex = 7
      OnExecute = ac_me_deleteExecute
    end
    object ac_me_end: TAction
      Category = 'Meeting'
      Caption = 'Abschlie'#223'en'
      Enabled = False
      ImageIndex = 14
      OnExecute = ac_me_endExecute
    end
    object ac_me_update: TAction
      Category = 'Meeting'
      Caption = 'Update'
      Enabled = False
      ImageIndex = 12
      OnExecute = ac_me_updateExecute
    end
    object ac_me_execute: TAction
      Category = 'Meeting'
      Caption = 'Teilnehmen'
      Enabled = False
      ImageIndex = 13
      OnExecute = ac_me_executeExecute
    end
    object ac_pr_abschnitt: TAction
      Category = 'Protokoll'
      Caption = 'Abschnitt bearbeiten'
      Enabled = False
      ImageIndex = 15
      OnExecute = ac_pr_abschnittExecute
    end
    object ac_view_task: TAction
      Category = 'Ansicht'
      Caption = 'Aufgabenlisten'
      Checked = True
      ImageIndex = 30
      OnExecute = ac_view_taskExecute
    end
    object ac_view_admin: TAction
      Category = 'Ansicht'
      Caption = 'Verwaltung'
      Checked = True
      ImageIndex = 31
      OnExecute = ac_view_adminExecute
    end
    object ac_ad_tasktype: TAction
      Category = 'Admin'
      Caption = 'Aufgabentypen'
      ImageIndex = 27
      OnExecute = ac_ad_tasktypeExecute
    end
    object ac_ad_filecache: TAction
      Category = 'Admin'
      Caption = 'Dateicache'
      ImageIndex = 29
      OnExecute = ac_ad_filecacheExecute
    end
    object ac_to_dms: TAction
      Category = 'Tools'
      Caption = 'Dokumentenmanagement'
    end
    object ac_to_wiki: TAction
      Category = 'Tools'
      Caption = 'Wiki'
    end
    object ac_to_faq: TAction
      Category = 'Tools'
      Caption = 'FAQ'
    end
    object ac_to_disput: TAction
      Category = 'Tools'
      Caption = 'Disput'
    end
    object ac_to_stat: TAction
      Category = 'Tools'
      Caption = 'Statistik'
    end
    object ac_to_import: TAction
      Category = 'Tools'
      Caption = 'Import'
    end
    object ac_to_keys: TAction
      Category = 'Tools'
      Caption = 'Schl'#252'ssel'
      ImageIndex = 45
      OnExecute = ac_to_keysExecute
    end
    object ac_tb_export: TAction
      Category = 'Textbausteine'
      Caption = 'Export'
      ImageIndex = 9
      OnExecute = ac_tb_exportExecute
    end
    object ac_tb_import: TAction
      Category = 'Textbausteine'
      Caption = 'Import'
      ImageIndex = 8
      OnExecute = ac_tb_importExecute
    end
    object ac_to_pdrive: TAction
      Category = 'Tools'
      Caption = 'Pers'#246'nlich Datenablage'
      ImageIndex = 26
      OnExecute = ac_to_pdriveExecute
    end
    object ac_ad_storages: TAction
      Category = 'Admin'
      Caption = 'Datenablagen'
      ImageIndex = 26
      OnExecute = ac_ad_storagesExecute
    end
    object ac_ad_action: TAction
      Category = 'Admin'
      Caption = 'Adminnachrichten senden'
      ImageIndex = 25
      OnExecute = ac_ad_actionExecute
    end
    object ac_ta_delete: TAction
      Category = 'Task'
      Caption = 'L'#246'schen'
      ImageIndex = 7
      OnExecute = ac_ta_deleteExecute
    end
    object ac_ad_plugin: TAction
      Category = 'Admin'
      Caption = 'Pluginverwaltung'
      ImageIndex = 24
      OnExecute = ac_ad_pluginExecute
    end
    object ac_ta_import: TAction
      Category = 'Task'
      Caption = 'Import'
      ImageIndex = 8
      OnExecute = ac_ta_importExecute
    end
    object ac_ad_mail: TAction
      Category = 'Admin'
      Caption = 'Mailkonten'
      ImageIndex = 47
      OnExecute = ac_ad_mailExecute
    end
    object ac_mail: TAction
      Category = 'Tools'
      Caption = 'Mails'
      ImageIndex = 47
      OnExecute = ac_mailExecute
    end
    object ac_hlp_fehler: TAction
      Category = 'help'
      Caption = 'Fehlermelden'
      ImageIndex = 50
      OnExecute = ac_hlp_fehlerExecute
    end
    object ac_hlp_hilfe: TAction
      Category = 'help'
      Caption = 'Hilfe'
      ImageIndex = 49
    end
    object ac_view_epub: TAction
      Category = 'Ansicht'
      Caption = 'ePub anzeigen'
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 64
    Top = 216
  end
  object JvBrowseForFolderDialog1: TJvBrowseForFolderDialog
    Title = 'Import Task'
    Left = 136
    Top = 268
  end
  object ImageList1: TImageList
    Left = 360
    Top = 48
    Bitmap = {
      494C010133003800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000D0000000010020000000000000D0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004F668B00000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF4F668B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6B69F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E3CEBE00C99D7C00BA825900B57A4E00BA835900C99F7D00E3CEBF000000
      000000000000000000000000000000000000425B8200000000FF000000FF0000
      00FF000000FFE0E3EA007487A1003E587F003E587F007488A200E1E5EB000000
      00FF000000FF000000FF000000FF435B83000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00CEA78A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C291
      6C00C38A6000DBA17600E9B08300EFB78B00E9B08300DBA27500C28A6000C392
      6E00000000000000000000000000000000006C7F9E00B5BECE00000000FF0000
      00FFD7DDE400435D8300809F9D00B6D8B700B5D8B6007E9D9D00455D8300D8DE
      E500000000FF000000FFB3BECC006E81A1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00C28B6100B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A
      4E00BB855B00EADBD00000000000000000000000000000000000BA855C00D69D
      7200F0B78B00F0B78B00F0B78B00F1BC9300F0B78B00F0B78B00F0B78B00D69D
      7300BC865E00000000000000000000000000D4D9E20049618700B9C1D0000000
      00FF4C65880091B0A500BDE0BA00BDE0BA00BDE0BA00BDE0BA0090AEA4004D66
      8900000000FFB7C0CF0047608600D5DBE3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00F0B78B00F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B7
      8B00DFA57A00BB855D00000000000000000000000000C2906A00D59B7100F0B7
      8B00F0B78B00F0B78B00F1BE9600FFFFFF00F1BD9500F0B78B00F0B78B00F0B7
      8B00D59C7000C2916C000000000000000000000000FFCCD3DD00687C9A003A54
      7E005E7A8D00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA005D78
      8E003A547D00687C9B00CDD4DE00000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00F0B78B00F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B7
      8B00F0B78B00B57A4E000000000000000000E5D1C300C28A6000F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00F1BC9300F0B78B00F0B78B00F0B78B00F0B7
      8B00F0B68A00C1895F00E5D3C50000000000000000FF000000FF000000FF647A
      970094B5A700BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA0093B3
      A600697D9B00000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00F0B78B00F0B78B00F0B7
      8B00F0B78B00F0B78B00FFFFFF00FFFFFF00FFFFFF00F0B78B00F0B78B00F0B7
      8B00F0B78B00B57A4E000000000000000000CA9F7F00DBA27500F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00FFFFFF00F0B78B00F0B78B00F0B78B00F0B7
      8B00F0B78B00DBA27500CCA38300000000004D648A00344F7A00344F7A003954
      7C00B1D4B500BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00B0D2
      B30038537B00344F7A00344F7A004E658A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00F0B78B00F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00FFFFFF00F0B78B00F0B78B00F0B78B00F0B7
      8B00F0B78B00B57A4E000000000000000000B9825900EAB18500F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00FEF8F400F3C7A500F0B78B00F0B78B00F0B7
      8B00F0B78B00EAB18400BA845A0000000000000000FF000000FF000000FF344E
      7900BCDFBA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BCDE
      B90034507A00000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00F0B78B00F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00FFFFFF00F0B78B00F0B78B00F0B78B00F0B7
      8B00F0B78B00B57A4E000000000000000000B57A4F00EEB68A00F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00F4C9A800FEFAF700F4CBAB00F0B78B00F0B7
      8B00F0B78B00EEB58900B57B500000000000000000FF9AA7BC004F668B003752
      7A009DBEAB005C798C0037547F0035517B0035517B0038557F005F7D8E00A0C2
      AD0035507A004F668B009EA9BE00000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00F0B78B00F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00FFFFFF00F0B78B00F0B78B00F0B78B00F0B7
      8B00F0B78B00B57A4E000000000000000000B9825800EAB18500F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00F0B78B00F5CDAE00FCF2EA00F0B78B00F0B7
      8B00F0B78B00EAB18400BB835A0000000000A3AFC2005E739500DBDFE7008799
      AF0039567F003F618B005F91BC006DA5D1006DA5D1005F91BC0041608B003B57
      7F008799B000DADFE6005D739400A6B3C4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00F0B78B00F0B78B00F0B7
      8B00F0B78B00F0B78B00FAE8D900FFFFFF00F0B78B00F0B78B00F0B78B00F0B7
      8B00F0B78B00B57A4E000000000000000000C89B7A00DCA27600F0B78B00F0B7
      8B00F0B78B00FFFDFC00F0B98E00F0B78B00F1BA9000FEFCFA00F0B78B00F0B7
      8B00F0B78B00DBA27600C99D7C0000000000596F9200D0D6E000000000FF0000
      00FF37537C006AA0CC0070AAD60070AAD60070AAD60070AAD6006AA0CB003954
      7E00000000FF000000FFD0D5DF005C7094000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00F0B78B00F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00F1BC9200F0B78B00F0B78B00F0B78B00F0B7
      8B00F0B78B00B57A4E000000000000000000E3CEBF00C38B6200F0B78B00F0B7
      8B00F0B78B00FBEDE200F7D9C100F1BC9300F7D9C200FBECE100F0B78B00F0B7
      8B00F0B78B00C28B6100E4D0C100000000003E588000000000FF000000FF0000
      00FF7A8CAA0040618C006295C0006CA4D0006CA4D0006295C10040618C007D8F
      AA00000000FF000000FF000000FF3F5880000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00F0B78B00F0B78B00F0B7
      8B00F0B78B00F0B78B00F1BC9300FFFEFE00F1BC9300F0B78B00F0B78B00F0B7
      8B00F0B78B00B57A4E00000000000000000000000000C08F6A00D69D7200F0B7
      8B00F0B78B00F2C19B00FBEEE300FEFAF700FBEDE300F2C19B00F0B78B00F0B7
      8B00D69D7200C2916C0000000000000000004D648900000000FF000000FF0000
      00FF000000FF415A84003A57840038537F0038537F003A588400425B83000000
      00FF000000FF000000FF000000FF4D6489000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00F0B78B00F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00F1BC9200F0B78B00F0B78B00F0B78B00F0B7
      8B00F0B78B00B57A4E0000000000000000000000000000000000BA855C00D69D
      7200F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00D69D
      7300BC855E00000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF8898B000395682004B6DA0004A6CA0003A5682008999B1000000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BB855D00DFA57A00F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B7
      8B00DEA57900BB865E000000000000000000000000000000000000000000C291
      6C00C38A6000DDA37700EBB38600ECB38700EBB38600DDA37700C28A6000C392
      6E0000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF98A5BB00576D90007C8EA900465F8700465F87007E8DAA00566C8F0099A8
      BC00000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EADBCF00BD875F00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A
      4E00BC865E00EADBD00000000000000000000000000000000000000000000000
      0000E3CEBE00C99D7C00BC855C00B67F5400BC855C00C99F7D00E3CEBF000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF51688C00000000FF000000FF000000FF000000FF000000FF000000FF5269
      8D00000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E8D8CC00CFAB9000BE8C6700B57C5200B47A4F00BA855E00C4967500D8BB
      A5000000000000000000000000000000000000000000B57A4E00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E000000000000000000769C5E00769C5E00769C
      5E00769C5E00769C5E00769C5E000000000000000000B9CED8005186A0008BAE
      C200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B7800000000000000000000000000C599
      7800B77F5600D4B49C00E8D8CC00F1E8E200F2EAE300ECDFD500E2CDBE00CBA4
      8700EFE4DD0000000000000000000000000000000000B57A4E00DDC5A800B7E0
      E200B7E0E200DDC5A800B57A4E000000000000000000769C5E00C9E6C600E4F2
      E200E3F2E200C9E6C600769C5E0000000000000000005689A40081C9EF0071B6
      DA006998AF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000BC886100C699
      7800000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B57A4E00B5E1E400E9FB
      FF00E9FBFF00B5E1E400B57A4E000000000000000000769C5E00ECF6EB00B6F1
      FC00B6F1FC00EBF6EA00769C5E0000000000000000008AAFC20071B6DA0085CE
      F5006497B2000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B780000000000C6997800C29470000000
      00000000000000000000E8D7CA00E8D7CA00000000000000000000000000E7D5
      C800E6D4C60000000000000000000000000000000000B57A4E00B7E0E200E8FB
      FF00E7FBFF00B7E0E200B57A4E000000000000000000769C5E00EBF6EA00B7F0
      FB00B7F0FB00EBF6EA00769C5E000000000000000000000000006798B00077BC
      E1006CA5C3006093AE006796AF00000000000000000000000000000000000000
      0000000000000000000000000000000000009C8B7800FFFFFF00FFFFFF00DED4
      C500DED4C500FFFFFF00DED4C500DED4C500FFFFFF004343C7004343C700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B7800EADDD200B3794D00EEE2D9000000
      0000F2E9E200BB865F00BA855D00C0906C00BE8B660000000000C08F6B00BB87
      6000BF8E6A00B9835B00EDE0D6000000000000000000B57A4E00DDC5A800B8DF
      E000B8DFE000DDC5A800B57A4E000000000000000000769C5E00C8E5C600E3F2
      E200E2F2E200C8E5C600769C5E00000000000000000000000000000000006595
      AF0079BEE30085CEF50079BCE2005387A3006996AE0000000000000000000000
      0000000000000000000000000000000000009C8B7800FFFFFF00FFFFFF00DED4
      C500DED4C500FFFFFF00DED4C500DED4C500FFFFFF004343C7004343C700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B7800D3B19900C2947000000000000000
      0000CBA48700C08F6B000000000000000000E8D7CB00C99F8000B3794D00F3EC
      E60000000000D7B9A300BA855D000000000000000000B57A4E00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E000000000000000000769C5E00769C5E00769C
      5E00769C5E00769C5E00769C5E00000000000000000000000000000000000000
      00006494AE0073B7DC005793B2006AABCE0078BDE2004B819E004A809D004B81
      9D006995AD000000000000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B7800C4967500D3B19900000000000000
      0000B9835B00DCC3AF00000000000000000000000000CAA18200B77F56000000
      00000000000000000000BB865E00DBBFAB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004F86A10069ABCD0085CEF50085CEF50085CEF50085CEF50084CD
      F30067A7C8004E839E0000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00DED4C500DED4C500FFFFFF00DED4C500DED4C500FFFF
      FF00DED4C500DED4C500FFFFFF009C8B7800BE8C6700D9BCA700000000000000
      0000B3794E00E0C9B800000000000000000000000000E1CBBB00B57B50000000
      00000000000000000000CFAB8F00C79B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006794AB0075B9DD0085CEF50085CEF50085CEF50085CEF50085CE
      F50083CCF300538BA8008AABBC00000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00DED4C500DED4C500FFFFFF00DED4C500DED4C500FFFF
      FF00DED4C500DED4C500FFFFFF009C8B7800C1916E00D7B8A100000000000000
      0000BB865F00D8BAA300000000000000000000000000EADBD000B57A4E000000
      00000000000000000000D7B9A200BF8D6800000000004A6AA1004A6AA1004A6A
      A1004A6AA1004A6AA1004A6AA1000000000000000000C4967400C4967400C496
      7400C4967400C4967400C4967400000000000000000000000000000000000000
      000000000000000000004B839F0085CEF50085CEF50085CEF50085CEF50083CC
      F3006599B500A8C1D00055859E00000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B7800C9A08100CDA68A00000000000000
      0000CFAA9000BF8E6900000000000000000000000000ECDED400B57A4E00F2E9
      E4000000000000000000D6B69F00C1916D00000000004A6AA1006793E0006793
      E0006B96E0004C6DA7004A6AA1000000000000000000C4967400FFE8C200FFE8
      C200FFE8C200FFE8C200C4967400000000000000000000000000000000000000
      000000000000000000004E86A30085CEF50085CEF50085CEF50083CCF3006399
      B500C5D5DF0000000000447A9600000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B7800DCC2AE00B9835B00000000000000
      0000F1E8E100B57B5000D9BCA7000000000000000000D3B19900B57A4E00ECDE
      D4000000000000000000C9A18100CAA18300000000004A6AA10082ACEF006B97
      E2006689C5007A9ED8004A6AA1000000000000000000C4967400FFF1D900FFFF
      FF00FFFFFF00FFF0D800C4967400000000000000000000000000000000000000
      000000000000000000004B829F0085CEF50085CEF50083CCF300649AB600C5D5
      DF0000000000DCE6EA0055859E00000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B780000000000B57C5200E0C8B7000000
      000000000000E4D1C200B7805700BC8B6500BE8B6600C69A7A00B9835B00E5D3
      C5000000000000000000B67D5300E0C8B700000000004A6AA1009CC4FF0098C0
      FC009CC4FF009CC4FF004A6AA1000000000000000000C4967400FFE9C400FFF6
      E800FFF2DC00FFE9C400C4967400000000000000000000000000000000000000
      000000000000000000006C97AE006EB0D30083CCF3006499B500C5D5DF000000
      00000000000081A4B7009AB7C500000000004343C7004343C7004343C7004343
      C7004343C7004343C7004343C7004343C7004343C7004343C7004343C7004343
      C7004343C7004343C7004343C7004343C70000000000D7B9A300B7805700F2E9
      E200000000000000000000000000E5D3C500E7D5C80000000000ECDFD5000000
      000000000000CFAB8F00BC89620000000000000000004A6AA1009CC4FF009CC4
      FF009CC4FF00E0ECFF004A6AA1000000000000000000C4967400FFE8C200FFE8
      C200FFE8C200FFE8C200C4967400000000000000000000000000000000000000
      00000000000000000000000000004E849F00558CA800AEC4D30000000000D0DD
      E400769DB1006894A90000000000000000004343C7008F8FF7008F8FF7008F8F
      F7008F8FF7008F8FF7008F8FF7008F8FF7008F8FF7008F8FF7008F8FF7008F8F
      F7008F8FF7008F8FF7008F8FF7004343C7000000000000000000CBA28500BB86
      5E00EFE3DB000000000000000000000000000000000000000000000000000000
      0000D4B39B00B67E5400EDE1D80000000000000000004A6AA1004A6AA1004A6A
      A1004A6AA1004A6AA1004A6AA1000000000000000000C4967400C4967400C496
      7400C4967400C4967400C4967400000000000000000000000000000000000000
      00000000000000000000000000000000000088AABB005B8AA2004F819B005C8A
      A20097B4C4000000000000000000000000004343C7008F8FF7008F8FF7008F8F
      F7008F8FF7008F8FF7008F8FF7008F8FF7008F8FF7008F8FF7008F8FF7008F8F
      F7008F8FF7008F8FF7008F8FF7004343C700000000000000000000000000D2B0
      9700B47B5000CDA68A00E6D3C600F1E8E100F2EAE300EBDDD200D9BCA700BC8B
      6500BD8A6500EEE2D90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004343C7004343C7004343C7004343
      C7004343C7004343C7004343C7004343C7004343C7004343C7004343C7004343
      C7004343C7004343C7004343C7004343C7000000000000000000000000000000
      0000F0E5DE00D3B19800C1916D00BA845C00B8815800B9825A00C99F8000E1CB
      BB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A9ABE4004747C6008888DB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B57A4E00B57A4E00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B57A4E0000000000B47B500000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C8B78009C8B78009C8B78009C8B78009C8B78009C8B7800C7BAAA00EDE3
      D6009DBACB004548C7006666DC004B4BC9000000000000000000C79B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B57A4E00F0B78B00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B57A4E0000000000B47B500000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C8B7800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B0D5
      E30070BAD30083BEE9004548C800ADAFE50000000000C5997800B57A4E00BC88
      6300F4EDE80000000000D6B8A200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B57A4E00F0B78B00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B57A4E0000000000B47A4F0000000000000000000000
      00000000000000000000000000000000000000000000000000009C8B78009C8B
      78009C8B7800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BCDBE6006DB9
      D100A1ECFD0074BFD70093B6CA00000000000000000000000000BC896200B57A
      4E00BC896300D4B39A00B57A4E00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6B69F00B57A4E00B57A4E00F0B78B00B57A4E00B57A4E00D6B69F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B57A4E0000000000B47A4F0000000000000000000000
      00000000000000000000000000000000000000000000000000009C8B7800FFFA
      F2009C8B7800FFFFFF00FFFFFF00FFFFFF00FFFFFF0088B9CE0066B4CF00A1EC
      FD0071BCD400B0D5E300EDE3D600000000000000000000000000F3EAE400BB87
      6000B57A4E00B57A4E00B57A4E00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C99D7C00CA936800F0B78B00CA936800C89D7C00000000000000
      000000000000000000000000000000000000000000000000000000000000D6B6
      9F000000000000000000B57A4E0000000000B47A4F000000000000000000D6B6
      9F00000000000000000000000000000000009C8B78009C8B78009C8B7800FFFA
      F2009C8B7800FFFFFF00FFFFFF00FFFFFF00EFF4F600599AB70062B1CC0069B6
      CF00B1D6E300FFFFFF00C2B4A40000000000000000000000000000000000D2B0
      9700B57A4E00B57A4E00B57A4E00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C4947200C0865A00C495720000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B57A
      4E00CA9F7E0000000000B57A4E0000000000B47A4E0000000000C99E7D00B57A
      4E00000000000000000000000000000000009C8B7800FFFAF2009C8B7800FFFA
      F2009C8B7800FFFFFF00FFFFFF00FFFFFF00A0A9AD00567F94005799B60085B7
      CB00FFFFFF00FFFFFF009C8B7800000000000000000000000000D6B79F00B57A
      4E00B57A4E00B57A4E00B57A4E00000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00B57A4E00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00B67B4F00B57A4E00B57A4E00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E0000000000B57A4E00B57A4E00B57A4E00B57A
      4E00C88F6500C2926D00B57A4E0000000000B47A4E00C2926D00C9906500B57A
      4E00B57A4E00B57A4E00B57A4E00000000009C8B7800FFFAF2009C8B7800FFFA
      F2009C8B7800FFFFFF00FFFFFF00FFFFFF00AEB6B800A5ACB200F2F6F800FFFF
      FF00FFFFFF00FFFFFF009C8B7800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00F0B78B00F0B78B00F0B7
      8B00EFB78B00C0865B00B67B4F0000000000B47A4E00BF865A00EFB78B00F0B7
      8B00F0B78B00F0B78B00B57A4E00000000009C8B7800FFFAF2009C8B7800FFFA
      F2009C8B7800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF009C8B7800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B57A4E00B57A4E00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00B67B4F00B57A4E00B57A4E00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E0000000000B57A4E00B57A4E00B57A4E00B57A
      4E00C88F6500C3936F00B57A4E0000000000B37A4E00C3936F00C9906500B57A
      4E00B57A4E00B57A4E00B57A4E00000000009C8B7800FFFAF2009C8B7800FFFA
      F2009C8B7800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF009C8B7800000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B57A4E00B57A4E00B57A
      4E00B57A4E00D7B9A20000000000000000000000000000000000000000000000
      00000000000000000000C2916D00C0875D00C1906D0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B57A
      4E00C99E7E0000000000B57A4E0000000000B3794E0000000000C79B7A00B57A
      4E00000000000000000000000000000000009C8B7800FFFAF2009C8B7800FFFA
      F2009C8B7800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF009C8B7800000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B57A4E00B57A4E00B57A
      4E00D3B29A000000000000000000000000000000000000000000000000000000
      000000000000C89D7C00CB946A00F0B68A00C9936900C89E7D00000000000000
      000000000000000000000000000000000000000000000000000000000000D6B6
      9F000000000000000000B57A4E0000000000B3794E000000000000000000D6B6
      9F00000000000000000000000000000000009C8B7800FFFAF2009C8B7800FFFA
      F2009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B7800000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B57A4E00B57A4E00B57A
      4E00BF8E69000000000000000000000000000000000000000000000000000000
      0000D1AE9500B57A4E00B57A4E00F0B78B00B57A4E00B57A4E00D1AF95000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B57A4E0000000000B3794D0000000000000000000000
      0000000000000000000000000000000000009C8B7800FFFAF2009C8B7800FFFA
      F200FFFAF200FFFAF200FFFAF200FFFAF200FFFAF200FFFAF200FFFAF200FFFA
      F2009C8B78000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B57A4E00D5B59E00BD8A
      6400B57A4E00BC89630000000000000000000000000000000000000000000000
      00000000000000000000B57A4E00F0B78B00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B57A4E0000000000B3794D0000000000000000000000
      0000000000000000000000000000000000009C8B7800FFFAF2009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DABEAB00000000000000
      0000BD8A6500B57A4E00C69A7900000000000000000000000000000000000000
      00000000000000000000B57A4E00F0B78B00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B57A4E0000000000B3794D0000000000000000000000
      0000000000000000000000000000000000009C8B7800FFFAF200FFFAF200FFFA
      F200FFFAF200FFFAF200FFFAF200FFFAF200FFFAF200FFFAF2009C8B78000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C89E7E0000000000000000000000000000000000000000000000
      00000000000000000000B57A4E00B57A4E00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B57A4E0000000000B3794D0000000000000000000000
      0000000000000000000000000000000000009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000769C5E00769C5E00769C
      5E00769C5E0000000000769C5E00769C5E00769C5E00769C5E00769C5E000000
      0000769C5E00769C5E00769C5E00769C5E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D8BBA500D8BBA50000000000000000000000
      00000000000000000000000000000000000000000000769C5E00BDE0BA00BDE0
      BA00769C5E0000000000769C5E00BDE0BA00BDE0BA00BDE0BA00769C5E000000
      0000769C5E00BDE0BA00BDE0BA00769C5E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78000000000000000000000000000000
      00000000000000000000D8BBA500B57A4E00B57A4E00D8BBA500000000000000
      00000000000000000000000000000000000000000000769C5E00BDE0BA00BDE0
      BA00769C5E0000000000769C5E00BDE0BA00BDE0BA00BDE0BA00769C5E000000
      0000769C5E00BDE0BA00BDE0BA00769C5E009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B7800000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000000000000000
      000000000000D6B69F00B57A4E00B57A4E00B57A4E00B57A4E00D6B69F000000
      00000000000000000000000000000000000000000000769C5E00BDE0BA00BDE0
      BA00769C5E0000000000769C5E00BDE0BA00BDE0BA00BDE0BA00769C5E000000
      0000769C5E00BDE0BA00BDE0BA00769C5E009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C8B7800FFFF
      FF00D0D0F100FFFFFF009C8B7800000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000000000000000
      0000000000000000000000000000B57A4E00B57A4E0000000000000000000000
      00000000000000000000000000000000000000000000769C5E00769C5E00769C
      5E00769C5E0000000000769C5E00769C5E00769C5E00769C5E00769C5E000000
      0000769C5E00769C5E00769C5E00769C5E009C8B7800FFFFFF00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00FFFFFF009C8B7800A3A3
      E4004343C700A4A4E4009C8B7800000000009C8B7800FFFFFF00FFFFFF00F0B7
      8B00F0B78B00F0B78B00F0B78B00F0B78B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000000000000000
      0000000000000000000000000000B57A4E00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F79
      6600000000000000000000000000000000008F79660000000000000000000000
      0000000000008F79660000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C8B7800CBCB
      EF00D1D1F100CBCBF0009C8B7800000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000000000000000
      0000000000000000000000000000B57A4E00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F79
      6600000000000000000000000000000000008F79660000000000000000000000
      0000000000008F79660000000000000000009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B7800000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F0B78B00F0B78B00F0B78B00F0B78B00F0B7
      8B00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000000000000000
      0000000000000000000000000000B57A4E00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F79
      66008F7966008F7966008F7966008F7966008F7966008F7966008F7966008F79
      66008F7966008F79660000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C8B7800FFFF
      FF00D0D0F100FFFFFF009C8B7800000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000000000000000
      0000000000000000000000000000B57A4E00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008F79660000000000000000000000
      0000000000000000000000000000000000009C8B7800FFFFFF00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00FFFFFF009C8B7800A3A3
      E4004343C700A4A4E4009C8B7800000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000000000000000
      0000000000000000000000000000B57A4E00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008F79660000000000000000000000
      0000000000000000000000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C8B7800CBCB
      EF00D1D1F100CBCBF0009C8B7800000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000000000000000
      0000000000000000000000000000B57A4E00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008F79660000000000000000000000
      0000000000000000000000000000000000009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B7800000000009C8B7800FFFFFF00FFFFFF00F0B7
      8B00F0B78B00F0B78B00F0B78B00F0B78B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000000000000000
      0000000000000000000000000000B57A4E00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A
      4E00000000000000000000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C8B7800FFFF
      FF00D0D0F100FFFFFF009C8B7800000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000000000000000
      0000000000000000000000000000B57A4E00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B57A4E00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00B57A
      4E00000000000000000000000000000000009C8B7800FFFFFF00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00FFFFFF009C8B7800A3A3
      E4004343C700A4A4E4009C8B7800000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000000000000000
      0000000000000000000000000000B57A4E00B57A4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B57A4E00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00B57A
      4E00000000000000000000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C8B7800CBCB
      EF00D1D1F100CBCBF0009C8B7800000000009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78000000000000000000000000000000
      000000000000D8BBA500B57A4E00B57A4E00B57A4E00B57A4E00D8BBA5000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B57A4E00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00B57A
      4E00000000000000000000000000000000009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B7800000000009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78000000000000000000000000000000
      00000000000000000000D8BBA500B57A4E00B57A4E00D8BBA500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A
      4E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DABFAA00DABFAA0000000000000000000000
      0000000000000000000000000000000000000000000000000000B57A4E00B57A
      4E00B57A4E000000000000000000000000000000000000000000B9CBAD00769C
      5E00769C5E00B9CBAD0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000077B4
      CB00CBE2EA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B77F5500B57A4E00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B77F
      5500000000000000000000000000000000000000000000000000B57A4E00B57A
      4E00B57A4E000000000000000000000000000000000000000000B9CBAD00769C
      5E00769C5E00B9CBAD0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004799B8004A9ABA0068B7
      D00050A0BD00499BB800A5CDDC00000000000000000000000000000000000000
      00000000000000000000E9D9CE00BD865E00BC865E00E9DACE00000000000000
      000000000000000000000000000000000000C3926E00E1A77A00F0B78B00F0B7
      8B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00E0A67A00C392
      6D00000000000000000000000000000000000000000000000000B57A4E00B57A
      4E00B57A4E000000000000000000000000000000000000000000B9CBAD00769C
      5E00769C5E00B9CBAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009EC9D9005CAAC5009EEAFB00A2EE
      FF009DE9FB0082D0E60064AAC500DEEBF100C3947100B57A4E00B57A4E00B57A
      4E00B57A4E00B57A4E00B47A4F00E2A87D00E2A97C00B37A4F00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00C4957200E1CBBA00C1895F00EEB58900F0B7
      8B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00EEB48800C1895E00E2CC
      BD00000000000000000000000000000000000000000000000000B57A4E00B57A
      4E00B57A4E000000000000000000000000000000000000000000B9CBAD00769C
      5E00769C5E00B9CBAD000000000000000000447A9600447A9600447A9600447A
      9600447A9600447A960064A3C40070BBE0004DA0BF0093DFF300A3EEFF00A3EE
      FF00A3EEFF00A0ECFD0067B6D10069ADC6009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B780000000000CBA18200C1895F00E3A9
      7F00919794004B7E98004B7E980092979400E2A97E00C0875D00CEA78B000000
      0000000000000000000000000000000000000000000000000000B57A4E00B57A
      4E00B57A4E000000000000000000000000000000000000000000B9CBAD00769C
      5E00769C5E00B9CBAD000000000000000000447A960085CEF50085CEF50085CE
      F50085CEF50085CEF50085CEF50083CDF3004B9DBC0098E4F700A3EEFF00A3EE
      FF00A3EEFF00A3EEFF0067B5CE00ADD1DF009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE100F2EBE1009C8B78000000000000000000E2CCBD00A786
      6A004C7F99006FB2D6006EB2D6004C7F9900A7866B00E2CBBC00000000000000
      00000000000000000000000000000000000000000000C3957200B57A4E00B57A
      4E00B57A4E000000000000000000D0C7B000E3EADE000000000095B28300769C
      5E00769C5E00769B5D00D4DFCC0000000000447A960085CEF50085CEF50085CE
      F50085CEF50085CEF50085CEF50070BBE0004DA0BF0093DFF300A3EEFF00A3EE
      FF00A3EEFF00A0ECFD0067B6D10069ADC6009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE100F2EBE1009C8B7800000000000000000000000000DCE4
      EA004D829E004C86A3004C86A3004D829E00DCE4EA0000000000000000000000
      00000000000000000000000000000000000000000000B57A4E00B57A4E00B57A
      4E00B57A4E0000000000D9BDA800B1976E0083A46D000000000095B28300769C
      5E00769C5E00769C5E00B9CBAD0000000000447A960085CEF50085CEF50085CE
      F50085CEF50085CEF50085CEF50083CCF20065B4D60059AAC8009EEAFB00A2EE
      FF009DE9FB0082D0E60064AAC500DEEBF1009C8B7800FFFFFF008F796600FFFF
      FF008F7966008F7966008F796600FFFFFF00F2EBE100F2EBE100D1CDE8008F8F
      F700E2DCE500F2EBE100F2EBE1009C8B7800000000000000000000000000A7C0
      CD0048819D0070B3D60070B3D60048809D00A8C1CE0000000000000000000000
      00000000000000000000000000000000000000000000B57A4E00B57A4E00B57A
      4E00B57A4E00ECDFD500B8815800F3EBE500B9CBAD009AB58800B9CBAD00769C
      5E00769C5E00769C5E00B9CBAD0000000000447A96004B83A000447A9600447A
      9600447A9600447A9600447A96004D85A30081CAF200499BBA004B9DBC0066B7
      D2004EA1BF00499CBB00A5CDDC00000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2EBE100F2EBE100C0BCEC00C1BD
      ED009D9CF400F2EBE100F2EBE1009C8B78000000000000000000000000005487
      A10078BDE30085CEF50085CEF5005265CF004C57BF00C3C6EA00000000000000
      00000000000000000000000000000000000000000000B57A4E00B57A4E00B57A
      4E00B57A4E00CDA68A00DABFAA00000000000000000080A36C00B0C6A300769C
      5E00769C5E00769C5E00B9CBAD0000000000477D990076BBDE0085CEF50085CE
      F50085CEF50085CEF50083CBF20083CBF20085CEF50081CAF10083CCF2005DAC
      CD0076C1E70083CCF30000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2EBE100F2EBE100EFE8E200BEBB
      ED00A7A5F200F2EBE100F2EBE1009C8B780000000000000000006995AD005992
      B10085CEF50085CEF50085CEF5006F9FE5004747C8004F51CB004F4FCA004444
      C6005454CB009191DE00000000000000000000000000B57A4E00B57A4E00B57A
      4E00B57A4E00BB865F00EEE2DA000000000000000000A3BB93009FB98E00769C
      5E00769C5E00769C5E00B9CBAD0000000000447A960085CEF50085CEF50085CE
      F50085CEF50085CEF50069AACC0069AACC0085CEF50085CEF50085CEF50085CE
      F50085CEF500477D9A0000000000000000009C8B7800FFFFFF008F796600FFFF
      FF008F7966008F796600FFFFFF00FFFFFF00F2EBE100F2EBE100A6A4F200C1BE
      EC00EFE8E200F2EBE100F2EBE1009C8B78000000000000000000344F7A0075B4
      DC0084CDF30085CEF50085CEF50080C3F1004445C8008787F2008585F1008E8E
      F6008282EF006161D8005656CB000000000000000000BB876000B57A4E00B57A
      4E00B57A4E00B57B5100000000000000000000000000ACC39F00769C5E00769C
      5E00769C5E00769C5E00C9D7C00000000000447A960085CEF50085CEF50085CE
      F50085CEF50085CEF50085CEF50085CEF50085CEF50085CEF50085CEF50085CE
      F50085CEF500447A960000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2EBE100F2EBE1009E9DF400C1BE
      EB00CEC9E900F2EBE100F2EBE1009C8B78000000000000000000344F7A003A5A
      850037547F00486E980070ADD5005D76D7006466DA008F8FF7008F8FF7008F8F
      F7008F8FF7008F8FF7006666DB008181D90000000000E7D6C900BC896300B57A
      4E00BD8A6400E8D6CA0000000000000000000000000000000000A1BA9000799E
      6200799E6200A1BB91000000000000000000447A960085CEF50085CEF50085CE
      F50085CEF50085CEF50085CEF50085CEF50085CEF50085CEF50085CEF50085CE
      F50085CEF500447A960000000000000000009C8B7800FFFFFF008F796600FFFF
      FF008F7966008F7966008F796600FFFFFF00F2EBE100F2EBE100E0DBE5008F8F
      F700DBD6E600F2EBE100F2EBE1009C8B7800000000000000000034507A004E71
      A5004C70A40045659700395683004547C5008686F2008F8FF7008F8FF7008F8F
      F7008F8FF7008F8FF7008686F1004A4AC9000000000000000000C7E0E90056A2
      BF0056A4BF00C8E0E900000000000000000000000000000000007EB8CE004A9A
      BA007EB9CE00000000000000000000000000447A960085CEF50085CEF50085CE
      F50085CEF50085CEF50085CEF50085CEF50085CEF50085CEF50085CEF50085CE
      F50085CEF500447A960000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE100F2EBE1009C8B78000000000000000000405C84004869
      9C004E71A6004E71A6004A6CA0004546C6008686F1008F8FF7008F8FF7008F8F
      F7008F8FF7008F8FF7008585F1004B4BC900000000000000000055A3BF0090DC
      F0008FDCF00058A3C000000000000000000000000000B5D6E20066B3CD009FEA
      FB0065B2CD00B7D7E2000000000000000000447A9600447A9600447A9600447A
      9600447A9600447A9600447A9600447A9600447A9600447A9600447A9600447A
      9600447A9600447A960000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E5E1DC00A6978600A5968500EFE9E000F2EBE100F2EB
      E100F2EBE100F2EBE100F2EBE1009C8B78000000000000000000BAC2D0003D57
      810046689A004C6FA3004A6CA000434CB1006364D9008F8FF7008F8FF7008F8F
      F7008F8FF7008F8FF7006666DB008181D900000000000000000058A4C00092DE
      F20090DDF10058A4C000000000000000000000000000B6D6E20068B3CE00A2ED
      FE0067B3CD00B7D7E30000000000000000000000000000000000000000000000
      0000447A960000000000000000000000000000000000447A9600000000000000
      0000000000000000000000000000000000009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B7800A7988800E0DBD600DFDAD500A79887009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B7800000000000000000000000000BAC2
      D000556C91003A547E00415A830098A3C2005555CC006161D8008181EE008989
      F4008181EE006161D8005656CB00000000000000000000000000C7E0E9005BA6
      C1005AA5C100C8E0E900000000000000000000000000000000007EB9CE0053A0
      BE007EB9CF000000000000000000000000000000000000000000000000000000
      00007199AE00447A9600447A9600447A9600447A9600729AAF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009090DD005454CB004A4A
      C8005454CB009191DE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78000000000000000000000000000000
      0000000000000000000000000000A1758B009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F7966008F7966008F7966008F7966008F7966008F7966008F7966000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C8B7800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000000000000000
      00000000000000000000DDCDD500BB96A7009C8B7800FFFFFF00FFFFFF00FBFC
      FB00FFFFFF00FFFFFF00FFFFFF009C8B780000000000978373008F7966008F79
      66008F7966008F796600978373000000000000000000978373008F7966008F79
      66008F7966008F79660097837300000000000000000000000000000000000000
      000000000000000000008F796600D4C1B0008F79660000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C8B7800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DBBFAA00D4B19800FFFEFE009C8B78000000000000000000000000000000
      000000000000D5C3CC00AC859800D0ACBA009C8B7800FFFFFF00E4EBDF008AAA
      7500E4ECDF00FFFFFF00FFFFFF009C8B780000000000C1B4A900A08C7900C9B5
      A400C9B5A400A08B7900C1B5AB000000000000000000C1B4A900A08C7900C9B5
      A400C9B5A400A08B7900C1B5AB00000000008F7966008F7966008F7966008F79
      66008F7966008F7966008F7966008F7966008F7966008F7966008F7966008F79
      66008F7966008F7966008F796600000000000000000000000000000000000000
      0000000000009C8B7800FFFFFF00FFFFFF00FFFFFF00DABCA600FFFFFF00DEC3
      AF00B57A4E00D6B69E00FFFFFF009C8B780000000000C7ADB900BFA2B000D7C5
      CE00B18D9E00B58FA000DDBCC700F1D4DB009C8B7800FFFFFF00A7BF9700C6D6
      BC0085A66F00DEE7D800FFFFFF009C8B78000000000000000000C0B4A9009984
      740099847400C1B4AA0000000000000000000000000000000000C0B4A9009984
      740099847400C1B4AA0000000000000000008F796600FFF2DB00FFF2DB00FFF2
      DB00FFF2DB00FFF2DB00FFF2DB00FFF2DB00FFF2DB00FFF2DB00FFF2DB00FFF2
      DB00FFF2DB00FFF2DB008F796600000000000000000000000000000000000000
      0000000000009C8B7800FFFFFF00FFFFFF00FFFFFF00B57A4E00C79A7900B57A
      4E00DABDA800FFFFFF00FFFFFF009C8B7800EBE2E700A57B9000CCA8B600B48E
      A000C6A3B200F2D4DC00F2D5DC00F2D5DC009C8B7800FFFFFF00FFFFFF00FFFF
      FF00E0E9DB00A7BF9700FFFFFF009C8B78000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008F796600FFF2DB00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00FFF2DB00B57A4E00B57A4E00B57A4E00B57A
      4E00B57A4E00FFF2DB008F796600000000009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B7800EBE7E300FFFFFF00FFFFFF00B57A4E00B57A4E00C89C
      7C00FFFFFF00FFFFFF00FFFFFF009C8B780000000000BD9DAC00BB96A600F0D3
      DB00F2D5DC00F0D3DA00C3A0AF00A67C91009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000C6DFE80056A2
      BF0056A4BF00C8E0E90000000000000000000000000000000000C6DFE80056A2
      BF0056A4BF00C8E0E90000000000000000008F796600FFF2DB00B57A4E00F0B7
      8B00F0B78B00F0B78B00B57A4E00FFF2DB00B57A4E00F0B78B00F0B78B00F0B7
      8B00B57A4E00FFF2DB008F796600000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00EFECE900F7F6F400EBE7E300FFFFFF00B57A4E00B57A4E00B57A
      4E00D8B8A100FFFFFF00FFFFFF009C8B78000000000000000000AA829600E0C0
      CA00F2D5DC00C3A0AF00BA9AA900000000009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B7800000000000000000055A3BF008EDA
      EF008DDAEE0058A3C0000000000000000000000000000000000055A3BF008EDA
      EF008DDAEE0058A3C00000000000000000008F796600FFF2DB00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00FFF2DB00B57A4E00B57A4E00B57A4E00B57A
      4E00B57A4E00FFF2DB008F796600000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00ECE8E500BFB4A800FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000A47A8E00ECCE
      D600F2D5DC00A67C910000000000000000000000000000000000A67F9200F2D5
      DC00ECCED600A2778D000000000000000000000000000000000058A4C0008CD9
      EE008CD8ED0058A4C0000000000000000000000000000000000058A4C0008CD9
      EE008CD8ED0058A4C00000000000000000008F796600FFF2DB00FFF2DB00FFF2
      DB00FFF2DB00FFF2DB00FFF2DB00FFF2DB00FFF2DB00FFF2DB00FFF2DB00FFF2
      DB00FFF2DB00FFF2DB008F796600000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BBAFA200EBE7E300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000A47B8F00ECCD
      D600F2D5DC00A67F920000000000000000000000000000000000A9809300F2D5
      DC00EFD1D900A47B900000000000000000000000000000000000C6DFE8005BA6
      C1005AA5C100C8E0E90000000000DCE4D600DCE4D60000000000C6DFE8005BA6
      C1005AA5C100C8E0E90000000000000000008F796600FFF2DB00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00FFF2DB00B57A4E00B57A4E00B57A4E00B57A
      4E00B57A4E00FFF2DB008F796600000000009C8B7800FFFFFF00FFFFFF00DABC
      A600B57A4E00B57A4E00B57A4E00FFFFFF00EBE7E300F7F6F400EFECE900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C8B78000000000000000000AA829600DCBB
      C600F2D5DC00C39FAD00BA9AA900F1EBEE00F0EBEE00B999A900C39FAE00F2D5
      DC00E3C4CE00A882950000000000000000000000000000000000000000000000
      000000000000000000000000000094B1810094B1820000000000000000000000
      0000000000000000000000000000000000008F796600FFF2DB00B57A4E00F0B7
      8B00F0B78B00F0B78B00B57A4E00FFF2DB00B57A4E00F0B78B00F0B78B00F0B7
      8B00B57A4E00FFF2DB008F796600000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00C89C7C00B57A4E00B57A4E00FFFFFF00FFFFFF00EBE7E3009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B780000000000BD9DAC00BB96A600EFD2
      D900F2D5DC00EFD2D800C29EAD00A9819400A9819400C29FAE00EFD1D900F2D5
      DC00F0D3DB00BB96A600BD9DAC00000000000000000000000000000000000000
      000094B18200769C5E00769C5E00769C5E00769C5E00769C5E00769C5E0095B2
      8300000000000000000000000000000000008F796600FFF2DB00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00FFF2DB00B57A4E00B57A4E00B57A4E00B57A
      4E00B57A4E00FFF2DB008F796600000000009C8B7800FFFFFF00FFFFFF00DEC3
      AF00B57A4E00C6987600B57A4E00FFFFFF00FFFFFF00FFFFFF009C8B78000000
      000000000000000000000000000000000000EBE2E700A57B9000CCA8B600B48E
      A000CCAAB800F2D5DC00F2D5DC00F2D5DC00F2D5DC00F2D5DC00F2D4DC00C7A4
      B200B48EA000CCA8B600A47A8E00EBE3E7000000000000000000000000000000
      0000769C5E00769C5E008FAE7C00D5E1CE007DA16600769C5E00769C5E00769C
      5E00000000000000000000000000000000008F796600FFF2DB00FFF2DB00FFF2
      DB00FFF2DB00FFF2DB00FFF2DB00FFF2DB00FFF2DB00FFF2DB00FFF2DB00FFF2
      DB00FFF2DB00FFF2DB008F796600000000009C8B7800FFFFFF00D9BBA500B57A
      4E00DABDA800FFFFFF00DCC1AC00FFFFFF00FFFFFF00FFFFFF009C8B78000000
      00000000000000000000000000000000000000000000C7ADB900C1A3B100D7C5
      CE00AD869900B892A300DFBFC900F0D3DB00F0D3DB00DCBBC600B58FA000B18B
      9E00D7C5CE00BFA2B000C7ADB900000000000000000000000000000000000000
      0000769C5E007EA16700EFF4ED00D6E1CF00DFE8DA007CA16600769C5E00769C
      5E00000000000000000000000000000000008F7966008F7966008F7966008F79
      66008F7966008F7966008F7966008F7966008F7966008F7966008F7966008F79
      66008F7966008F7966008F796600000000009C8B7800FFFFFF00DDC2AE00DBBF
      AA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C8B78000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D1BDC700A9809400D1AEBB00CFACB900A9819400D3BFC9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000769C5E00769C5E0083A56D00779C5F00C4D5BA00DEE7D8007CA16600769C
      5E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C8B7800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C8B78000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D6C4CD00BC96A700B995A500D6C4CD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000769C5E00769C5E00769C5E00769C5E00779C5F00C3D4B800A0BB9000769C
      5E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F0EBEE00A1758B00A1758B00F1EBEE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000096B38400769C5E00769C5E00769C5E00769C5E00769C5E00769C5E0097B4
      8600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000091CBDD0051A2BF004C9EBC007BBED4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000067B2
      CB0065B6D00095E1F5009CE8FA0070C0D80059A8C400E2F2F600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2CCBC00C99C7B00BA825900B57A4E00BA825900C99D7C00E2CDBE000000
      00000000000000000000000000000000000000000000C4967400C4967400C496
      7400C4967400C4967400C4967400C4967400C4967400C496740000000000769C
      5E00769C5E00769C5E00769C5E0000000000C4967400C4967400C4967400C496
      7400C4967400C4967400C4967400C4967400C4967400C4967400C4967400C496
      7400C4967400C4967400C4967400C496740000000000DFEFF50059A8C40073C2
      DA00A2EEFF00A3EEFF00A3EEFF00A3EEFF0076C5DD0055A4C100DAEDF4000000
      0000000000000000000000000000000000000000000000000000F3EBE500C190
      6B00C28B6100DBA17600E9B08300EFB78B00E9B08300DBA27500C2896000C291
      6C00F3EBE50000000000000000000000000000000000C4967400FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200C496740000000000769C
      5E00BDE0BA00BDE0BA00769C5E0000000000C4967400FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200C4967400D6ECF30052A3BF007FCEE400A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF007BCAE00051A1BF00CDE9
      F0000000000000000000000000000000000000000000F2EAE300BA825900D69D
      7200F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00D69C
      72007F638E00D9D3E000000000000000000000000000C4967400FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200C496740000000000769C
      5E00BDE0BA00BDE0BA00769C5E0000000000C4967400FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200C496740063AFC90080CFE400A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF0080CEE4004D9F
      BD00C3E3ED00000000008C8CF8000000000000000000C18E6900D59C7000F0B7
      8B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00957B
      AC004D4BC8005850B700000000000000000000000000C4967400FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200C496740000000000769C
      5E00769C5E00769C5E00769C5E0000000000C4967400FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200C49674004A9DBB00A1ECFE00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF0084D1
      E7004FA0BE00000000009A9AF8009B9BF800E3CEBE00C18A6000F0B78B00F0B7
      8B00F0B78B00F0B78B00E1A87C00D69D7000E2A87C00F0B78B00967BAD005452
      CB008989F4005653CB00ADA0C1000000000000000000C4967400FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200C496740000000000769C
      5E00BDE0BA00BDE0BA00769C5E0000000000C4967400FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200C4967400489BBA00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF0061B2CD005BAD
      C80058A7C30000000000000000006262F500C89B7A00DCA27600F0B78B00F0B7
      8B00F0B78B00C8906600C18F6A00D4B39A00C08F6900846A99005351CB008989
      F3008F8FF7007575E700675CB4000000000000000000C4967400FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200C496740000000000769C
      5E00BDE0BA00BDE0BA00769C5E0000000000C4967400FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200C4967400489BBA00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A2EEFF00A2EEFF006FBED70062AE
      C8000000000000000000E4E4FC006161F500B9825800EAB18500F0B78B00F0B7
      8B00E0A77B00C08F69000000000000000000000000005750BA007575E7008F8F
      F7008F8FF7008787F2004B48C0000000000000000000C4967400FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200C496740000000000769C
      5E00769C5E00769C5E00769C5E0000000000C4967400FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200C4967400489BBA00A3EEFF00A3EEFF009AE5
      FD00A3EEFF00A3EEFF00A3EEFF00A3EEFF006FBED70052A5C2006FBED70061AD
      C8000000000000000000C1C1FA007979F700B57A4F00EEB68A00F0B78B00F0B7
      8B00D69B6F00D5B39B000000000000000000000000008072B3006C6CE1008F8F
      F7008F8FF7008D8DF6004545C6000000000000000000C4967400FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200C496740000000000769C
      5E00BDE0BA00BDE0BA00769C5E0000000000C4967400FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200C4967400489BBA00A3EEFF00A3EEFF007AC6
      F6009CE7FD00A3EEFF00A3EEFF008EDCF0009BE7F80050A3C1005AA8C500CEEA
      F1000000000000000000000000005858F500B9825800EAB18500F0B78B00F0B7
      8B00DFA57A00C08F69000000000000000000000000005750BB007A7AE9008F8F
      F7008F8FF7008787F2004B48C1000000000000000000C4967400FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200C496740000000000769C
      5E00BDE0BA00BDE0BA00769C5E0000000000C4967400FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200C49674004A9DBB009EEAFC00A3EEFF0076C2
      F50079C5F6009AE5FD008FDBEF00489BBA0077C5DE0079C9E0006AB1CA000000
      00000000000000000000E7E7FC006161F500C89B7A00DCA27600F0B78B00F0B7
      8B00F0B68A00C7906800C18F6A00AB92A5005951B9005F5CD1008E8EF7008F8F
      F7008F8FF7007676E700675CB5000000000000000000C4967400C4967400C496
      7400C4967400C4967400C4967400C4967400C4967400C496740000000000769C
      5E00769C5E00769C5E00769C5E0000000000C4967400C4967400C4967400C496
      7400C4967400C4967400C4967400C4967400C4967400C4967400C4967400C496
      7400C4967400C4967400C4967400C496740086C3D9004B9EBC00489BBA00489B
      BA00489BBA004FA1BF0090DDF1005DAECA005FACC70061AFC800C2E1EC000000
      000000000000000000008383F700A7A7F900E3CEBE00C28A6100F0B78B00F0B7
      8B00F0B78B00F0B78B00E1A87C008D709C006262DB008E8EF7008F8FF7008F8F
      F7008F8FF7005754CA00AB9EC200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B57A4E00F0B7
      8B00F0B78B00F0B78B00B57A4E000000000000000000B57A4E00F0B78B00F0B7
      8B00F0B78B00B57A4E0000000000000000000000000000000000000000000000
      000000000000B6DEEA0051A2BF005AA9C500DEEEF40000000000000000000000
      0000000000006A6AF6009696F8000000000000000000C18E6900D79E7300F0B7
      8B00F0B78B00F0B78B00F0B78B009A7DA9006969DF008F8FF7008F8FF7008F8F
      F7007070E2005851B900000000000000000000000000A1758B00A1758B00A175
      8B00A1758B00A1758B00A1758B00A1758B00A1758B00A1758B00A1758B00A175
      8B00A1758B00A1758B00A1758B00000000000000000000000000B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E000000000000000000B57A4E00B57A4E00B57A
      4E00B57A4E00B57A4E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C5C5FA006565F600000000000000000000000000F2EAE300BA825900D69D
      7200F0B78B00F0B78B00F0B78B009A7DA9006969DF008F8FF7008F8FF7007271
      E3004B47C100DBD4E000000000000000000000000000A1758B00F2D5DC00F2D5
      DC00F2D5DC00F2D5DC00F2D5DC00F2D5DC00F2D5DC00F2D5DC00F2D5DC00F2D5
      DC00F2D5DC00F2D5DC00A1758B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007070F500A7A7F90000000000E5E5FC009393F8008B8BF8007979
      F7005F5FF500D8D8FB0000000000000000000000000000000000F3EBE500C190
      6B00C28B6100DDA37700EBB38600987BA7006363DB007575E6005653CB005A52
      BA00DCD5E20000000000000000000000000000000000A1758B00A1758B00A175
      8B00A1758B00A1758B00A1758B00A1758B00A1758B00A1758B00A1758B00A175
      8B00A1758B00A1758B00A1758B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008787F8006161F5006363F5009C9CF900C3C3FA00CBCB
      FB00000000000000000000000000000000000000000000000000000000000000
      0000E2CCBC00C99C7B00BC855C00816289004D49C000685DB400A89AC0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007E746D00E5E5E3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C8D1
      E1008FA3C6006782B2005776A8004B69A0004B69A0005776A8006782B20090A4
      C600C8D2E200000000000000000000000000C4967400C4967400C4967400C496
      7400C4967400C4967400C4967400C4967400C4967400C4967400C4967400C496
      7400C4967400C4967400C4967400000000000000000000000000000000000000
      0000E2CFBC00CCAA8E00BF967800BB907200F5E3C400F7E9D10073695F000000
      000000000000675D55004C403600807770000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007991BB005E7D
      B300789CD5008BB0EB0097BEF9009CC4FF009CC4FF0097BEF9008BB0EB00779C
      D5005979AE007A93BC000000000000000000C4967400FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200C4967400000000000000000000000000F3EAE300C4A1
      8400BE957700BE947600E3C7A600BB907200F7E3C100F7E3C1004C4036007168
      6000665C55004C403600695F57000000000091B07F00769C5E00769C5E00769C
      5E00769C5E00769C5E00769C5E00769C5E00769C5E00769C5E00769C5E00769C
      5E00769C5E00769C5E00769C5E0092B1800000000000000000004A6AA1009CC3
      FE009CC4FF009CC4FF009CC4FF005A7CB3005A7CB4009CC4FF009CC4FF009CC4
      FF009CC3FE004A6AA1000000000000000000C4967400FFE8C200769C5E00769C
      5E00769C5E00769C5E00769C5E00FFE8C200769C5E00769C5E00769C5E00769C
      5E00769C5E00FFE8C200C49674000000000000000000F3EBE200BF967700DDBE
      9E00C79F8100E5C9A800F7E3C100BB907200F7E3C100F7E3C1004C4036004C40
      36004C403600675D55000000000000000000769C5E00BDE0BA00BDE0BA00BDE0
      BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0
      BA00BDE0BA00BDE0BA00BDE0BA00769C5E0000000000000000004A6AA1009CC4
      FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4
      FF009CC4FF004A6AA1000000000000000000C4967400FFE8C200769C5E00BDE0
      BA00BDE0BA00BDE0BA00769C5E00FFE8C200769C5E00BDE0BA00BDE0BA00BDE0
      BA00769C5E00FFE8C200C49674000000000000000000C5A08200BB907200BB90
      7200BB907200BB907200BB907200BB907200F7E3C100F7E3C1004C4036004C40
      36004C403600746B64000000000000000000769C5E00BDE0BA00BDE0BA00BDE0
      BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0
      BA00BDE0BA00BDE0BA00BDE0BA00769C5E0000000000000000004A6AA1009CC4
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009CC4FF004A6AA1000000000000000000C4967400FFE8C200769C5E00BDE0
      BA00BDE0BA00BDE0BA00769C5E00FFE8C200769C5E00BDE0BA00BDE0BA00BDE0
      BA00769C5E00FFE8C200C496740000000000E3D0BD00C7A08200F7E3C100D3B1
      9100DEC1A000F7E3C100F7E3C100BB907200F7E3C100F7E3C1004C4036004C40
      36004C4036004C40360072685E0000000000769C5E00BDE0BA00BDE0BA00BDE0
      BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0
      BA00BCE0B900BDE0BA00BDE0BA00769C5E0000000000000000004A6AA1009CC4
      FF00FFFFFF00C4B8AA00C4B8AA00C4B8AA00C4B8AA00FFFFFF00FFFFFF00FFFF
      FF009CC4FF004A6AA1000000000000000000C4967400FFE8C200769C5E00BDE0
      BA00BDE0BA00BDE0BA00769C5E00FFE8C200769C5E00BDE0BA00BDE0BA00BDE0
      BA00769C5E00FFE8C200C496740000000000CBA98C00E2C6A600F7E3C100C69E
      7F00ECD4B300F7E3C100F7E3C100BB907200F7E3C100F7E3C100F7E3C100F7E3
      C100F7E3C100F7E3C100F7E9D20000000000769C5E00BDE0BA009BBE900093B7
      870075996100B9DDB50071955D00BBDEB80080A56F00799E670094B888009ABD
      9000678C50008FB38100BDE0BA00769C5E0000000000000000004A6AA1009CC4
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009CC4FF004A6AA1000000000000000000C4967400FFE8C200769C5E00BDE0
      BA00BDE0BA00BDE0BA00769C5E00FFE8C200769C5E00BDE0BA00BDE0BA00BDE0
      BA00769C5E00FFE8C200C496740000000000BE957700EED7B600F7E3C100BE95
      7700F4DEBD00F7E3C100F7E3C100BB907200F7E3C100F7E3C100F7E3C100F7E3
      C100F7E3C100F7E3C100F5E4C50000000000769C5E00BDE0BA009BBE900083A7
      72006D925800B9DDB50071955D00BDE0BA007EA26C006E935A007BA06900A0C4
      9600799E6700BDE0BA00BDE0BA00769C5E0000000000000000004A6AA1009CC4
      FF00FFFFFF00C4B8AA00C4B8AA00C4B8AA00C4B8AA00C4B8AA00C4B8AA00FFFF
      FF009CC4FF004A6AA1000000000000000000C4967400FFE8C200769C5E00BDE0
      BA00BDE0BA00BDE0BA00769C5E00FFE8C200769C5E00BDE0BA00BDE0BA00BDE0
      BA00769C5E00FFE8C200C496740000000000BD927300BB907200BB907200BB90
      7200BB907200BB907200BB907200BB907200BB907200BB907200BB907200BB90
      7200BB907200BB907200BC91740000000000769C5E00BDE0BA009BBE90007CA1
      6B006B8F5500B9DDB50071955D00BDE0BA0070955B0090B4820065894D00A5C8
      9C00799E6700BDE0BA00BDE0BA00769C5E0000000000000000004A6AA1009CC4
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009CC4FF004A6AA1000000000000000000C4967400FFE8C200769C5E00769C
      5E00769C5E00769C5E00769C5E00FFE8C200769C5E00769C5E00769C5E00769C
      5E00769C5E00FFE8C200C496740000000000BE957800EED7B600F7E3C100BE95
      7700F4DEBD00F7E3C100F7E3C100BB907200F7E3C100F7E3C100F3DEBC00BF97
      7800F7E3C100EED6B500BF97790000000000769C5E00BDE0BA009BBE900093B7
      87007599610097BB8B0064884B0091B483006F945A00ABCFA5006A8F5400AACE
      A200799E6700BDE0BA00BDE0BA00769C5E0000000000000000004A6AA1009CC4
      FF00FFFFFF00C4B8AA00C4B8AA00C4B8AA00C4B8AA00FFFFFF00FFFFFF00FFFF
      FF009CC4FF004A6AA1000000000000000000C4967400FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200C496740000000000CBA88C00E3C7A500F7E3C100C69E
      7F00ECD4B300F7E3C100F7E3C100BB907200F7E3C100F7E3C100EBD3B100C6A0
      8100F7E3C100E2C5A500CCAA8E0000000000769C5E00BDE0BA00BCDFB900BCDF
      B900BBDEB800BBDEB800B9DDB500BBDEB800B8DCB400BCE0B900B8DCB400BDDF
      BA00BBDEB800BDE0BA00BDE0BA00769C5E0000000000000000004A6AA1009CC4
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009CC4FF004A6AA1000000000000000000C4967400FFE8C200A1758B00A175
      8B00A1758B00A1758B00A1758B00A1758B00A1758B00A1758B00A1758B00A175
      8B00A1758B00FFE8C200C496740000000000E2CEBC00C8A28300F7E3C100D2B0
      9100DEC1A000F7E3C100F7E3C100BB907200F7E3C100F7E3C100DDC09F00D3B2
      9200F7E3C100C7A18200E3CFBE0000000000769C5E00BDE0BA00BDE0BA00BDE0
      BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0
      BA00BDE0BA00BDE0BA00BDE0BA00769C5E0000000000000000004A6AA1009CC4
      FF00FFFFFF00C4B8AA00C4B8AA00C4B8AA00C4B8AA00C4B8AA00C4B8AA00FFFF
      FF009CC4FF004A6AA1000000000000000000C4967400FFE8C200A1758B00A175
      8B00A1758B00A1758B00A1758B00A1758B00A1758B00A1758B00A1758B00A175
      8B00A1758B00FFE8C200C49674000000000000000000C39E7F00BB907200BB90
      7200BB907200BB907200BB907200BB907200BB907200BB907200BB907200BB90
      7200BB907200C49E81000000000000000000769C5E00BDE0BA00BDE0BA00BDE0
      BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0BA00BDE0
      BA00BDE0BA00BDE0BA00BDE0BA00769C5E0000000000000000004A6AA1009CC4
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009CC4FF004A6AA1000000000000000000C4967400FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C200C49674000000000000000000F2E9DF00BE947700DFC2
      A200C69F8000E4CAA800F7E3C100BB907200F7E3C100E4C8A700C6A08100DEC1
      A000BE947700F2E9E100000000000000000093B18100769C5E00769C5E00769C
      5E00769C5E00769C5E00769C5E00769C5E00769C5E00769C5E00769C5E00769C
      5E00769C5E00769C5E00769C5E0094B2830000000000000000004A6AA1009CC4
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009CC4FF004A6AA1000000000000000000C4967400C4967400C4967400C496
      7400C4967400C4967400C4967400C4967400C4967400C4967400C4967400C496
      7400C4967400C4967400C4967400000000000000000000000000F2E9E000C5A0
      8200BF957700BF947700E4CAA900BB907200E5C9A800BE947600BF957700C39B
      7E00F1E8DE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004B6BA10097BF
      F9009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4
      FF0097BEF9004C6CA20000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2CDBA00CBA98D00BF987900BD937500C1997B00CCAA8E00E2CDB9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099ADCB004C6C
      A2004A6AA1004A6AA1004A6AA1004A6AA1004A6AA1004A6AA1004A6AA1004A6A
      A1004C6CA2009BADCC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8805800B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A
      4E00B57A4E00B57A4E00B8815800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C8997800DCA37700F0B7
      8B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B7
      8B00F0B78B00DBA17500C79A780000000000000000004A6AA1004A6AA1004A6A
      A1004A6AA1004A6AA1004A6AA1004A6AA1004A6AA1004A6AA1004A6AA1004A6A
      A1004A6AA1004A6AA1004A6AA1004A6AA1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CDEDDE00CDED
      DE00CDEDDE00CDEDDE0000000000000000000000000000000000CDEDDE00CDED
      DE00CDEDDE00CDEDDE00000000000000000000000000ECDED400BA825900E6AC
      8000F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B78B00F0B7
      8B00E5AC8000BA815700ECDFD500000000004A6AA1004A6AA1004A6AA1004A6A
      A1004A6AA1004A6AA1004A6AA1004A6AA1004A6AA1004A6AA1004A6AA1004A6A
      A1004A6AA1004A6AA1004A6AA1004A6AA1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DEF2E9004CC28B004AC3
      8B004AC38B004CC28C00DEF2E9000000000000000000DEF2E9004CC28B004AC3
      8B004AC38B004CC28C00DEF2E900000000000000000000000000E1CBBC00B980
      5500D1986D00E7AE8200989892004E7F98004F80970098999200E7AE8200D097
      6D00B8805600E5D0C20000000000000000004A6AA100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF004A6AA1004A6AA100D4B29800B57B5000D6B49C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D7F1E50096DA
      BA0095DBBB00D9F1E50000000000000000000000000000000000D7F1E50096DA
      BA0095DBBB00D9F1E50000000000000000000000000000000000000000000000
      0000D6B59D00BA865D00457B96006EB1D6006EB1D600447A9600BB855C00D6B5
      9C00000000000000000000000000000000004A6AA100FFFFFF006793E0006793
      E0006793E0006793E0006793E0006793E0006793E0005F87CD005A80C2005A80
      C2005A80C200FFFFFF004A6AA1004A6AA100B67D5200DEA47700B67D52000000
      0000000000009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B780000000000000000000000000064BF
      FD0064BFFD00C6E4DC0079BD990079BD990079BD990079BD9900C5E3DC0064BF
      FD0064BFFD000000000000000000000000000000000000000000000000000000
      00000000000000000000437994004D87A4004D87A400447A9600000000000000
      0000000000000000000000000000000000004A6AA100FFFFFF006793E0006793
      E0006793E0006793E0006793E0006894E0005E86CB005A80C2005A80C2005A80
      C2006C92D300FFFFFF004A6AA1004A6AA100D4B29800B67F5400D6B49C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CEEAFD004DB7
      FF004DB7FF00C6E6F30057AD7F00389F6800389F680059AE8000C5E5F4004DB7
      FF004DB7FF00CEEAFD0000000000000000000000000000000000000000000000
      000000000000BACDD8004A829F0070B3D60070B3D6004A829E00BCCFD9000000
      0000000000000000000000000000000000004A6AA100FFFFFF006794E0006793
      E0006793E0006793E0006893E0007CA5E8005E84C5005A80C2005A80C2006D94
      D40099C2FD00FFFFFF004A6AA1004A6AA1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009FD7
      FD009FD7FD000000000000000000BADEDE00BADEDE0000000000000000009FD7
      FD009FD7FD000000000000000000000000000000000000000000000000000000
      0000000000005487A10078BDE30085CEF50085CEF50078BDE2005587A2000000
      0000000000000000000000000000000000004A6AA100FFFFFF008CB6F6006995
      E1006793E0006893E00089B3F4009CC4FF0092B9F500648ACB007198D8009BC3
      FE009CC4FF00FFFFFF004A6AA1004A6AA100D4B29800B57B5000D6B49C000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CDDCD000679975006799
      75006799750067997500B4D5D9004CB5FD004CB5FD00B5D5D800679975006799
      75006799750067997500CDDCD000000000000000000000000000000000000000
      00006995AD005992B10085CEF50085CEF50085CEF50085CEF5005992B1006C97
      AD00000000000000000000000000000000004A6AA100FFFFFF009CC4FF0092BB
      F9006D98E4008AB3F4009CC4FF009CC4FF009CC4FF009AC3FD009BC3FF009CC4
      FF009CC4FF00FFFFFF004A6AA1004A6AA100B67D5200DEA47700B67D52000000
      0000000000009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78000000000000000000418053001E69
      33001E69330043815500D1E9F2004CB5FD004CB5FD00D1E8F100418053001E69
      33001E6933004381550000000000000000000000000000000000000000000000
      0000344F7A0085CDF40085CEF50085CEF50085CEF50085CEF50085CDF400344F
      7A00000000000000000000000000000000004A6AA100FFFFFF009CC4FF009CC4
      FF009CC3FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4
      FF009CC4FF00FFFFFF004A6AA1004A6AA100D4B29800B67F5400D6B49C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B0D1
      D300B0D1D3000000000000000000DEF0FD00DEF0FD000000000000000000B0D1
      D300B0D1D3000000000000000000000000000000000000000000000000000000
      0000344F7A006DA9D10084CDF30085CEF50085CEF50085CEF5007BBFE700344F
      7A00000000000000000000000000000000004A6AA100FFFFFF009CC4FF009CC4
      FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF00E8F1FF00E7F1
      FF009CC4FF00FFFFFF004A6AA1004A6AA1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D4ECFD0025A5
      FD0025A5FD00D7EDFD0000000000000000000000000000000000D4ECFD0025A5
      FD0025A5FD00D7EDFD0000000000000000000000000000000000000000000000
      0000344F7A003A57830037547F00486E980070ADD50082C9F000476D9700344F
      7A00000000000000000000000000000000004A6AA100FFFFFF009CC4FF009CC4
      FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF00E6F0FF00E5F0
      FF009CC4FF00FFFFFF004A6AA1004A6AA100D4B29800B57B5000D6B49C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D5EDFD0025A5
      FD0025A5FD00D7EDFD0000000000000000000000000000000000D5EDFD0025A5
      FD0025A5FD00D7EDFD0000000000000000000000000000000000000000000000
      0000334F79004E71A5004C70A40045659700395683003B5A85003E5D8B00344F
      7A00000000000000000000000000000000004A6AA100FFFFFF009CC4FF009CC4
      FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4FF009CC4
      FF009CC4FF00FFFFFF004A6AA1004A6AA100B67D5200DEA47700B67D52000000
      0000000000009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B7800000000000000000000000000D7ED
      FD00D7EDFD00000000000000000000000000000000000000000000000000D7ED
      FD00D7EDFD000000000000000000000000000000000000000000000000000000
      0000425D850048699C004E71A6004E71A6004A6CA0004666990047679900445E
      8500000000000000000000000000000000004A6AA100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF004A6AA1004A6AA100D4B29800B67F5400D6B49C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BAC2D0003D57810046689A004C6FA3004A6CA0003C578100465E8600C7CE
      D900000000000000000000000000000000004A6AA1004A6AA1004A6AA1004A6A
      A1004A6AA1004A6AA1004A6AA1004A6AA1004A6AA1004A6AA1004A6AA1004A6A
      A1004A6AA1004A6AA1004A6AA100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BAC2D000556C91003A547E00415A8300A2AEC200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CADEEB00609EC6005396C2005396
      C2005396C2005396C2005396C2005396C2005396C2005396C2005396C2005396
      C2005396C2005396C200609FC600CBDFEB000000000000000000000000000000
      0000000000000000000000000000E6E6F600E6E6F60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B57A4E00BA825900C99D7C00E2CDBE000000
      0000000000000000000000000000000000005F9EC60091D9F100A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF008FD8F000619FC7000000000000000000000000000000
      00000000000000000000000000005D5DCD005D5DCD0000000000000000000000
      00000000000000000000000000000000000000000000B2A596009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B
      78009C8B78009C8B7800B2A5970000000000D8BBA500B57A4E00B57A4E00B57A
      4E00B57A4E000000000000000000B57A4E00E9AF8400DCA27600C38B6200C291
      6C00F3EBE5000000000000000000000000005396C200A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF005396C2000000000000000000000000000000
      000000000000000000005B5BCD004343C7004343C7005B5BCD00000000000000
      000000000000000000000000000000000000000000009A897700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009A8977000000000000000000D5B39B00BE865B00EFB7
      8B00B57A4E000000000000000000B57A4E00BC845A00CC946A00E8AF8200D39B
      6F00B8815700F3EBE50000000000000000005396C200A3EEFF00A3EEFF00A3EE
      FF00A3EEFF008F7966008F7966008F7966008F7966008F7966008F796600A3EE
      FF00A3EEFF00A3EEFF00A3EEFF005396C2000000000000000000000000000000
      0000E3E3F5005656CB004343C7004343C7004343C7004343C7005757CB00E3E3
      F50000000000000000000000000000000000000000009A897700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009A8977000000000000000000C18F6900D69C7100E0A6
      7A00B57A4E00000000000000000000000000F2EAE300D7B8A000B77F5500DEA4
      7800D49B6F00C08E690000000000000000005396C200A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF008F7966008F796600A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF005396C2000000000000000000000000000000
      00000000000000000000000000004343C7004343C70000000000000000000000
      000000000000000000000000000000000000000000009A897700000000000000
      000000000000B57A4E00B57A4E000000000000000000B57A4E00B57A4E000000
      000000000000000000009A89770000000000E3CEBF00C28A6000EBB28600B77E
      5300B57A4E000000000000000000000000000000000000000000EDE0D700BA81
      5800E9AF8400C1895F00E3CFC000000000005396C200A3EEFF00A3EEFF008F79
      66008F7966008F7966008F7966008F7966008F7966008F7966008F7966008F79
      66008F796600A3EEFF00A3EEFF005396C2000000000000000000000000000000
      00000000000000000000000000004343C7004343C70000000000000000000000
      000000000000000000000000000000000000000000009A897700000000000000
      000000000000B57A4E00B57A4E000000000000000000B57A4E00B57A4E000000
      000000000000000000009A89770000000000C89B7A00DCA37700CD956B00D3B1
      9700D8BBA600000000000000000000000000000000000000000000000000D8B9
      A200CC946A00DBA27500C89C7B00000000005396C200A3EEFF00A3EEFF008F79
      66008F7966008F7966008F7966008F7966008F7966008F7966008F7966008F79
      66008F796600A3EEFF00A3EEFF005396C2000000000000000000000000000000
      00000000000000000000000000004343C7004343C70000000000000000000000
      000000000000000000000000000000000000000000009A897700000000000000
      000000000000B57A4E00B57A4E000000000000000000B57A4E00B57A4E000000
      000000000000000000009A89770000000000B8805700EAB18500BD855D00F1E7
      DF0000000000000000000000000000000000000000000000000000000000F3EA
      E400BB845900EAB18400BB835A00000000005396C200A3EEFF00A3EEFF008F79
      6600FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C2008F796600A3EEFF00A3EEFF005396C2000000000000000000000000000000
      00000000000000000000000000004343C7004343C70000000000000000000000
      000000000000000000000000000000000000000000009A897700000000000000
      000000000000B57A4E00B57A4E000000000000000000B57A4E00B57A4E000000
      000000000000000000009A89770000000000B47B4E00EFB58A00B57B50000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B67B5000EEB58900B57B5000000000005396C200A3EEFF00A3EEFF008F79
      6600FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C2008F796600A3EEFF00A3EEFF005396C2000000000000000000000000000000
      00000000000000000000000000004343C7004343C70000000000000000000000
      000000000000000000000000000000000000E3DED900A6978700000000000000
      000000000000B57A4E00B57A4E000000000000000000B57A4E00B57A4E000000
      00000000000000000000A6978600E3DED900B9825800EAB18500BA815700F3EB
      E50000000000000000000000000000000000000000000000000000000000F0E6
      DE00BD865D00EAB08500B9825800000000005396C200A3EEFF00A3EEFF008F79
      6600FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C2008F796600A3EEFF00A3EEFF005396C2006969D2004343C7004343C7004343
      C7007979D7000000000000000000000000000000000000000000000000007777
      D7004343C7004343C7004343C7006A6AD300A7988700E0DBD600000000000000
      000000000000B57A4E00B57A4E000000000000000000B57A4E00B57A4E000000
      00000000000000000000E0DBD500A7988600C89B7A00DCA27600CB936900D8BA
      A400000000000000000000000000000000000000000000000000D6B7A000D3B0
      9800CF966C00DBA27600C89C7B00000000005396C200A3EEFF00A3EEFF008F79
      6600FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C2008F796600A3EEFF00A3EEFF005396C2004343C7008F8FF7008F8FF7008989
      F4004D4DC8000000000000000000000000000000000000000000000000004D4D
      C8008989F4008F8FF7008F8FF7004343C7000000000000000000D6B69F000000
      000000000000B57A4E00B87F54000000000000000000B67D5300B57A4E000000
      000000000000D6B69F000000000000000000E3CEBE00C28A6000E8AF8300B981
      5800EDE1D8000000000000000000000000000000000000000000B57A4E00B77E
      5300EBB28600C1895F00E3CFC000000000005396C200A3EEFF00A3EEFF008F79
      6600FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C2008F796600A3EEFF00A3EEFF005396C2004242C5008F8FF7008F8FF7008989
      F4004848C600D1D1F000E6E6F6000000000000000000E6E6F600D1D1F0004848
      C6008989F4008F8FF7008F8FF7004343C70000000000D6B59D00B57A4E00F3EB
      E500C89C7B00B57A4E00CBA083000000000000000000C99F7F00B57A4E00C99D
      7D00F3ECE600B57A4E00D5B49D000000000000000000C18E6900D59B7000DEA3
      7800B77F5500D7B8A200F3EAE400000000000000000000000000B57A4E00E0A6
      7A00D69C7100C2906B0000000000000000005396C200A3EEFF00A3EEFF008F79
      66008F7966008F7966008F7966008F7966008F7966008F7966008F7966008F79
      66008F796600A3EEFF00A3EEFF005396C2004545C7007B7BEA008E8EF6008C8C
      F5006363D7005757CF004F4FCB004A4AC8004A4AC8004F4FCB005757CF006363
      D7008C8CF5008E8EF6007A7AEA004545C700D6B49C00BE865C00B57A4E00B57A
      4E00B57A4E00B87F5500F2E9E4000000000000000000F1E8E200B77E5400B57A
      4E00B57A4E00B57A4E00BE865C00D6B49C0000000000F2EAE300B8805700D59B
      7000E8AF8300CB926900BC845C00B57A4E000000000000000000B57A4E00EFB7
      8B00C0875D00D3B2980000000000000000005396C200A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF005396C200B7B7E8005757CC004A4AC8006262
      D6007171E4007F7FEE008686F1008989F4008989F4008686F1007F7FEE007171
      E4006363D8004A4AC8005959CC00B7B7E900D9BDA800BD855B00B57A4E00B980
      5600CA9F7F00F3EAE40000000000000000000000000000000000F2E9E400C99F
      7F00B9805600B57A4E00BD855B00D9BDA8000000000000000000F3EBE500C190
      6B00C28B6100DCA37700E9AF8400B57A4E000000000000000000B57A4E00B57A
      4E00B57A4E00B57A4E00D7B8A1000000000063A0C7008FD8F000A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF008ED7EF0062A0C6000000000000000000DDDDF400ACAC
      E5008181DA005D5DCD005252CC004A4AC9004A4AC9005252CC005D5DD0008383
      D900ACACE500DEDEF400000000000000000000000000D8B9A200B57A4E000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B57A4E00D8B9A200000000000000000000000000000000000000
      0000E2CCBC00C99C7B00BC855C00B57B51000000000000000000000000000000
      000000000000000000000000000000000000CADEEB0063A2C8005396C2005396
      C2005396C2005396C2005396C2005396C2005396C2005396C2005396C2005396
      C2005396C2005396C20063A1C800CBDFEB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DABFAA000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DABFAA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B7AB9D00AD9F90000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7F4FC00E0D2
      F900DED0F800DED0F800DED0F800DED0F800DED0F800DED0F800DED0F800DED0
      F800EEE7FB000000000000000000000000000000000000000000F4F6FD00D3DD
      FD00D0DBFD00D0DBFD00D0DBFD00D0DBFD00D0DBFD00D0DBFD00D0DBFD00D1DB
      FD00E8EDFD0000000000000000000000000000000000000000009C8B78009C8B
      78009C8B78009C8B78009C8B7900BBAE9D00DCD2C300DED4C500DED4C500DED4
      C500DDD4C400B2A291009C8B7800BBAFA100489BBA00489BBA00489BBA00489B
      BA00489BBA00489BBA00489BBA00489BBA00489BBA00489BBA00489BBA00489B
      BA00489BBA00489BBA00489BBA00489BBA000000000000000000E0D3F900D0BB
      F800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BB
      F800D0BDF6000000000000000000000000000000000000000000D4DEFD00BCCC
      FF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCC
      FF00BDCDFD0000000000000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E3DED800B1A392009F8F7B00B1A3
      9200BBAFA1009C8B7800B7AB9E0000000000489BBA00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00489BBA000000000000000000DED0F800D0BB
      F800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BB
      F800D0BBF8000000000000000000000000000000000000000000D0DBFD00BCCC
      FF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCC
      FF00BCCCFF0000000000000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E2DDD800A7978400E7D5BB00FDEACF00E7D4
      BB00A3927E00AD9F8C000000000000000000489BBA00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00489BBA000000000000000000DED0F800D0BB
      F800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BB
      F800D0BBF8000000000000000000000000000000000000000000D0DBFD00BCCC
      FF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCC
      FF00BCCCFF0000000000000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00B1A39200E5D4BA00FFEDD100FFEDD100FFED
      D100E5D3B900AD9C8A000000000000000000489BBA00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00489BBA000000000000000000DED0F800D0BB
      F800D0BBF800D0BBF800CFB9F8009262EF00D0BBF800D0BBF800D0BBF800D0BB
      F800D0BBF8000000000000000000000000000000000000000000D0DBFD00BCCC
      FF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF0091ABFF0090AB
      FF00BCCCFF0000000000000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A1907D00FAE9CD00FFEDD100FFEDD100FFED
      D100FAE8CC00A08F7C000000000000000000489BBA00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00489BBA000000000000000000DED0F800D0BB
      F800D0BBF800CAB3F700834DEE00631EE900D0BBF800D0BBF800D0BBF800D0BB
      F800D0BBF8000000000000000000000000000000000000000000D0DBFD00BCCC
      FF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF0088A5FF002358
      FF007999FF0000000000000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00AFA18F00E6D5BB00FFEDD100FFEDD100FFED
      D100E5D4BA00AB9C89000000000000000000489BBA00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00489BBA000000000000000000DED0F800D0BB
      F800BFA3F6007234EB00631EE900631EE900631EE900631EE900631EE900631E
      E900631EE900631EE90000000000000000000000000000000000D0DBFD00BCCC
      FF0088A5FF002257FF002257FF002257FF002257FF002257FF002257FF002257
      FF002257FF006E91FD00000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E1DCD600AA998700E7D5BB00F8E6CB00E7D4
      BB00A9988600CABEAE000000000000000000489BBA00FFFFFF00FFFFFF00FDFF
      FF00B7E4F400A7D7EB00A7D7EB00769C5E00769C5E00A7D7EB00A7D7EB00B7E4
      F400FDFFFF00FFFFFF00FFFFFF00489BBA000000000000000000DED0F800D0BB
      F800BFA3F6007335EB00631EE900631EE900631EE900631EE900631EE900631E
      E900631EE900631EE90000000000000000000000000000000000D0DBFD00BCCC
      FF0088A5FF002257FF002257FF002257FF002257FF002257FF002257FF002257
      FF002257FF007596FD00000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E3DED800B3A59400A5948200B3A5
      9400E3DFD900DED4C5000000000000000000489BBA00FFFFFF00F7FCFE00AEDF
      F100A5E3F600A3EEFF00A3EEFF00769C5E00769C5E00A3EEFF00A3EEFF00A5E3
      F600AEDFF100F7FCFE00FFFFFF00489BBA000000000000000000DED0F800D0BB
      F800D0BBF800C9B1F7008049ED00631EE900D0BBF800D0BBF800D0BBF800D0BB
      F800D0BBF8000000000000000000000000000000000000000000D0DBFD00BCCC
      FF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF0088A5FF002358
      FF006F92FF0000000000000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B9AA99000000000000000000489BBA00EDF9FD00AADDEF00A4E6
      F800A3EEFF00769C5E00769C5E00769C5E00769C5E00769C5E00769C5E00A3EE
      FF00A4E6F800AADDEF00EDF9FD00489BBA000000000000000000DED0F800D0BB
      F800D0BBF800D0BBF800CFBAF8009464F000D0BBF800D0BBF800D0BBF800D0BB
      F800D0BBF8000000000000000000000000000000000000000000D0DBFD00BCCC
      FF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF0091ACFF0091AB
      FF00BCCCFF0000000000000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF009C8B78000000000000000000489BBA00ABDEEF00A4E9FB00A3EE
      FF00A3EEFF00769C5E00769C5E00769C5E00769C5E00769C5E00769C5E00A3EE
      FF00A3EEFF00A4E9FA00ABDEEF00489BBA000000000000000000DED0F800D0BB
      F800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BB
      F800D0BBF8000000000000000000000000000000000000000000D0DBFD00BCCC
      FF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCC
      FF00BCCCFF0000000000000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C8B78009C8B78009C8B
      78009C8B78009C8B78000000000000000000C0DCE6005AA3BF0096D1E400A8EF
      FF00A3EEFF00A3EEFF00A3EEFF00769C5E00769C5E00A3EEFF00A3EEFF00A3EE
      FF00A8EFFF0096D2E40059A3BF00C0DCE6000000000000000000DED0F800D0BB
      F800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BB
      F800D0BBF8000000000000000000000000000000000000000000D0DBFD00BCCC
      FF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCC
      FF00BCCCFF0000000000000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C8B7800FFFFFF00F9F8
      F700AA9C8C00B3A79800000000000000000000000000000000008FC1D4005CA8
      C200ADE9F700A3EEFF00A3EEFF00769C5E00769C5E00A3EEFF00A3EEFF00ADE9
      F7005CA8C2008FC1D40000000000000000000000000000000000E0D3F900D0BB
      F800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BBF800D0BB
      F800D0BDF6000000000000000000000000000000000000000000D4DEFD00BCCC
      FF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCCFF00BCCC
      FF00BDCDFD0000000000000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C8B7800F9F8F700AD9E
      8F00AFA29400000000000000000000000000000000000000000000000000D6E8
      EE0068ABC50084C4D900ACEEFE00A3EEFF00A3EEFF00ACEEFE0083C4D90068AC
      C400D6E8EE000000000000000000000000000000000000000000F7F4FC00DED1
      F800DBCBF800DBCBF800DBCBF800DBCBF800DBCBF800DBCBF800DBCBF800DCCD
      F800EEE7FB000000000000000000000000000000000000000000F4F6FD00D1DC
      FD00CCD8FD00CCD8FD00CCD8FD00CCD8FD00CCD8FD00CCD8FD00CCD8FD00CED9
      FD00E8EDFD0000000000000000000000000000000000000000009C8B7800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C8B7800AC9D8E00B4A8
      9A00000000000000000000000000000000000000000000000000000000000000
      000000000000B4D5E1005AA4C000A2DCEC00A2DCEC005AA4C000B4D5E1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C8B78009C8B
      78009C8B78009C8B78009C8B78009C8B78009C8B78009C8B7800B2A597000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000085BCD00087BCD00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007A7AD600D7D7F2007979D6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004343C7004343C7004343C7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008DC38B0052A54F0052A5
      4F0090C48D000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008AB1BA009ADAF00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D0DAFD00BAC9FD00BAC9FD00BAC9FD00BAC9FD00BAC9FD00BAC9FD00D0DA
      FD00000000000000000000000000000000000000000000000000A79788008F79
      66008F7966004343C7004343C7004343C7008F7966008F7966008F7966008F79
      66008F7966008F7966008F796600000000000000000000000000F4B15F00F5A5
      4200F5A54200F5A54200F5A54200F5A542007FA2420047A0430099CA970099CA
      970047A0430080B7710000000000000000000000000000000000000000000000
      00000000000000000000000000009BDCF2003CC8FD002FAAFD00000000000000
      000000000000000000000000000000000000000000000000000000000000CED8
      FD00003CFD00003DFF00003DFF00003DFF00003DFF00003DFF00003DFF00003C
      FD00D0DAFD000000000000000000000000000000000000000000947F6D008F79
      66008F7966008F7966008F7966008F7966008F7966008F7966008F7966008F79
      66008F7966008F7966008F7966000000000000000000FBEAD600F5A54200F5A5
      4200F5A54200F5A54200F5A54200D7A5430047A0430084C08200D6EAD600D6EA
      D60084C0820047A04300DFEEDF000000000000000000FAE7CF00FBDEBB00FBDE
      BB00FBDEBB00FBDEBB00FBDEBB00E8DBC00024A3F5000098FF0024A2F500E0D6
      C200FAE7CF00000000000000000000000000000000000000000000000000A9BC
      FD00003DFF00003DFF00003DFF00003DFF00003DFF00003DFF00003DFF00003D
      FF00A9BCFD0000000000000000000000000000000000000000008F7966008F79
      6600F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE1008F7966000000000000000000FBE9D400F6BD7800F6BF
      7B00F6BF7B00F6BF7B00F6BF7B00C4B66B0047A04300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0047A04300CBE3CB000000000000000000FAE7CF00FBDEBB00FBDE
      BB00FBDEBB00FBDEBB00FBDEBB00FBDEBB00DAD4C4001EA0F7000098FF002AA3
      F400E3E0D300000000000000000000000000000000000000000000000000A9BC
      FD00003DFF00003DFF003D6BFE00003DFF00003DFF003D6BFE00003DFF00003D
      FF00A9BCFD0000000000000000000000000000000000000000008F7966008F79
      6600F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE1008F796600000000000000000000000000F9D9B300F9CA
      9000F9CA9000F9CA9000F9CA9000E9C689004BA1450047A04300C2E0C100C2E0
      C10047A043004AA04600000000000000000000000000FAE7CF00FBDEBB00F2C7
      9700F2C79700D57E2400D57E2400DA8A3900E19A5100DFD2BA0025A2F5000098
      FF0021A0F700000000000000000000000000000000000000000000000000A9BC
      FD00003DFF003A69FE00FAFAFA007696FD007797FD00FAFAFA003968FE00003D
      FF00A9BCFD0000000000000000000000000000000000000000008F7966008F79
      6600F2EBE100F2EBE10091AE7B0091AF7C00F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE1008F796600000000000000000000000000F9D9B300F9CA
      9000F9CA9000F9CA9000F9CA9000F9CA9000A7B76C0047A043006FB56C006FB5
      6C00469E4200AAD2A900000000000000000000000000FAE7CF00FBDEBB00F2C7
      9700F2C79700E0994F00E0994F00E0994F00E0994F00E0994F00DAC8AC001FA1
      F70059ADE000CCC7BE000000000000000000000000000000000000000000A9BC
      FD00003DFF00003DFF0086A2FC00FAFAFA00FAFAFA0085A1FC00003DFF00003D
      FF00A9BCFD0000000000000000000000000000000000000000008F7966008F79
      6600F2EBE100F2EBE10092AF7D0093B17E00F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE1008F796600000000000000000000000000F9D9B300F9CA
      9000E8A55B00E8A55B00DF924100DF924100E39C4E00C8BA74008FB162008DB6
      6F00CBE3CB0000000000000000000000000000000000FAE7CF00FBDEBB00F6D3
      A900F6D3A900EDBB8500EDBB8500EDBB8500EDBB8500EDBB8500F6D3A900E4D8
      C100CCC5B600A6A4DA00B5B5F00000000000000000000000000000000000A9BC
      FD00003DFF00003DFF006E90FD00FAFAFA00F9F9FA006E90FD00003DFF00003D
      FF00A9BCFD0000000000000000000000000000000000000000008F7966008F79
      6600F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE1008F796600000000000000000000000000F9D9B300F9CA
      9000F0B87500F0B87500ECAE6800ECAE6800ECAE6800ECAE6800F9CA9000F9D9
      B3000000000000000000000000000000000000000000FAE7CF00FBDEBB00F6D3
      A900F6D3A900EDBB8500EDBB8500EDBB8500EDBB8500EDBB8500F6D3A900FBDE
      BB00EDDBD000B4B4EF000000000000000000000000000000000000000000A9BC
      FD00003DFF003A69FE00FAFAFA007696FD007797FD00FAFAFA003968FE00003D
      FF00A9BCFD0000000000000000000000000000000000000000008F7966008F79
      6600F2EBE100F2EBE10091AE7B0091AF7C00F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE1008F796600000000000000000000000000F9D9B300F9CA
      9000F0B87500F0B87500ECAE6800ECAE6800ECAE6800ECAE6800F9CA9000F9D9
      B3000000000000000000000000000000000000000000FAE7CF00FBDEBB00F2C7
      9700F2C79700E0984F00E0984F00E0984F00E0984F00E0984F00F2C79700FBDE
      BB00FAE7CF00000000000000000000000000000000000000000000000000A9BC
      FD00003DFF00003DFF003D6BFE00003DFF00003DFF003D6BFE00003DFF00003D
      FF00A9BCFD0000000000000000000000000000000000000000008F7966008F79
      6600F2EBE100F2EBE10092AF7D0093B17E00F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE1008F796600000000000000000000000000F9D9B300F9CA
      9000E8A55B00E8A55B00DF924000DF924000DF924000DF924000F9CA9000F9D9
      B3000000000000000000000000000000000000000000FAE7CF00FBDEBB00F2C7
      9700F2C79700E0984F00E0984F00E0984F00E0984F00E0984F00F2C79700FBDE
      BB00FAE7CF00000000000000000000000000000000000000000000000000A9BC
      FD00003DFF00003DFF00003DFF00003DFF00003DFF00003DFF00003DFF00003D
      FF00A9BCFD0000000000000000000000000000000000000000008F7966008F79
      6600F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE1008F796600000000000000000000000000F9D9B300F9CA
      9000E8A55B00E8A55B00DF924000DF924000DF924000DF924000F9CA9000F9D9
      B3000000000000000000000000000000000000000000F0CFB500FBDEBB00FBDE
      BB00FBDEBB00FBDEBB00FBDEBB00FBDEBB00FBDEBB00FBDEBB00FBDEBB00FBDE
      BB00F0CFB500000000000000000000000000000000000000000000000000A9BC
      FD00003DFF00003DFF00003DFF00003DFF00003DFF00003DFF00003DFF00003D
      FF00A9BCFD0000000000000000000000000000000000000000008F7966008F79
      6600F2EBE100F2EBE10091AE7B0091AF7C00F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE1008F796600000000000000000000000000F9D9B300F9CA
      9000F9CA9000F9CA9000F9CA9000F9CA9000F9CA9000F9CA9000F9CA9000F9D9
      B3000000000000000000000000000000000000000000DFAE9800E4B09200E4B0
      9200E4B09200E4B09200E4B09200E4B09200E4B09200E4B09200E4B09200E4B0
      9200DFAE98000000000000000000000000000000000000000000000000007595
      FD005E84FD002F60FD002B5DFF002B5DFF002B5DFF002B5DFF002F60FD005E84
      FD007595FD0000000000000000000000000000000000000000008F7966008F79
      6600F2EBE100F2EBE10092AF7D0093B17E00F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE1008F796600000000000000000000000000F9D9B300F9CA
      9000F9CA9000F9CA9000F9CA9000F9CA9000F9CA9000F9CA9000F9CA9000F9D9
      B3000000000000000000000000000000000000000000CC897D00B5513F00B551
      3F00B5513F00B5513F00B5513F00B5513F00B5513F00B5513F00B5513F00B551
      3F00CC897D0000000000000000000000000000000000000000000000000091AA
      FD007193FD006186FD003161FD002F61FF002F61FF003263FD006287FD007193
      FD0090ABFD0000000000000000000000000000000000000000008F7966008F79
      6600F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EBE100F2EB
      E100F2EBE100F2EBE1008F796600000000000000000000000000F9D9B300F9CA
      9000F9CA9000F9CA9000F9CA9000F9CA9000F9CA9000F9CA9000F9CA9000F9D9
      B3000000000000000000000000000000000000000000EFDDDA00E4C3BD00E4C3
      BD00E4C3BD00E4C3BD00E4C3BD00E4C3BD00E4C3BD00E4C3BD00E4C3BD00E4C3
      BD00EFDDDA000000000000000000000000000000000000000000000000000000
      00000000000000000000D6E0FD00A9BCFD00A9BCFD00D6E0FD00000000000000
      0000000000000000000000000000000000000000000000000000AB9B8C008F79
      66008F7966008F7966008F7966008F7966008F7966008F7966008F7966008F79
      66008F7966008F7966008F796600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4967400C496
      7400C4967400C4967400C4967400C4967400C4967400C4967400C4967400C496
      7400C4967400C49674000000000000000000CBC1B900E2DDD800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CBC2BA00D9D2CC0000000000E2DD
      D8009F8C7C00917C6A00B4A49800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A1758B00A1758B0000000000000000000000
      0000000000000000000000000000000000000000000000000000C4967400FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200C49674000000000000000000E0DAD50099857400E7E3DF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E2DCD80095817000C5BAB1009681
      6E00C2AE9C00D0BDAC00B29D8B00A08D7C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DACAD200BA96A700BA95A600DBCBD300000000000000
      0000000000000000000000000000000000000000000000000000C4967400FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200E3C29D00000000000000000000000000E0DAD50099857400E7E3
      DF0000000000E2DDD8009F8C7C00917C6A00B5A79A0000000000000000000000
      00000000000000000000000000000000000000000000C5BBB100917C6A00C8B4
      A200D4C1B000D4C1B000D4C1B000B7A392009A877600EEEBE900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D9C9D100AD869A00D1AFBC00D1AEBB00AD869A00DAC9D1000000
      0000000000000000000000000000000000000000000000000000C4967400FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C20000000000000000000000000000000000E0DAD5009985
      7400CBC1B80096816E00C2AE9C00D0BDAC00AB988500A18F7F00000000000000
      000000000000000000000000000000000000DDD7D20095806E00C8B4A200D4C1
      B000D4C1B000D4C1B000D4C1B000B5A08F009B87760000000000000000000000
      00000000000000000000000000000000000000000000C6ABB800C3A6B400DDCD
      D500B390A100B68FA100DCBBC600F0D3DB00F0D3DB00DCBBC600B58EA000B38F
      A100DDCDD500C3A7B500C6ACB900000000000000000000000000C4967400FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200DAB18800FFE8C2000000000000000000000000000000000000000000C7BD
      B400917B6800C5B2A100D4C1B000D4C1B000D4C0AF00AC988600A18E7E000000
      0000000000000000000000000000000000009D897800C2AE9C00D4C1B000D4C1
      B000D4C1B000D4C1B000B5A18F009B8777000000000000000000000000000000
      000000000000000000000000000000000000E9E0E500A3788D00CDA9B700B790
      A200CAA8B600F2D5DC00F2D5DC00F2D5DC00F2D5DC00F2D5DC00F2D4DC00CBA8
      B600B790A200CFAAB800A3788D00EAE1E5000000000000000000C4967400FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200B57A4E00DAB1880000000000000000000000000000000000DDD7D2009580
      6E00C8B4A200D4C1B000D4C1B000D4C1B000D4C1B000C4B09F00927C69009D8A
      7900000000000000000000000000000000008F7A6700D0BDAC00D4C1B000D4C1
      B000D4C1B000B6A290009B887700000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B796A600BB95A600F1D4
      DB00F2D5DC00F0D3DB00C4A1B000A67C9100A77D9100C5A1B000F0D3DB00F2D5
      DC00F0D3DB00BA94A600B896A600000000000000000000000000C4967400FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200B57A4E00B57A4E00D6B69F000000000000000000000000009D897800C2AF
      9D00D4C1B000D4C1B000D4C1B000D4C1B000C6B3A10096806E00C1AE9C00AF9C
      8900A08D7C00000000000000000000000000AB9A8C00AE998700D4C1B000D4C1
      B000B6A190009A8776000000000000000000000000009BC8D800D1E5EC000000
      0000EFEDEB00EFEDEB0000000000000000000000000000000000AA819600E0BF
      CA00F2D5DC00C6A2B100BB9AAB000000000000000000BA99AA00C5A1B000F2D5
      DC00E0BFCA00AA81960000000000000000000000000000000000C4967400FFE8
      C200FFE8C200B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00D6B69F000000000000000000917A6800D2BF
      AE00D4C1B000D4C1B000D4C1B000C6B3A10096806E00C1AE9C00D4C1B000D4C1
      B000AD998800B8AA9E0000000000000000000000000099857300B4A08E00B6A1
      90009A86750000000000000000000000000000000000CEE3EB005AA4BF00CFDB
      DD009985740099857500EFEDEB00000000000000000000000000A57B8F00EDCF
      D700F2D5DC00A87E920000000000000000000000000000000000A87E9200F2D5
      DC00EDCFD600A47B900000000000000000000000000000000000C4967400FFE8
      C200FFE8C200B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A4E00B57A
      4E00B57A4E00B57A4E00B57A4E00DABFAA000000000000000000AB9A8B00B4A1
      8F00D4C1B000D4C1B000C6B3A10096806E00C1AE9C00D4C1B000D4C1B000D4C1
      B000D0BDAB009A867400000000000000000000000000EFEDEB00998574009A86
      7400000000000000000000000000000000000000000000000000C5D5DA008B7E
      6E00B5A29100B5A08F009A867400000000000000000000000000A47B9000ECCE
      D600F2D5DC00A87E920000000000000000000000000000000000A87F9400F2D5
      DC00ECCED600A47B900000000000000000000000000000000000C4967400FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200B57A4E00B57A4E00D8BBA500000000000000000000000000000000009A86
      7400B7A39200C6B3A10096806E00C2AE9D00D4C1B000D4C1B000D4C1B000D4C1
      B000C2AE9D00A898880000000000000000000000000000000000EFEDEB000000
      000000000000000000009BC8D800D1E5EC0000000000EEEBE90099847300B7A2
      9100D4C1B000D4C1B000AE9A8700AC9B8D000000000000000000AA819600E0BF
      CA00F2D5DC00C6A2B100BB9AAB00F1EBEE00F0EBEE00BA99AA00C5A1B000F2D5
      DC00E0C0CA00AA83960000000000000000000000000000000000C4967400FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200B57A4E00DAB1880000000000000000000000000000000000000000000000
      000098837200937D6A00C4B09F00D4C1B000D4C1B000D4C1B000D4C1B000C8B4
      A20097827000E7E2DE0000000000000000000000000000000000000000000000
      00000000000000000000CEE3EB005AA4BF00CEDADC0099847300B7A49200D4C1
      B000D4C1B000D4C1B000D0BDAB00907B670000000000B796A600BB95A600F1D4
      DB00F2D5DC00F0D3DB00C4A1B000A9819400A9819400C5A1B000F0D3DB00F2D5
      DC00F0D3DB00BA94A600B896A600000000000000000000000000C4967400FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200DCB58B00FFE8C20000000000000000000000000000000000000000000000
      0000EEEBE80097837300BAA79500D4C1B000D4C1B000D4C1B000CAB6A500937D
      6A00CCC3BA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C4D3D7008C7D6F00B7A39200D4C1B000D4C1
      B000D4C1B000D4C1B000C2AE9D009D8A7900E9E0E500A3788D00CDA9B700B790
      A200CAA8B600F2D5DC00F2D5DC00F2D5DC00F2D5DC00F2D5DC00F2D4DC00CBA8
      B600B790A200CFAAB800A3788D00EAE1E5000000000000000000C4967400FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200FFE8C20000000000000000000000000000000000000000000000
      000000000000000000009A867500B29F8D00D0BCAB00C3B09E0099847200CCC1
      BA0099857400E7E3DF0000000000000000000000000000000000000000000000
      00000000000000000000EDEAE70099857300B8A49100D4C1B000D4C1B000D4C1
      B000D4C1B000C8B4A20095806D00DED8D20000000000C6ABB800C3A6B400DDCD
      D500B390A100B68FA100DCBBC600F0D3DB00F0D3DB00DCBBC600B58EA000B38F
      A100DDCDD500C3A7B500C6ACB900000000000000000000000000C4967400FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200E2BF9B0000000000000000000000000000000000000000000000
      0000000000000000000000000000AF9E900095806E00A1907F00E7E3E0000000
      0000DFD9D40099857400E7E3DF00000000000000000000000000000000000000
      00000000000000000000EEEBE90099847300B7A49300D4C1B000D4C1B000D4C1
      B000CAB6A500937F6B00C0B4AA00000000000000000000000000000000000000
      000000000000D9C9D100AD879A00D1AFBC00D1AEBB00AD869A00DAC9D1000000
      0000000000000000000000000000000000000000000000000000C4967400FFE8
      C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8C200FFE8
      C200FFE8C200C496740000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DFD9D40099857400E7E3E0000000000000000000000000000000
      0000000000000000000000000000000000009B877600B39E8D00D0BCAB00C3B0
      9E0096816F00C6BAB10095817000DFD9D4000000000000000000000000000000
      00000000000000000000DACAD200BC96A700BB95A500DACAD200000000000000
      0000000000000000000000000000000000000000000000000000C4967400C496
      7400C4967400C4967400C4967400C4967400C4967400C4967400C4967400C496
      7400C4967400C496740000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E2DDD800CBC1B9000000000000000000000000000000
      00000000000000000000000000000000000000000000AFA0920095806E00A18E
      7E00E2DDD70000000000E4DFDB00CBC1B9000000000000000000000000000000
      0000000000000000000000000000A1758B00A1758B0000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000D00000000100010000000000800600000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF7FFE00007FFFF01F781E0000
      3FFFE00F300C00000003C00710080000000380038001000000030001E0070000
      000300010000000000030001E007000000030001800100000003000100000000
      00030001300C000000030001700E000000038003781E00000003C007F81F0000
      0003E00FF00F00000003F01FF7EF0000FFFFFFFFFFFFF00F81818FFF0000E007
      818187FF0000CFFF818187FF00009CE78181C1FF000010418181E07F00003309
      8181F0070000339CFFFFF8030000339CFFFFF8010000339C8181FC010000338C
      8181FC050000318C8181FC090000980C8181FC1900008E598181FE230000C7F1
      8181FF070000E003FFFFFFFF0000F00FFFFFFFFFFFF8FFFFFC7FFD7FF000DFFF
      FC7FFD7FF00085FFFC7FFD7FC001C1FFF01FFD7FC001C1FFF83FED6F0001E1FF
      FC7FE54F0001C1FF000101010001FFFFFFFF01010001FFFF000101010001FF83
      FC7FE54F0001FF87F83FED6F0001FF87F01FFD7F0007FF83FC7FFD7F0007FFB1
      FC7FFD7F001FFFFBFC7FFD7F001FFFFF8410FFFFFFFFFE7F8410FFFF0000FC3F
      841000010000F81F841000010000FE7F841000010000FE7FEF7B00010000FE7F
      EF7B00010000FE7FE00300010000FE7FFF7F00010000FE7FFF7F00010000FE7F
      FF7F00010000FE7FF80F00010000FE7FF80F00010000FE7FF80F00010000F81F
      F80F00010000FC3FF80FFFFFFFFFFE7FC7C3FFE7FFFF000FC7C3FF81FC3F000F
      C7C3FF000000000FC7C300000000801FC7C300000000C03F864100000000E07F
      844100000000E07F800100010000E03F818100030000C003818100030000C001
      838100030000C00083C300030000C000C3C700030000C000C38300030000C000
      C383F7BF0000E001C3C7F03FFFFFFF83FFFFF800FE00FFFFF01FF800FC008181
      FC7FF800F80081810001F8008000C3C30001F8000000FFFF000100008000C3C3
      00010000C100C3C300010000C3C3C3C300010000C3C3C24300010000C003FE7F
      000100008001F00F0001001F0000F00F0001001F8001F00F0001001FF81FF00F
      FFFF001FFC3FF00FFFFF001FFC3FF00FFFFFF0FFFFFFFFFFFFFFE03FF01F8021
      0000801FC00780210000000F8003802100000005800380210000000400018021
      00000006000180210000000C038180210000000C038180210000000E03818021
      0000001C000180210000001C0001FFFFC183F87980038001C183FFF380038001
      FFFFF903C0078001FFFFFC0FF01FFFFFFFFFFFFCFFFFE0070001F018FFFFC003
      0001C0010000C003000180030000C003000180030000C003000100010000C003
      000100010000C003000100010000C003000100010000C003000100010000C003
      000100010000C003000100010000C003000180030000C003000180030000C003
      0001C007FFFFC003FFFFF01FFFFFC003FFFF8001FFFFFFFFFFFF80018000FFFF
      C3C380010000FFFF8181C00300001FFFC3C3F00F00001800E007FC3F00001FFF
      C003F81F0000FFFFE667F81F00001FFF8001F00F00001800C003F00F00001FFF
      E667F00F0000FFFFC3C3F00F00001FFFC3C3F00F00001800E7E7F00F00001FFF
      FFFFF00F0001FFFFFFFFF83FFFFFFFFFFFFF0000FE7FFFFFFE1F0000FE7F8001
      06070000FC3FBFFD86030000F00FBFFD87030000FE7FB99D07C10000FE7FB99D
      07E10000FE7FB99D0FE10000FE7FB99D1FF10000FE7F399C0FE1000007E0399C
      0FC1000007E0D99B07C100000180818181C300000000018080C30000000003C0
      C0C10000C0039FF9F0FF0000FFFFDFFBFFFFFFFFFFFCFFFFC007C007C0000000
      C007C007C0010000C007C007C0030000C007C007C0030000C007C007C0030000
      C007C007C0030000C003C003C0030000C003C003C0030000C007C007C0030000
      C007C007C0030000C007C007C0030000C007C007C003C003C007C007C007E007
      C007C007C00FF81FFFFFFFFFC01FFE7FF8FFFFFFFFFFFFFFF8FFFF87FE7FF00F
      C001C003FE3FE007C00180018007E007C00180018007E007C001C0038007E007
      C001C0038003E007C001C0078001E007C001C00F8003E007C001C00F8007E007
      C001C00F8007E007C001C00F8007E007C001C00F8007E007C001C00F8007E007
      C001C00F8007FC3FC001FFFFFFFFFFFFC0033FFF21FFFE7FC0031FFF00FFFC3F
      C003887F803FF81FC003C03F007F8001C003E01F00FF0000C003C00F01FF8001
      C001C0070393C183C000C0038781C3C3C000C0038FC1C3C3C001E003DC80C003
      C003F003FC008001C003F007FE000000C003FC03FC008001C003FE11FC01F81F
      C003FFF8FF00FC3FC003FFFCFF84FE7F00000000000000000000000000000000
      000000000000}
  end
end
