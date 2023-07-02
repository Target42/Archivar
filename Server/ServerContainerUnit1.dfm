object ArchivService: TArchivService
  OldCreateOrder = False
  OnCreate = ServiceCreate
  OnDestroy = ServiceDestroy
  DisplayName = 'ArchivarService'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 744
  Width = 415
  object DSServer1: TDSServer
    OnConnect = DSServer1Connect
    OnDisconnect = DSServer1Disconnect
    OnError = DSServer1Error
    AutoStart = False
    OnTrace = DSServer1Trace
    Left = 32
    Top = 19
  end
  object DSTCPServerTransport1: TDSTCPServerTransport
    Server = DSServer1
    Filters = <
      item
        FilterId = 'ZLibCompression'
        Properties.Strings = (
          'CompressMoreThan=1024')
      end
      item
        FilterId = 'RSA'
        Properties.Strings = (
          'UseGlobalKey=true'
          'KeyLength=1024'
          'KeyExponent=3')
      end
      item
        FilterId = 'PC1'
        Properties.Strings = (
          'Key=ZLEnCSOPql7fX1Em')
      end>
    AuthenticationManager = DSAuthenticationManager1
    OnConnect = DSTCPServerTransport1Connect
    OnDisconnect = DSTCPServerTransport1Disconnect
    KeepAliveEnablement = kaEnabled
    KeepAliveTime = 10000
    Left = 32
    Top = 73
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
    Left = 32
    Top = 128
  end
  object dsPerson: TDSServerClass
    OnGetClass = dsPersonGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 328
    Top = 120
  end
  object dsTask: TDSServerClass
    OnGetClass = dsTaskGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 328
    Top = 176
  end
  object dsFile: TDSServerClass
    OnGetClass = dsFileGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 328
    Top = 232
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
    Top = 64
  end
  object dsImage: TDSServerClass
    OnGetClass = dsImageGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 256
    Top = 120
  end
  object dsChapter: TDSServerClass
    OnGetClass = dsChapterGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 256
    Top = 176
  end
  object dsTaskEdit: TDSServerClass
    OnGetClass = dsTaskEditGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 256
    Top = 232
  end
  object dsTemplate: TDSServerClass
    OnGetClass = dsTemplateGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 328
    Top = 288
  end
  object dsTaskView: TDSServerClass
    OnGetClass = dsTaskViewGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 256
    Top = 288
  end
  object dsTextBlock: TDSServerClass
    OnGetClass = dsTextBlockGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 328
    Top = 400
  end
  object dsFileCache: TDSServerClass
    OnGetClass = dsFileCacheGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 256
    Top = 344
  end
  object dsEpub: TDSServerClass
    OnGetClass = dsEpubGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 328
    Top = 344
  end
  object dsMeeing: TDSServerClass
    OnGetClass = dsMeeingGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 256
    Top = 400
  end
  object dsSitzung: TDSServerClass
    OnGetClass = dsSitzungGetClass
    Server = DSServer1
    Left = 328
    Top = 464
  end
  object dsUpdater: TDSServerClass
    OnGetClass = dsUpdaterGetClass
    Server = DSServer1
    Left = 176
    Top = 8
  end
  object ServerContainerTransaction: TFDTransaction
    Options.AutoStop = False
    Options.EnableNested = False
    Connection = DBMod.ArchivarConnection
    Left = 24
    Top = 360
  end
  object QueryUser: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = ServerContainerTransaction
    SQL.Strings = (
      'select * from PE_PERSON'
      'where PE_NET = :net')
    Left = 24
    Top = 424
    ParamData = <
      item
        Name = 'NET'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object GRPEQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = ServerContainerTransaction
    SQL.Strings = (
      'select count(*) from gr_pa'
      'where pe_id = :pe_id')
    Left = 24
    Top = 472
    ParamData = <
      item
        Name = 'PE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object dsStammData: TDSServerClass
    OnGetClass = dsStammDataGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 256
    Top = 464
  end
  object dsPKI: TDSServerClass
    OnGetClass = dsPKIGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 256
    Top = 520
  end
  object dsDairy: TDSServerClass
    OnGetClass = dsDairyGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 320
    Top = 520
  end
  object dsStorage: TDSServerClass
    OnGetClass = dsStorageGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 328
    Top = 576
  end
  object DSHTTPService1: TDSHTTPService
    HttpPort = 8088
    Filters = <
      item
        FilterId = 'ZLibCompression'
        Properties.Strings = (
          'CompressMoreThan=1024')
      end
      item
        FilterId = 'RSA'
        Properties.Strings = (
          'UseGlobalKey=true'
          'KeyLength=1024'
          'KeyExponent=3')
      end
      item
        FilterId = 'PC1'
        Properties.Strings = (
          'Key=ai7ggYdY!fJ6eFB4')
      end>
    AuthenticationManager = DSAuthenticationManager1
    Left = 32
    Top = 192
  end
  object DSHTTPService2: TDSHTTPService
    HttpPort = 8089
    CertFiles = DSCertFiles1
    Filters = <
      item
        FilterId = 'ZLibCompression'
        Properties.Strings = (
          'CompressMoreThan=1024')
      end
      item
        FilterId = 'RSA'
        Properties.Strings = (
          'UseGlobalKey=true'
          'KeyLength=1024'
          'KeyExponent=3')
      end
      item
        FilterId = 'PC1'
        Properties.Strings = (
          'Key=XUgQukpi8QcJXasj')
      end>
    AuthenticationManager = DSAuthenticationManager1
    Left = 32
    Top = 240
  end
  object DSCertFiles1: TDSCertFiles
    OnGetPEMFilePasskey = DSCertFiles1GetPEMFilePasskey
    Left = 32
    Top = 296
  end
  object dsPlugin: TDSServerClass
    OnGetClass = dsPluginGetClass
    Server = DSServer1
    Left = 256
    Top = 576
  end
  object dsImport: TDSServerClass
    OnGetClass = dsImportGetClass
    Server = DSServer1
    Left = 256
    Top = 632
  end
  object dsMail: TDSServerClass
    OnGetClass = dsMailGetClass
    Server = DSServer1
    Left = 328
    Top = 640
  end
  object MailKonto: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = ServerContainerTransaction
    UpdateOptions.UpdateTableName = 'MAC_MAIL_ACCOUNT'
    TableName = 'MAC_MAIL_ACCOUNT'
    Left = 24
    Top = 528
  end
end
