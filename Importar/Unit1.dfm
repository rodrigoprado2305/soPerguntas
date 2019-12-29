object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 459
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 225
    Top = 42
    Width = 5
    Height = 382
    Color = clHotLight
    ParentColor = False
    ExplicitLeft = 257
    ExplicitHeight = 417
  end
  object Gauge1: TGauge
    Left = 0
    Top = 424
    Width = 761
    Height = 35
    Align = alBottom
    Progress = 0
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 42
    Width = 225
    Height = 382
    Align = alLeft
    Caption = 'Dados carregados do Excel'
    TabOrder = 0
    object StringGrid1: TStringGrid
      Left = 2
      Top = 15
      Width = 221
      Height = 365
      Align = alClient
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 230
    Top = 42
    Width = 531
    Height = 382
    Align = alClient
    Caption = 'Dados Pr'#233'-Configurados para importar no SQLite'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 527
      Height = 365
      Align = alClient
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'AssuntoID'
          Width = 56
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'AssuntoDesc'
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PerguntaID'
          Width = 61
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PerguntaDesc'
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Resposta'
          Width = 75
          Visible = True
        end>
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 761
    Height = 42
    Align = alTop
    TabOrder = 2
    object Button4: TButton
      Left = 271
      Top = 8
      Width = 146
      Height = 25
      Caption = '3-DataSet para SQLite'
      TabOrder = 0
      OnClick = Button4Click
    end
  end
  object Button1: TButton
    Left = 137
    Top = 8
    Width = 128
    Height = 25
    Caption = '2-StringGrid to DataSet'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 8
    Width = 123
    Height = 25
    Caption = '1-Excel na StringGrid'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 585
    Top = 8
    Width = 168
    Height = 25
    Caption = 'Dados Aleat'#243'rios na StringGrid'
    TabOrder = 5
    OnClick = Button3Click
  end
  object mtExcel: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 120
    Top = 224
    object mtExcelAssuntoID: TIntegerField
      FieldName = 'AssuntoID'
    end
    object mtExcelAssuntoDesc: TStringField
      DisplayWidth = 26
      FieldName = 'AssuntoDesc'
      Size = 26
    end
    object mtExcelPerguntaID: TIntegerField
      FieldName = 'PerguntaID'
    end
    object mtExcelPerguntaDesc: TStringField
      FieldName = 'PerguntaDesc'
      Size = 167
    end
    object mtExcelResposta: TStringField
      FieldName = 'Resposta'
      Size = 57
    end
  end
  object DataSource1: TDataSource
    DataSet = mtExcel
    Left = 160
    Top = 224
  end
end
