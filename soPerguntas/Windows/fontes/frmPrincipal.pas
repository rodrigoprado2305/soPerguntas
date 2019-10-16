unit frmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, // bases

  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, Data.DB,
  FMX.ListView, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Effects, FMX.Objects;

type
  TFormPrincipal = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    lblFase: TLabel;
    lvAssunto: TListView;
    btnVerificar: TButton;
    imgFundo: TImage;
    btnGerarQuiz: TCornerButton;
    GlowEffect1: TGlowEffect;
    GlowEffect2: TGlowEffect;
    lblPergunta: TLabel;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    procedure FormShow(Sender: TObject);
    procedure lvAssuntoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnVerificarClick(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure btnGerarQuizClick(Sender: TObject);
    procedure RadioButton1KeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    iFase, iAcerto, iErro, iAssuntoIDSelecionado: Integer;
    //dPercAcerto, dPercErro, dNota: Double;
    sRespClicada, sPerguntasUsadas: String;

    procedure proximaFase;
    procedure pintarRespostas;
    function verificarCheck: Boolean;
    procedure reset;
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

const
  NUM_FASES = 15;

implementation

uses uDMConexao, FireDAC.Stan.Param, System.Math, FrmFinal, uCriptografia;

{$R *.fmx}

procedure TFormPrincipal.btnVerificarClick(Sender: TObject);
begin
  //validar se tem alguma marcada
  if verificarCheck then
  begin
    showmessage('Selecione uma alternativa');
    exit;
  end;

  //Timer1.Enabled := True;
  pintarRespostas;
  if sRespClicada = dm.psResposta then
  begin
    showmessage('Você Acertou!!!');
    inc(iAcerto);
  end
  else
  begin
    showmessage('Você Errou!!!');
    inc(iErro);
  end;
  proximaFase;
end;

procedure TFormPrincipal.proximaFase;
var
  iRandomPerg: Integer;
  slResposta: TStringList;
  i: integer;
begin
  if (iFase = NUM_FASES) then
  begin
    FormFinal.lblAcerto.Text := IntToStr(iAcerto);
    FormFinal.lblErro.Text := IntToStr(iErro);
    FormFinal.lblRespondidas.Text := IntToStr(iFase);

    FormFinal.lblPercAcerto.Text := FormatFloat('0.00',(iAcerto*100)/NUM_FASES);
    FormFinal.lblPercErro.Text := FormatFloat('0.00',(iErro*100)/NUM_FASES);
    FormFinal.lblNota.Text := FormatFloat('0.00',(iAcerto/NUM_FASES)*10);

    //showmessage(sPerguntasUsadas);
    FormFinal.ShowModal;
    reset;
    exit;
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

  Rectangle1.Fill.Color := TAlphaColors.White;
  Rectangle2.Fill.Color := TAlphaColors.White;
  Rectangle3.Fill.Color := TAlphaColors.White;
  Rectangle4.Fill.Color := TAlphaColors.White;

  Rectangle1.Visible := False;
  Rectangle2.Visible := False;
  Rectangle3.Visible := False;
  Rectangle4.Visible := False;

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

procedure TFormPrincipal.btnGerarQuizClick(Sender: TObject);
begin
  if iAssuntoIDSelecionado = 0 then
  begin
    showmessage('Selecione um assunto');
    exit;
  end;

  DM.piAssuntoID := iAssuntoIDSelecionado;
  DM.FiltraPergunta(DM.piAssuntoID);

  {showmessage(
    'Assunto ID: ' + IntToStr(DM.piAssuntoID)
    + ' - Total de perguntas: ' + IntToStr(DM.piTotalPerguntas)
    + ' - Min: ' + IntToStr(DM.piMin)
    + ' - Max: ' + IntToStr(DM.piMax)
    ); }

  iFase := 0;
  iAcerto := 0;
  iErro := 0;
  //dPercAcerto := 0;
  //dPercErro := 0;
  //dNota := 0;

  sRespClicada := '';
  sPerguntasUsadas := '';
  proximaFase;

  RadioButton1.Visible := True;
  RadioButton2.Visible := True;
  RadioButton3.Visible := True;
  RadioButton4.Visible := True;

  btnVerificar.Enabled := True;
end;

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
var
  liItem: TListViewItem;
begin
  iAssuntoIDSelecionado := 0;
  sPerguntasUsadas := '';

  RadioButton1.StyledSettings := RadioButton1.StyledSettings - [TStyledSetting.FontColor];
  RadioButton2.StyledSettings := RadioButton1.StyledSettings;
  RadioButton3.StyledSettings := RadioButton1.StyledSettings;
  RadioButton4.StyledSettings := RadioButton1.StyledSettings;

  RadioButton1.Visible := False;
  RadioButton2.Visible := False;
  RadioButton3.Visible := False;
  RadioButton4.Visible := False;

  Rectangle1.Visible := False;
  Rectangle2.Visible := False;
  Rectangle3.Visible := False;
  Rectangle4.Visible := False;

  Caption := DescriptografarSenha(DM.qryChave.FieldByName('nomeEscola').AsString,23);
  lblPergunta.Text := '';

  lvAssunto.Items.Clear;
  lvAssunto.BeginUpdate;
  while not DM.qryAssunto.Eof do
  begin
    liItem := lvAssunto.Items.Add;
    liItem.Detail := DM.qryAssunto.FieldByName('assuntoid').AsString;
    liItem.Text := DM.qryAssunto.FieldByName('descricao').AsString;

    DM.qryAssunto.Next;
  end;
  lvAssunto.EndUpdate;
end;

procedure TFormPrincipal.lvAssuntoItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  iAssuntoIDSelecionado := StrToInt(AItem.Detail);
  //DM.FiltraPergunta(DM.piAssuntoID);   // foi para o botão gerar quiz
  btnGerarQuiz.Enabled := True;
end;

procedure TFormPrincipal.pintarRespostas;
begin
  Rectangle1.Visible := True;
  Rectangle2.Visible := True;
  Rectangle3.Visible := True;
  Rectangle4.Visible := True;

  if RadioButton1.Tag = 1 then
  begin
   // RadioButton1.FontColor := TAlphaColors.Blue;
    Rectangle1.Fill.Color := TAlphaColors.Lightskyblue;
  end
  else
  begin
   // RadioButton1.FontColor := TAlphaColors.Red;
    Rectangle1.Fill.Color := TAlphaColors.Tomato;
  end;

  if RadioButton2.Tag = 1 then
  begin
  //  RadioButton2.FontColor := TAlphaColors.Blue;
    Rectangle2.Fill.Color := TAlphaColors.Lightskyblue;
  end
  else
  begin
    //RadioButton2.FontColor := TAlphaColors.Red;
    Rectangle2.Fill.Color := TAlphaColors.Tomato;
  end;

  if RadioButton3.Tag = 1 then
  begin
    //RadioButton3.FontColor := TAlphaColors.Blue;
    Rectangle3.Fill.Color := TAlphaColors.Lightskyblue;
  end
  else
  begin
   // RadioButton3.FontColor := TAlphaColors.Red;
    Rectangle3.Fill.Color := TAlphaColors.Tomato;
  end;

  if RadioButton4.Tag = 1 then
  begin
   // RadioButton4.FontColor := TAlphaColors.Blue;
    Rectangle4.Fill.Color := TAlphaColors.Lightskyblue;
  end
  else
  begin
  //  RadioButton4.FontColor := TAlphaColors.Red;
    Rectangle4.Fill.Color := TAlphaColors.Tomato;
  end;
end;

{todo -oRodrigo Prado -cAPI:  Acrescentar melhoria aqui}
function TFormPrincipal.verificarCheck: Boolean;
begin
  result := False;

  if (  (not RadioButton1.IsChecked) and (not RadioButton2.IsChecked)
     and (not RadioButton3.IsChecked) and (not RadioButton4.IsChecked) ) then
    result := True;
end;

procedure TFormPrincipal.RadioButton1Change(Sender: TObject);
begin
  sRespClicada := TRadioButton(Sender).Text;
end;

procedure TFormPrincipal.RadioButton1KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkReturn) Or (Key = vkTab) then
    if TRadioButton(Sender).IsChecked then
      btnVerificarClick(Sender);
end;

procedure TFormPrincipal.reset;
begin
  btnGerarQuiz.Enabled := False;
  btnVerificar.Enabled := False;

  RadioButton1.StyledSettings := RadioButton1.StyledSettings - [TStyledSetting.FontColor];
  RadioButton2.StyledSettings := RadioButton1.StyledSettings;
  RadioButton3.StyledSettings := RadioButton1.StyledSettings;
  RadioButton4.StyledSettings := RadioButton1.StyledSettings;

  RadioButton1.Visible := False;
  RadioButton2.Visible := False;
  RadioButton3.Visible := False;
  RadioButton4.Visible := False;

  Rectangle1.Visible := False;
  Rectangle2.Visible := False;
  Rectangle3.Visible := False;
  Rectangle4.Visible := False;
  lblPergunta.Text := '';
  iFase := 0;
  iAcerto := 0;
  iErro := 0;
  //dPercAcerto := 0;
  //dPercErro := 0;
  //dNota := 0;

  sRespClicada := '';
  sPerguntasUsadas := '';
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
