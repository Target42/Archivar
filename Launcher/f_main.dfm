object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Launcher Archivar'
  ClientHeight = 275
  ClientWidth = 610
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
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 610
    Height = 190
    Align = alClient
    ExplicitLeft = 120
    ExplicitTop = 88
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 256
    Width = 610
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitTop = 90
    ExplicitWidth = 635
  end
  object Panel1: TPanel
    Left = 0
    Top = 190
    Width = 610
    Height = 66
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    ExplicitTop = 224
    ExplicitWidth = 635
    DesignSize = (
      610
      66)
    object SpeedButton1: TSpeedButton
      Left = 500
      Top = 18
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Caption = '...'
      OnClick = SpeedButton1Click
      ExplicitLeft = 479
    end
    object ProgressBar1: TProgressBar
      AlignWithMargins = True
      Left = 3
      Top = 46
      Width = 604
      Height = 17
      Align = alBottom
      TabOrder = 0
      ExplicitTop = 229
      ExplicitWidth = 629
    end
    object BitBtn1: TBitBtn
      Left = 532
      Top = 15
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Start'
      TabOrder = 1
      OnClick = BitBtn1Click
      ExplicitLeft = 557
    end
    object LabeledEdit1: TLabeledEdit
      Left = 3
      Top = 19
      Width = 491
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 80
      EditLabel.Height = 13
      EditLabel.Caption = 'Installationspfad'
      TabOrder = 2
      ExplicitWidth = 470
    end
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}'
      'DSAuthenticationPassword=qwertzuiopmnbvcxy1234'
      'DSAuthenticationUser=qwertzuiopmnbvcxy1234')
    AfterConnect = SQLConnection1AfterConnect
    AfterDisconnect = SQLConnection1AfterDisconnect
    Left = 424
    Top = 24
    UniqueId = '{56E10D53-2180-4F5F-9025-8396D8CF4797}'
  end
  object JvCreateProcess1: TJvCreateProcess
    CreationFlags = [cfUnicode, cfDetached]
    WaitForTerminate = False
    Left = 240
    Top = 16
  end
  object JvBrowseForFolderDialog1: TJvBrowseForFolderDialog
    Title = 'Installationspfad'
    Left = 432
    Top = 128
  end
end
