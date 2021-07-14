object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Launcher Archivar'
  ClientHeight = 109
  ClientWidth = 635
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
    Top = 90
    Width = 635
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object BitBtn1: TBitBtn
    Left = 24
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object ProgressBar1: TProgressBar
    AlignWithMargins = True
    Left = 3
    Top = 70
    Width = 629
    Height = 17
    Align = alBottom
    TabOrder = 2
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
end
