object LogFrame: TLogFrame
  Left = 0
  Top = 0
  Width = 736
  Height = 456
  Align = alClient
  TabOrder = 0
  ExplicitHeight = 315
  object GroupBox3: TGroupBox
    Left = 551
    Top = 0
    Width = 185
    Height = 456
    Align = alRight
    Caption = 'Textbausteine'
    TabOrder = 0
    ExplicitLeft = 568
    ExplicitTop = 168
    ExplicitHeight = 105
    inline TextBlockFrame1: TTextBlockFrame
      Left = 2
      Top = 15
      Width = 181
      Height = 439
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = 17
      ExplicitWidth = 181
      ExplicitHeight = 439
      inherited Panel1: TPanel
        Top = 383
        Width = 181
        ExplicitTop = 400
        ExplicitWidth = 736
        inherited LabeledEdit1: TLabeledEdit
          Width = 0
        end
      end
      inherited LV: TListView
        Width = 181
        Height = 383
        ExplicitWidth = 181
        ExplicitHeight = 383
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 551
    Height = 456
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    ExplicitWidth = 145
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 551
      Height = 97
      Align = alTop
      Caption = 'Aktuelle Informationen'
      TabOrder = 0
      ExplicitLeft = -336
      ExplicitWidth = 481
      inline EditFrame1: TEditFrame
        Left = 2
        Top = 15
        Width = 547
        Height = 80
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 17
        ExplicitWidth = 547
        ExplicitHeight = 80
        inherited RE: TRichEdit
          Width = 547
          Height = 80
          ExplicitWidth = 736
          ExplicitHeight = 456
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 97
      Width = 551
      Height = 359
      Align = alClient
      Caption = 'Historie'
      TabOrder = 1
      ExplicitLeft = 80
      ExplicitTop = 159
      ExplicitWidth = 185
      ExplicitHeight = 105
      object WebBrowser1: TWebBrowser
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 541
        Height = 336
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 300
        ExplicitHeight = 150
        ControlData = {
          4C000000EA370000BA2200000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
  end
  object PageProducer1: TPageProducer
    HTMLDoc.Strings = (
      '<p>'
      '<b><#user> am <#date> um <#time>:</b><br>'
      '<#rem>'
      '</p>'
      '<hr>')
    OnHTMLTag = PageProducer1HTMLTag
    Left = 592
    Top = 88
  end
end
