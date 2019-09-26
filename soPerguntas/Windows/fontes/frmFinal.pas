unit frmFinal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Effects;

type
  TFormFinal = class(TForm)
    lblAcerto: TLabel;
    lblErro: TLabel;
    imgFundo: TImage;
    lblRespondidas: TLabel;
    lblPercAcerto: TLabel;
    lblPercErro: TLabel;
    lblNota: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFinal: TFormFinal;

implementation

{$R *.fmx}

end.
