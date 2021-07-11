object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Launcher Archivar'
  ClientHeight = 299
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
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 280
    Width = 635
    Height = 19
    Panels = <>
  end
  object BitBtn1: TBitBtn
    Left = 248
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = BitBtn1Click
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
    Left = 56
    Top = 32
    UniqueId = '{56E10D53-2180-4F5F-9025-8396D8CF4797}'
  end
end
