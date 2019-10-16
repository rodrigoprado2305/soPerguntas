unit frmPontuacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Layouts, FMX.Effects,
  FMX.Filter.Effects, FMX.Objects, FMX.StdCtrls;

type
  TFormPontuacao = class(TForm)
    Layout1: TLayout;
    btnCompartilhar: TButton;
    UserImage: TImage;
    FillRGBEffect4: TFillRGBEffect;
    lblParabens: TLabel;
    lblNome: TLabel;
    lblRespondidas: TLabel;
    lblAcerto: TLabel;
    lblErro: TLabel;
    lblPercAcerto: TLabel;
    lblPercErro: TLabel;
    lblNota: TLabel;
    procedure btnCompartilharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPontuacao: TFormPontuacao;

implementation

{$R *.fmx}

procedure TFormPontuacao.btnCompartilharClick(Sender: TObject);
begin
  close;
end;

end.
