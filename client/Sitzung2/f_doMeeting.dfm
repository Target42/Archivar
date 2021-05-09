object DoMeetingform: TDoMeetingform
  Left = 0
  Top = 0
  Caption = 'Sitzung'
  ClientHeight = 562
  ClientWidth = 902
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 543
    Width = 902
    Height = 19
    Panels = <>
    ExplicitTop = 280
    ExplicitWidth = 667
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 902
    Height = 543
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 667
    ExplicitHeight = 280
    object TabSheet1: TTabSheet
      Caption = 'Tagesordnung'
      ExplicitWidth = 659
      ExplicitHeight = 252
    end
    object TabSheet2: TTabSheet
      Caption = 'Abstimung'
      ImageIndex = 1
      ExplicitWidth = 659
      ExplicitHeight = 252
    end
    object TabSheet3: TTabSheet
      Caption = 'Sitzungsleitung'
      ImageIndex = 2
      ExplicitLeft = 8
      ExplicitTop = 22
      ExplicitWidth = 659
      ExplicitHeight = 252
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 894
        Height = 515
        ActivePage = TabSheet6
        Align = alClient
        TabOrder = 0
        object TabSheet4: TTabSheet
          Caption = 'Allgemeines'
          ExplicitWidth = 281
          ExplicitHeight = 165
        end
        object TabSheet5: TTabSheet
          Caption = 'Teilnehmer'
          ImageIndex = 1
          ExplicitWidth = 651
          ExplicitHeight = 224
          inline TNFrame1: TTNFrame
            Left = 0
            Top = 0
            Width = 886
            Height = 487
            Align = alClient
            TabOrder = 0
            inherited Splitter4: TSplitter
              Height = 487
            end
            inherited GroupBox4: TGroupBox
              Height = 487
              ExplicitTop = 0
              ExplicitHeight = 316
              inherited LVGremium: TListView
                Height = 464
                OnCustomDraw = nil
                OnCustomDrawItem = nil
                OnDblClick = nil
                OnDragOver = nil
                ExplicitHeight = 293
              end
            end
            inherited Panel4: TPanel
              Width = 546
              Height = 487
              ExplicitTop = 0
              ExplicitWidth = 476
              ExplicitHeight = 316
              inherited Splitter5: TSplitter
                Top = 295
                Width = 546
              end
              inherited GroupBox5: TGroupBox
                Width = 546
                Height = 295
                ExplicitWidth = 476
                ExplicitHeight = 124
                inherited LVAbwesend: TListView
                  Width = 497
                  Height = 272
                  OnCustomDraw = nil
                  OnCustomDrawItem = nil
                  OnDblClick = nil
                  OnDragOver = nil
                  ExplicitWidth = 427
                  ExplicitHeight = 101
                end
                inherited Panel1: TPanel
                  Height = 278
                  ExplicitHeight = 107
                end
              end
              inherited GroupBox6: TGroupBox
                Top = 298
                Width = 546
                ExplicitTop = 127
                ExplicitWidth = 476
                inherited LVNichtabgestimmt: TListView
                  Width = 497
                  OnCustomDraw = nil
                  OnCustomDrawItem = nil
                  OnDblClick = nil
                  OnDragOver = nil
                  ExplicitWidth = 427
                end
              end
            end
          end
        end
        object TabSheet6: TTabSheet
          Caption = 'G'#228'ste'
          ImageIndex = 2
        end
      end
    end
  end
end
