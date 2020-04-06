object TaskEditForm: TTaskEditForm
  Left = 0
  Top = 0
  Caption = 'Aufgabe'
  ClientHeight = 385
  ClientWidth = 642
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 366
    Width = 642
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 642
    Height = 366
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Daten'
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 634
        Height = 338
        HorzScrollBar.Visible = False
        Align = alClient
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dateien'
      ImageIndex = 1
      inline FileFrame1: TFileFrame
        Left = 0
        Top = 0
        Width = 634
        Height = 338
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 634
        ExplicitHeight = 338
        inherited DBGrid1: TDBGrid
          Width = 634
          Height = 260
        end
        inherited GroupBox1: TGroupBox
          Top = 260
          Width = 634
          ExplicitTop = 260
          ExplicitWidth = 634
          inherited Panel1: TPanel
            Left = 513
            Color = clMoneyGreen
            ExplicitLeft = 513
          end
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 324
    Top = 104
    object Dokument1: TMenuItem
      Caption = 'Dokument'
      GroupIndex = 100
      object Bearbeiten1: TMenuItem
        Action = ac_bearbeiten
      end
      object Bearbeitenbeenden1: TMenuItem
        Action = ac_unlock
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Lesezeichenerstellen1: TMenuItem
        Caption = 'Lesezeichen erstellen'
        ShortCut = 120
        OnClick = Lesezeichenerstellen1Click
      end
    end
  end
  object ActionList1: TActionList
    Left = 436
    Top = 112
    object ac_bearbeiten: TAction
      Caption = 'Bearbeiten'
      ShortCut = 114
      OnExecute = ac_bearbeitenExecute
    end
    object ac_save: TAction
      Caption = 'ac_save'
    end
    object ac_unlock: TAction
      Caption = 'Bearbeiten beenden'
      ShortCut = 115
      OnExecute = ac_unlockExecute
    end
  end
end
