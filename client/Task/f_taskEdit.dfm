object TaskEditForm: TTaskEditForm
  Left = 0
  Top = 0
  Caption = 'Aufgabe'
  ClientHeight = 439
  ClientWidth = 725
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 420
    Width = 725
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 725
    Height = 420
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Daten'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 717
        Height = 81
        Align = alTop
        Caption = 'Allgemeines'
        TabOrder = 0
        DesignSize = (
          717
          81)
        object Label1: TLabel
          Left = 16
          Top = 27
          Width = 20
          Height = 13
          Caption = 'Titel'
        end
        object Label2: TLabel
          Left = 255
          Top = 27
          Width = 48
          Height = 13
          Caption = 'Gestarted'
        end
        object Label3: TLabel
          Left = 391
          Top = 27
          Width = 32
          Height = 13
          Caption = 'Termin'
        end
        object Label4: TLabel
          Left = 9
          Top = 54
          Width = 34
          Height = 13
          Caption = 'Erfasst'
        end
        object Label5: TLabel
          Left = 567
          Top = 27
          Width = 22
          Height = 13
          Caption = 'Rest'
        end
        object Label6: TLabel
          Left = 589
          Top = 56
          Width = 98
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Schreibgesch'#252'tzt'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 530
        end
        object Label7: TLabel
          Left = 176
          Top = 56
          Width = 31
          Height = 13
          Caption = 'Status'
        end
        object Label8: TLabel
          Left = 364
          Top = 56
          Width = 24
          Height = 13
          Caption = 'Style'
        end
        object DBEdit1: TDBEdit
          Left = 49
          Top = 24
          Width = 200
          Height = 21
          DataField = 'TA_NAME'
          DataSource = TaskSrc
          TabOrder = 0
          OnKeyPress = DBEdit1KeyPress
        end
        object DBEdit2: TDBEdit
          Left = 309
          Top = 24
          Width = 76
          Height = 21
          DataField = 'TA_STARTED'
          DataSource = TaskSrc
          TabOrder = 1
          OnKeyPress = DBEdit1KeyPress
        end
        object JvDBDatePickerEdit1: TJvDBDatePickerEdit
          Left = 440
          Top = 24
          Width = 121
          Height = 21
          AllowNoDate = True
          DataField = 'TA_TERMIN'
          DataSource = TaskSrc
          TabOrder = 2
          OnChange = JvDBDatePickerEdit1Change
        end
        object DBEdit3: TDBEdit
          Left = 49
          Top = 51
          Width = 121
          Height = 21
          DataField = 'TA_CREATED_BY'
          DataSource = TaskSrc
          Enabled = False
          ReadOnly = True
          TabOrder = 3
          OnKeyPress = DBEdit1KeyPress
        end
        object DBEdit4: TDBEdit
          Left = 595
          Top = 24
          Width = 33
          Height = 21
          DataField = 'TA_REST'
          DataSource = TaskSrc
          ReadOnly = True
          TabOrder = 4
        end
        object ComboBox1: TComboBox
          Left = 213
          Top = 51
          Width = 145
          Height = 21
          TabOrder = 5
          Text = 'ComboBox1'
          OnChange = ComboBox1Change
        end
        object ComboBox2: TComboBox
          Left = 394
          Top = 51
          Width = 130
          Height = 21
          TabOrder = 6
          Text = 'ComboBox2'
          OnChange = ComboBox2Change
        end
      end
      object PageControl2: TPageControl
        Left = 0
        Top = 81
        Width = 717
        Height = 311
        ActivePage = TabSheet4
        Align = alClient
        TabOrder = 1
        OnChange = PageControl2Change
        object TabSheet3: TTabSheet
          Caption = 'Details'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object ScrollBox1: TScrollBox
            Left = 0
            Top = 0
            Width = 709
            Height = 283
            HorzScrollBar.Visible = False
            Align = alClient
            TabOrder = 0
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Vorschau'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object WebBrowser1: TWebBrowser
            Left = 0
            Top = 0
            Width = 709
            Height = 283
            Align = alClient
            TabOrder = 0
            ExplicitLeft = 16
            ExplicitTop = 16
            ExplicitWidth = 300
            ExplicitHeight = 150
            ControlData = {
              4C00000047490000401D00000000000000000000000000000000000000000000
              000000004C000000000000000000000001000000E0D057007335CF11AE690800
              2B2E126208000000000000004C0000000114020000000000C000000000000046
              8000000000000000000000000000000000000000000000000000000000000000
              00000000000000000100000000000000000000000000000000000000}
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dateien'
      ImageIndex = 1
      inline FileFrame1: TFileFrame
        Left = 0
        Top = 0
        Width = 717
        Height = 392
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 717
        ExplicitHeight = 392
        inherited DBGrid1: TDBGrid
          Width = 717
          Height = 314
        end
        inherited GroupBox1: TGroupBox
          Top = 314
          Width = 717
          ExplicitTop = 314
          ExplicitWidth = 717
          inherited Panel1: TPanel
            Left = 596
            Color = clMoneyGreen
            ExplicitLeft = 596
          end
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 324
    Top = 104
    object Dokument1: TMenuItem
      Caption = 'Dokument'
      GroupIndex = 100
      object Bearbeiten1: TMenuItem
        Action = ac_bearbeiten
      end
      object Bearbeitenbeenden1: TMenuItem
        Action = ac_unlock
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Lesezeichenerstellen1: TMenuItem
        Action = ac_bookmark
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object acsave1: TMenuItem
        Action = ac_save
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Aktualisieren1: TMenuItem
        Action = ac_refresh
      end
    end
  end
  object ActionList1: TActionList
    Left = 436
    Top = 112
    object ac_bearbeiten: TAction
      Caption = 'Bearbeiten'
      ShortCut = 114
      OnExecute = ac_bearbeitenExecute
    end
    object ac_save: TAction
      Caption = 'Speichern'
      ShortCut = 16467
      OnExecute = ac_saveExecute
    end
    object ac_unlock: TAction
      Caption = 'Bearbeiten beenden'
      ShortCut = 115
      OnExecute = ac_unlockExecute
    end
    object ac_refresh: TAction
      Caption = 'Aktualisieren'
      ShortCut = 116
      OnExecute = ac_refreshExecute
    end
    object ac_bookmark: TAction
      Caption = 'Leesezeichen erstellen'
      ShortCut = 120
      OnExecute = ac_bookmarkExecute
    end
  end
  object TaskSrc: TDataSource
    AutoEdit = False
    DataSet = TaskTab
    Left = 152
    Top = 184
  end
  object TaskTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TaskTableSrc'
    RemoteServer = DSProviderConnection1
    OnPostError = TaskTabPostError
    OnReconcileError = TaskTabReconcileError
    Left = 40
    Top = 160
    object TaskTabTE_ID: TIntegerField
      FieldName = 'TE_ID'
    end
    object TaskTabTA_ID: TIntegerField
      FieldName = 'TA_ID'
      Required = True
    end
    object TaskTabTY_ID: TIntegerField
      FieldName = 'TY_ID'
    end
    object TaskTabTA_STARTED: TDateField
      FieldName = 'TA_STARTED'
    end
    object TaskTabTA_CREATED: TDateTimeField
      FieldName = 'TA_CREATED'
    end
    object TaskTabTA_NAME: TWideStringField
      FieldName = 'TA_NAME'
      Size = 200
    end
    object TaskTabTA_DATA: TBlobField
      FieldName = 'TA_DATA'
      Size = 8
    end
    object TaskTabTA_CREATED_BY: TWideStringField
      FieldName = 'TA_CREATED_BY'
      Size = 200
    end
    object TaskTabTA_TERMIN: TDateField
      FieldName = 'TA_TERMIN'
    end
    object TaskTabTA_CLID: TWideStringField
      FieldName = 'TA_CLID'
      Size = 38
    end
    object TaskTabTA_FLAGS: TIntegerField
      FieldName = 'TA_FLAGS'
    end
    object TaskTabTA_STATUS: TWideStringField
      FieldName = 'TA_STATUS'
      Size = 50
    end
    object TaskTabTA_REST: TStringField
      FieldKind = fkCalculated
      FieldName = 'TA_REST'
      OnGetText = TaskTabTA_RESTGetText
      Size = 10
      Calculated = True
    end
    object TaskTabTA_STYLE: TWideStringField
      FieldName = 'TA_STYLE'
      Size = 200
    end
    object TaskTabTA_STYLE_CLID: TWideStringField
      FieldName = 'TA_STYLE_CLID'
      Size = 38
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTask'
    Left = 232
    Top = 152
  end
  object TemplateTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TemplateTab'
    ReadOnly = True
    RemoteServer = DSProviderConnection1
    Left = 84
    Top = 161
  end
end
