object TextBlockPreviewForm: TTextBlockPreviewForm
  Left = 0
  Top = 0
  Caption = 'Textblockansicht'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 280
    Width = 635
    Height = 19
    Panels = <>
  end
  inline EditFrame1: TEditFrame
    Left = 0
    Top = 0
    Width = 635
    Height = 280
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 635
    ExplicitHeight = 280
    inherited RE: TRichEdit
      Width = 635
      Height = 231
      ReadOnly = True
      ExplicitLeft = 0
      ExplicitTop = 49
      ExplicitWidth = 635
      ExplicitHeight = 231
    end
    inherited GroupBox1: TGroupBox
      Width = 635
      ExplicitWidth = 635
    end
  end
end
