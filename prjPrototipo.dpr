program prjPrototipo;

uses
  Forms,
  CHATBOT in 'CHATBOT.pas' {frmChatBot};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmChatBot, frmChatBot);
  Application.Run;
end.
