object LogFrame: TLogFrame
  Left = 0
  Top = 0
  Width = 858
  Height = 517
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 305
  object GroupBox3: TGroupBox
    Left = 673
    Top = 0
    Width = 185
    Height = 517
    Align = alRight
    Caption = 'Textbausteine'
    TabOrder = 0
    ExplicitLeft = 266
    ExplicitHeight = 305
    inline TextBlockFrame1: TTextBlockFrame
      Left = 2
      Top = 15
      Width = 181
      Height = 500
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 181
      ExplicitHeight = 288
      inherited Panel1: TPanel
        Top = 444
        Width = 181
        ExplicitLeft = 64
        ExplicitTop = 232
        ExplicitWidth = 181
        inherited LabeledEdit1: TLabeledEdit
          Width = 161
          OnKeyPress = TextBlockFrame1LabeledEdit1KeyPress
          ExplicitWidth = 161
        end
      end
      inherited LV: TListView
        Width = 181
        Height = 444
        ExplicitWidth = 181
        ExplicitHeight = 232
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 673
    Height = 517
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    ExplicitWidth = 266
    ExplicitHeight = 305
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 673
      Height = 97
      Align = alTop
      Caption = 'Aktuelle Informationen'
      TabOrder = 0
      ExplicitWidth = 266
      inline EditFrame1: TEditFrame
        Left = 2
        Top = 15
        Width = 669
        Height = 80
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 15
        ExplicitWidth = 262
        ExplicitHeight = 80
        inherited RE: TRichEdit
          Width = 669
          Height = 80
          ExplicitWidth = 262
          ExplicitHeight = 80
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 97
      Width = 673
      Height = 420
      Align = alClient
      Caption = 'Historie'
      TabOrder = 1
      ExplicitWidth = 266
      ExplicitHeight = 208
      object WebBrowser1: TWebBrowser
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 663
        Height = 397
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 541
        ExplicitHeight = 336
        ControlData = {
          4C00000086440000082900000000000000000000000000000000000000000000
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
