object MailClientForm: TMailClientForm
  Left = 0
  Top = 0
  Caption = 'Mails'
  ClientHeight = 560
  ClientWidth = 953
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 248
    Top = 48
    Width = 16
    Height = 16
    AutoSize = True
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000
      001008060000001FF3FF6100000006624B474400FF00FF00FFA0BDA793000002
      964944415478DA8D925B48146114C7CFF9666746F3426446510415BD16486829
      5D84C0D6BD8C214A840FD183504FF660B2176240DD35A197022DA1A21E33BCEC
      0D51C8CA0A6F0FF5141181BD956061A6B5B3BBDFE9CC62B299521F7CC3CCF7CD
      F99DFFF99F83F09FABC11CD96659991BFC5A4D0019247AB0A8178470B38053E6
      785E7172E59EA23B5A7E2E64161D45F45C004E2920C29648150A123719F26253
      8011883F24492212763779FCF1DB08541209B91A0190EC7B4F30B20FA5F26443
      80E18F5FE1BFCEEB3F964F587905E724422BA6D315916E6329B7A4A495F9F017
      C008C64E93C4FB8E341E4B39323B10C48822E8E46087FBAD1188559284CBB62A
      AF2F768BD594FC01A80B260E48491392647DBEAEBEE30CB3487875385CFB7855
      F24B907091907623623B27295F03D499835BA5A54D72407051CF1F2AB6564609
      F05534541B74FA12A52AD22467EC240173286940B0CF4321D7EB2CA0A1E19192
      3C5818677FDE443A5D6D863FD1454087CAB419F7D442B9AA16D1187B32CB0A7A
      40C84920D9CC650CD8B15980E18B5DE36CC7BFE95B9CC5D6720D1FF72A9AE3C8
      A05933EFF5C77B1161BF96D61A938AF5941046A29D2EDF6FE5B86A5A8FAE2947
      FBCD335F38E023005D8884DCE39E40AC05089BD9972A45401F80D0CAB4E9B3A6
      69CA3500073C4312D787C3CE847DC0DF9F044AAF94B8C7562214AC64401310D4
      43265D95DBCA55406C49D70A76F59BD5DFB303E24BD4F1D0DCE1E2BEF26E0249
      7BB3201215435DCEB9F56DB715CC4B21AB621D9EF7EB2FDD6DD1C34211E33CB2
      C670D83DB1D1D0A13710EBE33A333CA697722FECD669483392A83D1A76DFDD6C
      E4D16346B7A325A6B94DA35C6B772AAD7ECE53533580D8CD8EF7E73ABE21C07E
      D4B6C677AA2AFA1952CF1D28E5A319DE26AB1A837FAC5FAF70291FA0B8783900
      00000049454E44AE426082}
    Visible = False
  end
  object Splitter2: TSplitter
    Left = 417
    Top = 0
    Height = 541
    ExplicitLeft = 832
    ExplicitTop = 80
    ExplicitHeight = 100
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 541
    Width = 953
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 417
    Height = 541
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 0
      Top = 160
      Width = 417
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 293
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 417
      Height = 160
      Align = alTop
      Caption = 'MailKonten'
      TabOrder = 0
      object TV: TTreeView
        Left = 2
        Top = 15
        Width = 413
        Height = 143
        Align = alClient
        Indent = 19
        TabOrder = 0
        OnChange = TVChange
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 163
      Width = 417
      Height = 378
      Align = alClient
      Caption = 'Mails'
      TabOrder = 1
      inline MailFrame1: TMailFrame
        Left = 2
        Top = 15
        Width = 413
        Height = 361
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 15
        ExplicitWidth = 413
        ExplicitHeight = 361
        inherited VST: TVirtualDrawTree
          Width = 413
          Height = 361
          OnChange = MailFrame1VSTChange
          ExplicitLeft = -1
          ExplicitTop = -4
          ExplicitWidth = 413
          ExplicitHeight = 361
        end
      end
    end
  end
  object WebBrowser1: TWebBrowser
    Left = 420
    Top = 0
    Width = 533
    Height = 541
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 616
    ExplicitTop = 88
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C00000016370000EA3700000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsMail'
    Left = 40
    Top = 24
  end
  object Accounts: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'MailAccount'
    RemoteServer = DSProviderConnection1
    Left = 112
    Top = 24
  end
  object Folder: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Mailfolder'
    RemoteServer = DSProviderConnection1
    Left = 168
    Top = 24
  end
  object Mails: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Mails'
    RemoteServer = DSProviderConnection1
    Left = 136
    Top = 80
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 264
    Top = 80
  end
end
