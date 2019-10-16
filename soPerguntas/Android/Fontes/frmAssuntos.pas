unit frmAssuntos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFormAssuntos = class(TForm)
    lvAssunto: TListView;
    procedure FormShow(Sender: TObject);
    procedure lvAssuntoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAssuntos: TFormAssuntos;

implementation

{$R *.fmx}

uses uDMConexao, frmQuiz, frmGerarQuiz;

procedure TFormAssuntos.FormShow(Sender: TObject);
var
  liItem: TListViewItem;
begin
  if not DM.BD.Connected then
    DM.BD.Connected := True;

  dm.qryAssunto.Close;
  dm.qryAssunto.Open('select assuntoid, descricao from assunto');
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

procedure TFormAssuntos.lvAssuntoItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  DM.piAssuntoID := StrToInt(AItem.Detail);
  DM.FiltraPergunta(DM.piAssuntoID);
  formgerarquiz.show;
end;

end.
