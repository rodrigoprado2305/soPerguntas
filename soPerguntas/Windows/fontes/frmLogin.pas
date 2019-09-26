unit frmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit,
  System.Math.Vectors, FMX.Effects, FMX.Ani, FMX.Objects;

type
  TFormLogin = class(TForm)
    edtSenha: TEdit;
    lblSenha: TLabel;
    btnAcessar: TButton;
    Image1: TImage;
    GlowEffect1: TGlowEffect;
    lblVersao: TLabel;
    procedure btnAcessarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

uses frmPrincipal, uDMConexao, uCriptografia, Fmx.DialogService;

{$R *.fmx}

procedure TFormLogin.btnAcessarClick(Sender: TObject);
var
  sSenha: string;
begin
  if Trim(edtSenha.Text) = '' then
  begin
    TDialogService.ShowMessage('Informe o a senha para continuar!');
    exit;
  end;

  sSenha := Trim(DescriptografarSenha(DM.qryChave.FieldByName('senha').AsString,23));
  if Trim(edtSenha.Text) = sSenha then
  begin
    FormPrincipal.Show;
  end
  else
  begin
    showmessage('Senha incorreta, tente novamente...');
    edtSenha.SetFocus;
  end;
end;

procedure TFormLogin.edtSenhaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkReturn) Or (Key = vkTab) then  // depois de digitar e teclar enter, focar o botao
    btnAcessarClick(Sender);
end;

procedure TFormLogin.FormCreate(Sender: TObject);
begin
  if not DM.BD.Connected then
    DM.BD.Connected := True;

  dm.qryAssunto.Close;
  dm.qryAssunto.Open('select assuntoid, descricao from assunto');

  Caption := DescriptografarSenha(DM.qryChave.FieldByName('nomeEscola').AsString,23);
end;

end.
