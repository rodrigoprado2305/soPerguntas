unit frmGerarQuiz;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Layouts;

type
  TFormGerarQuiz = class(TForm)
    barCabecalho: TToolBar;
    btnVoltar: TSpeedButton;
    lytTela: TLayout;
    btnGerarPerguntas: TButton;
    lblParabens: TLabel;
    lblNome: TLabel;
    lblNQuiz: TLabel;
    lblTotalPontos: TLabel;
    lblTotalGeral: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnGerarPerguntasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGerarQuiz: TFormGerarQuiz;

implementation

uses frmQuiz, uDMConexao;

{$R *.fmx}

procedure TFormGerarQuiz.btnGerarPerguntasClick(Sender: TObject);
begin
  formquiz.show;
  FormQuiz.gerarQuiz;
  close;
end;

procedure TFormGerarQuiz.btnVoltarClick(Sender: TObject);
begin
  close;
end;

procedure TFormGerarQuiz.FormShow(Sender: TObject);
begin
  DM.carregarEstatisticas;

  lblNome.Text := DM.psNome;

  lblNQuiz.Text := 'Nro. Quiz Jogados: '+DM.qryTemp.FieldByName('numjogadas').AsString;
  lblTotalPontos.Text := 'Total Pontos: ' + FormatFloat('0.00', DM.qryTemp.FieldByName('media').AsFloat);
  lblTotalGeral.Text := 'Total Pontos Geral: ' + FormatFloat('0.00', DM.qryTemp.FieldByName('mediageral').AsFloat);
end;

end.
