program SOPerguntas;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmPrincipal in 'fontes\frmPrincipal.pas' {FormPrincipal},
  frmFinal in 'fontes\frmFinal.pas' {FormFinal},
  uBiblioteca in '..\..\Comum\uBiblioteca.pas',
  uDMConexao in '..\..\Comum\uDMConexao.pas' {DM: TDataModule},
  frmLogin in 'fontes\frmLogin.pas' {FormLogin},
  uCriptografia in '..\..\Comum\uCriptografia.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormFinal, FormFinal);
  Application.Run;
end.
