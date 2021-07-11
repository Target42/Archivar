object FileServer: TFileServer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 313
  Width = 463
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    OnCommandGet = IdHTTPServer1CommandGet
    Left = 56
    Top = 56
  end
  object JvComputerInfoEx1: TJvComputerInfoEx
    Left = 256
    Top = 96
  end
  object PageProducer1: TPageProducer
    OnHTMLTag = PageProducer1HTMLTag
    Left = 152
    Top = 64
  end
end
