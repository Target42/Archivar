object ArchivarGuard: TArchivarGuard
  OnCreate = ServiceCreate
  DisplayName = 'ArchivarGuard'
  ServiceStartName = 'ArchivarGuard'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 262
  Width = 343
  object IdHTTP1: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 72
    Top = 88
  end
end
