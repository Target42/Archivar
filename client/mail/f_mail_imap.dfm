object MailimapConfigForm: TMailimapConfigForm
  Left = 0
  Top = 0
  Caption = 'IMAP/SMTP-Konfiguration'
  ClientHeight = 432
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 241
    Top = 115
    Height = 145
    ExplicitLeft = 320
    ExplicitTop = 144
    ExplicitHeight = 100
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 372
    Width = 544
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 374
    ExplicitWidth = 552
    inherited StatusBar1: TStatusBar
      Width = 552
      ExplicitWidth = 552
    end
    inherited Panel1: TPanel
      Width = 552
      ExplicitWidth = 552
      inherited OKBtn: TBitBtn
        Left = 453
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 453
      end
    end
  end
  object GroupBox6: TGroupBox
    Left = 0
    Top = 0
    Width = 544
    Height = 115
    Align = alTop
    Caption = 'IMAP4'
    TabOrder = 1
    ExplicitWidth = 552
    object LabeledEdit10: TLabeledEdit
      Left = 16
      Top = 80
      Width = 121
      Height = 21
      EditLabel.Width = 22
      EditLabel.Height = 13
      EditLabel.Caption = 'Host'
      TabOrder = 0
      Text = ''
    end
    object LabeledEdit11: TLabeledEdit
      Left = 143
      Top = 80
      Width = 34
      Height = 21
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = 'Port'
      TabOrder = 1
      Text = ''
    end
    object LabeledEdit12: TLabeledEdit
      Left = 16
      Top = 42
      Width = 225
      Height = 21
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = 'Username'
      TabOrder = 2
      Text = ''
    end
    object LabeledEdit13: TLabeledEdit
      Left = 247
      Top = 42
      Width = 290
      Height = 21
      EditLabel.Width = 44
      EditLabel.Height = 13
      EditLabel.Caption = 'Passwort'
      PasswordChar = '*'
      TabOrder = 3
      Text = ''
    end
    object BitBtn5: TBitBtn
      Left = 207
      Top = 80
      Width = 80
      Height = 25
      Caption = 'Test'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B2299B38B0279DABB1269D72FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B1279C55B0279CFFB0279DABFFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AD249B1CB1279C55B2299B38FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B2299B38B0279CAAB1269D72FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B1279D41B0279CFFB0279CBEFFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AE28A113B0279BF6B0279CFBAE26
        9D3CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B0279C84B0279CFFB027
        9CF1AF269C36FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AA00AA03B0279CA8B027
        9CFFB0279CEEB0289F2DFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AA00AA03AF27
        9CA3B0279CFFB0289BBBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00AF269C43B0269E4480008002FFFFFF00FFFFFF00AA22
        990FB0279CFFB0279CF3FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00B0279DE9B0279CFFAF289B33FFFFFF00FFFFFF00B028
        9F2DB0279CFFB0279CE6FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00B1269D99B0279CFFB0279CDCB1269D65AF289B66B127
        9CDDB0279CFFB1279C96FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00AA2B9C12B0279CC9B0279CFFB0279CFFB0279CFFB027
        9CFFB0289CC8AF209F10FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF0080008002AF289B59AF279C9DB1279B9CB126
        9C5880008002FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 4
      OnClick = BitBtn5Click
    end
  end
  object GroupBox7: TGroupBox
    Left = 0
    Top = 260
    Width = 544
    Height = 112
    Align = alBottom
    Caption = 'SMTP (Server)'
    TabOrder = 2
    ExplicitTop = 262
    ExplicitWidth = 552
    object LabeledEdit14: TLabeledEdit
      Left = 16
      Top = 72
      Width = 121
      Height = 21
      EditLabel.Width = 22
      EditLabel.Height = 13
      EditLabel.Caption = 'Host'
      TabOrder = 0
      Text = ''
    end
    object LabeledEdit15: TLabeledEdit
      Left = 159
      Top = 72
      Width = 34
      Height = 21
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = 'Port'
      TabOrder = 1
      Text = ''
    end
    object LabeledEdit16: TLabeledEdit
      Left = 16
      Top = 32
      Width = 225
      Height = 21
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = 'Username'
      TabOrder = 2
      Text = ''
    end
    object LabeledEdit17: TLabeledEdit
      Left = 257
      Top = 32
      Width = 280
      Height = 21
      EditLabel.Width = 44
      EditLabel.Height = 13
      EditLabel.Caption = 'Passwort'
      PasswordChar = '*'
      TabOrder = 3
      Text = ''
    end
    object BitBtn6: TBitBtn
      Left = 463
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Test'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B2299B38B0279DABB1269D72FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B1279C55B0279CFFB0279DABFFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AD249B1CB1279C55B2299B38FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B2299B38B0279CAAB1269D72FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B1279D41B0279CFFB0279CBEFFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AE28A113B0279BF6B0279CFBAE26
        9D3CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B0279C84B0279CFFB027
        9CF1AF269C36FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AA00AA03B0279CA8B027
        9CFFB0279CEEB0289F2DFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AA00AA03AF27
        9CA3B0279CFFB0289BBBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00AF269C43B0269E4480008002FFFFFF00FFFFFF00AA22
        990FB0279CFFB0279CF3FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00B0279DE9B0279CFFAF289B33FFFFFF00FFFFFF00B028
        9F2DB0279CFFB0279CE6FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00B1269D99B0279CFFB0279CDCB1269D65AF289B66B127
        9CDDB0279CFFB1279C96FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00AA2B9C12B0279CC9B0279CFFB0279CFFB0279CFFB027
        9CFFB0289CC8AF209F10FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF0080008002AF289B59AF279C9DB1279B9CB126
        9C5880008002FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 4
      OnClick = BitBtn6Click
    end
    object LabeledEdit18: TLabeledEdit
      Left = 207
      Top = 72
      Width = 250
      Height = 21
      EditLabel.Width = 77
      EditLabel.Height = 13
      EditLabel.Caption = 'Test-Empf'#228'nger'
      TabOrder = 5
      Text = ''
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 115
    Width = 241
    Height = 145
    Align = alLeft
    Caption = 'Ausgw'#228'hlte Ordner'
    TabOrder = 3
    object LB1: TListBox
      Left = 2
      Top = 15
      Width = 237
      Height = 128
      Align = alClient
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      OnDblClick = LB1DblClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 244
    Top = 115
    Width = 300
    Height = 145
    Align = alClient
    Caption = 'M'#246'gliche Ordner'
    TabOrder = 4
    object LB2: TListBox
      Left = 2
      Top = 15
      Width = 296
      Height = 128
      Align = alClient
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      OnDblClick = LB2DblClick
    end
  end
end
