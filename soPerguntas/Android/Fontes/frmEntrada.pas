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
    rectPainel: TRectangle;
    lytAcessar: TLayout;
    edtNome: TEdit;
    imgNome: TImage;
    lytHeader: TLayout;
    lytLogo2: TLayout;
    LogoCircle: TCircle;
    imgLogo2: TImage;
    lytLogo1: TLayout;
    imgLogo1: TImage;
    FillRGBEffect4: TFillRGBEffect;
    btnAcessar: TButton;
    lytEspaco: TLayout;
    procedure btnAcessarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEntrada: TFormEntrada;

implementation

uses frmAssuntos, uDMConexao;

{$R *.fmx}

procedure TFormEntrada.btnAcessarClick(Sender: TObject);
begin
  if Trim(edtNome.Text) = '' then
  begin
    showmessage('Informe o nome do jogador para continuar!');
    exit;
  end;

  DM.psNome := Trim(edtNome.Text);
  formAssuntos.show;
end;

end.
