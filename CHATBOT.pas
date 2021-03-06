unit CHATBOT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  StdCtrls, SynEditHighlighter, SynHighlighterJSON, xmldom, XMLIntf, msxmldom,
  XMLDoc, ComCtrls, AdvMemo, JvComponentBase, JvRichEditToHtml;

type
  TfrmChatBot = class(TForm)
    btnEnviar: TButton;
    IdHTTP1: TIdHTTP;
    Memo1: TMemo;
    xml: TXMLDocument;
    Memo2: TMemo;
    procedure FormShow(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    retorno : String;
    posicao : integer;
    caminho : TStringList;
    nChat, nModulo, nListAssunto, nAssunto : IXMLNode;
    nInformacoes, nInfo, pergunta, resposta : IXMLNode;
    procedure carregaXML;
    procedure acessaWebService;
    procedure carregaModulosXML;
    procedure carregaAssuntosXML(indice : integer);
    procedure carregaInformacoesXML(indice : integer);
    procedure carregaSolucaoXML(indice : integer);
  end;

var
  frmChatBot: TfrmChatBot;

implementation

{$R *.dfm}
procedure TfrmChatBot.FormShow(Sender: TObject);
begin
  posicao  := 0;
  caminho  := TStringList.Create;
  acessaWebService;
end;

procedure TfrmChatBot.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
     btnEnviarClick(nil);

  if not ( Key in ['0'..'9','V','v', Chr(8)] ) then
    Key := #0;
end;

procedure TfrmChatBot.acessaWebService;
var
  sResponse: TMemoryStream;
  resp : TMemoryStream;
begin
  IdHTTP1.Request.BasicAuthentication := False;
  IdHTTP1.Request.ContentType := 'application/json';
  IdHTTP1.Request.Accept      := 'application/json';
  IdHTTP1.Request.CustomHeaders.FoldLines := False;
  IdHTTP1.Request.CustomHeaders.Add('x-api-key: b8a6b273f109c80d4a204f047ad861f4--93d724d38dfb90908b0171d776c16839');

  try
    resp := TMemoryStream.Create;
    xml.XML.Text := IdHTTP1.Get('http://177.136.76.151:8090/mobileAPI/v1/chatbot/xml/');
    carregaModulosXML;
  except
  end;
end;

procedure TfrmChatBot.btnEnviarClick(Sender: TObject);
begin
 try
   if ((trim(Memo1.Text) = 'v') or
       (trim(Memo1.Text) = 'V')) and
       (posicao > 0) then
     begin
       posicao  := posicao-1;
       case posicao of
         0 : carregaModulosXML;
         1 : carregaAssuntosXML(StrToInt(caminho[caminho.Count -1]));
         2 : carregaInformacoesXML(StrToInt(caminho[caminho.Count -1]));
         3 : carregaSolucaoXML(StrToInt(trim(caminho[caminho.Count -1])));
       end;
       caminho.Delete(caminho.Count -1);
       Memo1.Clear;
     end
   else if ((trim(Memo1.Text) <> 'v') or (trim(Memo1.Text) <> 'V')) then
      begin
        case posicao of
          0 : carregaAssuntosXML(StrToInt(trim(Memo1.Text)));
          1 : carregaInformacoesXML(StrToInt(trim(Memo1.Text)));
          2 : carregaSolucaoXML(StrToInt(trim(Memo1.Text)));
        end;
        caminho.Add(Memo1.Text);
        posicao  := posicao+1;
        Memo1.Clear;
      end;

 finally

 end;
end;


procedure TfrmChatBot.carregaAssuntosXML(indice: integer);
var
  y : integer;
begin
  Memo2.Lines.Add('');
  Memo2.Lines.Add('');
  nModulo := nChat.ChildNodes.Get(indice-1);
  Memo2.Lines.Add('Temos algumas dicas sobre '+nModulo.ChildNodes.FindNode('nome').NodeValue+' que podem te ajudar!');
  Memo2.Lines.Add('');
  Memo2.Lines.Add('Escolha um assunto :');
  Memo2.Lines.Add('');
  nListAssunto := nModulo.ChildNodes.FindNode('listaAssuntos');
  for y := 0 to nListAssunto.ChildNodes.Count - 1 do
    begin
    nAssunto := nListAssunto.ChildNodes.Get(y);
    Memo2.Lines.Add(intToStr(y+1)+' - '+nAssunto.ChildNodes.FindNode('desc').NodeValue);
    end;
  Memo2.Lines.Add('V - Voltar');
end;

procedure TfrmChatBot.carregaInformacoesXML(indice: integer);
var
  z : integer;
begin
  nAssunto := nListAssunto.ChildNodes.Get(indice-1);
  Memo2.Lines.Add('');
  Memo2.Lines.Add('');
  Memo2.Lines.Add('Aqui est?o algumas dicas sobre '+nAssunto.ChildNodes.FindNode('desc').NodeValue+'  que podem te ajudar!');
  Memo2.Lines.Add('');
  Memo2.Lines.Add('Selecione uma Informa??o :');
  nInformacoes := nAssunto.ChildNodes.FindNode('informacoes');
  for z := 0 to nInformacoes.ChildNodes.Count - 1  do
    begin
    nInfo := nInformacoes.ChildNodes.Get(z);
    Memo2.Lines.Add(intToStr(z+1)+' - '+nInfo.ChildNodes.FindNode('duvida').NodeValue);
    end;
  Memo2.Lines.Add('V - Voltar');
end;

procedure TfrmChatBot.carregaModulosXML;
var
  i: integer;
begin
  Memo2.Clear;
  Memo2.Lines.Add('Ol? Loris!');
  Memo2.Lines.Add('Sou o Assistente Virtual do STARH!');
  Memo2.Lines.Add('');
  Memo2.Lines.Add('Vou te ajudar a esclarecer suas d?vidas sobre o nosso Sistema!');
  Memo2.Lines.Add('');
  Memo2.Lines.Add('Escolha um M?dulo:');
  Memo2.Lines.Add('');


  xml.Active := True;
  nChat := xml.ChildNodes.FindNode('chatbot');

  for I := 0 to nChat.ChildNodes.Count - 1 do
    begin
    nModulo := nChat.ChildNodes.Get(i);
    Memo2.Lines.Add(intToStr(i+1)+' - '+nModulo.ChildNodes.FindNode('nome').NodeValue);
    nListAssunto := nModulo.ChildNodes.FindNode('listaAssuntos');
    end;

end;

procedure TfrmChatBot.carregaSolucaoXML(indice: integer);
begin
    nInfo := nInformacoes.ChildNodes.Get(indice-1);
    Memo2.Lines.Add('');
    Memo2.Lines.Add('');
    Memo2.Lines.Add(nInfo.ChildNodes.FindNode('duvida').NodeValue);
    Memo2.Lines.Add('');
    Memo2.Lines.Add(nInfo.ChildNodes.FindNode('solucao').NodeValue);
    Memo2.Lines.Add('');
    Memo2.Lines.Add('');
    Memo2.Lines.Add('V - Voltar');
end;

procedure TfrmChatBot.carregaXML;
var
  i,x,y,z: integer;
begin
  Memo2.Clear;
  xml.Active := True;
  nChat := xml.ChildNodes.FindNode('chatbot');

  for I := 0 to nChat.ChildNodes.Count - 1 do
    begin
    nModulo := nChat.ChildNodes.Get(i);
    Memo2.Lines.Add('-- MODULO --');
    Memo2.Lines.Add(nModulo.ChildNodes.FindNode('nome').NodeValue);
    Memo2.Lines.Add('-- ASSUNTO --');
    nListAssunto := nModulo.ChildNodes.FindNode('listaAssuntos');
    for y := 0 to nListAssunto.ChildNodes.Count - 1 do
      begin
      nAssunto := nListAssunto.ChildNodes.Get(y);
      Memo2.Lines.Add(nAssunto.ChildNodes.FindNode('desc').NodeValue);
      Memo2.Lines.Add('-- PERGUNTAS --');
      nInformacoes := nAssunto.ChildNodes.FindNode('informacoes');
      for z := 0 to nInformacoes.ChildNodes.Count - 1  do
        begin
        nInfo := nInformacoes.ChildNodes.Get(z);
        Memo2.Lines.Add('-- DUVIDA --');
        Memo2.Lines.Add(nInfo.ChildNodes.FindNode('duvida').NodeValue);
        Memo2.Lines.Add('-- SOLUCAO --');
        Memo2.Lines.Add(nInfo.ChildNodes.FindNode('solucao').NodeValue);
        end;
      end;
    end;
end;

end.
