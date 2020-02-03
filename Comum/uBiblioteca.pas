unit uBiblioteca;

interface

uses
  System.SysUtils;

  Function fnCaminhoExe: String;
  Function fnNomeExe: String;
  Function fnCaminhoBD: String;
  //function fnCaminhoScript(sNomeArquivo: String): String;

implementation

uses System.IOUtils, uConst;

function fnCaminhoExe: String;
begin
   result := ExtractFilePath(ParamStr(0));
end;

function fnNomeExe: String;
begin
   result := ExtractFileName(ParamStr(0));
end;

function fnCaminhoBD: String;
begin
  {$IFDEF ANDROID}
  result := TPath.Combine(TPath.GetDocumentsPath, BD);
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  result := fnCaminhoExe+'Dados\'+BD;
  {$ENDIF}
end;

(*
function fnCaminhoScript(sNomeArquivo: String): String;
begin
  {$IFDEF ANDROID}
  if sNomeArquivo = SQL_PERGUNTAS then
    result := TPath.Combine(TPath.GetDocumentsPath, SQL_PERGUNTAS)
  else
    result := TPath.Combine(TPath.GetDocumentsPath, SQL_ASSUNTOS);
  {$ENDIF}
end;       *)

end.
