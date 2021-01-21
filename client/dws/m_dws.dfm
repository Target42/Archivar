object DwsMod: TDwsMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 253
  Width = 315
  object DelphiWebScript1: TDelphiWebScript
    Left = 24
    Top = 16
  end
  object dwsUnit1: TdwsUnit
    Script = DelphiWebScript1
    Classes = <
      item
        Name = 'TTable'
        Constructors = <
          item
            Name = 'Create'
            OnEval = dwsUnit1ClassesTTableConstructorsCreateEval
          end>
        Methods = <
          item
            Name = 'getTableHeader'
            ResultType = 'TTableHeader'
            OnEval = dwsUnit1ClassesTTableMethodsgetTableHeaderEval
            Visibility = cvPrivate
            Kind = mkFunction
          end
          item
            Name = 'Rows'
            ResultType = 'integer'
            OnEval = dwsUnit1ClassesTTableMethodsRowsEval
            Kind = mkFunction
          end
          item
            Name = 'Cols'
            ResultType = 'integer'
            OnEval = dwsUnit1ClassesTTableMethodsColsEval
            Kind = mkFunction
          end
          item
            Name = 'Cell'
            Parameters = <
              item
                Name = 'row'
                DataType = 'Integer'
              end
              item
                Name = 'col'
                DataType = 'Integer'
              end>
            ResultType = 'String'
            Overloaded = True
            OnEval = dwsUnit1ClassesTTableMethodsCellEval
            Kind = mkFunction
          end
          item
            Name = 'Cell'
            Parameters = <
              item
                Name = 'row'
                DataType = 'Integer'
              end
              item
                Name = 'Field'
                DataType = 'String'
              end>
            ResultType = 'string'
            Overloaded = True
            OnEval = dwsUnit1ClassesTTableMethodsCell_IntegerString_Eval
            Kind = mkFunction
          end
          item
            Name = 'getName'
            ResultType = 'string'
            OnEval = dwsUnit1ClassesTTableMethodsgetNameEval
            Kind = mkFunction
          end>
        Properties = <
          item
            Name = 'Header'
            DataType = 'TTableHeader'
            ReadAccess = 'getTableHeader'
          end
          item
            Name = 'Name'
            DataType = 'String'
            ReadAccess = 'getName'
          end>
        OnCleanUp = dwsUnit1ClassesTTableCleanUp
      end
      item
        Name = 'TTableHeader'
        Methods = <
          item
            Name = 'Count'
            ResultType = 'integer'
            OnEval = dwsUnit1ClassesTTableHeaderMethodsCountEval
            Kind = mkFunction
          end
          item
            Name = 'Caption'
            Parameters = <
              item
                Name = 'Name'
                DataType = 'String'
              end>
            ResultType = 'String'
            OnEval = dwsUnit1ClassesTTableHeaderMethodsCaptionEval
            Kind = mkFunction
          end
          item
            Name = 'Width'
            Parameters = <
              item
                Name = 'name'
                DataType = 'String'
              end>
            ResultType = 'integer'
            OnEval = dwsUnit1ClassesTTableHeaderMethodsWidthEval
            Kind = mkFunction
          end
          item
            Name = 'Names'
            ResultType = 'array of string'
            OnEval = dwsUnit1ClassesTTableHeaderMethodsNamesEval
            Kind = mkFunction
          end>
        OnCleanUp = dwsUnit1ClassesTTableHeaderCleanUp
      end>
    Functions = <
      item
        Name = 'ScriptParamCount'
        ResultType = 'Integer'
        OnEval = dwsUnit1FunctionsScriptParamCVountEval
      end
      item
        Name = 'ScriptParam'
        Parameters = <
          item
            Name = 'index'
            DataType = 'Integer'
          end>
        ResultType = 'String'
        OnEval = dwsUnit1FunctionsScriptParamEval
      end
      item
        Name = 'hasField'
        Parameters = <
          item
            Name = 'name'
            DataType = 'String'
          end>
        ResultType = 'Boolean'
        OnEval = dwsUnit1FunctionshasFieldEval
      end
      item
        Name = 'getFieldStr'
        Parameters = <
          item
            Name = 'name'
            DataType = 'String'
          end>
        ResultType = 'String'
        OnEval = dwsUnit1FunctionsgetFieldStrEval
      end
      item
        Name = 'getFieldInt'
        Parameters = <
          item
            Name = 'name'
            DataType = 'String'
          end>
        ResultType = 'Integer'
        OnEval = dwsUnit1FunctionsgetFieldIntEval
      end
      item
        Name = 'getTable'
        Parameters = <
          item
            Name = 'name'
            DataType = 'String'
          end>
        ResultType = 'TTable'
        OnEval = dwsUnit1FunctionsgetTableEval
      end
      item
        Name = 'printXML'
        ResultType = 'String'
        OnEval = dwsUnit1FunctionsprintXMLEval
      end>
    UnitName = 'Helper'
    StaticSymbols = False
    Left = 184
    Top = 40
  end
  object XMLDump: TPageProducer
    HTMLDoc.Strings = (
      '<table style="text-align: left; width: 100%;" border="1"'
      ' cellpadding="2" cellspacing="0">'
      '  <tbody>'
      '    <tr>'
      '      <td style="font-weight: bold;">Name</td>'
      '      <td style="font-weight: bold;">Value</td>'
      '    </tr>'
      '    <#datarows>'
      '  </tbody>'
      '</table>'
      ' <#tables>')
    OnHTMLTag = XMLDumpHTMLTag
    Left = 144
    Top = 128
  end
  object DumpTable: TPageProducer
    HTMLDoc.Strings = (
      '<h4><#tablename></h4>'
      ''
      '<table style="text-align: left; width: 100%;" border="1"'
      ' cellpadding="2" cellspacing="0">'
      '  <tbody>'
      '    <tr>'
      '      <#header>'
      '    </tr>'
      '    <#rows>'
      '  </tbody>'
      '</table>'
      '')
    OnHTMLTag = DumpTableHTMLTag
    Left = 216
    Top = 120
  end
  object dwsDebugger1: TdwsDebugger
    OnNotifyException = dwsDebugger1NotifyException
    Left = 24
    Top = 64
  end
end
