object MailIMap: TMailIMap
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 317
  Width = 457
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
  object Msg: TIdMessage
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
    Left = 72
    Top = 142
  end
  object IdSMTP1: TIdSMTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL2
    MailAgent = 'archivar'
    HeloName = 'hallo'
    Port = 465
    SASLMechanisms = <>
    UseTLS = utUseImplicitTLS
    Left = 255
    Top = 24
  end
  object IdSSLIOHandlerSocketOpenSSL2: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':465'
    MaxLineAction = maException
    Port = 465
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 255
    Top = 72
  end
  object FolderQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = MailTransaction
    SQL.Strings = (
      'SELECT *'
      'FROM MAF_FOLDER '
      'where MAC_ID = :mac_id'
      'and MAF_ACTIVE = '#39'T'#39)
    Left = 200
    Top = 152
    ParamData = <
      item
        Name = 'MAC_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object MailTransaction: TFDTransaction
    Options.AutoStop = False
    Connection = DBMod.ArchivarConnection
    Left = 280
    Top = 152
  end
  object MailTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = MailTransaction
    UpdateOptions.UpdateTableName = 'MAM_MAIL'
    TableName = 'MAM_MAIL'
    Left = 200
    Top = 216
  end
  object AutoincQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = MailTransaction
    Left = 312
    Top = 216
  end
  object ListQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = MailTransaction
    SQL.Strings = (
      'SELECT MAM_ID, MAM_MSG_ID'
      'FROM MAM_MAIL'
      'where MAF_ID = :maf_id')
    Left = 392
    Top = 176
    ParamData = <
      item
        Name = 'MAF_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object DeleteQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = MailTransaction
    SQL.Strings = (
      'DELETE FROM MAM_MAIL a '
      'WHERE'
      '    a.MAM_ID = :MAM_ID')
    Left = 392
    Top = 232
    ParamData = <
      item
        Name = 'MAM_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
