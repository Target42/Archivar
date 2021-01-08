object HttpMod: THttpMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 227
  Width = 309
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    DefaultPort = 42424
    OnCommandOther = IdHTTPServer1CommandOther
    OnParseAuthentication = IdHTTPServer1ParseAuthentication
    OnCommandGet = IdHTTPServer1CommandGet
    Left = 72
    Top = 56
  end
end
