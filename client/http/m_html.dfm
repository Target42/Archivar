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
      '<head>'
      '<link rel="stylesheet" type="text/css" href="/css/archivar.css">'
      '</head>'
      '<body>'
      ''
      '<#data>'
      ''
      ''
      '</body>')
    OnHTMLTag = FrameHTMLTag
    Left = 24
    Top = 8
  end
  object JvRichEditToHtml1: TJvRichEditToHtml
    Left = 128
    Top = 112
  end
end
