unit frmMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, DB, DBAccess, Ora, ShellAPI, AdvToolBtn, ExtCtrls;

type
  TForm2 = class(TForm)
    dbDatasys: TOraSession;
    Panel1: TPanel;
    btnProcesso: TAdvToolButton;
    btnAssunto: TAdvToolButton;
    btnSolucoes: TAdvToolButton;
    pCentral: TPanel;
    btnDocumentos: TAdvToolButton;
    btnConsulta: TAdvToolButton;
    procedure btnProcessoClick(Sender: TObject);
    procedure btnAssuntoClick(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
    procedure btnWebClick(Sender: TObject);
    procedure btnCentralManuaisClick(Sender: TObject);
    procedure btnSolucoesClick(Sender: TObject);
    procedure btnDocumentosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses FPROCESSO, FASSUNTO, FSOLUCOES, FCONSULTA, FDOCUMENTO;

{$R *.dfm}

procedure TForm2.btnCentralManuaisClick(Sender: TObject);
begin
  //
end;

procedure TForm2.btnConsultaClick(Sender: TObject);
begin
  frmConsulta := TfrmConsulta.Create(nil);
  frmConsulta.FHandlePai := pCentral.Handle;
  frmConsulta.Show;
end;

procedure TForm2.btnDocumentosClick(Sender: TObject);
begin
  frmDocumentos := TfrmDocumentos.Create(nil);
  frmDocumentos.FHandlePai := pCentral.Handle;
  frmDocumentos.Show;
end;

procedure TForm2.btnProcessoClick(Sender: TObject);
begin
  frmProcesso := TfrmProcesso.Create(nil);
  frmProcesso.FHandlePai := pCentral.Handle;
  frmProcesso.Show;
end;

procedure TForm2.btnSolucoesClick(Sender: TObject);
begin
  frmSolucoes := TfrmSolucoes.Create(nil);
  frmSolucoes.FHandlePai := pCentral.Handle;
  frmSolucoes.Show;
end;

procedure TForm2.btnWebClick(Sender: TObject);
begin
   ShellExecute(Handle, 'open', 'http://192.168.0.253:8090/#/', '', '', 1);
end;



procedure TForm2.btnAssuntoClick(Sender: TObject);
begin
  frmAssunto := TfrmAssunto.Create(nil);
  frmAssunto.FHandlePai := pCentral.Handle;
  frmAssunto.Show;
end;

end.
