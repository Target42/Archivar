object LogFrame: TLogFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object GroupBox3: TGroupBox
    Left = 266
    Top = 0
    Width = 185
    Height = 305
    Align = alRight
    Caption = 'Textbausteine'
    TabOrder = 0
    inline TextBlockFrame1: TTextBlockFrame
      Left = 2
      Top = 15
      Width = 181
      Height = 288
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 181
      ExplicitHeight = 288
      inherited Panel1: TPanel
        Top = 232
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
        Height = 232
        ExplicitWidth = 181
        ExplicitHeight = 232
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 266
    Height = 305
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 266
      Height = 97
      Align = alTop
      Caption = 'Aktuelle Informationen'
      TabOrder = 0
      inline EditFrame1: TEditFrame
        Left = 2
        Top = 15
        Width = 262
        Height = 80
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 15
        ExplicitWidth = 262
        ExplicitHeight = 80
        inherited RE: TRichEdit
          Width = 262
          Height = 31
          ExplicitLeft = 0
          ExplicitTop = 49
          ExplicitWidth = 262
          ExplicitHeight = 31
        end
        inherited GroupBox1: TGroupBox
          Width = 262
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 97
      Width = 266
      Height = 208
      Align = alClient
      Caption = 'Historie'
      TabOrder = 1
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
