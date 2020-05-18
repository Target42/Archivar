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
      end>
    UnitName = 'Helper'
    StaticSymbols = False
    Left = 184
    Top = 40
  end
end
