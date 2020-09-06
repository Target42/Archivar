object TaskEditForm: TTaskEditForm
  Left = 0
  Top = 0
  Caption = 'Aufgabe'
  ClientHeight = 385
  ClientWidth = 666
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
    Top = 366
    Width = 666
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 666
    Height = 366
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Daten'
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 658
        Height = 81
        Align = alTop
        Caption = 'Allgemeines'
        TabOrder = 0
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
          Left = 530
          Top = 62
          Width = 98
          Height = 13
          Caption = 'Schreibgesch'#252'tzt'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
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
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 81
        Width = 658
        Height = 257
        Align = alClient
        Caption = 'Details'
        TabOrder = 1
        object ScrollBox1: TScrollBox
          Left = 2
          Top = 15
          Width = 654
          Height = 240
          HorzScrollBar.Visible = False
          Align = alClient
          TabOrder = 0
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dateien'
      ImageIndex = 1
      inline FileFrame1: TFileFrame
        Left = 0
        Top = 0
        Width = 658
        Height = 338
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 658
        ExplicitHeight = 338
        inherited DBGrid1: TDBGrid
          Width = 658
          Height = 260
        end
        inherited GroupBox1: TGroupBox
          Top = 260
          Width = 658
          ExplicitTop = 260
          ExplicitWidth = 658
          inherited Panel1: TPanel
            Left = 537
            Color = clMoneyGreen
            ExplicitLeft = 537
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
        Caption = 'Lesezeichen erstellen'
        ShortCut = 120
        OnClick = Lesezeichenerstellen1Click
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
      Caption = 'ac_save'
    end
    object ac_unlock: TAction
      Caption = 'Bearbeiten beenden'
      ShortCut = 115
      OnExecute = ac_unlockExecute
    end
  end
  object TaskSrc: TDataSource
    AutoEdit = False
    DataSet = TaskTab
    Left = 144
    Top = 80
  end
  object TaskTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TaskTableSrc'
    RemoteServer = DSProviderConnection1
    OnPostError = TaskTabPostError
    OnReconcileError = TaskTabReconcileError
    Left = 80
    Top = 96
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
