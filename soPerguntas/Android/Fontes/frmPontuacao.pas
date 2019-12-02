unit frmPontuacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Layouts, FMX.Effects,
  FMX.Filter.Effects, FMX.Objects, FMX.StdCtrls, frmEntrada;

type
  TFormPontuacao = class(TForm)
    recTela: TRectangle;
    lytTela: TLayout;
    btnCompartilhar: TButton;
    UserImage: TImage;
    FillRGBEffect4: TFillRGBEffect;
    lblParabens: TLabel;
    lblNome: TLabel;
    lblRespondidas1: TLabel;
    lblAcerto1: TLabel;
    lblErro1: TLabel;
    lblPercAcerto1: TLabel;
    lblPercErro1: TLabel;
    lblNota1: TLabel;
    imgLogo1: TImage;
    lblLinhaBot: TLabel;
    lblResultados: TLabel;
    lblLinhaTop: TLabel;
    barCabecalho: TToolBar;
    btnSair: TSpeedButton;
    lblAcerto: TLabel;
    lblPercErro: TLabel;
    lblNota: TLabel;
    lblErro: TLabel;
    lblRespondidas: TLabel;
    lblPercAcerto: TLabel;
    lytGeral: TLayout;
    procedure btnCompartilharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPontuacao: TFormPontuacao;

implementation

uses
  FMX.Helpers.Android, Androidapi.Jni.GraphicsContentViewText,
  Androidapi.Jni.Net, Androidapi.Jni.JavaTypes, idUri, Androidapi.Jni,
  Androidapi.JNIBridge, Androidapi.Helpers,
  FMX.Platform.Android, AndroidApi.Jni.App, AndroidAPI.jni.OS,
  uDMConexao, System.IOUtils;

{$R *.fmx}

procedure TFormPontuacao.btnCompartilharClick(Sender: TObject);
var
  IntentWhatsApp: JIntent;
  FileUri: Jnet_Uri;
  lst: JArrayList;
  img: TBitmap;
  sMensagem: String;
begin
  sMensagem := 'Acesse o site: http://www.projetoeducando.com.br  ';
  sMensagem := 'O Jogador: '+DM.psNome+' - concluiu 10 questões do tema "'+DM.psTema+'", '+sLineBreak+sMensagem;

  img := lytTela.MakeScreenshot;

  try
    img.SaveToFile(TPath.combine(TPath.GetDownloadsPath, 'screenshot_temp.jpg'));
  except
     on E : Exception do
     begin
       ShowMessage('Erro ao salvar a imagem da pontuação: '+E.Message);
     end;
  end;

  lst:= TJArrayList.Create;

  FileUri := TJNet_Uri.JavaClass.fromFile(TJFile.JavaClass.init(StringToJString(system.IOUtils.TPath.GetDownloadsPath + '/screenshot_temp.jpg')));

  lst.add(0,FileUri);

  IntentWhatsApp := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_SEND);
  IntentWhatsApp.setType(StringToJString('text/plain'));
  IntentWhatsApp.putExtra(TJIntent.JavaClass .EXTRA_TEXT,StringToJString(sMensagem));

  IntentWhatsApp.setType(StringToJString('image/jpg'));
  IntentWhatsApp.putParcelableArrayListExtra(TJIntent.JavaClass.EXTRA_STREAM,lst);
  IntentWhatsApp.setPackage(StringToJString('com.whatsapp'));

  //SharedActivity.startActivity(IntentWhatsApp); // is deprecated
  TAndroidHelper.Activity.startActivity(IntentWhatsApp);
  close;
end;

procedure TFormPontuacao.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFormPontuacao.FormShow(Sender: TObject);
begin
  lblNome.Text := DM.psNome;
  lblResultados.Text := 'Você concluiu o tema "' + DM.psTema+'"';
end;

end.
