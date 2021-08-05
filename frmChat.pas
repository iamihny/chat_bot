unit frmChat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    IdHTTP1: TIdHTTP;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  sResponse: TMemoryStream;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
begin
      SSL := TIdSSLIOHandlerSocketOpenSSL.Create(IdHTTP1);
      IdHTTP1.IOHandler :=  SSL;
      IdHTTP1.HandleRedirects := true;
      IdHTTP1.Request.BasicAuthentication := False;
      IdHTTP1.Request.ContentType := 'application/json';
      IdHTTP1.Request.Accept      := 'application/json';
      IdHTTP1.Request.CustomHeaders.FoldLines := False;
      IdHTTP1.Request.CustomHeaders.Add('x-api-key: b8a6b273f109c80d4a204f047ad861f4--93d724d38dfb90908b0171d776c16839');

      try
        //IdHTTP1.post('http://177.136.76.151:8090/mobileAPI/v1/sms/enviaSMS/', JsonToSend);
        //ShowMessage('SMS enviada com Sucesso!');
       IdHTTP1.Get('http://177.136.76.151:8090/mobileAPI/v1/chatbot/');
      except
        on E: Exception do
          ShowMessage('Erro ao enviar a SMS: '#13#10 + e.Message);
      end;
end;

end.
