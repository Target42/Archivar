object HttpMod: THttpMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 399
  Width = 514
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    IOHandler = IdServerIOHandlerStack1
    Scheduler = IdSchedulerOfThreadDefault1
    OnCommandGet = IdHTTPServer1CommandGet
    Left = 72
    Top = 32
  end
  object IdSchedulerOfThreadDefault1: TIdSchedulerOfThreadDefault
    MaxThreads = 0
    Left = 80
    Top = 112
  end
  object PageProducer1: TPageProducer
    HTMLDoc.Strings = (
      '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'
      '<html>'
      '<head>'
      '<style>'
      ''
      '.center {'
      '  display: block;'
      '  margin-left: auto;'
      '  margin-right: auto;'
      '  width: 50%;'
      '}'
      '<.style>'
      '</head>'
      ''
      ''
      '<body>'
      ''
      ''
      '<h1>Archivar</h1>'
      ''
      ''
      ' <img src="/logo.png" alt="logo" class="center"> '
      '<br>'
      ''
      ''
      'Den <a href="launcher.zip">Launcher</a> (Speichern unter)auf die'
      
        'Platte kopieren, Auspacken und starten. Dann wird das eigentlich' +
        'e Download-Tool gestartet. Wichtig: Host :<span style="font-weig' +
        'ht: bold; color: rgb(255, 0, 0);"> target42.de</span><br>'
      ''
      ''
      '<br>'
      'Die User haben alle keine Passworte.<br>'
      '<br>'
      'Ablage ist normal: c:\berofice\<br>'
      'AdminDaten:<br>'
      '<br>'
      ''
      ''
      'host :target42.de<br>'
      ''
      ''
      'user: admin<br>'
      '<br>'
      'Das ist eine allererste Installation.<br>'
      ''
      ''
      '<br>'
      ''
      ''
      '</body>'
      '</html>')
    OnHTMLTag = PageProducer1HTMLTag
    Left = 232
    Top = 48
  end
  object IdServerIOHandlerStack1: TIdServerIOHandlerStack
    Left = 80
    Top = 176
  end
end
