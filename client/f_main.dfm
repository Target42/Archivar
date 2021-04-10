object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Archivar'
  ClientHeight = 678
  ClientWidth = 1126
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowMenu = Fenster1
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 249
    Top = 0
    Height = 469
    ExplicitLeft = 568
    ExplicitTop = 96
    ExplicitHeight = 100
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 469
    Width = 1126
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Visible = False
    ExplicitLeft = 284
    ExplicitTop = 0
    ExplicitWidth = 301
  end
  object Image1: TImage
    Left = 252
    Top = 0
    Width = 874
    Height = 469
    Align = alClient
    Center = True
    ExplicitLeft = 392
    ExplicitTop = 48
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 659
    Width = 1126
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
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 249
    Height = 469
    ActivePage = TabSheet6
    Align = alLeft
    MultiLine = True
    TabOrder = 1
    TabPosition = tpLeft
    Visible = False
    object TabSheet1: TTabSheet
      Caption = 'Gremien'
      inline GremiumTreeFrame1: TGremiumTreeFrame
        Left = 0
        Top = 0
        Width = 221
        Height = 461
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 221
        ExplicitHeight = 461
        inherited TV: TTreeView
          Width = 221
          Height = 461
          ExplicitWidth = 221
          ExplicitHeight = 461
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Lesezeichen'
      ImageIndex = 1
      inline BookmarkFrame1: TBookmarkFrame
        Left = 0
        Top = 0
        Width = 221
        Height = 461
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 221
        ExplicitHeight = 461
        inherited LV: TListView
          Width = 221
          Height = 461
          ExplicitWidth = 221
          ExplicitHeight = 461
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'B'#252'cher'
      ImageIndex = 2
      inline ePupFrame1: TePupFrame
        Left = 0
        Top = 0
        Width = 221
        Height = 461
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 221
        ExplicitHeight = 461
        inherited DBGrid1: TDBGrid
          Width = 221
          Height = 461
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
      ImageIndex = 3
      object UserView: TListView
        Left = 0
        Top = 0
        Width = 221
        Height = 420
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 75
          end
          item
            Caption = 'Vorname'
            Width = 75
          end
          item
            Caption = 'Status'
          end>
        TabOrder = 0
        ViewStyle = vsReport
      end
      object Panel1: TPanel
        Left = 0
        Top = 420
        Width = 221
        Height = 41
        Align = alBottom
        Caption = 'Panel1'
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
  end
  object PageControl2: TPageControl
    Left = 0
    Top = 472
    Width = 1126
    Height = 187
    ActivePage = TabSheet4
    Align = alBottom
    TabOrder = 2
    Visible = False
    object TabSheet4: TTabSheet
      Caption = 'Aufgaben'
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 1118
        Height = 159
        Align = alClient
        Caption = 'Aufgaben'
        TabOrder = 0
        inline TaskListFrame1: TTaskListFrame
          Left = 2
          Top = 15
          Width = 1114
          Height = 142
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 2
          ExplicitTop = 15
          ExplicitWidth = 1114
          ExplicitHeight = 142
          inherited LV: TListView
            Width = 1114
            Height = 142
            ExplicitWidth = 1114
            ExplicitHeight = 142
          end
          inherited ActionList1: TActionList
            Left = 176
            Top = 80
          end
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Termine'
      ImageIndex = 1
      inline MeetingFrame1: TMeetingFrame
        Left = 0
        Top = 0
        Width = 1118
        Height = 159
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 1118
        ExplicitHeight = 159
        inherited Lv: TListView
          Width = 1118
          Height = 159
          ExplicitWidth = 1118
          ExplicitHeight = 159
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 64
    Top = 88
    object Programm1: TMenuItem
      Caption = '&Programm'
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
      Visible = False
      object Aufgabe2: TMenuItem
        Caption = 'Aufgabe'
        GroupIndex = 200
        object Neue2: TMenuItem
          Action = ac_ta_neu
        end
        object Laden2: TMenuItem
          Action = ac_ta_load
        end
        object N10: TMenuItem
          Caption = '-'
        end
      end
      object Proptokoll1: TMenuItem
        Caption = 'Protokoll'
        GroupIndex = 200
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
    object Admin1: TMenuItem
      Caption = 'Admin'
      GroupIndex = 200
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
        Caption = 'Vorlagen'
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
      end
      object extbausteine1: TMenuItem
        Caption = 'Textbausteine'
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
    end
    object Fenster1: TMenuItem
      Caption = 'Fenster'
      GroupIndex = 200
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
        OnClick = est1Click
      end
      object test21: TMenuItem
        Caption = 'test2'
      end
    end
  end
  object ActionList1: TActionList
    Left = 152
    Top = 160
    object ac_prg_close: TAction
      Category = 'Program'
      Caption = 'Ende'
      OnExecute = ac_prg_closeExecute
    end
    object ac_prg_connect: TAction
      Category = 'Program'
      Caption = 'Verbinden'
      ShortCut = 113
      OnExecute = ac_prg_connectExecute
    end
    object ac_prg_discon: TAction
      Category = 'Program'
      Caption = 'Trennen'
      Enabled = False
      OnExecute = ac_prg_disconExecute
    end
    object ac_prg_set: TAction
      Category = 'Program'
      Caption = 'Einstellungen'
      OnExecute = ac_prg_setExecute
    end
    object ac_ad_gremium: TAction
      Category = 'Admin'
      Caption = 'Gremium'
      OnExecute = ac_ad_gremiumExecute
    end
    object ac_ad_person: TAction
      Category = 'Admin'
      Caption = 'Mitglieder'
      OnExecute = ac_ad_personExecute
    end
    object ac_ta_neu: TAction
      Category = 'Task'
      Caption = 'Neue'
      Enabled = False
      OnExecute = ac_ta_neuExecute
    end
    object WindowCascade1: TWindowCascade
      Category = 'Window'
      Caption = '&Cascade'
      Enabled = False
      Hint = 'Cascade'
      ImageIndex = 17
    end
    object WindowTileHorizontal1: TWindowTileHorizontal
      Category = 'Window'
      Caption = 'Tile &Horizontally'
      Enabled = False
      Hint = 'Tile Horizontal'
      ImageIndex = 15
    end
    object WindowTileVertical1: TWindowTileVertical
      Category = 'Window'
      Caption = '&Tile Vertically'
      Enabled = False
      Hint = 'Tile Vertical'
      ImageIndex = 16
    end
    object WindowMinimizeAll1: TWindowMinimizeAll
      Category = 'Window'
      Caption = '&Minimize All'
      Enabled = False
      Hint = 'Minimize All'
    end
    object WindowArrange1: TWindowArrange
      Category = 'Window'
      Caption = '&Arrange'
      Enabled = False
    end
    object ac_pr_new: TAction
      Category = 'Protokoll'
      Caption = 'Neu'
      Enabled = False
      OnExecute = ac_pr_newExecute
    end
    object ac_pr_open: TAction
      Category = 'Protokoll'
      Caption = 'Bearbeiten'
      Enabled = False
      OnExecute = ac_pr_openExecute
    end
    object ac_ad_pics: TAction
      Category = 'Admin'
      Caption = 'Bilder'
      OnExecute = ac_ad_picsExecute
    end
    object ac_ta_load: TAction
      Category = 'Task'
      Caption = 'Laden'
      Enabled = False
      OnExecute = ac_ta_loadExecute
    end
    object ac_ad_datafields: TAction
      Category = 'Admin'
      Caption = 'Datenfelder'
      OnExecute = ac_ad_datafieldsExecute
    end
    object ac_ad_templates: TAction
      Category = 'Admin'
      Caption = 'Vorlagen bearbeiten'
      OnExecute = ac_ad_templatesExecute
    end
    object ac_ad_template_new: TAction
      Category = 'Admin'
      Caption = 'Neue Vorlage'
      OnExecute = ac_ad_template_newExecute
    end
    object ac_ad_sys_template: TAction
      Category = 'Admin'
      Caption = 'Systemvorlage'
      OnExecute = ac_ad_sys_templateExecute
    end
    object ac_tb_neu: TAction
      Category = 'Textbausteine'
      Caption = 'Neu'
      Enabled = False
      OnExecute = ac_tb_neuExecute
    end
    object ac_tb_edit: TAction
      Category = 'Textbausteine'
      Caption = 'Bearbeiten'
      Enabled = False
      OnExecute = ac_tb_editExecute
    end
    object ac_tb_löschen: TAction
      Category = 'Textbausteine'
      Caption = 'L'#246'schen'
      Enabled = False
      OnExecute = ac_tb_löschenExecute
    end
    object ac_ad_http: TAction
      Category = 'Admin'
      Caption = 'Webserverdateien verwalten'
      OnExecute = ac_ad_httpExecute
    end
    object ac_pr_view: TAction
      Category = 'Protokoll'
      Caption = 'Anzeigen'
      Enabled = False
      OnExecute = ac_pr_viewExecute
    end
    object ac_ad_epub: TAction
      Category = 'Admin'
      Caption = 'ePub Manager'
      OnExecute = ac_ad_epubExecute
    end
    object ac_me_new: TAction
      Category = 'Meeting'
      Caption = 'Neu'
      Enabled = False
      OnExecute = ac_me_newExecute
    end
    object ac_pr_delete: TAction
      Category = 'Protokoll'
      Caption = '&L'#246'schen'
      Enabled = False
    end
    object ac_me_edit: TAction
      Category = 'Meeting'
      Caption = 'Bearbeiten'
      Enabled = False
      OnExecute = ac_me_editExecute
    end
    object ac_me_invite: TAction
      Category = 'Meeting'
      Caption = 'Einladen'
      Enabled = False
      OnExecute = ac_me_inviteExecute
    end
    object ac_me_delete: TAction
      Category = 'Meeting'
      Caption = '&L'#246'schen'
      Enabled = False
      OnExecute = ac_me_deleteExecute
    end
    object ac_me_end: TAction
      Category = 'Meeting'
      Caption = 'Abschlie'#223'en'
      Enabled = False
    end
    object ac_me_update: TAction
      Category = 'Meeting'
      Caption = 'Update'
      Enabled = False
      OnExecute = ac_me_updateExecute
    end
    object ac_me_execute: TAction
      Category = 'Meeting'
      Caption = 'Ausf'#252'hren'
      Enabled = False
      OnExecute = ac_me_executeExecute
    end
    object ac_pr_abschnitt: TAction
      Category = 'Protokoll'
      Caption = 'Abschnitt bearbeiten'
      Enabled = False
      OnExecute = ac_pr_abschnittExecute
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 64
    Top = 216
  end
end
