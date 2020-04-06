object GM: TGM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 238
  Width = 469
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
      'DSAuthenticationPassword=admim'
      'DSAuthenticationUser=admin')
    AfterConnect = SQLConnection1AfterConnect
    AfterDisconnect = SQLConnection1AfterDisconnect
    BeforeDisconnect = SQLConnection1BeforeDisconnect
    Left = 56
    Top = 32
    UniqueId = '{56E10D53-2180-4F5F-9025-8396D8CF4797}'
  end
  object DeleteTimesTab: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 152
    Top = 32
    object DeleteTimesTabFD_ID: TIntegerField
      FieldName = 'FD_ID'
    end
    object DeleteTimesTabFD_NAME: TStringField
      FieldName = 'FD_NAME'
      Size = 100
    end
    object DeleteTimesTabFD_MONATE: TIntegerField
      FieldName = 'FD_MONATE'
    end
  end
  object JvComputerInfoEx1: TJvComputerInfoEx
    Left = 64
    Top = 120
  end
  object DSClientCallbackChannelManager1: TDSClientCallbackChannelManager
    DSHostname = 'localhost'
    DSPort = '8021'
    CommunicationProtocol = 'tcp/ip'
    ChannelName = 'storage'
    ManagerId = '246585.16461.649512'
    UserName = '{E4DBFC6B-C573-47FF-AC01-9CE6C5F63DB9}'
    Password = 'dev'
    Left = 184
    Top = 158
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Left = 216
    Top = 32
  end
end
