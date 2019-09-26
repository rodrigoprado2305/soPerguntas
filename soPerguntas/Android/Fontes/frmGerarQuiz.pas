unit frmGerarQuiz;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFormGerarQuiz = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGerarQuiz: TFormGerarQuiz;

implementation

uses frmQuiz;

{$R *.fmx}

procedure TFormGerarQuiz.Button1Click(Sender: TObject);
begin
  formquiz.show;
  FormQuiz.gerarQuiz;
end;

procedure TFormGerarQuiz.Button2Click(Sender: TObject);
begin
  close;
end;

end.
