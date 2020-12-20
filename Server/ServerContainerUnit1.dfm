object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  OnCreate = ServiceCreate
  DisplayName = 'ServerContainer1'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 462
  Width = 415
  object DSServer1: TDSServer
    OnConnect = DSServer1Connect
    OnDisconnect = DSServer1Disconnect
    OnError = DSServer1Error
    AutoStart = False
    Left = 56
    Top = 11
  end
  object DSTCPServerTransport1: TDSTCPServerTransport
    Server = DSServer1
    Filters = <
      item
        FilterId = 'PC1'
        Properties.Strings = (
          'Key=V4meLxEoz66rwsj7')
      end
      item
        FilterId = 'RSA'
        Properties.Strings = (
          'UseGlobalKey=true'
          'KeyLength=1024'
          'KeyExponent=3')
      end
      item
        FilterId = 'ZLibCompression'
        Properties.Strings = (
          'CompressMoreThan=1024')
      end>
    AuthenticationManager = DSAuthenticationManager1
    OnConnect = DSTCPServerTransport1Connect
    OnDisconnect = DSTCPServerTransport1Disconnect
    Left = 56
    Top = 65
  end
  object dsAdmin: TDSServerClass
    OnGetClass = dsAdminGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 328
    Top = 11
  end
  object dsGremium: TDSServerClass
    OnGetClass = dsGremiumGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 328
    Top = 64
  end
  object DSAuthenticationManager1: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManager1UserAuthenticate
    OnUserAuthorize = DSAuthenticationManager1UserAuthorize
    Roles = <>
    Left = 56
    Top = 128
  end
  object dsPerson: TDSServerClass
    OnGetClass = dsPersonGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 328
    Top = 128
  end
  object dsTask: TDSServerClass
    OnGetClass = dsTaskGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 328
    Top = 184
  end
  object QueryUser: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from PE_PERSON'
      'where PE_NET = :net')
    Left = 56
    Top = 192
    ParamData = <
      item
        DataType = ftString
        Name = 'net'
        ParamType = ptInput
      end>
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 120
    Top = 192
  end
  object dsFile: TDSServerClass
    OnGetClass = dsFileGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 328
    Top = 248
  end
  object dsMisc: TDSServerClass
    OnGetClass = dsMiscGetClass
    Server = DSServer1
    Left = 256
    Top = 8
  end
  object dsProtocol: TDSServerClass
    OnGetClass = dsProtocolGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 256
    Top = 128
  end
  object dsImage: TDSServerClass
    OnGetClass = dsImageGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 256
    Top = 192
  end
  object dsChapter: TDSServerClass
    OnGetClass = dsChapterGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 256
    Top = 248
  end
  object dsTaskEdit: TDSServerClass
    OnGetClass = dsTaskEditGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 256
    Top = 304
  end
  object dsTemplate: TDSServerClass
    OnGetClass = dsTemplateGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 336
    Top = 312
  end
  object dsTaskView: TDSServerClass
    OnGetClass = dsTaskViewGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 264
    Top = 376
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    Left = 336
    Top = 392
  end
  object dsFileCache: TDSServerClass
    OnGetClass = dsFileCacheGetClass
    Server = DSServer1
    Left = 176
    Top = 384
  end
end
