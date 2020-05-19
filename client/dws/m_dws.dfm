object DwsMod: TDwsMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 253
  Width = 315
  object DelphiWebScript1: TDelphiWebScript
    Left = 88
    Top = 40
  end
  object dwsUnit1: TdwsUnit
    Script = DelphiWebScript1
    Classes = <
      item
        Name = 'TTable'
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
            OnEval = dwsUnit1ClassesTTableMethodsCellEval
            Kind = mkFunction
          end>
        Properties = <
          item
            Name = 'Header'
            DataType = 'TTableHeader'
            ReadAccess = 'getTableHeader'
          end>
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
          end>
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
      end>
    UnitName = 'Helper'
    StaticSymbols = False
    Left = 184
    Top = 40
  end
end
