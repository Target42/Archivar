object MainSetupForm: TMainSetupForm
  Left = 0
  Top = 0
  ActiveControl = edHostname
  Caption = 'Setup'
  ClientHeight = 299
  ClientWidth = 558
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 280
    Width = 558
    Height = 19
    Panels = <>
  end
  object JvWizard1: TJvWizard
    Left = 0
    Top = 0
    Width = 558
    Height = 280
    ActivePage = ServerInfo
    ButtonBarHeight = 42
    ButtonStart.Caption = 'To &Start Page'
    ButtonStart.NumGlyphs = 1
    ButtonStart.Width = 85
    ButtonLast.Caption = 'To &Last Page'
    ButtonLast.NumGlyphs = 1
    ButtonLast.Width = 85
    ButtonBack.Caption = '< &Back'
    ButtonBack.NumGlyphs = 1
    ButtonBack.Width = 75
    ButtonNext.Caption = '&Next >'
    ButtonNext.NumGlyphs = 1
    ButtonNext.Width = 75
    ButtonFinish.Caption = '&Finish'
    ButtonFinish.NumGlyphs = 1
    ButtonFinish.Width = 75
    ButtonCancel.Caption = 'Abbrechen'
    ButtonCancel.NumGlyphs = 1
    ButtonCancel.ModalResult = 2
    ButtonCancel.Width = 75
    ButtonHelp.Caption = '&Hilfe'
    ButtonHelp.NumGlyphs = 1
    ButtonHelp.Width = 75
    ShowRouteMap = False
    OnFinishButtonClick = JvWizard1FinishButtonClick
    DesignSize = (
      558
      280)
    object WelcomePage: TJvWizardWelcomePage
      Header.Title.Color = clNone
      Header.Title.Text = 'Archrivar Setup'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Tahoma'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Installation und Initialisierung der Datenbank'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'Tahoma'
      Header.Subtitle.Font.Style = []
      Caption = 'WelcomePage'
    end
    object SearchGDS: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Pr'#252'fe FireBIRD'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Tahoma'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Suche fbclient.dll'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'Tahoma'
      Header.Subtitle.Font.Style = []
      Caption = 'SearchGDS'
      OnEnterPage = SearchGDSEnterPage
      object Memo1: TMemo
        Left = 0
        Top = 70
        Width = 558
        Height = 168
        Align = alClient
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object ServerInfo: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Serverinformationen'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Tahoma'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Details zum Datenbankserver'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'Tahoma'
      Header.Subtitle.Font.Style = []
      Caption = 'ServerInfo'
      OnEnterPage = ServerInfoEnterPage
      object edHostname: TLabeledEdit
        Left = 16
        Top = 96
        Width = 137
        Height = 21
        EditLabel.Width = 48
        EditLabel.Height = 13
        EditLabel.Caption = 'Hostname'
        TabOrder = 0
        Text = 'localhost'
      end
      object edDatabase: TLabeledEdit
        Left = 168
        Top = 96
        Width = 193
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = 'Datenbank'
        TabOrder = 1
        Text = 'd:\db\archivar.fdb'
      end
      object edDBUser: TLabeledEdit
        Left = 16
        Top = 144
        Width = 137
        Height = 21
        EditLabel.Width = 39
        EditLabel.Height = 13
        EditLabel.Caption = 'DB-User'
        TabOrder = 2
        Text = 'sysdba'
      end
      object edDBPwd: TLabeledEdit
        Left = 168
        Top = 144
        Width = 121
        Height = 21
        EditLabel.Width = 63
        EditLabel.Height = 13
        EditLabel.Caption = 'DB-Password'
        TabOrder = 3
        Text = 'masterkey'
      end
      object btnCreate: TBitBtn
        Left = 16
        Top = 184
        Width = 75
        Height = 25
        Caption = 'Erzeugen'
        TabOrder = 4
        OnClick = btnCreateClick
      end
      object esDSServer: TLabeledEdit
        Left = 376
        Top = 144
        Width = 41
        Height = 21
        EditLabel.Width = 108
        EditLabel.Height = 13
        EditLabel.Caption = 'Applikationsserverport'
        NumbersOnly = True
        TabOrder = 5
        Text = '211'
      end
    end
    object InitData: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Basisdaten'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Tahoma'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Anlegen der Basisdaten'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'Tahoma'
      Header.Subtitle.Font.Style = []
      Caption = 'InitData'
      OnEnterPage = InitDataEnterPage
      object Panel1: TPanel
        Left = 0
        Top = 197
        Width = 558
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 0
        object BitBtn1: TBitBtn
          Left = 16
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Erzeugen'
          TabOrder = 0
          OnClick = BitBtn1Click
        end
      end
      object LV: TListView
        Left = 0
        Top = 70
        Width = 558
        Height = 127
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 150
          end
          item
            Caption = 'Status'
            Width = 100
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
  end
  object ArchivarConnection: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Transaction = IBTransaction1
    Left = 46
    Top = 20
  end
  object TETab: TFDQuery
    Connection = ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT * FROM TE_TEMPLATE')
    Left = 406
    Top = 100
  end
  object PITab: TFDQuery
    Connection = ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT * FROM PI_PIC')
    Left = 483
    Top = 99
  end
  object IBTransaction1: TFDTransaction
    Connection = ArchivarConnection
    Left = 48
    Top = 72
  end
  object IBScript1: TFDScript
    SQLScripts = <>
    Connection = ArchivarConnection
    Transaction = IBTransaction1
    Params = <>
    Macros = <>
    Left = 408
    Top = 48
  end
  object AutoIncQry: TFDQuery
    Connection = ArchivarConnection
    Transaction = IBTransaction1
    Left = 496
    Top = 48
  end
  object FDTab: TFDQuery
    Connection = ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT * FROM FD_DELETE')
    Left = 402
    Top = 159
  end
  object TYTab: TFDQuery
    Connection = ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT * FROM TY_TASKTYPE')
    Left = 486
    Top = 159
  end
  object GRTab: TFDQuery
    Connection = ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT * FROM GR_GREMIUM')
    Left = 255
    Top = 108
  end
  object DATab: TFDQuery
    Connection = ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT * FROM DA_DATAFIELD')
    Left = 255
    Top = 167
  end
  object CreateDB: TFDScript
    SQLScripts = <>
    Connection = ArchivarConnection
    Transaction = IBTransaction1
    Params = <>
    Macros = <>
    Left = 192
    Top = 88
  end
end
