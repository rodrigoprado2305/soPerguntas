unit frmQuiz;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.Advertising,
  FMX.Media, System.IOUtils;

type
  TFormQuiz = class(TForm)
    lblFase: TLabel;
    recFase: TRectangle;
    rectOkErro: TRectangle;
    imgErro: TImage;
    imgOk: TImage;
    timer1: TTimer;
    barCabecalho: TToolBar;
    btnVoltar: TSpeedButton;
    lytMeio: TLayout;
    lblPergunta: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    rectMeio: TRectangle;
    btnInfo: TSpeedButton;
    BannerAd1: TBannerAd;
    MediaPlayer1: TMediaPlayer;
    chkEfeitosSonoros: TCheckBox;
    procedure timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure chkEfeitosSonorosChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
  private
    { Private declarations }
    iFase, iAcerto, iErro: Integer;
    bMusica: Boolean;
    sRespClicada, sPerguntasUsadas: String;

    procedure proximaFase;

    procedure pintarRespostas;
    procedure tocaSom(sArqNome: String);

  public
    { Public declarations }
    procedure gerarQuiz;
  end;

var
  FormQuiz: TFormQuiz;

const
  NUM_FASES = 10;

implementation

uses uDMConexao, System.Math, frmPontuacao, frmInformacao, Data.DB;

{$R *.fmx}

procedure TFormQuiz.proximaFase;
var
  iRandomPerg: Integer;
  slResposta: TStringList;
  i: integer;
  dMedia: double;
begin
  if (iFase = NUM_FASES) then
  begin
    //showmessage('final');

    FormPontuacao.lblRespondidas.Text := IntToStr(iFase);
    FormPontuacao.lblAcerto.Text := IntToStr(iAcerto);
    FormPontuacao.lblErro.Text := IntToStr(iErro);

    FormPontuacao.lblPercAcerto.Text := FormatFloat('0.00',(iAcerto*100)/NUM_FASES);
    FormPontuacao.lblPercErro.Text := FormatFloat('0.00',(iErro*100)/NUM_FASES);
    dMedia := (iAcerto/NUM_FASES)*10;
    FormPontuacao.lblNota.Text := FormatFloat('0.00',dMedia);

    FormPontuacao.Show;

    close;

    DM.atualizarEstatisticas(dMedia);
  end;

  inc(iFase);
  lblFase.Text := IntToStr(iFase)+'/'+IntToStr(NUM_FASES);

  RadioButton1.IsChecked := False;
  RadioButton2.IsChecked := False;
  RadioButton3.IsChecked := False;
  RadioButton4.IsChecked := False;

  RadioButton1.Tag := 0;
  RadioButton2.Tag := 0;
  RadioButton3.Tag := 0;
  RadioButton4.Tag := 0;

  RadioButton1.FontColor := TAlphaColorRec.Black;
  RadioButton2.FontColor := TAlphaColorRec.Black;
  RadioButton3.FontColor := TAlphaColorRec.Black;
  RadioButton4.FontColor := TAlphaColorRec.Black;

  imgOk.Visible := False;
  imgErro.Visible := False;

  slResposta := TStringList.Create;
  try
    randomize;
    repeat
      iRandomPerg := RandomRange(DM.piMin, DM.piMax);
    until Pos(IntToStr(iRandomPerg), sPerguntasUsadas) = 0;
    DM.filtraPergunta(DM.piAssuntoID, iRandomPerg);
    DM.psDescPergunta := DM.qryPerguntas.FieldByName('descricao').AsString;
    DM.psResposta := DM.qryPerguntas.FieldByName('resposta').AsString;
    lblPergunta.Text := DM.psDescPergunta;
    sPerguntasUsadas := sPerguntasUsadas + IntToStr(iRandomPerg)+',';

    slResposta.Add(DM.psResposta);
    repeat
      randomize;
      iRandomPerg := RandomRange(DM.piMin, DM.piMax);
      DM.filtraPergunta(DM.piAssuntoID, iRandomPerg);
    until Pos(DM.qryPerguntas.FieldByName('resposta').AsString, slResposta.CommaText) = 0;
    slResposta.Add(DM.qryPerguntas.FieldByName('resposta').AsString);

    repeat
      randomize;
      iRandomPerg := RandomRange(DM.piMin, DM.piMax);
      DM.filtraPergunta(DM.piAssuntoID, iRandomPerg);
    until Pos(DM.qryPerguntas.FieldByName('resposta').AsString, slResposta.CommaText) = 0;
    slResposta.Add(DM.qryPerguntas.FieldByName('resposta').AsString);

    repeat
      randomize;
      iRandomPerg := RandomRange(DM.piMin, DM.piMax);
      DM.filtraPergunta(DM.piAssuntoID, iRandomPerg);
    until Pos(DM.qryPerguntas.FieldByName('resposta').AsString, slResposta.CommaText) = 0;
    slResposta.Add(DM.qryPerguntas.FieldByName('resposta').AsString);

    randomize;
    i := Random(slResposta.Count);
    RadioButton1.Text := slResposta[i];
    slResposta.Delete(i);

    randomize;
    i := Random(slResposta.Count);
    RadioButton2.Text := slResposta[i];
    slResposta.Delete(i);

    randomize;
    i := Random(slResposta.Count);
    RadioButton3.Text := slResposta[i];
    slResposta.Delete(i);

    randomize;
    i := Random(slResposta.Count);
    RadioButton4.Text := slResposta[i];
    slResposta.Delete(i);

    if RadioButton1.Text = dm.psResposta then
      RadioButton1.Tag := 1
    else
      RadioButton1.Tag := 0;

    if RadioButton2.Text = dm.psResposta then
      RadioButton2.Tag := 1
    else
      RadioButton2.Tag := 0;

    if RadioButton3.Text = dm.psResposta then
      RadioButton3.Tag := 1
    else
      RadioButton3.Tag := 0;

    if RadioButton4.Text = dm.psResposta then
      RadioButton4.Tag := 1
    else
      RadioButton4.Tag := 0;

  finally
    slResposta.Free;
  end;
end;

procedure TFormQuiz.btnInfoClick(Sender: TObject);
begin
  formInformacao.Show;
end;

procedure TFormQuiz.chkEfeitosSonorosChange(Sender: TObject);
begin
  bMusica := not bMusica;
end;

procedure TFormQuiz.FormCreate(Sender: TObject);
begin
  //BannerAd1.AdUnitID := 'ca-app-pub-9350000386173480/4464322998';
  bMusica := True;
end;

procedure TFormQuiz.FormShow(Sender: TObject);
begin
  timer1.Enabled := False;

  sPerguntasUsadas := '';

  RadioButton1.StyledSettings := RadioButton1.StyledSettings - [TStyledSetting.FontColor];
  RadioButton2.StyledSettings := RadioButton1.StyledSettings;
  RadioButton3.StyledSettings := RadioButton1.StyledSettings;
  RadioButton4.StyledSettings := RadioButton1.StyledSettings;

  RadioButton1.Visible := False;
  RadioButton2.Visible := False;
  RadioButton3.Visible := False;
  RadioButton4.Visible := False;
end;

procedure TFormQuiz.gerarQuiz;
begin
  if DM.qryPerguntas.IsEmpty then
  begin
    showmessage('Selecione um assunto');
    exit;
  end;

  {showmessage(
    'Assunto ID: ' + IntToStr(DM.piAssuntoID)
    + ' - Total de perguntas: ' + IntToStr(DM.piTotalPerguntas)
    + ' - Min: ' + IntToStr(DM.piMin)
    + ' - Max: ' + IntToStr(DM.piMax)
    );       }

  iFase := 0;
  iAcerto := 0;
  iErro := 0;
  sRespClicada := '';
  sPerguntasUsadas := '';
  proximaFase;

  RadioButton1.Visible := True;
  RadioButton2.Visible := True;
  RadioButton3.Visible := True;
  RadioButton4.Visible := True;
end;

procedure TFormQuiz.pintarRespostas;
begin
  if RadioButton1.Tag = 1 then
    RadioButton1.FontColor := TAlphaColors.Blue
  else
    RadioButton1.FontColor := TAlphaColors.Red;

  if RadioButton2.Tag = 1 then
    RadioButton2.FontColor := TAlphaColors.Blue
  else
    RadioButton2.FontColor := TAlphaColors.Red;

  if RadioButton3.Tag = 1 then
    RadioButton3.FontColor := TAlphaColorRec.Blue
  else
    RadioButton3.FontColor := TAlphaColorRec.Red;

  if RadioButton4.Tag = 1 then
    RadioButton4.FontColor := TAlphaColorRec.Blue
  else
    RadioButton4.FontColor := TAlphaColorRec.Red;
end;

procedure TFormQuiz.RadioButton1Click(Sender: TObject);
begin
  RadioButton1.Enabled := False;
  RadioButton2.Enabled := False;
  RadioButton3.Enabled := False;
  RadioButton4.Enabled := False;

  MediaPlayer1.Clear;

  sRespClicada := TRadioButton(Sender).Text;
  pintarRespostas;
  if sRespClicada = dm.psResposta then
  begin
    imgOk.Visible := True;
    imgErro.Visible := False;
    tocaSom('rsrcOk');
  end
  else
  begin
    imgOk.Visible := False;
    imgErro.Visible := True;
    tocaSom('rsrcErro');
  end;
  timer1.Enabled := True;
end;

procedure TFormQuiz.timer1Timer(Sender: TObject);
begin
  if sRespClicada = dm.psResposta then
    inc(iAcerto)
  else
    inc(iErro);

  proximaFase;
  timer1.Enabled := False;

  RadioButton1.Enabled := True;
  RadioButton2.Enabled := True;
  RadioButton3.Enabled := True;
  RadioButton4.Enabled := True;
end;

procedure TFormQuiz.tocaSom(sArqNome: String);
var
  ResStream: TResourceStream;
  sFile: string;
begin
  if bMusica then
  begin
    if sArqNome = 'rsrcOk' then
    begin
      ResStream := TResourceStream.Create(HInstance, sArqNome, RT_RCDATA);
      try
        sFile := TPath.Combine(System.IOUtils.TPath.GetDownloadsPath, 'ok.mp3');
        ResStream.Position := 0;
        ResStream.SaveToFile(sFile);
        MediaPlayer1.FileName := sFile;
        MediaPlayer1.Play;
      finally
        ResStream.Free;
      end;
    end
    else if sArqNome = 'rsrcErro' then
    begin
      ResStream := TResourceStream.Create(HInstance, sArqNome, RT_RCDATA);
      try
        sFile := TPath.Combine(System.IOUtils.TPath.GetDownloadsPath, 'erro.mp3');
        ResStream.Position := 0;
        ResStream.SaveToFile(sFile);
        MediaPlayer1.FileName := sFile;
        MediaPlayer1.Play;
      finally
        ResStream.Free;
      end;
    end;
  end;
end;

end.
