object TextBlockParameterForm: TTextBlockParameterForm
  Left = 0
  Top = 0
  ActiveControl = SG
  Caption = 'Textblockparameter'
  ClientHeight = 299
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 239
    Width = 359
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 239
    ExplicitWidth = 359
    inherited StatusBar1: TStatusBar
      Width = 359
      ExplicitWidth = 359
    end
    inherited Panel1: TPanel
      Width = 359
      ExplicitWidth = 359
      inherited OKBtn: TBitBtn
        Left = 260
        Default = False
        Kind = bkCustom
        ModalResult = 0
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 260
      end
    end
  end
  object SG: TStringGrid
    Left = 0
    Top = 0
    Width = 359
    Height = 239
    Align = alClient
    ColCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goAlwaysShowEditor]
    TabOrder = 1
    OnKeyPress = SGKeyPress
    OnSelectCell = SGSelectCell
  end
end
