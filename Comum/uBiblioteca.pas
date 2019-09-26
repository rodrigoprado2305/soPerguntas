unit uBiblioteca;

interface

uses
  System.SysUtils;

  Function fnCaminhoExe: String;
  Function fnNomeExe: String;
  Function fnCaminhoBD: String;

implementation

uses System.IOUtils;

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
  result := TPath.Combine(TPath.GetDocumentsPath, 'perguntas.sdb');
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  result := fnCaminhoExe+'Dados\perguntas.sdb';
  {$ENDIF}
end;

end.
