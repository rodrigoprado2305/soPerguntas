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
    Height = 417
    Color = clHotLight
    ParentColor = False
    ExplicitLeft = 257
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 42
    Width = 225
    Height = 417
    Align = alLeft
    Caption = 'Dados carregados do Excel'
    TabOrder = 0
    object StringGrid1: TStringGrid
      Left = 2
      Top = 15
      Width = 221
      Height = 400
      Align = alClient
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 230
    Top = 42
    Width = 531
    Height = 417
    Align = alClient
    Caption = 'Dados Pr'#233'-Configurados para importar no SQLite'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 527
      Height = 400
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
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 120
    Top = 224
    Content = {
      414442530F00261BA8020000FF00010001FF02FF0304000E0000006D00740045
      007800630065006C0005000A0000005400610062006C00650006000000000007
      0000080032000000090000FF0AFF0B04001200000041007300730075006E0074
      006F004900440005001200000041007300730075006E0074006F00490044000C
      00010000000E000D000F00011000011100011200011300011400011500120000
      0041007300730075006E0074006F0049004400FEFF0B04001600000041007300
      730075006E0074006F0044006500730063000500160000004100730073007500
      6E0074006F0044006500730063000C00020000000E0016001700140000000F00
      0110000111000112000113000114000115001600000041007300730075006E00
      74006F004400650073006300180014000000FEFF0B0400140000005000650072
      00670075006E007400610049004400050014000000500065007200670075006E
      0074006100490044000C00030000000E000D000F000110000111000112000113
      0001140001150014000000500065007200670075006E007400610049004400FE
      FF0B040018000000500065007200670075006E00740061004400650073006300
      050018000000500065007200670075006E007400610044006500730063000C00
      040000000E0016001700FF0000000F0001100001110001120001130001140001
      150018000000500065007200670075006E007400610044006500730063001800
      FF000000FEFF0B04001000000052006500730070006F00730074006100050010
      00000052006500730070006F007300740061000C00050000000E0016001700FF
      0000000F00011000011100011200011300011400011500100000005200650073
      0070006F007300740061001800FF000000FEFEFF19FEFF1AFEFF1BFEFEFEFF1C
      FEFF1DFF1EFEFEFE0E004D0061006E0061006700650072001E00550070006400
      6100740065007300520065006700690073007400720079001200540061006200
      6C0065004C006900730074000A005400610062006C00650008004E0061006D00
      6500140053006F0075007200630065004E0061006D0065000A00540061006200
      49004400240045006E0066006F0072006300650043006F006E00730074007200
      610069006E00740073001E004D0069006E0069006D0075006D00430061007000
      61006300690074007900180043006800650063006B004E006F0074004E007500
      6C006C00140043006F006C0075006D006E004C006900730074000C0043006F00
      6C0075006D006E00100053006F007500720063006500490044000E0064007400
      49006E0074003300320010004400610074006100540079007000650014005300
      65006100720063006800610062006C006500120041006C006C006F0077004E00
      75006C006C000800420061007300650014004F0041006C006C006F0077004E00
      75006C006C0012004F0049006E0055007000640061007400650010004F004900
      6E00570068006500720065001A004F0072006900670069006E0043006F006C00
      4E0061006D00650018006400740041006E007300690053007400720069006E00
      67000800530069007A006500140053006F007500720063006500530069007A00
      65001C0043006F006E00730074007200610069006E0074004C00690073007400
      100056006900650077004C006900730074000E0052006F0077004C0069007300
      74001800520065006C006100740069006F006E004C006900730074001C005500
      7000640061007400650073004A006F00750072006E0061006C000E0043006800
      61006E00670065007300}
    object mtExcelAssuntoID: TIntegerField
      FieldName = 'AssuntoID'
    end
    object mtExcelAssuntoDesc: TStringField
      FieldName = 'AssuntoDesc'
    end
    object mtExcelPerguntaID: TIntegerField
      FieldName = 'PerguntaID'
    end
    object mtExcelPerguntaDesc: TStringField
      FieldName = 'PerguntaDesc'
      Size = 255
    end
    object mtExcelResposta: TStringField
      FieldName = 'Resposta'
      Size = 255
    end
  end
  object DataSource1: TDataSource
    DataSet = mtExcel
    Left = 160
    Top = 224
  end
end
