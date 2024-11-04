object MailMod: TMailMod
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 446
  Width = 598
  object IdIMAP41: TIdIMAP4
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    Port = 993
    UseTLS = utUseImplicitTLS
    SASLMechanisms = <>
    MilliSecsToWaitToClearBuffer = 10
    Left = 80
    Top = 16
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':993'
    MaxLineAction = maException
    Port = 993
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 80
    Top = 80
  end
  object TestMsg: TIdMessage
    AttachmentEncoding = 'UUE'
    Body.Strings = (
      'Das ist eine Testmail vom Archivar-Server')
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    Subject = 'Archivar-Server-Testmail'
    ConvertPreamble = True
    Left = 88
    Top = 184
  end
  object IdSMTP1: TIdSMTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL2
    MailAgent = 'archivar'
    HeloName = 'hallo'
    Port = 465
    SASLMechanisms = <>
    UseTLS = utUseImplicitTLS
    Left = 264
    Top = 16
  end
  object IdSSLIOHandlerSocketOpenSSL2: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':465'
    MaxLineAction = maException
    Port = 465
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 264
    Top = 80
  end
end
