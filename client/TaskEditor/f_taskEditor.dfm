object TaksEditorForm: TTaksEditorForm
  Left = 0
  Top = 0
  Caption = 'Aufgabeneditor'
  ClientHeight = 415
  ClientWidth = 635
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
    Top = 396
    Width = 635
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 635
    Height = 396
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Allgemeines'
      object Splitter1: TSplitter
        Left = 0
        Top = 215
        Width = 627
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 169
        ExplicitWidth = 156
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 627
        Height = 215
        Align = alClient
        Caption = 'Datenfelder'
        TabOrder = 0
        object LV: TListView
          Left = 2
          Top = 15
          Width = 623
          Height = 157
          Align = alClient
          Columns = <
            item
              Caption = 'Name'
              Width = 100
            end
            item
              Caption = 'Typ'
              Width = 70
            end
            item
              Caption = 'Erforderlich'
              Width = 70
            end
            item
              Caption = 'Tabelle'
            end
            item
              Caption = 'Beschreibung'
              Width = 150
            end>
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
        object Panel1: TPanel
          Left = 2
          Top = 172
          Width = 623
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'Panel1'
          ShowCaption = False
          TabOrder = 1
          object SpeedButton1: TSpeedButton
            Left = 584
            Top = 6
            Width = 23
            Height = 22
          end
          object BitBtn1: TBitBtn
            Left = 8
            Top = 6
            Width = 97
            Height = 25
            Caption = 'Neues Datenfeld'
            TabOrder = 0
            OnClick = BitBtn1Click
          end
          object BitBtn2: TBitBtn
            Left = 127
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Neue Tabelle'
            TabOrder = 1
            OnClick = BitBtn2Click
          end
          object BitBtn3: TBitBtn
            Left = 216
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Bearbeiten'
            TabOrder = 2
            OnClick = BitBtn3Click
          end
          object BitBtn4: TBitBtn
            Left = 312
            Top = 6
            Width = 75
            Height = 25
            Caption = 'L'#246'schen'
            TabOrder = 3
            OnClick = BitBtn4Click
          end
          object BitBtn5: TBitBtn
            Left = 408
            Top = 6
            Width = 113
            Height = 25
            Caption = 'Globales Datenfeld'
            TabOrder = 4
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 218
        Width = 627
        Height = 150
        Align = alBottom
        Caption = 'Beschreibung'
        TabOrder = 1
        inline EditFrame1: TEditFrame
          Left = 2
          Top = 15
          Width = 623
          Height = 133
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 2
          ExplicitTop = 15
          ExplicitWidth = 623
          ExplicitHeight = 133
          inherited RE: TRichEdit
            Width = 623
            Height = 133
            ExplicitWidth = 623
            ExplicitHeight = 133
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      inline EditorFrame1: TEditorFrame
        Left = 0
        Top = 0
        Width = 627
        Height = 368
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 627
        ExplicitHeight = 368
        inherited GroupBox2: TGroupBox
          Height = 368
          ExplicitHeight = 368
          inherited TV: TTreeView
            Height = 351
            ExplicitHeight = 351
          end
        end
        inherited EditPanel: TPanel
          Width = 257
          Height = 368
          ExplicitWidth = 257
          ExplicitHeight = 368
        end
        inherited Panel1: TPanel
          Left = 442
          Height = 368
          ExplicitLeft = 442
          ExplicitTop = 0
          ExplicitHeight = 368
        end
      end
    end
  end
end
