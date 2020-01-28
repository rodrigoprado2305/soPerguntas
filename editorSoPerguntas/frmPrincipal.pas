unit frmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ScrollBox, FMX.Memo;

type
  TFormPrincipal = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    GroupBox1: TGroupBox;
    edtEscola: TEdit;
    lblEscola: TLabel;
    edtSenha: TEdit;
    lblSenha: TLabel;
    Button2: TButton;
    lblStatus: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure carregarDados;
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses uDMConexao, uBiblioteca, uCriptografia;

{$R *.fmx}

procedure TFormPrincipal.Button1Click(Sender: TObject);
begin
  try
    if not DM.BD.Connected then
      DM.BD.Connected := True
    else
    begin
      showmessage('O Banco de Dados já esta conectado!');
      exit;
    end;


    if not DM.qryChave.Active then
      DM.qryChave.Active := True;

    carregarDados;

    showmessage('Banco de Dados conectado com sucesso!');
  except
    on E:Exception do
    begin
      showmessage('Erro ao tentar conectar-se a base de dados. '+#13+
                  'Verifique se o arquivo "perguntas.sdb" está no mesmo diretório que o "editorSoPerguntas.exe"'+#13+
                  'Excessão: '+E.Message);
      Application.Terminate;
    end;
  end;
end;

procedure TFormPrincipal.Button2Click(Sender: TObject);
begin
  DM.qryTemp.Close;
  DM.qryTemp.SQL.Text := 'update chave set nomeEscola = ' + QuotedStr(CriptografarSenha(Trim(edtEscola.Text),23))
    + ' , senha = '  + QuotedStr(CriptografarSenha(Trim(edtSenha.Text),23)) + ' where chaveid = ' + IntToStr(edtEscola.Tag);
  try
    DM.qryTemp.ExecSQL;
    showmessage('Dados alterados com sucesso!');
  except
    on E:Exception do
    begin
      showmessage('Erro ao tentar editar os dados. '+#13+
                  'Excessão: '+E.Message);
      Application.Terminate;
    end;
  end;
end;

procedure TFormPrincipal.carregarDados;
begin
  edtEscola.Text := DescriptografarSenha(Trim(DM.qryChave.FieldByName('nomeEscola').AsString),23);
  edtSenha.Text := DescriptografarSenha(Trim(DM.qryChave.FieldByName('senha').AsString),23);
  edtEscola.Tag := DM.qryChave.FieldByName('chaveid').AsInteger;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  carregarDados;

  lblStatus.Text := '[BD] '+fnCaminhoBD;
  //Caption := '  Gestão PE Versão ' + getVersaoExe(Application.ExeName);
  Caption := '  Chave do cliente versão 1.2 - 27/01/2020 22:26';

end;

end.
