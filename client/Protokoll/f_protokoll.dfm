object ProtokollForm: TProtokollForm
  Left = 0
  Top = 0
  Caption = 'Protokoll'
  ClientHeight = 372
  ClientWidth = 888
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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 353
    Width = 888
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 49
    Width = 888
    Height = 304
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Allgemines'
      object Splitter1: TSplitter
        Left = 209
        Top = 0
        Height = 276
        ExplicitLeft = 272
        ExplicitTop = 16
        ExplicitHeight = 100
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 209
        Height = 276
        Align = alLeft
        Caption = 'Hauptkapitel'
        TabOrder = 0
        object Panel2: TPanel
          Left = 2
          Top = 211
          Width = 205
          Height = 63
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'Panel2'
          ShowCaption = False
          TabOrder = 0
          object SpeedButton1: TSpeedButton
            Left = 16
            Top = 6
            Width = 23
            Height = 22
            Hint = 'Titel hinzuf'#252'gen'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004499440F47A0
              439B47A043ED47A043ED48A0439949A4490EFFFFFF00FFFFFF00FFFFFF00FFAA
              5503F5A442D6F5A542FFF5A542FFF5A542FFF5A542FFF5A542FF7FA242FF47A0
              43FF99CA97FF99CA97FF47A043FF56A142BDFFFFFF00FFFFFF00FFFFFF00F5A4
              4335F5A542FFF5A542FFF5A542FFF5A542FFF5A542FFD7A543FF47A043FF84C0
              82FFD6EAD6FFD6EAD6FF84C082FF47A043FF44A24429FFFFFF00FFFFFF00F6A4
              4038F6AE57CAF7B461D2F7B461D2F7B461D2F7B461D2BEAE58DF47A043FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF47A043FF469F4345FFFFFF00FFFFFF00FFFF
              FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFE9C689FF4BA145FF47A0
              43FFC2E0C1FFC2E0C1FF47A043FF47A043F946A24616FFFFFF00FFFFFF00FFFF
              FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFA7B76CFF47A0
              43FF6FB56CFF6FB56CFF47A043FE47A04373FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00F9C991ABF9CA90FFE8A55BFFE8A55BFFDF9241FFDF9241FFE39C4EFFC8BA
              74FF8FB162FF7EAD5BDD469F4345FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00F9C991ABF9CA90FFF0B875FFF0B875FFECAE68FFECAE68FFECAE68FFECAE
              68FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00F9C991ABF9CA90FFF0B875FFF0B875FFECAE68FFECAE68FFECAE68FFECAE
              68FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00F9C991ABF9CA90FFE8A55BFFE8A55BFFDF9240FFDF9240FFDF9240FFDF92
              40FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00F9C991ABF9CA90FFE8A55BFFE8A55BFFDF9240FFDF9240FFDF9240FFDF92
              40FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
              90FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
              90FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
              90FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton1Click
          end
          object SpeedButton2: TSpeedButton
            Left = 45
            Top = 6
            Width = 23
            Height = 22
            Hint = 'Titel bearbeiten'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003278889013ACE06C00AE
              FF13FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0011B0E56A06BBFFC60099
              FFCF0097FF16FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFE8DBC0FF24A3F5FF0098
              FFFF24A2F5FFE0D6C2FFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFDAD4C4FF1EA0
              F7FF0098FFFF2AA3F4FFDAD6C3B3FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFF2C797FFF2C797FFD57E24FFD57E24FFDA8A39FFE19A51FFDFD2
              BAFF25A2F5FF0098FFFF189EF9F31199F71EFFFFFF00FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFF2C797FFF2C797FFE0994FFFE0994FFFE0994FFFE0994FFFE099
              4FFFDAC8ACFF1FA1F7FF51AAE1F1C3BCB1CF7B7BDC1DFFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFF6D3A9FFF6D3A9FFEDBB85FFEDBB85FFEDBB85FFEDBB85FFEDBB
              85FFF6D3A9FFE4D8C1FFCAC3B3ED928FD3CB7373E683FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFF6D3A9FFF6D3A9FFEDBB85FFEDBB85FFEDBB85FFEDBB85FFEDBB
              85FFF6D3A9FFFBDEBBFFE8CFBFB47373E4856666CC05FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFF2C797FFF2C797FFE0984FFFE0984FFFE0984FFFE0984FFFE098
              4FFFF2C797FFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFF2C797FFF2C797FFE0984FFFE0984FFFE0984FFFE0984FFFE098
              4FFFF2C797FFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00EFC6
              A6CEFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDE
              BBFFFBDEBBFFFBDEBBFFEFC6A6CEFFFFFF00FFFFFF00FFFFFF00FFFFFF00DB9E
              83D0E4B092FFE4B092FFE4B092FFE4B092FFE4B092FFE4B092FFE4B092FFE4B0
              92FFE4B092FFE4B092FFDB9E83D0FFFFFF00FFFFFF00FFFFFF00FFFFFF00B651
              3FAAB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB551
              3FFFB5513FFFB5513FFFB6513FAAFFFFFF00FFFFFF00FFFFFF00FFFFFF00B351
              412FB4513F55B4513F55B4513F55B4513F55B4513F55B4513F55B4513F55B451
              3F55B4513F55B4513F55B351412FFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton2Click
          end
          object SpeedButton3: TSpeedButton
            Left = 74
            Top = 6
            Width = 23
            Height = 22
            Hint = 'Titel l'#246'schen'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003A42
              F71F3742F4873643F4A43644F36D2B55FF06FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003641F42F3643
              F4F13844F4FF3643F4FF3844F4FF3742F5C44040FF04FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFF6A6BE5FF5D67
              F6FFD4D7FDFF747DF8FFD4D7FDFF3845F4FF3544F565FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFF414BF1FF3844
              F4FFC2C6FCFFFCFCFFFF7B85F7FF3643F4FF3643F39BFFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFF2C797FFF2C797FFDD9244FFDD9244FFF0C28FFF555CEBFF5A65
              F6FFEFF0FEFFBBC0FBFFD7D9FDFF3845F4FF3642F57FFFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFF2C797FFF2C797FFE0994FFFE0994FFFE6A867FFAB9ED3FF3845
              F4FF5963F6FF3643F4FF5B66F6FF3643F4F13A42F71FFFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFF6D3A9FFF6D3A9FFF0C290FFF0C290FFF0C290FFF3C99AFFADA0
              D2FF555CEBFF474FEFFF5A5FEAEA3641F42FFFFFFF00FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFF6D3A9FFF6D3A9FFEDBB85FFEDBB85FFEDBB85FFEDBB85FFF7D5
              ADFFFBDEBBFFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFF2C797FFF2C797FFE0984FFFE0984FFFE0984FFFE0984FFFE098
              4FFFF2C797FFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFF2C797FFF2C797FFE0984FFFE0984FFFE0984FFFE0984FFFE098
              4FFFF2C797FFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
              BAABFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDE
              BBFFFBDEBBFFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00E2AB
              8FB1EABC9CE3EABC9CE3EABC9CE3EABC9CE3EABC9CE3EABC9CE3EABC9CE3EABC
              9CE3EABC9CE3EABC9CE3E2AB8FB1FFFFFF00FFFFFF00FFFFFF00FFFFFF00B651
              3FAAB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB551
              3FFFB5513FFFB5513FFFB6513FAAFFFFFF00FFFFFF00FFFFFF00FFFFFF00B351
              412FB4513F55B4513F55B4513F55B4513F55B4513F55B4513F55B4513F55B451
              3F55B4513F55B4513F55B351412FFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton3Click
          end
          object SpeedButton4: TSpeedButton
            Left = 128
            Top = 6
            Width = 23
            Height = 22
            Hint = 'Hoch'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00B6523F7DB5513FFFB5513FFFB5513FFFB5513FFFB551
              3FFFB5513FFFB550407CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FF000001B5513FADB5513FFFB5513FFFB5513FFFB551
              3FFFB5523EACFF000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00B946460BB5513FCFB5513FFFB5513FFFB550
              3FCEB946460BFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B94F3E1DB5513FE8B5513FE7B94F
              3E1DFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B5534034B4504133FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton4Click
          end
          object SpeedButton5: TSpeedButton
            Left = 128
            Top = 34
            Width = 23
            Height = 22
            Hint = 'Runter'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B5534034B5534034FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B14E4317B5503FE1B5503FE1B14E
              4317FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00BF604008B6513FC6B5513FFFB5513FFFB651
              3FC6BF604008FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FF000001B5513FA3B5513FFFB5513FFFB5513FFFB551
              3FFFB5513FA3FF000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00B4503F82B5513FFFB5513FFFB5513FFFB5513FFFB551
              3FFFB5513FFFB6513F81FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
              3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton5Click
          end
        end
        object LV: TListView
          Left = 2
          Top = 15
          Width = 205
          Height = 196
          Align = alClient
          Columns = <
            item
              Caption = 'Nr'
              Width = 40
            end
            item
              Caption = 'Titel'
              Width = 125
            end>
          ReadOnly = True
          RowSelect = True
          SortType = stText
          TabOrder = 1
          ViewStyle = vsReport
          OnChange = LVChange
        end
      end
      object Panel3: TPanel
        Left = 212
        Top = 0
        Width = 668
        Height = 276
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel3'
        ShowCaption = False
        TabOrder = 1
        inline ChapterFrame1: TChapterFrame
          Left = 0
          Top = 0
          Width = 668
          Height = 276
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 668
          ExplicitHeight = 276
          inherited Splitter1: TSplitter
            Height = 276
            ExplicitHeight = 276
          end
          inherited GroupBox1: TGroupBox
            Height = 276
            ExplicitHeight = 276
            inherited Panel1: TPanel
              Top = 211
              ExplicitTop = 211
            end
            inherited TV: TTreeView
              Height = 196
              ExplicitHeight = 196
            end
          end
          inherited DSProviderConnection1: TDSProviderConnection
            Left = 88
            Top = 65520
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Teilnehmer'
      ImageIndex = 1
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 880
        Height = 210
        Align = alClient
        DataSource = TNSrc
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'TN_NAME'
            ReadOnly = True
            Title.Caption = 'Name'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TN_VORNAME'
            ReadOnly = True
            Title.Caption = 'Vorname'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TN_DEPARTMENT'
            ReadOnly = True
            Title.Caption = 'Abteilung'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TN_ROLLE'
            Title.Caption = 'Rolle'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'StatusText'
            PickList.Strings = (
              'Anwesend'
              'Entschuldigt'
              'Abwesend'
              'Eingeladen')
            Title.Caption = 'Status'
            Visible = True
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 235
        Width = 880
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 1
        object Button1: TButton
          Left = 8
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Anwesend'
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 104
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Entschuldigt'
          TabOrder = 1
        end
        object Button3: TButton
          Left = 208
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Abwesend'
          TabOrder = 2
          OnClick = Button3Click
        end
      end
      object DBNavigator2: TDBNavigator
        Left = 0
        Top = 210
        Width = 880
        Height = 25
        DataSource = TNSrc
        Align = alBottom
        TabOrder = 2
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'G'#228'ste'
      ImageIndex = 2
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 880
        Height = 251
        Align = alClient
        DataSource = TGSrc
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'TG_NAME'
            Title.Caption = 'Name'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TG_VORNAME'
            Title.Caption = 'Vorname'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TG_DEPARTMENT'
            Title.Caption = 'Abteilung'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TG_VON'
            Title.Caption = 'von'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TG_BIS'
            Title.Caption = 'bis'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TG_GRUND'
            Title.Caption = 'Grund'
            Width = 150
            Visible = True
          end>
      end
      object DBNavigator1: TDBNavigator
        Left = 0
        Top = 251
        Width = 880
        Height = 25
        DataSource = TGSrc
        Align = alBottom
        TabOrder = 1
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 888
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel4'
    ShowCaption = False
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 15
      Width = 20
      Height = 13
      Caption = 'Titel'
    end
    object Label2: TLabel
      Left = 175
      Top = 15
      Width = 11
      Height = 13
      Caption = 'Nr'
    end
    object Label3: TLabel
      Left = 255
      Top = 15
      Width = 31
      Height = 13
      Caption = 'Datum'
    end
    object DBEdit1: TDBEdit
      Left = 42
      Top = 12
      Width = 121
      Height = 21
      DataField = 'PR_NAME'
      DataSource = PrSrc
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 192
      Top = 12
      Width = 57
      Height = 21
      DataField = 'PR_NR'
      DataSource = PrSrc
      TabOrder = 1
    end
    object JvDBDateTimePicker1: TJvDBDateTimePicker
      Left = 292
      Top = 12
      Width = 186
      Height = 21
      Date = 43920.661384108800000000
      Time = 43920.661384108800000000
      TabOrder = 2
      DropDownDate = 43920.000000000000000000
      DataField = 'PR_DATUM'
      DataSource = PrSrc
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsProtocol'
    Left = 208
    Top = 160
  end
  object PRTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PRTable'
    RemoteServer = DSProviderConnection1
    Left = 48
    Top = 80
  end
  object TGTab: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'PR_ID'
    Params = <>
    ProviderName = 'TGTable'
    RemoteServer = DSProviderConnection1
    AfterInsert = TGTabAfterInsert
    Left = 144
    Top = 80
  end
  object TNSrc: TDataSource
    DataSet = TNTab
    Left = 92
    Top = 136
  end
  object PrSrc: TDataSource
    DataSet = PRTab
    Left = 44
    Top = 136
  end
  object TGSrc: TDataSource
    DataSet = TGTab
    Left = 140
    Top = 136
  end
  object AutoIncValue: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'AutoIncValue'
    RemoteServer = DSProviderConnection1
    Left = 204
    Top = 80
  end
  object TNTab: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'PR_ID'
    Params = <>
    ProviderName = 'Teilnehmer'
    RemoteServer = DSProviderConnection1
    Left = 92
    Top = 80
    object TNTabPR_ID: TIntegerField
      FieldName = 'PR_ID'
      Required = True
    end
    object TNTabTN_ID: TIntegerField
      FieldName = 'TN_ID'
      Required = True
    end
    object TNTabTN_NAME: TWideStringField
      FieldName = 'TN_NAME'
      Size = 100
    end
    object TNTabTN_VORNAME: TWideStringField
      FieldName = 'TN_VORNAME'
      Size = 100
    end
    object TNTabTN_DEPARTMENT: TWideStringField
      FieldName = 'TN_DEPARTMENT'
      Size = 25
    end
    object TNTabTN_ROLLE: TWideStringField
      FieldName = 'TN_ROLLE'
      Size = 50
    end
    object TNTabStatusText: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'StatusText'
      OnChange = TNTabStatusTextChange
      OnGetText = TNTabStatusTextGetText
      OnSetText = TNTabStatusTextSetText
      Size = 25
    end
    object TNTabTN_STATUS: TIntegerField
      FieldName = 'TN_STATUS'
    end
  end
  object MainMenu1: TMainMenu
    Left = 432
    Top = 160
    object Protokoll1: TMenuItem
      Caption = 'Protokoll'
      GroupIndex = 120
      object Sperren1: TMenuItem
        Caption = 'Bearbeiten'
        ShortCut = 114
        OnClick = ac_pr_lockExecute
      end
      object Freigeben1: TMenuItem
        Caption = 'Bearbeiten beenden'
        ShortCut = 115
        OnClick = ac_pr_unlockExecute
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Lesezeichenerstellen1: TMenuItem
        Caption = 'Lesezeichen erstellen'
        ShortCut = 120
        OnClick = ac_pr_bookmarkExecute
      end
    end
  end
  object CPTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Chapter'
    RemoteServer = DSProviderConnection1
    Left = 44
    Top = 192
  end
  object CpSrc: TDataSource
    AutoEdit = False
    DataSet = CPTab
    Left = 92
    Top = 192
  end
  object UpdateCPQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'CP_NR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CP_TITLE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CP_ID'
        ParamType = ptInput
      end>
    ProviderName = 'UpdateCPQry'
    RemoteServer = DSProviderConnection1
    Left = 156
    Top = 200
  end
end
