object TOFrame: TTOFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object VST: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    Header.AutoSizeIndex = -1
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs]
    StyleElements = [seClient, seBorder]
    TabOrder = 0
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    TreeOptions.StringOptions = [toSaveCaptions, toShowStaticText, toAutoAcceptEditChange]
    OnDrawText = VSTDrawText
    OnFreeNode = VSTFreeNode
    OnGetCellText = VSTGetCellText
    Columns = <
      item
        Position = 0
        Text = #220'berschrift'
        Width = 200
      end
      item
        Position = 1
        Text = 'Datum'
        Width = 247
      end>
  end
end
