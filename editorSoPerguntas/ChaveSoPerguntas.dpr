program ChaveSoPerguntas;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmPrincipal in 'frmPrincipal.pas' {FormPrincipal},
  uBiblioteca in '..\Comum\uBiblioteca.pas',
  uDMConexao in '..\Comum\uDMConexao.pas' {DM: TDataModule},
  uCriptografia in '..\Comum\uCriptografia.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
