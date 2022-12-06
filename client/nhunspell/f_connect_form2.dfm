object FullCorrectForm: TFullCorrectForm
  Left = 0
  Top = 0
  Caption = 'Rechtschreibkorrektur'
  ClientHeight = 413
  ClientWidth = 947
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 257
    Top = 0
    Height = 353
    ExplicitLeft = 296
    ExplicitTop = 72
    ExplicitHeight = 100
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 394
    Width = 947
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 353
    Width = 947
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      947
      41)
    object BitBtn1: TBitBtn
      Left = 16
      Top = 10
      Width = 75
      Height = 25
      Kind = bkAbort
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 864
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 260
    Top = 0
    Width = 687
    Height = 353
    Align = alClient
    Caption = 'Text'
    TabOrder = 3
    object RichEdit1: TRichEdit
      Left = 2
      Top = 15
      Width = 683
      Height = 336
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      HideSelection = False
      Lines.Strings = (
        'RichEdit1')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      Zoom = 100
    end
  end
  object GroupBox1: TPanel
    Left = 0
    Top = 0
    Width = 257
    Height = 353
    Align = alLeft
    ParentColor = True
    TabOrder = 2
    object GroupBox3: TGroupBox
      Left = 1
      Top = 1
      Width = 255
      Height = 88
      Align = alTop
      Caption = 'Wort'
      TabOrder = 0
      object Edit1: TEdit
        Left = 16
        Top = 24
        Width = 193
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
      end
      object BitBtn3: TBitBtn
        Left = 16
        Top = 51
        Width = 75
        Height = 25
        Caption = 'Ersetzen'
        TabOrder = 1
        OnClick = BitBtn3Click
      end
    end
    object GroupBox4: TGroupBox
      Left = 1
      Top = 89
      Width = 255
      Height = 163
      Align = alClient
      Caption = 'Vorschl'#228'ge'
      TabOrder = 1
      object LB: TListBox
        Left = 2
        Top = 15
        Width = 251
        Height = 146
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = LBDblClick
      end
    end
    object GroupBox5: TGroupBox
      Left = 1
      Top = 252
      Width = 255
      Height = 100
      Align = alBottom
      Caption = 'Aktionen'
      TabOrder = 2
      object BitBtn4: TBitBtn
        Left = 16
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Start'
        TabOrder = 0
        OnClick = BitBtn4Click
      end
      object BitBtn5: TBitBtn
        Left = 16
        Top = 55
        Width = 75
        Height = 25
        Caption = 'Position'
        TabOrder = 1
        OnClick = BitBtn5Click
      end
      object BitBtn6: TBitBtn
        Left = 97
        Top = 40
        Width = 75
        Height = 25
        Caption = 'Weiter'
        TabOrder = 2
        OnClick = BitBtn6Click
      end
      object BitBtn7: TBitBtn
        Left = 178
        Top = 40
        Width = 75
        Height = 25
        Caption = 'Hinzuf'#252'gen'
        TabOrder = 3
        OnClick = BitBtn7Click
      end
    end
  end
end
