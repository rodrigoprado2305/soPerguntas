unit frmGerarQuiz;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Layouts,
  FMX.Objects;

type
  TFormGerarQuiz = class(TForm)
    barCabecalho: TToolBar;
    btnVoltar: TSpeedButton;
    recTela: TRectangle;
    lytTela: TLayout;
    btnGerarPerguntas: TButton;
    lblParabens: TLabel;
    lblNome: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lblNQuiz: TLabel;
    lblTotalGeral: TLabel;
    lblTotalPontos: TLabel;
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
var
  i: integer;
begin
  DM.carregarEstatisticas;

  lblNome.Text := DM.psNome;

  i := DM.qryTemp.FieldByName('numjogadas').AsInteger;
  lblNQuiz.Text := IntToStr(i);
  lblTotalPontos.Text := FormatFloat('0.00', DM.qryTemp.FieldByName('media').AsFloat);
  lblTotalGeral.Text := FormatFloat('0.00', DM.qryTemp.FieldByName('mediageral').AsFloat);
end;

end.
