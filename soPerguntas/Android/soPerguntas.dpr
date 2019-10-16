program soPerguntas;



uses
  System.StartUpCopy,
  FMX.Forms,
  frmEntrada in 'Fontes\frmEntrada.pas' {FormEntrada},
  frmAssuntos in 'Fontes\frmAssuntos.pas' {FormAssuntos},
  frmQuiz in 'Fontes\frmQuiz.pas' {FormQuiz},
  uDMConexao in '..\..\Comum\uDMConexao.pas' {DM: TDataModule},
  uBiblioteca in '..\..\Comum\uBiblioteca.pas',
  frmGerarQuiz in 'Fontes\frmGerarQuiz.pas' {FormGerarQuiz},
  frmPontuacao in 'Fontes\frmPontuacao.pas' {FormPontuacao};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TFormEntrada, FormEntrada);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormAssuntos, FormAssuntos);
  Application.CreateForm(TFormQuiz, FormQuiz);
  Application.CreateForm(TFormGerarQuiz, FormGerarQuiz);
  Application.CreateForm(TFormPontuacao, FormPontuacao);
  Application.Run;
end.
