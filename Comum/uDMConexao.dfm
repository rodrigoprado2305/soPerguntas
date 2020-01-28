object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 232
  Width = 346
  object BD: TFDConnection
    Params.Strings = (
      
        'Database=D:\Desenvolvimento\Delphi\trunk\Projeto Educando\soPerg' +
        'untas\soPerguntas\BD\perguntas.sdb'
      'LockingMode=Normal'
      'Encrypt=aes-128'
      'OpenMode=ReadWrite'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 56
    Top = 8
  end
  object qryAssunto: TFDQuery
    Connection = BD
    Left = 183
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 56
    Top = 64
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 56
    Top = 118
  end
  object qryPerguntas: TFDQuery
    Connection = BD
    Left = 183
    Top = 72
  end
  object qryChave: TFDQuery
    Connection = BD
    Left = 280
    Top = 8
  end
  object qryTemp: TFDQuery
    Connection = BD
    Left = 280
    Top = 73
  end
end
