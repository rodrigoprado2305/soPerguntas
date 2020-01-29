unit frmAssuntos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, frmEntrada,
  FMX.Layouts;

type
  TFormAssuntos = class(TForm)
    barCabecalho: TToolBar;
    btnVoltar: TSpeedButton;
    lblTitulo: TLabel;
    Rectangle1: TRectangle;
    lvAssunto: TListView;
    Layout1: TLayout;
    Layout2: TLayout;
    imgArrow: TImage;
    lblVersaoBD: TLabel;
    procedure FormShow(Sender: TObject);
    procedure lvAssuntoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnVoltarClick(Sender: TObject);
    procedure imgArrowClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure carregarListas;
  end;

var
  FormAssuntos: TFormAssuntos;

implementation

{$R *.fmx}

uses uDMConexao, frmQuiz, frmGerarQuiz;

procedure TFormAssuntos.btnVoltarClick(Sender: TObject);
begin
  close;
  lblVersaoBD.Visible := False;
end;

procedure TFormAssuntos.carregarListas;
var
  liItem: TListViewItem;
begin
  if not DM.BD.Connected then
    DM.BD.Connected := True;

  dm.qryAssunto.Close;
  //dm.qryAssunto.Open('select assuntoid, descricao from assunto');
  dm.qryAssunto.SQL.Text :=
    'select ' +
    '  a.assuntoid, a.descricao, e.media ' +
    'from ' +
    '  assunto a ' +
    '  left join estatisticas as e on (e.assuntoid = a.assuntoid) ';
  dm.qryAssunto.Open;

  lvAssunto.Items.Clear;
  lvAssunto.BeginUpdate;
  while not DM.qryAssunto.Eof do
  begin
    liItem := lvAssunto.Items.Add;
    liItem.Detail := 'Nota média: ' + FormatFloat('0.00', DM.qryAssunto.FieldByName('media').AsFloat); //DM.qryAssunto.FieldByName('assuntoid').AsString;
    liItem.Text := DM.qryAssunto.FieldByName('descricao').AsString;
    liItem.Tag := DM.qryAssunto.FieldByName('assuntoid').AsInteger;

    DM.qryAssunto.Next;
  end;
  lvAssunto.EndUpdate;
end;

procedure TFormAssuntos.FormShow(Sender: TObject);
begin
  carregarListas;
  lblVersaoBD.Visible := False;
  lblVersaoBD.Text := DM.getVersaoBD;
end;

procedure TFormAssuntos.imgArrowClick(Sender: TObject);
begin
  lblVersaoBD.Visible := True;
end;

procedure TFormAssuntos.lvAssuntoItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  DM.piAssuntoID := AItem.Tag; //(AItem.Detail);
  DM.psTema := AItem.Text;
  DM.FiltraPergunta(DM.piAssuntoID);
  formgerarquiz.show;
end;

end.
