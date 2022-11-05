object GM: TGM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 314
  Width = 420
  object JvScheduledEvents1: TJvScheduledEvents
    AutoSave = False
    Events = <
      item
        Name = 'CleanDeadDocuments'
        OnExecute = JvScheduledEvents1Events0Execute
        StartDate = '2022/11/05 07:53:21.000'
        RecurringType = srkDaily
        EndType = sekNone
        Freq_StartTime = 31200000
        Freq_EndTime = 31200000
        Freq_Interval = 1
        Daily_EveryWeekDay = True
      end>
    Left = 88
    Top = 32
  end
end
