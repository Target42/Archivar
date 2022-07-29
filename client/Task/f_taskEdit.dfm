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
  Position = poDefault
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
    Panels = <
      item
        Style = psOwnerDraw
        Width = 150
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
    OnDrawPanel = StatusBar1DrawPanel
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
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 717
        Height = 113
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
        object Label9: TLabel
          Left = 4
          Top = 84
          Width = 54
          Height = 13
          Caption = 'Kommentar'
        end
        object Label10: TLabel
          Left = 466
          Top = 80
          Width = 28
          Height = 13
          Caption = 'Farbe'
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
          TabOrder = 4
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
          TabOrder = 3
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
        object DBEdit5: TDBEdit
          Left = 64
          Top = 78
          Width = 380
          Height = 21
          DataField = 'TA_REM'
          DataSource = TaskSrc
          TabOrder = 7
          OnKeyPress = DBEdit1KeyPress
        end
        object JvColorComboBox1: TJvColorComboBox
          Left = 500
          Top = 78
          Width = 145
          Height = 20
          ColorDialogText = 'Custom...'
          DroppedDownWidth = 145
          NewColorText = 'Custom'
          Options = [coText]
          Sorted = True
          TabOrder = 8
          OnChange = JvColorComboBox1Change
        end
      end
      object PageControl2: TPageControl
        Left = 0
        Top = 113
        Width = 717
        Height = 279
        ActivePage = TabSheet3
        Align = alClient
        TabOrder = 1
        OnChange = PageControl2Change
        object TabSheet3: TTabSheet
          Caption = 'Details'
          inline FormFrame1: TFormFrame
            Left = 0
            Top = 0
            Width = 709
            Height = 251
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 709
            ExplicitHeight = 251
            inherited ScrollBox1: TScrollBox
              Width = 709
              Height = 251
              ExplicitWidth = 709
              ExplicitHeight = 251
            end
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Vorschau'
          ImageIndex = 1
          object WebBrowser1: TWebBrowser
            Left = 0
            Top = 0
            Width = 709
            Height = 251
            Align = alClient
            TabOrder = 0
            ExplicitLeft = 16
            ExplicitTop = 16
            ExplicitWidth = 300
            ExplicitHeight = 150
            ControlData = {
              4C00000047490000F11900000000000000000000000000000000000000000000
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
        inherited Splitter1: TSplitter
          Height = 392
          ExplicitHeight = 392
        end
        inherited GroupBox2: TGroupBox
          Height = 392
          ExplicitHeight = 392
          inherited GroupBox4: TGroupBox
            Top = 333
            ExplicitTop = 333
          end
          inherited VST: TVirtualStringTree
            Height = 318
            ExplicitHeight = 318
          end
        end
        inherited GroupBox3: TGroupBox
          Width = 465
          Height = 392
          ExplicitWidth = 465
          ExplicitHeight = 392
          inherited GroupBox1: TGroupBox
            Top = 333
            Width = 461
            ExplicitTop = 333
            ExplicitWidth = 461
          end
          inherited LV: TListView
            Width = 461
            Height = 318
            ExplicitWidth = 461
            ExplicitHeight = 318
          end
        end
        inherited JvDragDrop1: TJvDragDrop
          DropTarget = FileFrame1
        end
        inherited ImageList1: TImageList
          Bitmap = {
            494C010102000800440010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
            0000000000003600000028000000400000001000000001002000000000000010
            000000000000000000000000000000000000000000FF078DBE00078DBE00078D
            BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
            BE00078DBE00078DBE00000000FF000000FF000000FF078DBE00078DBE00078D
            BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
            BE00078DBE00000000FF000000FF000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000078DBE0063CBF800078DBE00A3E1
            FB0066CDF90065CDF80065CDF90065CDF90065CDF80065CDF90065CDF80066CD
            F8003AADD800ACE7F500078DBE00000000FF078DBE0025A1D10071C6E80084D7
            FA0066CDF90065CDF90065CDF90065CDF90065CDF80065CDF90065CDF80066CE
            F9003AADD8001999C900000000FF000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000078DBE006AD1F900078DBE00A8E5
            FC006FD4FA006FD4F9006ED4FA006FD4F9006FD4FA006FD4FA006FD4FA006ED4
            F9003EB1D900B1EAF500078DBE00000000FF078DBE004CBCE70039A8D100A0E2
            FB006FD4FA006FD4F9006ED4FA006FD4F9006FD4FA006FD4FA006FD4FA006ED4
            F9003EB1D900C9F0F300078DBE00000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000078DBE0072D6FA00078DBE00AEEA
            FC0079DCFB0079DCFB0079DCFB0079DCFB0079DCFB007ADCFB0079DCFA0079DC
            FA0044B5D900B6EEF600078DBE00000000FF078DBE0072D6FA00078DBE00AEE9
            FC0079DCFB0079DCFB0079DCFB0079DCFB0079DCFB007ADCFB0079DCFA0079DC
            FA0044B5D900C9F0F300078DBE00000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000078DBE0079DDFB00078DBE00B5EE
            FD0083E4FB0084E4FB0083E4FC0083E4FC0084E4FC0083E4FC0083E4FB0084E5
            FC0048B9DA00BBF2F600078DBE00000000FF078DBE0079DDFB001899C7009ADF
            F30092E7FC0084E4FB0083E4FC0083E4FC0084E4FC0083E4FC0083E4FB0084E5
            FC0048B9DA00C9F0F3001496C400000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000078DBE0082E3FC00078DBE00BAF3
            FD008DEBFC008DEBFC008DEBFC008DEBFD008DEBFD008DEBFC008DEBFD008DEB
            FC004CBBDA00BEF4F700078DBE00000000FF078DBE0082E3FC0043B7DC0065C2
            E000ABF0FC008DEBFC008DEBFC008DEBFD008DEBFD008DEBFC008DEBFD008DEB
            FC004CBBDA00C9F0F300C9F0F300078DBE000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000078DBE008AEAFC00078DBE00FFFF
            FF00C9F7FE00C8F7FE00C9F7FE00C9F7FE00C9F7FE00C8F7FE00C9F7FE00C8F7
            FE009BD5E700DEF9FB00078DBE00000000FF078DBE008AEAFC0077DCF300219C
            C700FEFFFF00C8F7FD00C9F7FD00C9F7FD00C9F7FE00C8F7FE00C9F7FD00C8F7
            FE009BD5E600EAFEFE00D2F3F800078DBE000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000078DBE0093F0FE00078DBE00078D
            BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
            BE00078DBE00078DBE00078DBE00000000FF078DBE0093F0FE0093F0FD001697
            C500078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
            BE00078DBE00078DBE00078DBE00078DBE000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000078DBE009BF5FE009AF6FE009AF6
            FE009BF5FD009BF6FE009AF6FE009BF5FE009AF6FD009BF5FE009AF6FE009AF6
            FE000989BA00000000FF000000FF000000FF078DBE009BF5FE009AF6FE009AF6
            FE009BF5FD009BF6FE009AF6FE009BF5FE009AF6FD009BF5FE009AF6FE009AF6
            FE000989BA00000000FF000000FF000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000078DBE00FEFEFE00A0FBFF00A0FB
            FE00A0FBFE00A1FAFE00A1FBFE00A0FAFE00A1FBFE00A1FBFF00A0FBFF00A1FB
            FF000989BA00000000FF000000FF000000FF078DBE00FEFEFE00A0FBFF00A0FB
            FE00A0FBFE00A1FAFE00A1FBFE00A0FAFE00A1FBFE00A1FBFF00A0FBFF00A1FB
            FF000989BA00000000FF000000FF000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000FF078DBE00FEFEFE00A5FE
            FF00A5FEFF00A5FEFF00078DBE00078DBE00078DBE00078DBE00078DBE00078D
            BE00000000FF000000FF000000FF000000FF000000FF078DBE00FEFEFE00A5FE
            FF00A5FEFF00A5FEFF00078DBE00078DBE00078DBE00078DBE00078DBE00078D
            BE00000000FF000000FF000000FF000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000FF000000FF078DBE00078D
            BE00078DBE00078DBE00000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF078DBE00078D
            BE00078DBE00078DBE00000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000424D3E000000000000003E000000
            2800000040000000100000000100010000000000800000000000000000000000
            000000000000000000000000FFFFFF0080038007000000000001000300000000
            0001000100000000000100010000000000010001000000000001000000000000
            0001000000000000000100000000000000070007000000000007000700000000
            800F800F00000000C3FFC3FF00000000FFFFFFFF00000000FFFFFFFF00000000
            FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
            000000000000}
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Log-buch'
      ImageIndex = 2
      inline LogFrame1: TLogFrame
        Left = 0
        Top = 0
        Width = 717
        Height = 392
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 717
        ExplicitHeight = 392
        inherited GroupBox3: TGroupBox
          Left = 532
          Height = 392
          ExplicitLeft = 532
          ExplicitHeight = 392
          inherited TextBlockFrame1: TTextBlockFrame
            Height = 375
            ExplicitHeight = 375
            inherited Panel1: TPanel
              Top = 319
              ExplicitLeft = 0
              ExplicitTop = 319
            end
            inherited LV: TListView
              Height = 319
              ExplicitHeight = 319
            end
          end
        end
        inherited Panel1: TPanel
          Width = 532
          Height = 392
          ExplicitWidth = 532
          ExplicitHeight = 392
          inherited GroupBox1: TGroupBox
            Width = 532
            ExplicitWidth = 532
            inherited EditFrame1: TEditFrame
              Width = 528
              ExplicitWidth = 528
              inherited RE: TRichEdit
                Width = 528
                OnKeyPress = DBEdit1KeyPress
                ExplicitWidth = 528
              end
            end
          end
          inherited GroupBox2: TGroupBox
            Width = 532
            Height = 295
            ExplicitWidth = 532
            ExplicitHeight = 295
            inherited WebBrowser1: TWebBrowser
              Width = 522
              Height = 272
              ExplicitWidth = 175
              ExplicitHeight = 82
              ControlData = {
                4C000000F33500001D1C00000000000000000000000000000000000000000000
                000000004C000000000000000000000001000000E0D057007335CF11AE690800
                2B2E126208000000000000004C0000000114020000000000C000000000000046
                8000000000000000000000000000000000000000000000000000000000000000
                00000000000000000100000000000000000000000000000000000000}
            end
          end
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 388
    Top = 160
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
    Top = 152
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
    Left = 40
    Top = 232
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
    object TaskTabTA_REST: TStringField
      FieldKind = fkCalculated
      FieldName = 'TA_REST'
      OnGetText = TaskTabTA_RESTGetText
      Size = 10
      Calculated = True
    end
    object TaskTabTE_ID: TIntegerField
      FieldName = 'TE_ID'
      Origin = 'TE_ID'
    end
    object TaskTabTA_ID: TIntegerField
      FieldName = 'TA_ID'
      Origin = 'TA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TaskTabTY_ID: TIntegerField
      FieldName = 'TY_ID'
      Origin = 'TY_ID'
    end
    object TaskTabTA_STARTED: TDateField
      FieldName = 'TA_STARTED'
      Origin = 'TA_STARTED'
    end
    object TaskTabTA_CREATED: TSQLTimeStampField
      FieldName = 'TA_CREATED'
      Origin = 'TA_CREATED'
    end
    object TaskTabTA_NAME: TStringField
      FieldName = 'TA_NAME'
      Origin = 'TA_NAME'
      Size = 200
    end
    object TaskTabTA_DATA: TBlobField
      FieldName = 'TA_DATA'
      Origin = 'TA_DATA'
    end
    object TaskTabTA_CREATED_BY: TStringField
      FieldName = 'TA_CREATED_BY'
      Origin = 'TA_CREATED_BY'
      Size = 200
    end
    object TaskTabTA_TERMIN: TDateField
      FieldName = 'TA_TERMIN'
      Origin = 'TA_TERMIN'
    end
    object TaskTabTA_CLID: TStringField
      FieldName = 'TA_CLID'
      Origin = 'TA_CLID'
      Size = 38
    end
    object TaskTabTA_FLAGS: TIntegerField
      FieldName = 'TA_FLAGS'
      Origin = 'TA_FLAGS'
    end
    object TaskTabTA_STATUS: TStringField
      FieldName = 'TA_STATUS'
      Origin = 'TA_STATUS'
      Size = 50
    end
    object TaskTabTA_STYLE: TStringField
      FieldName = 'TA_STYLE'
      Origin = 'TA_STYLE'
      Size = 200
    end
    object TaskTabTA_STYLE_CLID: TStringField
      FieldName = 'TA_STYLE_CLID'
      Origin = 'TA_STYLE_CLID'
      Size = 38
    end
    object TaskTabTA_REM: TStringField
      FieldName = 'TA_REM'
      Origin = 'TA_REM'
      Size = 256
    end
    object TaskTabTA_COLOR: TIntegerField
      FieldName = 'TA_COLOR'
      Origin = 'TA_COLOR'
    end
    object TaskTabTA_DELETED: TStringField
      FieldName = 'TA_DELETED'
      Origin = 'TA_DELETED'
      FixedChar = True
      Size = 1
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
    Left = 92
    Top = 161
  end
  object LogTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TaskLogSrc'
    RemoteServer = DSProviderConnection1
    Left = 100
    Top = 224
  end
end
