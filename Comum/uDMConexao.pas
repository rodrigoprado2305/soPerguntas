unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDM = class(TDataModule)
    BD: TFDConnection;
    qryAssunto: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    qryPerguntas: TFDQuery;
    qryChave: TFDQuery;
    qryTemp: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    piTotalPerguntas, piAssuntoID, piMin, piMax: Integer;
    psDescPergunta, psResposta: String;
    procedure filtraPergunta(iAssuntoID: Integer; iPerguntaID: Integer = 0);
  end;

var
  DM: TDM;

implementation

uses uBiblioteca;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  BD.Params.Clear;
  BD.Params.Values['DriverID'] := 'SQLite';
  BD.Params.Add('Database='+fnCaminhoBD);

  try
    BD.Connected := True;
  except
    on E:Exception do
      raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
  end;

  DM.qryChave.Close;
  DM.qryChave.Open('select chaveid, nomeEscola, senha from chave');

 {
  qryRespostas.Params[1].DataType := TFieldType.ftInteger;
  qryRespostas.Params[1].FDDataType := dtInt32;
  qryRespostas.Params[1].ParamType := ptInput;  }
end;

procedure TDM.FiltraPergunta(iAssuntoID: Integer; iPerguntaID: Integer = 0);
begin
  qryPerguntas.Close;
  qryPerguntas.SQL.Text :=
    'select perguntaid, descricao, resposta from perguntas ' +
    'where assuntoid =:assuntoid ';

  if iPerguntaID > 0 then
    qryPerguntas.SQL.Text := qryPerguntas.SQL.Text + ' and perguntaid =:perguntaid';

  qryPerguntas.ParamByName('assuntoid').AsInteger := iAssuntoID;

  if iPerguntaID > 0 then
    qryPerguntas.ParamByName('perguntaid').AsInteger := iPerguntaID;

  qryPerguntas.Open;
  qryPerguntas.First;

  if iPerguntaID = 0 then
  begin
    piTotalPerguntas := qryPerguntas.RecordCount;
    piMin := qryPerguntas.FieldByName('perguntaid').AsInteger;
    qryPerguntas.Last;
    piMax := qryPerguntas.FieldByName('perguntaid').AsInteger;
    qryPerguntas.First;
  end;
end;

end.
