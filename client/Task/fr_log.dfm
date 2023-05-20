object LogFrame: TLogFrame
  Left = 0
  Top = 0
  Width = 1054
  Height = 377
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 305
  object GroupBox3: TGroupBox
    Left = 869
    Top = 0
    Width = 185
    Height = 377
    Align = alRight
    Caption = 'Textbausteine'
    TabOrder = 0
    ExplicitLeft = 266
    ExplicitHeight = 305
    inline TextBlockFrame1: TTextBlockFrame
      Left = 2
      Top = 15
      Width = 181
      Height = 360
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 181
      ExplicitHeight = 288
      inherited Panel1: TPanel
        Top = 304
        Width = 181
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
        Height = 304
        ExplicitWidth = 181
        ExplicitHeight = 232
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 869
    Height = 377
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
      Width = 869
      Height = 121
      Align = alTop
      Caption = 'Aktuelle Informationen'
      TabOrder = 0
      ExplicitWidth = 266
      inline EditFrame1: TEditFrame
        Left = 2
        Top = 15
        Width = 865
        Height = 104
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 15
        ExplicitWidth = 262
        ExplicitHeight = 104
        inherited RE: TRichEdit
          Width = 865
          Height = 70
          OnDragDrop = Memo1DragDrop
          OnDragOver = Memo1DragOver
          ExplicitWidth = 262
          ExplicitHeight = 70
        end
        inherited Panel1: TPanel
          Width = 865
          ExplicitWidth = 262
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 121
      Width = 869
      Height = 256
      Align = alClient
      Caption = 'Historie'
      TabOrder = 1
      ExplicitWidth = 266
      ExplicitHeight = 184
      object WebBrowser1: TWebBrowser
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 859
        Height = 233
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 917
        ExplicitHeight = 404
        ControlData = {
          4C000000C8580000151800000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object RichEdit1: TRichEdit
        Left = 56
        Top = 136
        Width = 185
        Height = 89
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          'RichEdit1')
        ParentFont = False
        TabOrder = 1
        Visible = False
        Zoom = 100
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
    Left = 32
    Top = 136
  end
  object JvRichEditToHtml1: TJvRichEditToHtml
    Footer.Strings = (
      '')
    Left = 96
    Top = 169
    Header.Strings = ()
  end
end
