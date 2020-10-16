inherited ReportFrameEditorImg: TReportFrameEditorImg
  ExplicitWidth = 451
  ExplicitHeight = 305
  object Image1: TImage [0]
    Left = 0
    Top = 21
    Width = 451
    Height = 243
    Align = alClient
    ExplicitLeft = 40
    ExplicitTop = 80
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  inherited Panel1: TPanel
    Width = 451
    ExplicitWidth = 451
    inherited SpeedButton1: TSpeedButton
      Left = 425
      ExplicitLeft = 425
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 264
    Width = 451
    Height = 41
    Align = alBottom
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 16
      Top = 6
      Width = 97
      Height = 25
      Caption = 'Bild ausw'#228'hlen'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 160
    Top = 104
  end
end
