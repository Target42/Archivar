object HtmlMod: THtmlMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 192
  Width = 251
  object PageProducer1: TPageProducer
    OnHTMLTag = PageProducer1HTMLTag
    Left = 88
    Top = 8
  end
  object Frame: TPageProducer
    HTMLDoc.Strings = (
      '<!DOCTYPE html>'
      '<html>'
      '  <head>'
      
        '    <link rel="stylesheet" type="text/css" href="/css/archivar.c' +
        'ss">'
      '  </head>'
      '<body>'
      '  <div id="data">'
      '    <#data>'
      '  </div>'
      '</body>'
      '</html>')
    OnHTMLTag = FrameHTMLTag
    Left = 24
    Top = 8
  end
end
