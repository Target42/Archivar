object ePupFrame: TePupFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'EP_TITEL'
        Title.Caption = 'Titel'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EP_GROUP'
        Title.Caption = 'Gruppe'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EP_SUBGROUP'
        Title.Caption = 'Untergruppe'
        Width = 100
        Visible = True
      end>
  end
  object EpubTab: TFDMemTable
    Indexes = <
      item
        Name = 'pri'
        Fields = 'EP_ID'
        Options = [soUnique]
      end
      item
        Active = True
        Selected = True
        Name = 'title'
        Fields = 'EP_TITEL'
        Options = [soNoCase]
        FilterOptions = [ekNoCase]
      end>
    IndexName = 'title'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 56
    object EpubTabEP_ID: TAutoIncField
      FieldName = 'EP_ID'
    end
    object EpubTabEP_TITEL: TStringField
      FieldName = 'EP_TITEL'
      Size = 250
    end
    object EpubTabEP_NAME: TStringField
      FieldName = 'EP_NAME'
      Size = 250
    end
    object EpubTabEP_MD5: TStringField
      FieldName = 'EP_MD5'
      Size = 30
    end
    object EpubTabEP_GROUP: TStringField
      FieldName = 'EP_GROUP'
      Size = 100
    end
    object EpubTabEP_SUBGROUP: TStringField
      FieldName = 'EP_SUBGROUP'
      Size = 100
    end
  end
  object DataSource1: TDataSource
    DataSet = EpubTab
    Left = 128
    Top = 56
  end
  object PopupMenu1: TPopupMenu
    Left = 48
    Top = 136
    object Download1: TMenuItem
      Caption = 'Download'
      OnClick = Download1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Anzeigen1: TMenuItem
      Caption = 'Anzeigen'
      OnClick = Anzeigen1Click
    end
  end
end
