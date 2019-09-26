unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    mtExcel: TFDMemTable;
    mtExcelAssuntoID: TIntegerField;
    mtExcelAssuntoDesc: TStringField;
    mtExcelPerguntaID: TIntegerField;
    mtExcelPerguntaDesc: TStringField;
    mtExcelResposta: TStringField;
    DataSource1: TDataSource;
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Splitter1: TSplitter;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    Function XlsToStringGrid(xStringGrid: TStringGrid; xFileXLS: string): Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses System.Win.ComObj, uDMConexao;

{$R *.dfm}

Function TForm1.XlsToStringGrid(xStringGrid: TStringGrid; xFileXLS: string): Boolean;
const
   xlCellTypeLastCell = $0000000B;
var
   XLSAplicacao, AbaXLS: OLEVariant;
   RangeMatrix: Variant;
   x, y, k, r: Integer;
begin
  Result := False;
  // Cria Excel- OLE Object
  XLSAplicacao := CreateOleObject('Excel.Application');
  try
    // Esconde Excel
    XLSAplicacao.Visible := False;
    // Abre o Workbook
    XLSAplicacao.Workbooks.Open(xFileXLS);
    {Selecione aqui a aba que você deseja abrir primeiro - 1,2,3,4....}
    XLSAplicacao.WorkSheets[1].Activate;
    {Selecione aqui a aba que você deseja ativar - começando sempre no 1 (1,2,3,4) }
    AbaXLS := XLSAplicacao.Workbooks[ExtractFileName(xFileXLS)].WorkSheets[1];

    AbaXLS.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    // Pegar o número da última linha
    x := XLSAplicacao.ActiveCell.Row;
    // Pegar o número da última coluna
    y := XLSAplicacao.ActiveCell.Column;
    // Seta xStringGrid linha e coluna
    XStringGrid.RowCount := x;
    XStringGrid.ColCount := y;
    // Associaca a variant WorkSheet com a variant do Delphi
    RangeMatrix := XLSAplicacao.Range['A1', XLSAplicacao.Cells.Item[x, y]].Value;
    // Cria o loop para listar os registros no TStringGrid
    k := 1;
    repeat
      for r := 1 to y do
        XStringGrid.Cells[(r - 1), (k - 1)] := RangeMatrix[k, r];
      Inc(k, 1);
    until k > x;
    RangeMatrix := Unassigned;
  finally
    // Fecha o Microsoft Excel
    if not VarIsEmpty(XLSAplicacao) then
    begin
      XLSAplicacao.Quit;
      XLSAplicacao := Unassigned;
      AbaXLS := Unassigned;
      Result := True;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, iAssuntoID : integer;
begin
  iAssuntoID := 0;
  mtExcel.EmptyDataSet;

  for i := 1 to StringGrid1.RowCount -1 do
  begin
    if not mtExcel.Locate('AssuntoDesc',StringGrid1.Cells[0,i]) then
      inc(iAssuntoID);

    mtExcel.AppendRecord([
      iAssuntoID,
      StringGrid1.Cells[0,i],
      i,
      StringGrid1.Cells[1,i],
      StringGrid1.Cells[2,i]
           ]);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var s: string;
begin

  s := 'D:\Desenvolvimento\Delphi\trunk\Projeto Educando\soPerguntas\Importar\Win32\Debug\SOPERGUNTAS_TESTE_SETEMBRO.xlsx';
  XlsToStringGrid(stringgrid1,s);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  //Criar as colunas
  StringGrid1.Cells[0,0] := 'Nome';
  StringGrid1.Cells[1,0] := 'Sobrenome';
  StringGrid1.Cells[2,0] := 'E-mail';
  StringGrid1.Cells[3,0] := 'Site';

  { Alimenta com os registros }
  StringGrid1.Cells[0,1] := 'Adriano';
  StringGrid1.Cells[1,1] := 'Santos';
  StringGrid1.Cells[2,1] := 'asrsantos@gmail.com';
  StringGrid1.Cells[3,1] := 'delphitodelphi.blogspot.com';

  StringGrid1.Cells[0,2] := 'José';
  StringGrid1.Cells[1,2] := 'de Arimatéia';
  StringGrid1.Cells[2,2] := 'arimateia@gmail.com';
  StringGrid1.Cells[3,2] := 'arimateia.blogspot.com';

  StringGrid1.Cells[0,3] := 'João';
  StringGrid1.Cells[1,3] := 'Bosco';
  StringGrid1.Cells[2,3] := 'bosco@gmail.com';
  StringGrid1.Cells[3,3] := 'bosco.blogspot.com';

  StringGrid1.Cells[0,4] := 'Marina';
  StringGrid1.Cells[1,4] := 'Silva';
  StringGrid1.Cells[2,4] := 'silva@gmail.com';
  StringGrid1.Cells[3,4] := 'silva.blogspot.com';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  dm.qryTemp.Close;
  dm.qryTemp.SQL.Text := 'delete from chave';
  dm.qryTemp.ExecSQL;

  dm.qryTemp.Close;
  dm.qryTemp.SQL.Text := 'delete from perguntas';
  dm.qryTemp.ExecSQL;

  dm.qryTemp.Close;
  dm.qryTemp.SQL.Text := 'delete from assunto';
  dm.qryTemp.ExecSQL;

  dm.qryTemp.Close;
  dm.qryTemp.SQL.Text := 'insert into chave (nomeEscola, senha) values (''IMPORTAÇAO INICIAL PROJETO EDUCANDO'',''SCRIB130'')';
  dm.qryTemp.ExecSQL;

  mtExcel.First;

  mtExcel.DisableControls;
  while not mtExcel.Eof do
  begin
    dm.qryTemp.Close;
    dm.qryTemp.SQL.Text := 'select assuntoid from assunto where assuntoid = '+ mtExcel.FieldByName('AssuntoID').AsString;
    dm.qryTemp.Open;
    if dm.qryTemp.IsEmpty then
    begin
      dm.qryTemp.Close;
      dm.qryTemp.SQL.Text := 'insert into assunto (assuntoid, descricao) values ('+
        mtExcel.FieldByName('AssuntoID').AsString +', '+
        QuotedStr(mtExcel.FieldByName('AssuntoDesc').AsString) + ')';
      dm.qryTemp.ExecSQL;
    end;

    dm.qryTemp.Close;
    dm.qryTemp.SQL.Text := 'insert into perguntas (perguntaid, assuntoid, descricao, resposta) values ('+
      mtExcel.FieldByName('PerguntaID').AsString +', '+
      mtExcel.FieldByName('AssuntoID').AsString +', '+
      QuotedStr(mtExcel.FieldByName('PerguntaDesc').AsString) +', '+
      QuotedStr(mtExcel.FieldByName('Resposta').AsString) +
      ')';
    try
      dm.qryTemp.ExecSQL;
    Except
    on E: Exception do
      begin
        ShowMessage(
          'PerguntaID: '+mtExcel.FieldByName('PerguntaID').AsString
          +' AssuntoID: '+mtExcel.FieldByName('AssuntoID').AsString
          + ' Erro: ' + E.Message );
        break;
      end;
    end;

    mtExcel.Next;
  end;

  mtExcel.EnableControls;

  showmessage('Importação finalizada');
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  mtExcel.Open;
end;

end.
