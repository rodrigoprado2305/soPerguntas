unit frmGerarQuiz;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo;

type
  TFormGerarQuiz = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    barCabecalho: TToolBar;
    btnVoltar: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGerarQuiz: TFormGerarQuiz;

implementation

uses frmQuiz, uDMConexao;

{$R *.fmx}

procedure TFormGerarQuiz.btnVoltarClick(Sender: TObject);
begin
  close;
end;

procedure TFormGerarQuiz.Button1Click(Sender: TObject);
begin
  formquiz.show;
  FormQuiz.gerarQuiz;
  close;
end;

procedure TFormGerarQuiz.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TFormGerarQuiz.FormShow(Sender: TObject);
var
  i: integer;
begin
  DM.carregarEstatisticas;

  i := DM.qryTemp.FieldByName('numjogadas').AsInteger;
  memo1.Lines.Clear;
  Memo1.Lines.Add('Nro. Quiz Jogados: '+IntToStr(i));
  Memo1.Lines.Add('Total Pontos: ' + FormatFloat('0.00', DM.qryTemp.FieldByName('media').AsFloat));
  Memo1.Lines.Add('Total Pontos Geral: ' + FormatFloat('0.00', DM.qryTemp.FieldByName('mediageral').AsFloat));
end;

end.
