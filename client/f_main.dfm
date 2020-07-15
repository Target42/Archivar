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
    Left = 241
    Top = 0
    Height = 466
    ExplicitLeft = 568
    ExplicitTop = 96
    ExplicitHeight = 100
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 466
    Width = 1126
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 284
    ExplicitTop = 0
    ExplicitWidth = 301
  end
  object Image1: TImage
    Left = 244
    Top = 0
    Width = 882
    Height = 466
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
  object GroupBox2: TGroupBox
    Left = 0
    Top = 469
    Width = 1126
    Height = 190
    Align = alBottom
    Caption = 'Aufgaben'
    TabOrder = 1
    Visible = False
    inline TaskListFrame1: TTaskListFrame
      Left = 2
      Top = 15
      Width = 1122
      Height = 173
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 1122
      ExplicitHeight = 173
      inherited DBGrid1: TDBGrid
        Width = 1122
        Height = 173
      end
      inherited ActionList1: TActionList
        Left = 176
        Top = 80
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 241
    Height = 466
    ActivePage = TabSheet1
    Align = alLeft
    TabOrder = 2
    Visible = False
    object TabSheet1: TTabSheet
      Caption = 'Gremien'
      inline GremiumTreeFrame1: TGremiumTreeFrame
        Left = 0
        Top = 0
        Width = 233
        Height = 438
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 233
        ExplicitHeight = 438
        inherited TV: TTreeView
          Width = 233
          Height = 438
          ExplicitWidth = 233
          ExplicitHeight = 438
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Lesezeichen'
      ImageIndex = 1
      inline BookmarkFrame1: TBookmarkFrame
        Left = 0
        Top = 0
        Width = 233
        Height = 438
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 233
        ExplicitHeight = 438
        inherited LV: TListView
          Width = 233
          Height = 438
          ExplicitWidth = 233
          ExplicitHeight = 438
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 152
    Top = 32
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
      object Aufgabe2: TMenuItem
        Caption = 'Aufgabe'
        GroupIndex = 200
        object Neue2: TMenuItem
          Action = ac_ta_neu
        end
        object Laden2: TMenuItem
          Action = ac_ta_load
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
        OnClick = test21Click
      end
    end
  end
  object ActionList1: TActionList
    Left = 128
    Top = 120
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
      Caption = 'Laden'
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
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 136
    Top = 168
  end
end
