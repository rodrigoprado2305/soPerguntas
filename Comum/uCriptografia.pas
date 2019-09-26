unit uCriptografia;

interface

uses System.SysUtils, System.Classes;

const
  CKEY1 = 53761;
  CKEY2 = 32618;

  /// <summary> Criptografar senha
  /// </summary>
  /// <param name="wsSenha"> Palavra utilizada
  /// </param>
  /// <param name="wKey"> Chave númerica
  /// </param>
  /// <returns>Deve retornar a senha criptografada
  /// </returns>
  function CriptografarSenha(const wsSenha: string; wKey: Word): string;

  /// <summary> Descriptografar senha
  /// </summary>
  /// <param name="wsSenha"> Palavra utilizada
  /// </param>
  /// <param name="wKey"> Chave númerica
  /// </param>
  /// <returns>Deve retornar a senha original
  /// </returns>
  function DescriptografarSenha(const wsSenha: string; wKey: Word): string;

  /// <summary> Criptografar/Descriptografar arquivo
  /// </summary>
  /// <param name="sArqIn"> Arquivo entrada
  /// </param>
  /// <param name="sArqOut"> Arquivo saída
  /// </param>
  /// <param name="wKey"> Chave númerica
  /// </param>
  /// <returns>Deve retornar o arquivo criptografado ou descriptografado
  /// </returns>
  procedure ENcryptDEcryptFile(sArqIn, sArqOut : String; wKey : Word);

implementation

function CriptografarSenha(const wsSenha: string; wKey: Word): string;
var
  i: Integer;
  RStr: RawByteString;
  RStrB: TBytes Absolute RStr;
begin
  Result := '';
  RStr := UTF8Encode(wsSenha);
  for i := 0 to Length(RStr) - 1 do
  begin
    RStrB[i] := RStrB[i] xor (wKey shr 8);
    wKey := (RStrB[i] + wKey) * CKEY1 + CKEY2;
  end;
  for i := 0 to Length(RStr) - 1 do
    Result := Result + IntToHex(RStrB[i], 2);
end;

function DescriptografarSenha(const wsSenha: string; wKey: Word): string;
var
  i, tmpKey: Integer;
  RStr: RawByteString;
  RStrB: TBytes Absolute RStr;
  sAux: String;
begin
  sAux := UpperCase(wsSenha);
  SetLength(RStr, Length(sAux) div 2);
  i := 1;
  try
    while (i < Length(sAux)) do
    begin
      RStrB[i div 2] := StrToInt('$' + sAux[i] + sAux[i + 1]);
      Inc(i, 2);
    end;
  except
    Result := '';
    Exit;
  end;
  for i := 0 to Length(RStr) - 1 do
  begin
    tmpKey := RStrB[i];
    RStrB[i] := RStrB[i] xor (wKey shr 8);
    wKey := (tmpKey + wKey) * CKEY1 + CKEY2;
  end;
  Result := UTF8ToWideString(RStr);//UTF8Decode(RStr);
end;

procedure ENcryptDEcryptFile(sArqIn, sArqOut : String; wKey : Word);
var
  msFileIN, msFileOut : TMemoryStream;
  i : Integer;
  btByte : byte;
begin
  msFileIN := TMemoryStream.Create;
  msFileOut := TMemoryStream.Create;

  try
    msFileIN.LoadFromFile(sArqIn);
    msFileIN.Position := 0;

    for i := 0 to msFileIN.Size - 1 do
    begin
      msFileIN.Read(btByte, 1);
      btByte := (btByte xor not(ord(wKey shr I)));
      msFileOut.Write(btByte,1);
    end;

    msFileOut.SaveToFile(sArqOut);
  finally
    msFileIN.Free;
    msFileOut.Free;
  end;

  {
  EnDecryptFile(
  'D:\Desenvolvimento\Delphi\trunk\Projeto Educando\soPerguntas\soPerguntas\BD\perguntas.sdb',
  'D:\Desenvolvimento\Delphi\trunk\Projeto Educando\soPerguntas\soPerguntas\BD\perguntasCrpty.sdb',
  23);
  EnDecryptFile(
  'D:\Desenvolvimento\Delphi\trunk\Projeto Educando\soPerguntas\soPerguntas\BD\perguntasCrpty.sdb',
  'D:\Desenvolvimento\Delphi\trunk\Projeto Educando\soPerguntas\soPerguntas\BD\perguntasDeCrpty.sdb',
  23);
  }

//http://www.planetadelphi.com.br/dica/1654/encriptar/desencriptar-arquivos
end;


end.
