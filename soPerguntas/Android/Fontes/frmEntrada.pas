unit frmEntrada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.Layouts,
  FMX.Effects, FMX.Filter.Effects;

type
  TFormEntrada = class(TForm)
    VertScrollBox1: TVertScrollBox;
    HeaderLayout: TLayout;
    CenterLayout: TLayout;
    lblTitulo1: TText;
    lblTitulo2: TText;
    LogoLayout: TLayout;
    imgLogo: TImage;
    FormLayout: TLayout;
    edtNome: TEdit;
    lblTitulo3: TText;
    btnAcessar: TButton;
    procedure Button1Click(Sender: TObject);
    procedure imgLogoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEntrada: TFormEntrada;

implementation

uses System.IOUtils, uDMConexao, frmAssuntos;

{$R *.fmx}

procedure TFormEntrada.Button1Click(Sender: TObject);
begin
  //showmessage(TPath.GetDocumentsPath);
  //showmessage(dm.qryChave.FieldByName('nomeEscola').AsString);
  formAssuntos.show;
end;

procedure TFormEntrada.imgLogoClick(Sender: TObject);
var s: string;
begin
  s := 'Adicionando -1';
  DM.qryTemp.Close;
  DM.qryTemp.SQL.Text := ' update assunto set descricao = '+QuotedStr(s)+' where assuntoid = 1';

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

end.
