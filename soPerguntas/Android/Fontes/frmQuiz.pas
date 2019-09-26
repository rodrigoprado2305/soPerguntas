unit frmQuiz;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TFormQuiz = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    lblFase: TLabel;
    Image1: TImage;
    recFase: TRectangle;
    rectOkErro: TRectangle;
    imgErro: TImage;
    imgOk: TImage;
    tmrRegraVisual: TTimer;
    barCabecalho: TToolBar;
    btnVoltar: TSpeedButton;
    lblPergunta: TLabel;
    procedure tmrRegraVisualTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
  private
    { Private declarations }
    iFase, iAcerto, iErro: Integer;
    sRespClicada: String;
    procedure carregaFase;

    procedure pintarRespostas;

  public
    { Public declarations }
    procedure gerarQuiz;
  end;

var
  FormQuiz: TFormQuiz;

const
  NUM_FASES = 5;

implementation

uses uDMConexao, System.Math;

{$R *.fmx}

procedure TFormQuiz.carregaFase;
var
  iRandomPerg: Integer;
  slResposta: TStringList;
  i: integer;
begin
  if (iFase = NUM_FASES) then
  begin
   showmessage('final');
   // FormFinal.lblAcerto.Text := IntToStr(iAcerto);
   // FormFinal.lblErro.Text := IntToStr(iErro);
   // FormFinal.ShowModal;
    Application.Terminate;
  end;

  inc(iFase);
  lblFase.Text := IntToStr(iFase)+'/15';

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

  slResposta := TStringList.Create;
  try
    randomize;
    iRandomPerg := RandomRange(DM.piMin, DM.piMax);
    DM.filtraPergunta(DM.piAssuntoID, iRandomPerg);
    DM.psDescPergunta := DM.qryPerguntas.FieldByName('descricao').AsString;
    DM.psResposta := DM.qryPerguntas.FieldByName('resposta').AsString;
    lblPergunta.Text := DM.psDescPergunta;

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

procedure TFormQuiz.FormShow(Sender: TObject);
begin
  tmrRegraVisual.Enabled := False;
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

  showmessage(
    'Assunto ID: ' + IntToStr(DM.piAssuntoID)
    + ' - Total de perguntas: ' + IntToStr(DM.piTotalPerguntas)
    + ' - Min: ' + IntToStr(DM.piMin)
    + ' - Max: ' + IntToStr(DM.piMax)
    );

  iFase := 0;
  iAcerto := 0;
  iErro := 0;
  sRespClicada := '';
  carregaFase;

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

procedure TFormQuiz.RadioButton1Change(Sender: TObject);
begin
  pintarRespostas;
  if sRespClicada = dm.psResposta then
  begin
    showmessage('Voce Acertou');
    inc(iAcerto);
  end
  else
  begin
    showmessage('errou');
    inc(iErro);
  end;
  //tmrRegraVisual.Enabled := True;
  carregaFase;
end;

procedure TFormQuiz.tmrRegraVisualTimer(Sender: TObject);
begin
  {if pResposta[0] = pResposta[1] then
  begin
    //tocaSom;
    proximaFase;
  end
  else
  begin
    //tocaSom;
    FormErro.Show;
  end;

  timer1.Enabled := False;
  btnResp01.Enabled := True;
  btnResp02.Enabled := True;
  pResposta[0] := '';
  pResposta[1] := '';  }
end;

end.
