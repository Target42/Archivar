object DwsMod: TDwsMod
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 334
  Width = 357
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
            Visibility = cvPrivate
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableMethodsgetTableHeaderEval
          end
          item
            Name = 'Rows'
            ResultType = 'integer'
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableMethodsRowsEval
          end
          item
            Name = 'Cols'
            ResultType = 'integer'
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableMethodsColsEval
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
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableMethodsCellEval
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
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableMethodsCell_IntegerString_Eval
          end
          item
            Name = 'getName'
            ResultType = 'string'
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableMethodsgetNameEval
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
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableHeaderMethodsCountEval
          end
          item
            Name = 'Names'
            ResultType = 'array of string'
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableHeaderMethodsNamesEval
          end
          item
            Name = 'Name'
            Parameters = <
              item
                Name = 'index'
                DataType = 'Integer'
              end>
            ResultType = 'string'
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableHeaderMethodsNameEval
          end
          item
            Name = 'Caption'
            Parameters = <
              item
                Name = 'Name'
                DataType = 'String'
              end>
            ResultType = 'String'
            Overloaded = True
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableHeaderMethodsCaptionEval
          end
          item
            Name = 'Caption'
            Parameters = <
              item
                Name = 'index'
                DataType = 'Integer'
              end>
            ResultType = 'string'
            Overloaded = True
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableHeaderMethodsCaption_Integer_Eval
          end
          item
            Name = 'Width'
            Parameters = <
              item
                Name = 'name'
                DataType = 'String'
              end>
            ResultType = 'integer'
            Overloaded = True
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableHeaderMethodsWidthEval
          end
          item
            Name = 'Width'
            Parameters = <
              item
                Name = 'index'
                DataType = 'Integer'
              end>
            ResultType = 'integer'
            Overloaded = True
            Kind = mkFunction
            OnEval = dwsUnit1ClassesTTableHeaderMethodsWidth_Integer_Eval
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
      end
      item
        Name = 'RunTemplate'
        Parameters = <
          item
            Name = 'fileName'
            DataType = 'String'
          end
          item
            Name = 'rtf'
            DataType = 'ReplaceTagFunc'
          end>
        ResultType = 'String'
        OnEval = dwsUnit1FunctionsRunTemplateEval
      end>
    Delegates = <
      item
        Name = 'ReplaceTagFunc'
        Parameters = <
          item
            Name = 'Tag'
            DataType = 'String'
          end>
        ResultType = 'String'
      end>
    UnitName = 'Helper'
    StaticSymbols = False
    Left = 128
    Top = 112
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
    Left = 24
    Top = 192
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
    Left = 128
    Top = 200
  end
  object dwsDebugger1: TdwsDebugger
    OnNotifyException = dwsDebugger1NotifyException
    Left = 24
    Top = 64
  end
end
